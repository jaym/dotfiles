return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
      "MunifTanjim/nui.nvim"
    },
    keys = {
      { "<leader>nf", "<cmd>NvimTreeFocus<cr>",  desc = "NvimTreeFocus" },
      { "<leader>nn", "<cmd>NvimTreeToggle<cr>", desc = "NvimTreeToggle" },
    },
    config = true
  }
}
