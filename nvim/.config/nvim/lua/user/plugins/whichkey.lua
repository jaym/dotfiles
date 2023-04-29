return {
  "folke/which-key.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    window = {
      border = "single",        -- none, single, double, shadow
      position = "bottom",      -- bottom, top
      margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]
      padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
      winblend = 0,             -- value between 0-100 0 for fully opaque and 100 for fully transparent
    },
    defaults = {
      mode = { "n", "v" },
      ["<leader>f"] = { name = "+find" },
      ["<leader>s"] = { name = "+search" },
      ["<leader>g"] = { name = "+git" },
      ["g"] = { name = "+goto" },
    },
  },
  config = function(_, opts)
    vim.o.timeout = true
    vim.o.timeoutlen = 300
    local wk = require("which-key")
    wk.setup(opts)
    wk.register(opts.defaults)
  end
}
