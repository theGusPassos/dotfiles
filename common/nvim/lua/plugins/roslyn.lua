return
{
    "seblyng/roslyn.nvim",
    ft = { "cs", "csproj" },
    dependencies = { "williamboman/mason.nvim" },

    ---@module  'roslyn.config'
    ---@type    RoslynNvimConfig
    opts = {
        -- "auto" | "roslyn" | "off"
        --
        -- - "auto": Does nothing for filewatching, leaving everything as default
        -- - "roslyn": Turns off neovim filewatching which will make roslyn do the filewatching
        -- - "off": Hack to turn off all filewatching. (Can be used if you notice performance issues)
        filewatching = "auto",

        -- Optional function that takes an array of targets as the only argument. Return the target you
        -- want to use. If it returns `nil`, then it falls back to guessing the target like normal
        -- Example:
        --
        -- choose_target = function(target)
        --     return vim.iter(target):find(function(item)
        --         if string.match(item, "Foo.sln") then
        --             return item
        --         end
        --     end)
        -- end
        choose_target = nil,

        -- Optional function that takes the selected target as the only argument.
        -- Returns a boolean of whether it should be ignored to attach to or not
        --
        -- I am for example using this to disable a solution with a lot of .NET Framework code on mac
        -- Example:
        --
        -- ignore_target = function(target)
        --     return string.match(target, "Foo.sln") ~= nil
        -- end
        ignore_target = nil,

        -- Whether or not to look for solution files in the child of the (root).
        -- Set this to true if you have some projects that are not a child of the
        -- directory with the solution file
        broad_search = false,

        -- Whether or not to lock the solution target after the first attach.
        -- This will always attach to the target in `vim.g.roslyn_nvim_selected_solution`.
        -- NOTE: You can use `:Roslyn target` to change the target
        lock_target = false,
    },

    config = function(_, opts)
        require("roslyn").setup(opts)

        vim.lsp.config("roslyn", {
            settings = {
                ["csharp|background_analysis"] = {
                    dotnet_analyzer_diagnostics_scope = "openFiles",
                    dotnet_compiler_diagnostics_scope = "fullSolution",
                },

                ["csharp|completion"] = {
                    dotnet_provide_regex_completions = true,
                    dotnet_show_completion_items_from_unimported_namespaces = true,
                },

                ["csharp|inlay_hints"] = {
                    csharp_enable_inlay_hints_for_implicit_object_creation                = true,
                    csharp_enable_inlay_hints_for_implicit_variable_types                 = true,
                    csharp_enable_inlay_hints_for_lambda_parameter_types                  = true,
                    csharp_enable_inlay_hints_for_types                                   = true,
                    dotnet_enable_inlay_hints_for_indexer_parameters                      = true,
                    dotnet_enable_inlay_hints_for_literal_parameters                      = false,
                    dotnet_enable_inlay_hints_for_object_creation_parameters              = true,
                    dotnet_enable_inlay_hints_for_other_parameters                        = false,
                    dotnet_enable_inlay_hints_for_parameters                              = true,
                    dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
                    dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name   = true,
                    dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent   = true,
                },

                ["csharp|code_lens"] = {
                    dotnet_enable_references_code_lens = true,
                },
            },
        })

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(ev)
                local client = vim.lsp.get_client_by_id(ev.data.client_id)
                if client and client.name == "roslyn" then
                    vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "BufWritePost" }, {
                        buffer = ev.buf,
                        callback = function()
                            vim.lsp.codelens.refresh({ bufnr = ev.buf })
                        end,
                    })
                end
            end,
        })

        vim.api.nvim_create_user_command("RoslynSolution", function()
            local sln = vim.g.roslyn_nvim_selected_solution
            if sln then
                vim.notify("Active solution: " .. sln, vim.log.levels.INFO)
            else
                vim.notify("No solution selected yet.", vim.log.levels.WARN)
            end
        end, { desc = "Show the active Roslyn solution" })
    end
}
