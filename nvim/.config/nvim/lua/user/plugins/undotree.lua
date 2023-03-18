return {
  {
    'https://github.com/mbbill/undotree',
    cmd = 'UndotreeToggle',
    keys = {
      { '<leader>u', vim.cmd.UndotreeToggle, silent = true, noremap = true },
    },
  }
}
