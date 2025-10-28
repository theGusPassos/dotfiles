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
    {
        "neovim/nvim-lspconfig",
        config = function()
            -- General LSP keymaps and setup
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local bufnr = args.buf

                    -- General LSP keymaps
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
                    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr })
                    vim.keymap.set("n", "<leader>f", function()
                        vim.lsp.buf.format({ async = true })
                    end, { buffer = bufnr })

                    -- Diagnostic keymaps
                    vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float,
                        { buffer = bufnr, desc = "Show line diagnostics" })
                    vim.keymap.set("n", "<leader>th", function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
                    end, { buffer = bufnr, desc = "Toggle inlay hints" })
                end
            })

            vim.lsp.config("clojure_lsp", {
                root_dir = function(bufnr, on_dir)
                    local pattern = vim.api.nvim_buf_get_name(bufnr)
                    local util = require("lspconfig.util")
                    local fallback = vim.loop.cwd()
                    local patterns = { "project.clj", "deps.edn", "build.boot", "shadow-cljs.edn", ".git", "bb.edn" }
                    local root = util.root_pattern(patterns)(pattern)
                    return on_dir((root or fallback))
                end
            })
            vim.lsp.enable('clojure_lsp')

            vim.lsp.enable('lua_ls')

            vim.lsp.config('ts_ls', {
                cmd = { 'typescript-language-server', '--stdio' },
                filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
            })
            vim.lsp.enable("ts_ls")

            vim.lsp.config("gopls", {
                settings = {
                    gopls = {
                        -- multi module
                        experimentalWorkspaceModule = true,
                        analyses = {
                            unusedparams = true,
                        },
                        staticcheck = true,
                        gofumpt = true,
                    }
                }
            })
            vim.lsp.enable("gopls")
        end
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
        -- use opts = {} for passing setup options
        -- this is equivalent to setup({}) function
    },
    {
        'mfussenegger/nvim-dap',
        config = function()
            local dap = require("dap")
            dap.adapters.coreclr = {
                type = 'executable',
                command = '/usr/bin/netcoredbg',
                args = { '--interpreter=vscode' }
            }

            dap.configurations.cs = {
                {
                    type = "coreclr",
                    name = "launch - netcoredbg",
                    request = "launch",
                    program = function()
                        return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
                    end,
                },
            }

            vim.fn.sign_define('DapBreakpoint', { text = '🟥', texthl = '', linehl = '', numhl = '' })
            vim.fn.sign_define('DapStopped', { text = '▶️', texthl = '', linehl = '', numhl = '' })

            vim.keymap.set("n", "<F1>", dap.continue, {})
            vim.keymap.set("n", "<F2>", dap.step_over, {})
            vim.keymap.set("n", "<F3>", dap.step_into, {})

            vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)
        end
    },
    { "nvim-neotest/nvim-nio" },
    {
        'rcarriga/nvim-dap-ui',
        requires = { 'mfussengger/nvim-dap', 'nvim-neotest/nvim-nio' },
        config = function()
            local dap, dapui = require("dap"), require("dapui")
            dapui.setup()

            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end
        end
    },
    {
        'theHamsta/nvim-dap-virtual-text'
    },
}
