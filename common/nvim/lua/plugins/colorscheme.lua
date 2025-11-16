return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                style = "night",
                transparent = true,
            })
        end
    },
    {
        "tiagovla/tokyodark.nvim",
        opts = {
            -- custom options here
        },
        config = function(_, opts)
            require("tokyodark").setup(opts)
        end,
    },
    {
        "neanias/everforest-nvim",
        lazy = false,
        priority = 1001,
        config = function()
            require("everforest").setup({
            })
        end,
    },
    {
        "rebelot/kanagawa.nvim",
    },
    {
        'sainnhe/gruvbox-material',
        lazy = false,
        priority = 1000,
        config = function()
            -- Optionally configure and load the colorscheme
            -- directly inside the plugin declaration.
            vim.g.gruvbox_material_enable_italic = true
            vim.cmd.colorscheme('gruvbox-material')
        end
    },
    {
        "rose-pine/neovim"
    },
    {
        "scottmckendry/cyberdream.nvim",
        config = function()
            require("cyberdream").setup({
                variant = "dark",
                transparent = true,
                saturation = 1,
                italic_comments = false,
                hide_fillchars = false,
                borderless_pickers = false,
                terminal_colors = true,
            })
        end
    }
}
