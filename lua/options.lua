--------- OPTIONS ---------

vim.opt.relativenumber = true
vim.opt.wrap = true

lvim.log.level = "info"
lvim.format_on_save.enabled = true

lvim.colorscheme = "catppuccin"
lvim.transparent_window = true


-- local dap = require("dap")

-- dap.adapters.node = dap.adapters["pwa-node"]



----------------------------------------------------------------------
--  Debugging QoL toggles / theme tweaks
----------------------------------------------------------------------
-- 1) Skip stepping into node_modules unless you flip it off
vim.g.dap_skip_node_modules = true -- set false if you really need to dive in

-- 2) Smart-step through generated code (JS/TS only)
vim.g.dap_js_smart_step     = true

-- 3) Inline-values virtual text looks like a regular comment
vim.api.nvim_set_hl(0, "DapVirtualText", { link = "Comment" })
