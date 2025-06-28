--------- OPTIONS ---------

vim.opt.relativenumber = true
vim.opt.wrap = true

lvim.log.level = "info"
lvim.format_on_save.enabled = true

lvim.colorscheme = "catppuccin"
lvim.transparent_window = true


local dap = require("dap")

dap.adapters.node = dap.adapters["pwa-node"]
