lvim.builtin.which_key.mappings["t"] = {
  name = "Terminal",
  t = { "<cmd>toggleterm<CR>", "Horizontal" },
  v = { "<cmd>toggleterm direction=vertical<CR>", "Vertical" },
  f = { "<cmd>toggleterm direction=float<CR>", "Float" },
}

lvim.builtin.which_key.mappings[" "] = { "<cmd>Telescope find_files<CR>", "Find files" }


lvim.builtin.which_key.mappings["s"] = {
  name = "Split",
  h = { ":split<CR>", "Horizontal" },
  v = { ":vsplit<CR>", "Vertical" },
}

lvim.builtin.which_key.mappings["o"] = { "<cmd>AerialToggle!<CR>", "Toggle outline" }

lvim.builtin.which_key.mappings["d"] = {
  name = "Debug",
  b = { function() require("dap").toggle_breakpoint() end, "Toggle Breakpoint" },
  c = { function() require("dap").continue() end, "Continue / Start" },
  C = { function() require("dap").run_to_cursor() end, "Run to Cursor" },
  a = { function() 
    local launch_json_path = vim.fn.getcwd() .. "/.vscode/launch.json"
    vim.notify("Checking for launch.json at: " .. launch_json_path, vim.log.levels.INFO)
    if vim.fn.filereadable(launch_json_path) then
      vim.notify("launch.json found! Attempting to load configurations.", vim.log.levels.INFO)
      local dap_vscode = require("dap.ext.vscode")
      local js_based_languages = {
        "typescript",
        "javascript",
        "typescriptreact",
        "javascriptreact",
        "vue",
      }
      -- Add "node" to the mapping as your launch.json uses type "node"
      dap_vscode.load_launchjs(nil, {
        ["pwa-node"] = js_based_languages,
        ["chrome"] = js_based_languages,
        ["pwa-chrome"] = js_based_languages,
        ["node"] = js_based_languages, -- Explicitly add 'node' type mapping
      })
      vim.notify("launch.json configurations loaded. Select a configuration.", vim.log.levels.INFO)
    else
      vim.notify("launch.json NOT found at: " .. launch_json_path, vim.log.levels.WARN)
    end
    require("dap").continue()
  end, "Run with Args (launch.json)" },
  i = { function() require("dap").step_into() end, "Step Into" },
  o = { function() require("dap").step_over() end, "Step Over" },
  O = { function() require("dap").step_out() end, "Step Out" },
  r = { function() require("dap").repl.toggle() end, "Toggle REPL" },
  l = { function() require("dap").run_last() end, "Run Last" },
  s = { function() require("dap").session() end, "Session" },
  t = { function() require("dap").terminate() end, "Terminate" },
  w = { function() require("dap.ui.widgets").hover() end, "Widgets" },
  u = { function() require("dapui").toggle() end, "Toggle UI" },
  k = { function() require("dap").up() end, "Up (Stack Frame)" },
  j = { function() require("dap").down() end, "Down (Stack Frame)" },
}

lvim.builtin.which_key.mappings["<c-h>"] = { "<cmd><C-U>TmuxNavigateLeft<cr>", "Navigate left" }
lvim.builtin.which_key.mappings["<c-j>"] = { "<cmd><C-U>TmuxNavigateDown<cr>", "Navigate down" }
lvim.builtin.which_key.mappings["<c-k>"] = { "<cmd><C-U>TmuxNavigateUp<cr>", "Navigate up" }
lvim.builtin.which_key.mappings["<c-l>"] = { "<cmd><C-U>TmuxNavigateRight<cr>", "Navigate right" }
lvim.builtin.which_key.mappings["<c-\\]"] = { "<cmd><C-U>TmuxNavigatePrevious<cr>", "Navigate previous" }