require('options')
require('keymaps')
require('loader')

require("mason").setup({
    registries = {
        "github:mason-org/mason-registry",
        -- roslyn registry
        "github:Crashdummyy/mason-registry",
    },
})

vim.lsp.enable('lua_ls')
