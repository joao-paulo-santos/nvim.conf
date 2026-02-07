-- 1. basic options
require("options")

-- 2. keymaps
require("keymaps")

require("lsp")

-- require("format").setup()

-- 3. lazy.nvim bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 4. load plugins
require("lazy").setup("plugins")

require("noice").setup({
  cmdline = {
    enabled = true,
    view = "cmdline_popup",
  },
  messages = {
    enabled = false, -- disable message UI (fixes :reg floating)
  },
  popupmenu = {
    enabled = true,
    backend = "nui",
  },
  notify = {
    enabled = false, -- disable Noice notifications
  },
  lsp = {
    progress = { enabled = false },
    hover = { enabled = true },
    signature = { enabled = true },
    message = { enabled = false },
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  presets = {
    bottom_search = false,
    command_palette = true,
    long_message_to_split = true,
    inc_rename = false,
    lsp_doc_border = true,
  },
})

local autocmds = require("autocmds")
autocmds.setup_yank_highlight()
autocmds.setup_session_restore()

vim.api.nvim_create_autocmd('FileType', {
  pattern = { '*' },
  callback = function()
    -- remove error = false when nvim 0.12+ is default
    if vim.treesitter.get_parser(nil, nil, { error = false }) then
      vim.treesitter.start()
    end
  end,
})

vim.cmd.colorscheme("vscode") -- starting theme
