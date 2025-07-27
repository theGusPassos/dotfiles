return {
  {
    "Hoffs/omnisharp-extended-lsp.nvim",
    ft = "cs",
    config = function()
      local omnisharp_path = "/home/gus/.omnisharp/OmniSharp"
      local pid = vim.fn.getpid()
      local config = {
        cmd = { omnisharp_path, "--languageserver", "--hostPID", tostring(pid) },
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        handlers = {
          ["textDocument/definition"] = require('omnisharp_extended').handler,
        },
        settings = {
          OmniSharp = {
            enableRoslynAnalyzers = true,
            organizeImportsOnFormat = true,
            enableImportCompletion = true,
          }
        },
      }
      
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "cs",
        callback = function(args)
          local clients = vim.lsp.get_clients({ name = "omnisharp" })
          if #clients == 0 then
            vim.lsp.start(config)
          end
        end
      })
    end
  }
}
