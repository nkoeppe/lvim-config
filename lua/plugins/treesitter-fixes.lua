---@file plugins/treesitter-fixes.lua

return {
  "nvim-treesitter/nvim-treesitter",

  opts = function(_, opts)
    -- stop the ‘kind-eq?’ panic until upstream lands a universal fix
    opts.indent = { enable = false }
  end,

  config = function()
    -- replace the malformed query/highlights.scm that ships with ≤ 6c939e2
    local tsq = require("vim.treesitter.query")
    if tsq and tsq.set then
      tsq.set("query", "highlights", [[
        (comment)    @comment
        (identifier) @variable
      ]])
    end
  end,
}
