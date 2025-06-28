-- ~/.config/lvim/lua/plugins/dap.lua
return {

  -- Core client + comfy keymaps in the *same* spec
  {
    "mfussenegger/nvim-dap",
    keys = { -- nice UX bindings
      {
        "<F5>",
        function()
          -- try to bring in launch.json the first time you debug
          require("user.load_launch_json").load()
          require("dap").continue()
        end,
        desc = "DAP • Continue (auto-load launch.json)"
      },
      { "<F10>", function() require("dap").step_over() end, desc = "DAP • Step over" },
      { "<F11>", function() require("dap").step_into() end, desc = "DAP • Step into" },
      { "<F12>", function() require("dap").step_out() end, desc = "DAP • Step out" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "DAP • Toggle breakpoint" },
      {
        "<leader>dB",
        function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        desc = "DAP • Conditional breakpoint"
      },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "DAP • Toggle REPL" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "DAP • Toggle UI" },
      {
        "<leader>dl",
        function() require("user.load_launch_json").load() end,
        desc = "DAP • Load launch.json"
      },
    },
  },

  -- Pretty side panes
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    opts = { floating = { border = "rounded" } },
    config = function(_, opts)
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui"]     = function() dapui.close() end
    end,
  },

  -- Inline virtual-text
  { "theHamsta/nvim-dap-virtual-text",  dependencies = "mfussenegger/nvim-dap", opts = { commented = true } },

  -- Mason bridge (auto-installs js-debug)
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
    opts = { ensure_installed = { "js-debug-adapter" }, automatic_installation = true },
  },

  -- VS Code JS/TS adapter (> 1.76 path fix)
  {
    "mxsdev/nvim-dap-vscode-js",
    dependencies = "mfussenegger/nvim-dap",
    ft = { "javascript", "typescript", "javascriptreact", "typescriptreact", "vue", "svelte" },
    opts = function()
      -- local registry = require("mason-registry")
      -- local path = registry.get_package("js-debug-adapter"):get_install_path()
      return {
        -- debugger_path = path .. "/js-debug/src/dapDebugServer.js",
        debugger_cmd = { "js-debug-adapter", "0" },
        adapters = { "pwa-node", "pwa-chrome", "pwa-msedge",
          "node-terminal", "pwa-extensionHost", "node", "chrome" },
      }
    end,
    config = function(_, opts)
      require("dap-vscode-js").setup(opts)
      for _, lang in ipairs({ "javascript", "typescript", "javascriptreact",
        "typescriptreact", "vue", "svelte" }) do
        require("dap").configurations[lang] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "▶ Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            skipFiles = { "<node_internals>/**" },
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "⏸ Attach",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            skipFiles = { "<node_internals>/**" },
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "🧪 Jest current file",
            runtimeExecutable = "node",
            runtimeArgs = { "./node_modules/jest/bin/jest.js", "--runInBand", "${file}", "--coverage" },
            rootPath = "${workspaceFolder}",
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
          },
        }
      end
    end,
  },

  -- Telescope integration
  { "nvim-telescope/telescope-dap.nvim" },
}
