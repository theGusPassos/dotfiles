return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                style = "moon",
                transparent = true,
                styles = {
                    comments = { italic = false },
                    keywords = { italic = true },
                },
            })
        end
    },
    {
        "tiagovla/tokyodark.nvim",
        opts = {
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
        config = function()
            require('kanagawa').setup({
                keywordStyle = { italic = true },
                commentStyle = { italic = false },
                transparent = true,
                overrides = function(colors)
                    local theme = colors.theme
                    return {
                        NormalFloat = { bg = "none" },
                        FloatBorder = { bg = "none" },
                        FloatTitle  = { bg = "none" },

                        -- Save an hlgroup with dark background and dimmed foreground
                        -- so that you can use it where your still want darker windows.
                        -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
                        NormalDark  = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

                        -- Popular plugins that open floats will link to NormalFloat by default;
                        -- set their background accordingly if you wish to keep them dark and borderless
                        LazyNormal  = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                        MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                    }
                end,
            })
        end,
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
                hide_fillchars = true,
                borderless_pickers = false,
                terminal_colors = true,
                overrides = function(c)
                    return {
                        ["@keyword"] = { fg = c.orange, italic = true },
                        ["@keyword.function"] = { fg = c.orange, italic = true },
                        ["@operator"] = { fg = c.orange, italic = true },
                    }
                end,
            })
        end
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                transparent_background = true,
                styles = {
                    conditionals = { "italic" },
                    loops = { "italic" },
                    keywords = { "italic" },
                    comments = {},
                }
            })
        end
    }
}
