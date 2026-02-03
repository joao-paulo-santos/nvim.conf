return {
  "folke/persistence.nvim",
  event = "BufReadPre", 
  lazy = false, 
  opts = {
    dir = vim.fn.stdpath("state") .. "/sessions/",
    options = { "buffers", "curdir", "tabpages", "winsize" },
  }
}