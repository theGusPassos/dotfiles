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

require("nvim-treesitter.configs").setup({
    ensure_installed = { "c_sharp", "clojure", "go", "gomod", "gosum", "gotmpl", "java"},
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
    }
})

vim.cmd [[colorscheme cyberdream]]

-- theme transparency

-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
-- vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
-- vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
-- vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })

--vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
--vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none" })

