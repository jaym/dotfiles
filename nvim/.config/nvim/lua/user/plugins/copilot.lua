return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      local copilot = require("copilot")
      copilot.setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = false,
            accept_word = "<M-l>",
            accept_line = "<C-l>",
            next = "<M-j>",
            prev = "<M-k>",
            dismiss = "<C-]>",
          },
        },
      })

      -- Allow TAB to trigger completion. If there are no completions available,
      -- it will insert a TAB character.
      local bufopts = { noremap = true, silent = true, }
      local suggestion = require("copilot.suggestion")

      vim.keymap.set("i", "<TAB>", function()
        if suggestion.is_visible() then
          suggestion.accept()
        else
          -- Send the tab character
          vim.api.nvim_put({ vim.api.nvim_replace_termcodes("<TAB>", true, false, true) }, "c", true, true)
        end
      end, bufopts)
    end,
  }
}
