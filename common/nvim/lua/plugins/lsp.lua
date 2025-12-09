vim.diagnostic.config({
    virtual_text = { spacing = 4, prefix = "●" },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "✘",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.HINT] = "",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
            [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
            [vim.diagnostic.severity.INFO] = "DiagnosticSignHint",
        },
    },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = true,
        header = "",
        prefix = "",
    },
})

return {
    -- LSP configuration
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local opts = { noremap = true, silet = true }

            -- LSP capabilities
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            -- LSP attach function
            local on_attach = function(client, bufnr)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr })
                vim.keymap.set("n", "<leader>f", function()
                    vim.lsp.buf.format({ async = true })
                end, { buffer = bufnr })

                vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", {
                    buffer = bufnr,
                    noremap = true,
                    silent = true,
                })

                -- Diagnostic keymaps
                vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float,
                    { buffer = bufnr, desc = "Show line diagnostics" })
                vim.keymap.set("n", "<leader>th", function()
                    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
                end, { buffer = bufnr, desc = "Toggle inlay hints" })
            end

            -- lua LSP - luals
            vim.lsp.config("lua_ls", {
                cmd = { "lua-language-server" },
                on_attach = on_attach,
                capabilities = capabilities,
                on_init = function(client)
                    if client.workspace_folders then
                        local path = client.workspace_folders[1].name
                        if
                            path ~= vim.fn.stdpath('config')
                            and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
                        then
                            return
                        end
                    end

                    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                        runtime = {
                            version = 'LuaJIT',
                            path = {
                                'lua/?.lua',
                                'lua/?/init.lua',
                            },
                        },
                        workspace = {
                            checkThirdParty = false,
                            library = {
                                vim.env.VIMRUNTIME
                            }
                        }
                    })
                end,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        runtime = {
                            version = "LuaJIT",
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                    },
                }
            })

            -- react typescript LSP
            vim.lsp.config("vtsls", {
                on_attach = on_attach,
                capabilities = capabilities,
                vtsls = {
                    eslint = {
                        enabled = false,
                    },
                },
                settings = {
                    typescript = {
                        format = { indentSize = 2, tabSize = 2, convertTabsToSpaces = true },
                        preferences = { indentSize = 2, tabSize = 2 },
                    },
                    javascript = {
                        format = { indentSize = 2, tabSize = 2, convertTabsToSpaces = true },
                        preferences = { indentSize = 2, tabSize = 2 },
                    },
                }
            })

            -- java LSP from eclipse
            vim.lsp.config("jdtls", {
                on_attach = on_attach,
                capabilities = capabilities,
            })

            -- go LSP
            vim.lsp.config("gopls", {
                cmd = { 'gopls', '-remote=auto' },
                on_attach = on_attach,
                capabilities = capabilities,
                flags = {
                    debounce_text_changes = 300,
                },
                settings = {
                    gopls = {
                        staticcheck = true,
                    }
                }
            })

            -- uber uLSP for go and java
            vim.api.nvim_create_autocmd('FileType', {
                pattern = 'go',
                callback = function(args)
                    vim.lsp.start({
                        cmd = { 'socat', '-', 'tcp:localhost:27883,ignoreeof' },
                        flags = {
                            debounce_text_changes = 300, -- Optimized from 1000ms
                        },
                        capabilities = capabilities,
                        filetypes = { 'go' },
                        root_dir = vim.fs.root(args.buf, { '.git' }),
                        single_file_support = false,
                        on_attach = function(client, bufnr)
                            -- Suppress connection messages
                            client.config.on_error = function() end
                        end,
                        handlers = {
                            -- Suppress window/showMessage notifications
                            ["window/showMessage"] = function() end,
                            -- ["window/logMessage"] = function() end,
                        },
                        docs = {
                            description = [[
                                uLSP brought to you by the IDE team!
                                By utilizing uLSP in Neovim, you acknowledge that this integration is provided 'as-is' with no warranty, express or implied.
                                We make no guarantees regarding its functionality, performance, or suitability for any purpose, and absolutely no support will be provided.
                                Use at your own risk, and may the code gods have mercy on your soul
                              ]],
                        },
                    })
                end,
            })

            vim.lsp.enable({ "jdtls", "lua_ls", "vtsls" })
        end
    },
}
