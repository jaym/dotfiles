return {
  'nvim-neorg/neorg',
  build = ":Neorg sync-parsers",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-cmp",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require('neorg').setup {
      load = {
        ["core.defaults"] = {},
        ["core.completion"] = { config = { engine = "nvim-cmp", name = "[Norg]" } },
        ["core.integrations.nvim-cmp"] = {},
        ["core.concealer"] = { config = { icon_preset = "diamond" } },
        ["core.export"] = {},
        ["core.keybinds"] = {
          -- https://github.com/nvim-neorg/neorg/blob/main/lua/neorg/modules/core/keybinds/keybinds.lua
          config = {
            default_keybinds = true,
            neorg_leader = ",",
          },
        },
      }
    }
  end,
}
