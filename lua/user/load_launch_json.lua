-- ~/.config/lvim/lua/user/load_launch_json.lua
-- Loads the closest .vscode/launch.json and patches ALL configs (defaults + file)
-- to honour global toggles like smart-step / skip-node_modules.
-- Keeps a cache flag so we don’t inject duplicates.

local M = { _loaded = false }

----------------------------------------------------------------------
--  Walk every config table and inject smart-step / skip-deps flags
----------------------------------------------------------------------
local function apply_overrides()
  local dap = require("dap")

  for _, cfgs in pairs(dap.configurations) do
    for _, cfg in ipairs(cfgs) do
      if not cfg.type then goto continue end -- ← NEW guard

      -- smart-step for JS/TS adapters
      if vim.g.dap_js_smart_step
          and (cfg.type:match("^pwa") or cfg.type == "js_docker") then
        cfg.smartStep = true
      end

      -- skip node_modules when toggle is on
      if vim.g.dap_skip_node_modules then
        cfg.skipFiles = cfg.skipFiles or { "<node_internals>/**" }
        local found = false
        for _, pat in ipairs(cfg.skipFiles) do
          if pat == "${workspaceFolder}/node_modules/**" then
            found = true; break
          end
        end
        if not found then
          table.insert(cfg.skipFiles, "${workspaceFolder}/node_modules/**")
        end
      end

      ::continue::
    end
  end
end


function M.load(opts)
  if M._loaded and not (opts and opts.force) then
    return
  end

  ---------------------------------------------------------------------------
  -- 1. Find nearest .vscode/launch.json (walk up to $HOME)
  ---------------------------------------------------------------------------
  local home   = vim.loop.os_homedir()
  local launch = vim.fs.find(".vscode/launch.json",
    { upward = true, stop = home, type = "file", limit = 1 })[1]

  if not launch then
    vim.notify("launch.json not found (searched up to " .. home .. ")", vim.log.levels.DEBUG)
  else
    -------------------------------------------------------------------------
    -- 2. Map adapter-name → filetypes so load_launchjs keeps our configs
    -------------------------------------------------------------------------
    local ft_map = {
      ["pwa-node"]   = { "javascript", "typescript", "vue", "svelte" },
      ["pwa-chrome"] = { "javascript", "typescript", "vue" },
      node           = { "javascript", "typescript" },
      chrome         = { "javascript", "typescript" },

      -- NEW: tell the loader that the custom adapter belongs to JS/TS files
      js_docker      = { "javascript", "typescript", "vue", "svelte" },
    }

    require("dap.ext.vscode").load_launchjs(launch, ft_map)
    vim.notify("Loaded launch.json → " .. launch, vim.log.levels.INFO)
  end

  ---------------------------------------------------------------------------
  -- 3. Apply global flags (smart-step, skip-deps) to EVERY configuration
  ---------------------------------------------------------------------------
  apply_overrides()
  M._loaded = true
end

return M
