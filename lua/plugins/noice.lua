return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    notify,                        -- guarantees nvim-notify is present
    "nvim-tree/nvim-web-devicons", -- icons for Noice + lir.nvim
  },
  opts = {
    lsp = {
      progress = { enabled = true },
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"]                = true,
        ["cmp.entry.get_documentation"]                  = true,
      },
    },
    popupmenu = { backend = "nui" },
    presets = {
      bottom_search         = true,
      command_palette       = true,
      long_message_to_split = true,
      lsp_doc_border        = true,
    },
    views = { mini = { win_options = { winblend = 0 } } },
  },
  config = function(_, opts)
    require("noice").setup(opts)

    -- which-key bindings (run only when which-key is available)
    if lvim.builtin and lvim.builtin.which_key then
      lvim.builtin.which_key.mappings["N"] = {
        name = "Noice",
        h = { "<cmd>Noice history<CR>", "History" },
        d = {
          function() require("notify").dismiss { silent = true, pending = true } end,
          "Dismiss all",
        },
      }
    end
  end,
}

