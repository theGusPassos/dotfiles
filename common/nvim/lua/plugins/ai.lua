return {
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        version = false, -- Never set this value to "*"! Never!
        ---@module 'avante'
        ---@type avante.Config
        opts = {
            provider = "copilot",
            providers = {
                copilot = {
                    model = "claude-sonnet-4",
                },
            },
        },
        keys = {
            {
                "<leader>ac",
                function() require("avante").add_current_file() end,
                desc = "Avante: Add current buffer to context",
                mode = "n"
            }
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
        },
    }
}
