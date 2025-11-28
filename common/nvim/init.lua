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

vim.cmd [[colorscheme cyberdream]]
