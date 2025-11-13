vim.keymap.set('n', '<leader>gt', '<cmd>exe v:count1 . ":ToggleTerm size=10" <CR>', opts)

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n><C-w>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

return {
  {'akinsho/toggleterm.nvim', version = "*", config = true }
}


