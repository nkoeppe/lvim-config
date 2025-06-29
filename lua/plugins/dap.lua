-- ~/.config/lvim/lua/plugins/dap.lua
return {
  ---------------------------------------------------------------------------
  -- 1. Core client + keymaps
  ---------------------------------------------------------------------------
  {
    "mfussenegger/nvim-dap",
    -- Handy key-bindings (same mnemonics as before)
    keys = {
      {
        "<F5>",
        function()
          require("user.load_launch_json").load() -- auto-load once
          require("dap").continue()
        end,
        desc = "DAP • Continue / Start"
      },
      { "<F10>", function() require("dap").step_over() end, desc = "DAP • Step over" },
      { "<F11>", function() require("dap").step_into() end, desc = "DAP • Step into" },
      { "<F12>", function() require("dap").step_out() end, desc = "DAP • Step out" },
      {
        "<leader>db",
        function() require("dap").toggle_breakpoint() end,
        desc = "DAP • Toggle breakpoint"
      },
      {
        "<leader>dB",
        function()
          require("dap").set_breakpoint(vim.fn.input("Condition: "))
        end,
        desc = "DAP • Conditional breakpoint"
      },
      {
        "<leader>dr",
        function() require("dap").repl.toggle() end,
        desc = "DAP • Toggle REPL"
      },
      {
        "<leader>du",
        function() require("dapui").toggle() end,
        desc = "DAP • Toggle UI"
      },
      {
        "<leader>dl",
        function() require("user.load_launch_json").load({ force = true }) end,
        desc = "DAP • Reload launch.json"
      },
    },

    -------------------------------------------------------------------------
    -- Adapter definitions (JS / TS via vscode-js-debug)
    -------------------------------------------------------------------------
    config = function()
      local dap      = require("dap")
      local registry = require("mason-registry")
      local js_debug = registry.get_package("js-debug-adapter")
      local debugger = js_debug:get_install_path() .. "/js-debug/src/dapDebugServer.js"

      -- Re-usable factory
      local function make_adapter(name)
        return {
          type       = "server",
          host       = "127.0.0.1",
          port       = "${port}", -- nvim-dap injects a free port here
          executable = { command = "node", args = { debugger, "${port}" } },
        }
      end

      dap.adapters["pwa-node"]   = dap.adapters["pwa-node"] or make_adapter("pwa-node")
      dap.adapters["pwa-chrome"] = dap.adapters["pwa-chrome"] or make_adapter("pwa-chrome")

      -- dap.adapters["js_docker"]  = {
      --   type = "server",
      --   host = "127.0.0.1",
      --   port = 8123,
      -- }


      -- dap.adapters.node2 = {
      --   type    = 'executable',
      --   command = 'node',
      --   args    = {
      --     vim.fn.stdpath('data')
      --     .. '/mason/packages/node-debug2-adapter/out/src/nodeDebug.js',
      --   },
      -- }


      -----------------------------------------------------------------------
      -- Default configs (⇧/F5 menu) – you can still add launch.json entries
      -----------------------------------------------------------------------
      local languages    = {
        "javascript", "typescript", "javascriptreact",
        "typescriptreact", "vue", "svelte",
      }

      local base_configs = {
        -- {
        --   type       = "pwa-node",
        --   request    = "launch",
        --   name       = "▶ Launch file",
        --   program    = "${file}",
        --   cwd        = "${workspaceFolder}",
        --   sourceMaps = true,
        --   skipFiles  = { "<node_internals>/**" },
        -- },
        -- {
        --   type       = "pwa-node",
        --   request    = "attach",
        --   name       = "⏸ Attach process",
        --   processId  = require("dap.utils").pick_process,
        --   cwd        = "${workspaceFolder}",
        --   sourceMaps = true,
        --   skipFiles  = { "<node_internals>/**" },
        -- },
        -- {
        --   type              = "pwa-node",
        --   request           = "launch",
        --   name              = "🧪 Jest current file",
        --   runtimeExecutable = "node",
        --   runtimeArgs       = {
        --     "./node_modules/jest/bin/jest.js",
        --     "--runInBand",
        --     "${file}",
        --   },
        --   cwd               = "${workspaceFolder}",
        --   console           = "integratedTerminal",
        -- },
        -- {
        --   name             = 'Attach - Nest (Docker) (Node 2)',
        --   type             = 'node2',
        --   request          = 'attach',
        --   port             = 9229,        -- node --inspect=0.0.0.0:9229
        --   address          = '127.0.0.1', -- or the container IP
        --   protocol         = 'inspector',

        --   sourceMaps       = true,
        --   localRoot        = vim.fn.getcwd(), -- host project root
        --   remoteRoot       = '/app',          -- path **inside** the container
        --   outFiles         = { '${workspaceFolder}/dist/**/*.js' },

        --   skipFiles        = { '<node_internals>/**' },
        --   -- optional: suppress attaching to every forked worker
        --   attachSimplePort = 9229,
        -- },

        -- {
        --   -- Docker-attached debugger (see: https://medium.com/@ryan.matthews.professional/debug-a-node-js-project-running-in-docker-6a16b786821d)
        --   type             = "pwa-node",
        --   request          = "attach",
        --   name             = "🐳 Attach Docker node",
        --   localRoot        = vim.fn.getcwd(),
        --   cwd              = "${workspaceFolder}",
        --   remoteRoot       = "/app",
        --   websocketAddress = function()
        --     -- Replace <container-name> with your container
        --     local out = vim.fn.system({ "docker", "logs", "<container-name>" })
        --     return string.match(out, "ws:%S+")
        --   end,
        -- },
      }

      for _, lang in ipairs(languages) do
        dap.configurations[lang] = dap.configurations[lang] or {}
        vim.list_extend(dap.configurations[lang], base_configs)
      end
    end
  },

  ---------------------------------------------------------------------------
  -- 2. UI, virtual-text, Mason bridge, Telescope helpers
  ---------------------------------------------------------------------------
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
  { "theHamsta/nvim-dap-virtual-text",  dependencies = "mfussenegger/nvim-dap", opts = {} },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
    opts = { ensure_installed = { "js-debug-adapter" } }
  },
  { "nvim-telescope/telescope-dap.nvim" },
}
