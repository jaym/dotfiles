local function run_telescope(builtin, opts)
  return function()
    require("telescope.builtin")[builtin](opts)
  end
end
return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    keys = {
      { "<leader>b",  "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Buffers" },
      { "<leader>:",  "<cmd>Telescope command_history<cr>",               desc = "Command History" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>",                       desc = "Buffers" },
      { "<leader>ff", "<cmd>Telescope find_files<cr>",                    desc = "Find Files" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>",                      desc = "Recent" },
      -- git
      { "<leader>gc", "<cmd>Telescope git_commits<CR>",                   desc = "commits" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>",                    desc = "status" },
      { "<leader>gb", "<cmd>Telescope git_branches<CR>",                  desc = "branches" },
      -- search
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>",     desc = "Buffer" },
      { "<leader>sc", "<cmd>Telescope command_history<cr>",               desc = "Command History" },
      { "<leader>sC", "<cmd>Telescope commands<cr>",                      desc = "Commands" },
      { "<leader>sd", "<cmd>Telescope diagnostics<cr>",                   desc = "Diagnostics" },
      { "<leader>sg", "<cmd>Telescope live_grep<cr>",                     desc = "Grep" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>",                     desc = "Help Pages" },
      { "<leader>sH", "<cmd>Telescope highlights<cr>",                    desc = "Search Highlight Groups" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>",                       desc = "Key Maps" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>",                     desc = "Man Pages" },
      { "<leader>sm", "<cmd>Telescope marks<cr>",                         desc = "Jump to Mark" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>",                   desc = "Options" },
      { "<leader>sR", "<cmd>Telescope resume<cr>",                        desc = "Resume" },
      { "<leader>sw", "<cmd>Telescope grep_string<cr>",                   desc = "Word" },
      {
        "<leader>ss",
        run_telescope("lsp_document_symbols", {
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          },
        }),
        desc = "Goto Symbol",
      },
    },
    cmd = "Telescope",
    config = function()
      local actions = require('telescope.actions')
      require('telescope').setup {
        defaults = {
          mappings = {
            i = {
              -- map actions.which_key to <C-h> (default: <C-/>)
              -- actions.which_key shows the mappings for your picker,
              -- e.g. git_{create, delete, ...}_branch for the git_branches picker
              ["<C-h>"] = "which_key",
              ["<C-j>"] = {
                actions.move_selection_next, type = "action",
                opts = { nowait = true, silent = true }
              },
              ["<C-k>"] = {
                actions.move_selection_previous, type = "action",
                opts = { nowait = true, silent = true }
              },
            }
          }
        }
      }
    end
  },
}
