return {
    "github/copilot.vim",
    enabled = false,
    init = function()
        vim.g.copilot_filetypes = {
            ["*"] = false,
        }
    end,
}
