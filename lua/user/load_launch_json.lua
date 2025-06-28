local M = { _loaded = false } -- cache flag to avoid double-loading

function M.load(opts)
  if M._loaded and not (opts and opts.force) then
    vim.notify("launch.json already loaded – skip", vim.log.levels.DEBUG)
    return
  end

  local vscode = require("dap.ext.vscode")
  local home   = vim.loop.os_homedir()
  local launch = vim.fs.find(".vscode/launch.json",
    { upward = true, stop = home, type = "file", limit = 1 })[1]

  if not launch then
    vim.notify("launch.json not found (searched up to " .. home .. ")", vim.log.levels.WARN)
    return
  end

  -- snapshot how many configs are present *before* we load
  local before, after = {}, {}
  local dap = require("dap")
  for ft, cfg in pairs(dap.configurations) do before[ft] = #cfg end

  vscode.load_launchjs(launch, {
    ["pwa-node"]   = { "javascript", "typescript", "vue", "svelte" },
    ["pwa-chrome"] = { "javascript", "typescript", "vue" },
    node           = { "javascript", "typescript" },
    chrome         = { "javascript", "typescript" },
  })

  -- count again
  for ft, cfg in pairs(dap.configurations) do
    local n = #cfg
    if n > (before[ft] or 0) then
      after[#after + 1] = string.format("• %s → +%d", ft, n - (before[ft] or 0))
    end
  end

  M._loaded = true
  vim.notify(("Loaded launch.json → %s\n%s")
    :format(launch, #after > 0 and table.concat(after, "\n") or "no new configs"),
    vim.log.levels.INFO)
end

return M
