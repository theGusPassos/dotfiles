return {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
        "ray-x/guihua.lua",
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
    },
    opts = {
        lsp_keymaps = false,
        dap_debug_keymap =  false,

        lsp_inlay_hints = {
            enable = true,
        },

        -- prevent auto-downloads
        go_install = false,
        gopls_cmd = { "gopls" },
    },
    config = function(_, opts)
        require("go").setup(opts)

        local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.go",
            callback = function()
                require('go.format').goimports()
            end,
            group = format_sync_grp,
        })
        local gopls_cfg = require('go.lsp').config()
        -- gopls_cfg.filetypes = { 'go', 'gomod'}, -- override settings

        print(gopls_cfg)

        vim.lsp.config.gopls = gopls_cfg
        vim.lsp.enable('gopls')
    end,

    ft = { "go", 'gomod' },
    build = ':lua require("go.install").update_all_sync()'
}
