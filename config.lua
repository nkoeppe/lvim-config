local modules = {
  "options",
  "keymaps",
  "plugins.init",
  "builtin-overrides"
}

for _, m in ipairs(modules) do
  local ok, err = pcall(require, m)
  if not ok then
    vim.notify(("Fehler beim Laden von %s:\n%s"):format(m, err), vim.log.levels.ERROR)
  end
end

vim.notify("Test notification from config.lua", vim.log.levels.INFO)
