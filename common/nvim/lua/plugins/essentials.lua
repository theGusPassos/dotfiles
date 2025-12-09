return {
    -- auto pairs {} ()
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
        -- use opts = {} for passing setup options
        -- this is equivalent to setup({}) function
    },

    -- DAP 
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

    -- ALE
    {
        'dense-analysis/ale',
        config = function()
            local g = vim.g

            g.ale_linters = {
                go = { 'golangci-lint' },
                lua = {},
            }
        end
    },

    -- auto tag
    {
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    }
}
