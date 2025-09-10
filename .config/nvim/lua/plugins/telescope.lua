local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Search only git files' })
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = 'Search str in files' })

local telescope_custom_actions = {}

function telescope_custom_actions._multiopen(prompt_bufnr, open_cmd)
    local picker = action_state.get_current_picker(prompt_bufnr)
    local selected_entry = action_state.get_selected_entry()
    local num_selections = #picker:get_multi_selection()
    if not num_selections or num_selections <= 1 then
        actions.add_selection(prompt_bufnr)
    end
    actions.send_selected_to_qflist(prompt_bufnr)
    vim.cmd("cfdo " .. open_cmd)
end

function telescope_custom_actions.multi_selection_open_vsplit(prompt_bufnr)
    telescope_custom_actions._multiopen(prompt_bufnr, "vsplit")
end

local builtin = require('telescope').setup({
    defaults = {
        mappings = {
            i = {
                ["<C-V>"] = telescope_custom_actions.multi_selection_open_vsplit
            },
            n = i,
        }
    }
})

return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
}
