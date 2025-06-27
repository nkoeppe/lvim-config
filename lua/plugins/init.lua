-- Sammelt alle Dateien in ~/.config/lvim/lua/plugins (außer init.lua)
local plugin_dir = vim.fn.stdpath("config") .. "/lua/plugins"
local files      = vim.fn.readdir(plugin_dir)

lvim.plugins     = lvim.plugins or {}

for _, file in ipairs(files) do
  if file:sub(-4) == ".lua" and file ~= "init.lua" then
    local ok, spec = pcall(dofile, plugin_dir .. "/" .. file)
    if ok and spec then
      table.insert(lvim.plugins, spec)
    else
      vim.notify(("Plugin-Datei %s konnte nicht geladen werden: %s"):format(file, spec), vim.log.levels.ERROR)
    end
  end
end
