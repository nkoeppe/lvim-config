-- Symbol outline sidebar
return {
  "stevearc/aerial.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  opts = {
    layout = { default_direction = "right" },
    backends = { "lsp", "treesitter", "markdown" },
  },
  
}
