--- Seamless navigation between Neovim windows and tmux panes.
--
return {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
    "TmuxNavigatorProcessList",
  },
}
-- return {
--   "christoomey/vim-tmux-navigator",
--   event = "VeryLazy",
--   -- lazy = false,                          -- sofort laden, damit alle Modi abgedeckt sind
--   init = function()
--     vim.g.tmux_navigator_no_mappings = 1 -- Standard-<C-h/j/k/l> aktiviert
--   end,
-- }
-- return {}