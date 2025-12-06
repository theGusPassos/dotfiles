vim.lsp.config("roslyn", {
    root_dir = function(fname)
        local util = require("lspconfig").util

        -- Scan current and parent directories manually:
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

return {
    {
        "seblyng/roslyn.nvim",
        ft = { "cs", "csproj", "sln" },
        opts = {
            filewatching = "roslyn",
        },
    },
    {
        "GustavEikaas/easy-dotnet.nvim",
        dependencies = { "nvim-lua/plenary.nvim", 'nvim-telescope/telescope.nvim', },
        config = function()
            require("easy-dotnet").setup()
        end
    },
}
