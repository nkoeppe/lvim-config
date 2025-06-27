--- Seamless navigation between Neovim windows and tmux panes.
--
return {
  "christoomey/vim-tmux-navigator",
  event = "VeryLazy",
  config = function()
    -- The plugin automatically sets up the keymaps below, so we just need to load it.
    -- We can even leave the default keymaps enabled, as they are the ones we want.
    -- For reference, the default keymaps are:
    -- vim.keymap.set('n', '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>')
    -- vim.keymap.set('n', '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>')
    -- vim.keymap.set('n', '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>')
    -- vim.keymap.set('n', '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>')
    -- vim.keymap.set('n', '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>')
  end,
}