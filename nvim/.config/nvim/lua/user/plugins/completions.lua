return {
  {
    "VonHeikemen/lsp-zero.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
      { "lukas-reineke/lsp-format.nvim", config = true },
    },
    config = function()
      local lsp = require("lsp-zero")
      lsp.preset("recommended")
      lsp.ensure_installed({
        'gopls',
        'rust_analyzer',
      })
      lsp.on_attach(function(client, bufnr)
        require("lsp-format").on_attach(client, bufnr)

        local function set_buffer_keymap(mode, lhs, rhs, desc)
          local bufopts = { noremap = true, silent = true, buffer = bufnr, desc = desc }
          vim.keymap.set(mode, lhs, rhs, bufopts)
        end

        set_buffer_keymap('n', 'gT', vim.lsp.buf.type_definition, 'Goto Type')
        set_buffer_keymap('n', 'gi', vim.lsp.buf.implementation, 'Goto Implmentation')
        set_buffer_keymap('n', 'K', vim.lsp.buf.hover, 'Hover')
        set_buffer_keymap('n', '<C-k>', vim.lsp.buf.signature_help, 'Signature')
        set_buffer_keymap('i', '<C-k>', vim.lsp.buf.signature_help, 'Signature')

        set_buffer_keymap('n', '<leader>lr', vim.lsp.buf.rename, 'Rename')
        set_buffer_keymap('n', '<leader>la', vim.lsp.buf.code_action, 'Code Actions')
        set_buffer_keymap('n', 'gr', vim.lsp.buf.references, 'References')
        set_buffer_keymap('n', '<leader>lf', function() vim.lsp.buf.format { async = true } end, 'Format')
      end)
      local cmp = require("cmp")
      lsp.setup_nvim_cmp({
        -- preselect = cmp.PreselectMode.None,
        completion = {
          completeopt = 'menu,menuone,noinsert,noselect'
        },
        select_behavior = cmp.SelectBehavior.Insert,
        mapping = lsp.defaults.cmp_mappings({
          ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
          ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
          ["<C-k>"] = cmp.mapping.select_prev_item {},
          ["<C-p>"] = cmp.mapping.select_prev_item {},
          ["<C-j>"] = cmp.mapping.select_next_item {},
          ["<C-n>"] = cmp.mapping.select_next_item {},
        }),
        sources = {
          { name = 'path' },
          { name = 'nvim_lsp', priority = 1000 },
          { name = 'buffer',   keyword_length = 3 },
          { name = 'luasnip',  keyword_length = 2 },
        }
      })
      lsp.nvim_workspace()
      lsp.setup()
      vim.diagnostic.config { virtual_text = true }
    end
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "williamboman/mason.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      local nls = require "null-ls"
      nls.setup {
        sources = {
          nls.builtins.formatting.stylua,
          nls.builtins.diagnostics.ruff.with { extra_args = { "--max-line-length=180" } },
        },
      }
    end,
  },
}
