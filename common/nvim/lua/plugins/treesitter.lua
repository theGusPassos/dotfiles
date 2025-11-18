return {
    "nvim-treesitter/nvim-treesitter",

    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "c_sharp",
                "clojure",
                "go",
                "gomod",
                "gosum",
                "gotmpl",
                "java",
            },

            highlight = {
                enable = true,
                additional_vim_regex_highlighting = true,
            },
        })
    end,
}
