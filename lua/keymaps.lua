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


-- local dap = require "dap"

-- lvim.builtin.which_key.mappings["d"] = {
--   name = "Debug",
--   c = { function() dap.continue() end, "Continue / Start" },
--   b = { function() dap.toggle_breakpoint() end, "Toggle Breakpoint" },
--   C = { function() dap.run_to_cursor() end, "Run to Cursor" },
--   a = { function() _G.__load_launch_json() end, "Load launch.json" },

--   -- Stepping
--   i = { function() dap.step_into() end, "Step Into" },
--   o = { function() dap.step_over() end, "Step Over" },
--   O = { function() dap.step_out() end, "Step Out" },

--   -- UI helpers
--   u = { function() require("dapui").toggle() end, "Toggle UI" },
--   r = { function() dap.repl.toggle() end, "Toggle REPL" },
--   w = { function() require("dap.ui.widgets").hover() end, "Widgets Hover" },

--   -- Misc
--   l = { function() dap.run_last() end, "Run Last" },
--   t = { function() dap.terminate() end, "Terminate" },
--   k = { function() dap.up() end, "Up Stack Frame" },
--   j = { function() dap.down() end, "Down Stack Frame" },


-- }








-- lvim.builtin.which_key.mappings["d"] = {
--   name = "Debug",
--   b = { function() require("dap").toggle_breakpoint() end, "Toggle Breakpoint" },
--   c = { function() require("dap").continue() end, "Continue / Start" },
--   C = { function() require("dap").run_to_cursor() end, "Run to Cursor" },
-- a = {
--   function()
--     ----------------------------------------------------------------------
--     -- Locate the nearest .vscode/launch.json (walking up the tree) ------
--     ----------------------------------------------------------------------
--     local function find_launch_json()
--       local dir  = vim.fn.getcwd()
--       local home = vim.fn.expand("~")

--       while dir ~= home and dir ~= "/" do
--         local file = dir .. "/.vscode/launch.json"
--         if vim.fn.filereadable(file) == 1 then return file end
--         dir = vim.fn.fnamemodify(dir, ":h")
--       end
--     end

--     local launch_json = find_launch_json()
--     if not launch_json then
--       vim.notify("launch.json not found in cwd or parents", vim.log.levels.WARN)
--       return
--     end

--     ----------------------------------------------------------------------
--     -- Load it via dap.ext.vscode, supplying an explicit type → ft map ---
--     ----------------------------------------------------------------------
--     local ft_map = {
--       node           = { "javascript", "typescript", "vue" },
--       ["pwa-node"]   = { "javascript", "typescript", "vue" },
--       chrome         = { "javascript", "typescript", "vue" },
--       ["pwa-chrome"] = { "javascript", "typescript", "vue" },
--     }

--     require('dap').adapters['pwa-node'] = {
--       type = 'server',
--       host = 'localhost',
--       port = '${port}',
--       executable = {
--         command = 'node',
--         args = {
--           get_pkg_path('js-debug-adapter', '/js-debug/src/dapDebugServer.js'),
--           '${port}',
--         },
--       },
--     }
--     require("dap.ext.vscode").load_launchjs(launch_json, ft_map)
--     vim.notify("launch.json loaded from " .. launch_json, vim.log.levels.INFO)
--   end,
--   "Load launch.json configs",
-- },
-- i = { function() require("dap").step_into() end, "Step Into" },
--   o = { function() require("dap").step_over() end, "Step Over" },
--   O = { function() require("dap").step_out() end, "Step Out" },
--   r = { function() require("dap").repl.toggle() end, "Toggle REPL" },
--   l = { function() require("dap").run_last() end, "Run Last" },
--   s = { function() require("dap").session() end, "Session" },
--   t = { function() require("dap").terminate() end, "Terminate" },
--   w = { function() require("dap.ui.widgets").hover() end, "Widgets" },
--   u = { function() require("dapui").toggle() end, "Toggle UI" },
--   k = { function() require("dap").up() end, "Up (Stack Frame)" },
--   j = { function() require("dap").down() end, "Down (Stack Frame)" },
-- }
-- lvim.builtin.which_key.mappings["d"].a = { load_launch_json, "Load launch.json configs" }



lvim.builtin.which_key.mappings["<c-h>"] = { "<cmd><C-U>TmuxNavigateLeft<cr>", "Navigate left" }
lvim.builtin.which_key.mappings["<c-j>"] = { "<cmd><C-U>TmuxNavigateDown<cr>", "Navigate down" }
lvim.builtin.which_key.mappings["<c-k>"] = { "<cmd><C-U>TmuxNavigateUp<cr>", "Navigate up" }
lvim.builtin.which_key.mappings["<c-l>"] = { "<cmd><C-U>TmuxNavigateRight<cr>", "Navigate right" }
lvim.builtin.which_key.mappings["<c-\\]"] = { "<cmd><C-U>TmuxNavigatePrevious<cr>", "Navigate previous" }
