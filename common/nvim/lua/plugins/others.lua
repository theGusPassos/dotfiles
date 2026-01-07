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
        enabled = true,
        opts = {
            signs = {
                signs = {
                    add = { text = "┃" },
                    change = { text = "┃" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                    untracked = { text = "┆" },
                },
                signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
                numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
                linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
                word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
                watch_gitdir = {
                    follow_files = true,
                },
                auto_attach = true,
                attach_to_untracked = false,
                current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
                    delay = 1000,
                    ignore_whitespace = false,
                    virt_text_priority = 100,
                },
                current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
                sign_priority = 6,
                update_debounce = 100,
                status_formatter = nil, -- Use default
                max_file_length = 40000, -- Disable if file is longer than this (in lines)
            }
        }
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
        ft = { "markdown", "text" },
    }
}
