return {
  "rcarriga/nvim-notify",
  config = function()
    -- route early messages through nvim-notify
    vim.notify = require("notify")
    require("notify").setup {
      stages  = "slide",
      timeout = 2500,
    }
  end,
}
