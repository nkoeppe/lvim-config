-- Adds SQL completion to nvim-cmp
return {
  "kristijanhusak/vim-dadbod-completion",
  ft = { "sql", "mysql", "plsql" },
  config = function()
    -- tell Vim which omnifunc to use in SQL buffers
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "sql", "mysql", "plsql" },
      callback = function()
        vim.bo.omnifunc = "vim_dadbod_completion#omni"
      end,
    })

    -- register the completion source just for SQL-ish filetypes
    local cmp = require "cmp"
    cmp.setup.filetype({ "sql", "mysql", "plsql" }, {
      sources = cmp.config.sources({
        { name = "vim-dadbod-completion" },
      }, { { name = "buffer" } }),
    })
  end,
}
