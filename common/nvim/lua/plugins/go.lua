return {
    "ray-x/go.nvim",
    dependencies = {
        "ray-x/guihua.lua",
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
    },

    opts = function()
        local opts = {
            lsp_keymaps = false,
            dap_debug_keymaps = false,

            -- uses your existing lspconfig, doesn't override gopls
            lsp_cfg = false,

            lsp_inlay_hints = {
                enable = true,
            },
        }

        require("go").setup(opts)

        -- goimports on save
        local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.go",
            callback = function()
                require("go.format").goimports()
            end,
            group = format_sync_grp,
        })

        return opts
    end,

    -- important: load before LSP attaches
    event = { "BufReadPre", "BufNewFile" },
    ft = { "go", "gomod" },

    build = ":lua require('go.install').update_all_sync()",
}

