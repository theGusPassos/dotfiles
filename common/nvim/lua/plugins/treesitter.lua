return {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "c_sharp",
                "clojure",
                "go",
                "gomod",
                "gosum",
                "gotmpl",
                "html",
                "java",
                "markdown",
                "sql",
                "tsx",
            },

            highlight = {
                enable = true,
                additional_vim_regex_highlighting = true,
            },
        })
    end,
}
