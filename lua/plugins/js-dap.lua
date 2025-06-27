-- JavaScript / TypeScript debugging via vscode-js-debug
return {
  "mxsdev/nvim-dap-vscode-js",
  ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
  dependencies = {
    "mfussenegger/nvim-dap", -- core DAP
    "rcarriga/nvim-dap-ui",  -- UI (already in LunarVim, but listing is safe)
  },
  config = function()
    require("dap-vscode-js").setup {
      debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter",
      adapters      = { "pwa-node", "pwa-chrome", "node-terminal" },
      -- Fix for nvim-notify API change
      log_file_path = vim.fn.stdpath("cache") .. "/dap-vscode-js.log",
      log_file_level = false,
      log_console_level = "error",
    }

    local dap = require "dap"

    local common = {
      cwd        = "${workspaceFolder}",
      sourceMaps = true,
      skipFiles  = { "<node_internals>/**" },
      protocol   = "inspector",
    }

    for _, ft in ipairs { "typescript", "typescriptreact", "javascript", "javascriptreact" } do
      dap.configurations[ft] = {
        vim.tbl_extend("force", common, {
          type       = "pwa-node",
          request    = "attach",
          name       = "🔥 Attach Docker EDI2 backend",
          host       = "localhost",
          port       = 9229,
          cwd        = "${workspaceFolder}/backend",
          remoteRoot = "/app",
          sourceMaps = true,
          protocol   = "inspector"
        }),
        vim.tbl_extend("force", common, {
          type      = "pwa-node",
          request   = "attach",
          name      = "Attach to process",
          processId = require("dap.utils").pick_process,
        }),
      }
    end

    
  end,
}
