return {
    -- {
    --     "yetone/avante.nvim",
    --     lazy = false,
    --     version = false,
    --     build = "make",

    --     config = function()
    --         require("avante").setup({
    --             provider = "ollamalocal",
    --             providers = {
    --                 ollamalocal = {
    --                     __inherited_from = "openai",
    --                     ['local'] = true,
    --                     endpoint = "http://127.0.0.1:11434/v1",
    --                     model = "qwen3.5:4B",
    --                     is_env_set = require("avante.providers.ollama").check_endpoint_alive,
    --                     api_key_name = "",
    --                     extra_request_body = {
    --                         temperature = 0.3,
    --                         max_tokens = 4096,
    --                         num_ctx = 8192,
    --                     },
    --                 },
    --             },
    --             behaviour = {
    --                 auto_suggestions = false,
    --                 auto_apply_diff_after_generation = false,
    --             },
    --         })
    --     end,

    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --         "MunifTanjim/nui.nvim",
    --         "nvim-tree/nvim-web-devicons",
    --         {
    --             "HakonHarnes/img-clip.nvim",
    --             lazy = false,
    --             opts = {
    --                 default = {
    --                     embed_image_as_base64 = false,
    --                     prompt_for_file_name = false,
    --                     drag_and_drop = { insert_mode = true },
    --                 },
    --             },
    --         },
    --     }
    -- },
    {
        "milanglacier/minuet-ai.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("minuet").setup({
                provider = "openai_fim_compatible",

                -- Start small for local models
                n_completions = 1,
                context_window = 512, -- increase later if your GPU handles it

                provider_options = {
                    openai_fim_compatible = {
                        -- Ollama needs a non-null env var as a placeholder for the API key
                        api_key = "TERM", -- just reads $TERM which always exists, value doesn't matter
                        name = "Ollama",
                        end_point = "http://localhost:11434/v1/completions",
                        model = "qwen2.5-coder:7b",
                        optional = {
                            max_tokens = 128,
                            top_p = 0.9,
                        },
                    },
                },

                -- Virtual text config (no nvim-cmp needed)
                virtualtext = {
                    auto_trigger_ft = { "python", "lua", "javascript", "typescript" }, -- add your langs
                    keymap = {
                        accept = "<Tab>",
                        accept_line = "<A-a>",
                        prev = "<A-[>",
                        next = "<A-]>",
                        dismiss = "<A-e>",
                    },
                },
            })
        end,
    }
}
