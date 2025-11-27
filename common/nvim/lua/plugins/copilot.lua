return {
  "github/copilot.vim",
  init = function()
    vim.g.copilot_filetypes = {
      ["*"] = true,
      txt = false,
    }
  end,
}

