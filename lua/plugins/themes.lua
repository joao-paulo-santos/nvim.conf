return {
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
      -- vim.cmd.colorscheme("catppuccin")
    end,
  },
  {
    "Mofiqul/vscode.nvim",
    name = "vscode",
    priority = 1000,
    opts = {
      -- Alternatively set style in setup
      -- style = 'light'

      -- Enable transparent background
      -- transparent = true,

      -- Enable italic comment
      italic_comments = true,

      -- Enable italic inlay type hints
      italic_inlayhints = true,

      -- Underline `@markup.link.*` variants
      underline_links = true,

      -- Disable nvim-tree background color
      disable_nvimtree_bg = true,

      -- Apply theme colors to terminal
      terminal_colors = true,

      -- Override colors (see ./lua/vscode/colors.lua)
      color_overrides = {
        vscLineNumber = '#FFFFFF',
      },

      -- Override highlight groups (see ./lua/vscode/theme.lua)
      group_overrides = {
        -- this supports the same val table as vim.api.nvim_set_hl
        -- use colors from this colorscheme by requiring vscode.colors!
      }
    },
    config = function(_, opts)
      require("vscode").setup(opts)
      -- vim.cmd.colorscheme "vscode"
    end,
  },
  {
    "folke/tokyonight.nvim",
    opts = { transparent = true, },
    lazy = false,
    priority = 1000,
    config = function(_, opts)
      -- vim.cmd.colorscheme("tokyonight")
    end
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      -- vim.cmd("colorscheme rose-pine")
    end
  }
}
