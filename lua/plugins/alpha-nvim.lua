return {
  "goolord/alpha-nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "nvim-telescope/telescope.nvim",
    "folke/persistence.nvim",
  },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
      "Welcome to Neovim",
    }

    dashboard.section.buttons.val = {
      dashboard.button("e", "  New file", ":ene <BAR> startinsert<CR>"),
      dashboard.button("r", "  Recent files", ":Telescope oldfiles<CR>"),
      dashboard.button("p", " Projects", ":Telescope projects<CR>"),
      dashboard.button("s", " Restore Session", ":lua require('persistence').load()<CR>"),
      dashboard.button("l", " Last Session", ":lua require('persistence').load({ last = true })<CR>"),
      dashboard.button("q", "  Quit", ":qa<CR>"),
    }

    alpha.setup(dashboard.opts)
  end,
}
