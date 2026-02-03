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
      require("nvim-treesitter").setup({
        ensure_installed = {
          "go", "python", "c", "cpp", "rust",
          "javascript", "typescript", "html", "css",
          "bash", "json", "lua", "vim", "vimdoc"
        },
        auto_install = true,
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
    'DrKJeff16/project.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    main = "project_nvim",
    opts = {
      detection_methods = { "lsp", "pattern" },
      patterns = { ".git", "package.json" },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "DrKJeff16/project.nvim"
    },
    config = function()
      require("project_nvim").setup({
        -- your project settings
      })
      local telescope = require("telescope")
      telescope.setup({
        pickers = {
          buffers = {
            mappings = {
              n = { ["dd"] = "delete_buffer" },
            },
          },
        },
      })
      pcall(telescope.load_extension, "projects")
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    config = function()
      -- Settings for UFO
      vim.o.foldcolumn = '1'
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      require('ufo').setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { 'treesitter', 'indent' }
        end
      })
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
