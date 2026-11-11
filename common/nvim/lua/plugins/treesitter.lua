return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false, -- main doesn't support lazy-loading
    build = ":TSUpdate",
    config = function()
        local langs = {
            "c_sharp",
            "clojure",
            "go",
            "gomod",
            "gosum",
            "gotmpl",
            "html",
            "java",
            "markdown",
            "markdown_inline",
            -- "python",
            "sql",
            "tsx",
        }
        require("nvim-treesitter").install(langs)

        vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
                if pcall(vim.treesitter.start, args.buf) then
                    -- equivalent of additional_vim_regex_highlighting = true
                    vim.bo[args.buf].syntax = "on"
                end
            end,
        })
    end,
}
