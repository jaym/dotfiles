return {
  {
    "ray-x/go.nvim",
    dependencies = { "ray-x/guihua.lua" },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ":lua require('go.install').update_all_sync()",
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    },
    config = function()
      require("mason-null-ls").setup({
        ensure_installed = {
          "cppcheck",
          "cpplint",
          "ruff",
          "staticcheck",
          "stylua",
        }
      })
    end,
  },
  {
    "VonHeikemen/lsp-zero.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "jay-babu/mason-null-ls.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
      { "lukas-reineke/lsp-format.nvim", config = true },
      "folke/trouble.nvim",
    },
    config = function()
      local lsp = require("lsp-zero")
      lsp.preset({
        name = "recommended",
        set_lsp_keymaps = { preserve_mappings = false },
      })
      lsp.ensure_installed({
        'gopls',
        'rust_analyzer',
      })
      lsp.on_attach(function(client, bufnr)
        require("lsp-format").on_attach(client, bufnr)
        local telescope = require("telescope.builtin")

        local function set_buffer_keymap(mode, lhs, rhs, desc)
          local bufopts = { noremap = true, silent = true, buffer = bufnr, desc = desc }
          vim.keymap.set(mode, lhs, rhs, bufopts)
        end

        set_buffer_keymap('n', 'gT', "<cmd>TroubleToggle lsp_type_definitions<cr>", 'Goto Type')
        set_buffer_keymap('n', 'gi', "<cmd>TroubleToggle lsp_implementations<cr>", 'Goto Implmentation')
        set_buffer_keymap('n', 'gd', "<cmd>TroubleToggle lsp_definitions<cr>", 'Goto Definition')
        set_buffer_keymap('n', 'gr', "<cmd>TroubleToggle lsp_references<cr>", 'References')
        set_buffer_keymap('n', 'gD', vim.lsp.buf.declaration, 'Goto Declaration')

        set_buffer_keymap('n', 'K', vim.lsp.buf.hover, 'Hover')
        set_buffer_keymap('n', '<C-k>', vim.lsp.buf.signature_help, 'Signature')
        set_buffer_keymap('n', '<leader>lr', vim.lsp.buf.rename, 'Rename')
        set_buffer_keymap('n', '<leader>la', vim.lsp.buf.code_action, 'Code Actions')
        set_buffer_keymap('n', '<leader>ls', telescope.lsp_dynamic_workspace_symbols, 'Symbols')
        set_buffer_keymap('n', '<leader>lf', function() vim.lsp.buf.format { async = true } end, 'Format')
        set_buffer_keymap('i', '<C-k>', vim.lsp.buf.signature_help, 'Signature')

        set_buffer_keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>", "TroubleToggle")
        set_buffer_keymap("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics")
        set_buffer_keymap("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", "Document Diagnostics")
        set_buffer_keymap("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", "LocList")
        set_buffer_keymap("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", "Quickfix")

        local capabilities = client.server_capabilities
        if capabilities.codeLensProvider then
          vim.api.nvim_create_autocmd({ 'BufEnter', 'InsertLeave' }, {
            buffer = bufnr,
            callback = function()
              vim.lsp.codelens.refresh()
            end
          })

          set_buffer_keymap('n', '<leader>ll', function() vim.lsp.codelens.refresh() end, 'Refresh CodeLens')
          set_buffer_keymap('n', '<leader>lL', function() vim.lsp.codelens.run() end, 'Run CodeLens')
        end
      end)
      local cmp = require("cmp")
      local cmp_mappings = lsp.defaults.cmp_mappings({
        ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<C-k>"] = cmp.mapping.select_prev_item {},
        ["<C-p>"] = cmp.mapping.select_prev_item {},
        ["<C-j>"] = cmp.mapping.select_next_item {},
        ["<C-n>"] = cmp.mapping.select_next_item {},
      })
      cmp_mappings['<Tab>'] = nil
      cmp_mappings['<S-Tab>'] = nil
      lsp.setup_nvim_cmp({
        -- preselect = cmp.PreselectMode.None,
        completion = {
          completeopt = 'menu,menuone,noinsert,noselect'
        },
        select_behavior = cmp.SelectBehavior.Insert,
        mapping = cmp_mappings,
        sources = {
          { name = 'path' },
          { name = 'nvim_lsp', priority = 1000 },
          { name = 'buffer',   keyword_length = 3 },
          { name = 'luasnip',  keyword_length = 2 },
        }
      })
      lsp.nvim_workspace()

      lsp.configure("gopls", {
        settings = {
          gopls = {
            staticcheck = true,
            codelenses = {
              test = true,
            }
          },
        },
      })

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
          nls.builtins.diagnostics.cppcheck,
          nls.builtins.diagnostics.cpplint,
          nls.builtins.diagnostics.shellcheck,
          nls.builtins.diagnostics.staticcheck,
        },
      }
    end,
  },
  {
    "folke/trouble.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
        { silent = true, noremap = true }
      )
      vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
        { silent = true, noremap = true }
      )
      vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
        { silent = true, noremap = true }
      )
      vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>",
        { silent = true, noremap = true }
      )
      vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
        { silent = true, noremap = true }
      )

      require("trouble").setup()
    end
  }
}
