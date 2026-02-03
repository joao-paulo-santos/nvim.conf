return {
  { "nvim-lua/plenary.nvim" },

  {
    "folke/tokyonight.nvim",
    opts = { transparent = true, },
    lazy = false,
    priority = 1000,
    config = function(_, opts)
      vim.cmd.colorscheme("tokyonight")
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.config").setup({
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup()
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        pickers = {
          buffers = {
            mappings = {
              n = { ["dd"] = "delete_buffer" },
            },
          },
        },
      })
    end,
  },
  {
    "mason-org/mason.nvim",
    opts = {}
  },
}
