return {
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        opts = {
            provider = "ollama",
            providers = {
                ollama = {
                    endpoint = "http://127.0.0.1:11434",
                    model = "deepseek-r1:7b",
                },
            }
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
