-- Sammelt alle Dateien in ~/.config/lvim/lua/plugins (außer init.lua)
local plugin_dir = vim.fn.stdpath("config") .. "/lua/plugins"
local files      = vim.fn.readdir(plugin_dir)

lvim.plugins     = lvim.plugins or {}

table.insert(lvim.plugins, { "nvim-tree/nvim-web-devicons", lazy = false })


for _, file in ipairs(files) do
  if file:sub(-4) == ".lua" and file ~= "init.lua" then
    local ok, spec = pcall(dofile, plugin_dir .. "/" .. file)
    if ok and spec then
      if vim.tbl_islist(spec) and type(spec[1]) == "table" then
        -- the file returned a list of specs → push each one
        for _, s in ipairs(spec) do
          table.insert(lvim.plugins, s)
        end
      else
        -- normal single-spec file
        table.insert(lvim.plugins, spec)
      end
    else
      vim.notify(("Plugin-Datei %s konnte nicht geladen werden: %s"):format(file, spec), vim.log.levels.ERROR)
    end
  end
end
