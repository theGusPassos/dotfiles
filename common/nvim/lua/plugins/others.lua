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
            vim.g.mkdp_filetypes = { "markdown", "text" }
        end,
        ft = { "markdown", "text" },
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

    -- git
    {
        "lewis6991/gitsigns.nvim",
    },
    {
        "sindrets/diffview.nvim",
    },

    -- focus & writing
    {
        "folke/twilight.nvim",
        opts = {
            context = 3,
        }
    },
    {
        "folke/zen-mode.nvim",
        opts = {
        }
    },
    {
        "preservim/vim-pencil",
        ft =  { "markdown", "text" },
    }
}
