return {
    {
        "j-hui/fidget.nvim",
        opts = {
            -- options
        },
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },
    {
        "sindrets/diffview.nvim",
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup {
                options = {
                    theme = 'dracula',
                },
            }
        end,
    },
    {
        "rcarriga/nvim-notify",
        config = function()
            require("notify").setup()
            vim.notify = require("notify")
        end
    },
    {
        "lewis6991/gitsigns.nvim",
    }
}
