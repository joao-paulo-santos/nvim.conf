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
      local ok, _ = pcall(require("telescope").load_extension, "projects")
      if not ok then
        require("telescope").load_extension("project_nvim")
      end
    end,
  },
  {
    "mason-org/mason.nvim",
    opts = {}
  },
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {
      builtin_marks = {},
    },
  },
}
