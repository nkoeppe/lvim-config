lvim.builtin.mason.ensure_installed = {
  "stylua",
  "css-lsp",
  "html-lsp",
  "typescript-language-server",
  "ve-language-server",
  "prisma-language-server"
}


lvim.builtin.dap.active = true


lvim.builtin.telescope.defaults.prompt_prefix = "🔍 "
lvim.builtin.telescope.defaults.selection_caret = " "
lvim.builtin.telescope.on_config_done = function(telescope)
  pcall(telescope.load_extension, 'fzf')
end
