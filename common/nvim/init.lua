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

vim.cmd [[colorscheme kanagawa]]

-- theme transparency

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
--vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
--vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none" })
vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })

