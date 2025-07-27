return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- General LSP keymaps and setup
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          local bufnr = args.buf

          -- General LSP keymaps
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr })
          vim.keymap.set("n", "<leader>f", function()
            vim.lsp.buf.format({ async = true })
          end, { buffer = bufnr })

          -- Diagnostic keymaps
          vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float, 
            { buffer = bufnr, desc = "Show line diagnostics" })
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, 
            { buffer = bufnr, desc = "Previous diagnostic" })
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, 
            { buffer = bufnr, desc = "Next diagnostic" })
        end
      })

      vim.diagnostic.config({
        -- Show error messages inline
        virtual_text = true,
        -- Show signs in gutter
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })
    end
  },
  {
    -- autocomplete
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args) require("luasnip").lsp_expand(args.body) end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }),
      })
    end
  }
}
