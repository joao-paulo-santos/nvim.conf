return {
  { "nvim-lua/plenary.nvim" },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
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
      require('nvim-treesitter').install({ 'rust', 'javascript', 'zig' }):wait(300000) -- wait max. 5 minutes
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      integrations = {
        treesitter = true,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
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
    dependencies = { -- OPTIONAL
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'ibhagwan/fzf-lua',
    },
    opts = {},
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "DrKJeff16/project.nvim"
    },
    config = function()
      require('project').setup()
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
