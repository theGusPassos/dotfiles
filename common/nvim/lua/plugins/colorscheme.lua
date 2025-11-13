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
    }
}
