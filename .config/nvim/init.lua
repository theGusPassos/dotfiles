require('options')
require('keymaps')
require('loader')

vim.lsp.config['omnisharp'] = {
    cmd = { '/home/gus/.omnisharp/OmniSharp', '--languageserver', '--hostPID', tostring(vim.fn.getpid()) }
}

vim.lsp.enable('omnisharp')

