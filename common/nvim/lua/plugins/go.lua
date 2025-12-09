return {
    {
        "ray-x/go.nvim",
        dependencies = {
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },

        ft = { "go", "gomod" },

        opts = {
            lsp_keymaps = false,
            dap_debug_keymap = false,

            lsp_inlay_hints = {
                enable = true,
            },

            go_install = false,
            gopls_cmd = { "gopls" },

            lsp_cfg = {
                settings = {
                    gopls = {
                        directoryFilters = {
                            "-node_modules",
                            "-vendor",
                            "-.git",
                            "-dist",
                            "-build",
                        },
                        analyses = {
                            unusedparams = true,
                        },
                        staticcheck = false,
                    },
                },
            },
        },

        config = function(_, opts)
            require("go").setup(opts)

            local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*.go",
                callback = function()
                    require("go.format").goimports()
                end,
                group = format_sync_grp,
            })
        end,

        build = ':lua require("go.install").update_all_sync()',
    },
}
