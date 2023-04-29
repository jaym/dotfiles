return {
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<leader>t"] = { name = "+terminal" },
      },
    }
  },
  {
    "voldikss/vim-floaterm",
    keys = {
      { '<leader>tt', '<cmd>FloatermToggle<cr>',                            desc = 'Floating Terminal' },
      { '<leader>tv', '<cmd>FloatermNew --wintype=vsplit --width=0.33<cr>', desc = 'Vertial Split' },
      { '<leader>tx', '<cmd>FloatermNew --wintype=split --height=0.33<cr>', desc = 'Horizontal Split' },
      { '<leader>tq', '<cmd>FloatermToggle<cr>',                            desc = 'Floating Terminal' },
      {
        '<C-y>',
        '<cmd>FloatermToggle<cr>',
        desc = 'Previous Terminal',
        mode = { 't', 'i', 'n' }
      },
    },
    cmd = { "FloatermToggle", "FloattermNew" },
    config = function()
      vim.g.floaterm_width = 0.8
      vim.g.floaterm_height = 0.8
      vim.g.floaterm_title = 0
      vim.g.floaterm_position = 'center'
      vim.g.floaterm_autoclose = 1
    end
  },
}
