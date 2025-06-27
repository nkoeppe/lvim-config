-- Cloud AI autocompletion
return {
  "Exafunction/codeium.nvim",
  event = "InsertEnter",
  config = function()
    require("codeium").setup()
    vim.keymap.set("i", "<C-g>", function() return vim.fn["codeium#Accept"]() end, { expr = true, desc = "Accept" })
    vim.keymap.set("i", "<C-;>", function() return vim.fn end, { expr = true, desc = "Next" })
    vim.keymap.set("i", "<C-,>", function() return vim.fn["codeium#CycleCompletions"](-1) end,
      { expr = true, desc = "Prev" })
    vim.keymap.set("i", "<C-x>", function() return vim.fn["codeium#Clear"]() end, { expr = true, desc = "Clear" })
  end,
}
