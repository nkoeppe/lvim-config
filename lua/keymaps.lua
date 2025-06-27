lvim.builtin.which_key.mappings["t"] = {
  name = "Terminal",
  t = { "<cmd>toggleterm<CR>", "Horizontal" },
  v = { "<cmd>toggleterm direction=vertical<CR>", "Vertical" },
  f = { "<cmd>toggleterm direction=float<CR>", "Float" },
}

lvim.builtin.which_key.mappings["s"] = {
  name = "Split",
  h = { ":split<CR>", "Horizontal" },
  v = { ":vsplit<CR>", "Vertical" },
}

lvim.builtin.which_key.mappings["o"] = { "<cmd>AerialToggle!<CR>", "Toggle outline" }

lvim.builtin.which_key.mappings["d"] = {
  name = "Debug",
  b = { require("dap").toggle_breakpoint, "Toggle breakpoint" },
  c = { require("dap").continue, "Continue / start" },
  a = { require("dap").run_to_cursor, "Run to cursor" },
  i = { require("dap").step_into, "Step into" },
  o = { require("dap").step_over, "Step over" },
  O = { require("dap").step_out, "Step out" },
  r = { require("dap").repl.open, "REPL" },
  l = { require("dap").run_last, "Run last" },
  u = { require("dapui").toggle, "Toggle UI" },
}

lvim.builtin.which_key.mappings["<c-h>"] = { "<cmd><C-U>TmuxNavigateLeft<cr>", "Navigate left" }
lvim.builtin.which_key.mappings["<c-j>"] = { "<cmd><C-U>TmuxNavigateDown<cr>", "Navigate down" }
lvim.builtin.which_key.mappings["<c-k>"] = { "<cmd><C-U>TmuxNavigateUp<cr>", "Navigate up" }
lvim.builtin.which_key.mappings["<c-l>"] = { "<cmd><C-U>TmuxNavigateRight<cr>", "Navigate right" }
lvim.builtin.which_key.mappings["<c-\\]"] = { "<cmd><C-U>TmuxNavigatePrevious<cr>", "Navigate previous" }