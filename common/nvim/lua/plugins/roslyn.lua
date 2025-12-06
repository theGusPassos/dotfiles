-- plugins/csharp.lua or similar
local lspconfig = require("lspconfig")

-- Helper function to detect if current directory is a C# project
local function is_csharp_project()
    local cwd = vim.loop.cwd()
    for _, file in ipairs(vim.fn.readdir(cwd)) do
        if file:match("%.sln$") or file:match("%.csproj$") then
            return true
        end
    end
    return false
end

-- ROSLYN LSP setup
local function setup_roslyn()
    lspconfig.roslyn.setup({
        root_dir = function(fname)
            local util = lspconfig.util
            return util.search_ancestors(fname, function(path)
                for _, file in ipairs(vim.fn.readdir(path)) do
                    if file:match("%.sln$") or file:match("%.csproj$") then
                        return path
                    end
                end
            end)
        end,
        settings = {
            ["csharp|inlay_hints"] = {
                csharp_enable_inlay_hints_for_implicit_object_creation = true,
                csharp_enable_inlay_hints_for_implicit_variable_types = true,
            },
            ["csharp|code_lens"] = {
                dotnet_enable_references_code_lens = true,
            },
        },
    })
end

-- Auto-load Roslyn only for C# projects when opening a .cs file
vim.api.nvim_create_autocmd("FileType", {
    pattern = "cs",
    callback = function()
        if is_csharp_project() then
            setup_roslyn()
        end
    end
})

-- PLUGIN SETUP TABLE (for lazy.nvim or packer.nvim)
return {
    {
        "seblyng/roslyn.nvim",
        ft = { "cs", "csproj", "sln" },
        opts = {
            filewatching = "polling", -- avoids dotnet dependency
        },
    },
    {
        "GustavEikaas/easy-dotnet.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
        config = function()
            require("easy-dotnet").setup()
        end,
        cond = function()
            return is_csharp_project() -- only load in a C# project
        end,
    },
}

