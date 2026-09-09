return
{
    "seblyng/roslyn.nvim",
    ft = { "cs", "csproj" },
    dependencies = { "williamboman/mason.nvim" },

    ---@module  'roslyn.config'
    ---@type    RoslynNvimConfig
    opts = {
        filewatching = "roslyn",

        broad_search = true,

        choose_target = function(targets)
            if #targets == 1 then
                return targets[1]
            end

            local cwd = vim.fn.getcwd() .. "/"
            local labels = vim.tbl_map(function(t)
                return t:gsub(vim.pesc(cwd), "")
            end, targets)

            local chosen
            vim.ui.select(labels, {
                prompt = "Select Roslyn solution:",
                format_item = function(item) return item end,
            }, function(_, idx)
                if idx then chosen = targets[idx] end
            end)

            return chosen
        end,

        ignore_target = function(target)
            return false
        end,

        lock_target = false,
        silent = false,
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
