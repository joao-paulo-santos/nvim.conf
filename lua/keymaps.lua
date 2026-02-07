local map = vim.keymap.set

-- leader
vim.g.mapleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move selection up" })

-- quality of life
map("n", "<leader>w", "<cmd>w<cr>", { noremap = true, silent = true, desc = "save file" })
map("n", "<leader>qq", "<cmd>q<cr>", { noremap = true, silent = true, desc = "quit" })
map("n", "<leader>qb", ":bp | bd #<CR>", { noremap = true, silent = true, desc = "remove current buffer" })
map("n", "<leader>h", "<cmd>nohlsearch<cr>", { noremap = true, silent = true, desc = "clear search" })


vim.keymap.set("n", "<leader>ff", function()
  require("telescope.builtin").find_files()
end, { desc = "Find files" })

vim.keymap.set("n", "<leader>fg", function()
  require("telescope.builtin").live_grep()
end, { desc = "Live grep" })

vim.keymap.set("n", "<leader>fF", function()
  require("telescope.builtin").git_files()
end, { desc = "Git files" })

vim.keymap.set("n", "<leader>fp", "<cmd>Telescope projects<cr>", { desc = "Projects" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
vim.keymap.set("n", "<C-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "<C-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })

vim.keymap.set("n", "<leader>s", function()
  require("snipe").open_buffer_menu()
end, { desc = "Snipe: Open buffer menu" })

vim.keymap.set("n", "<leader>y", function()
  require("modules.yazi").open_picker()
end, { desc = "Open Yazi file picker" })

vim.keymap.set("i", "<C-j>", function()
  return vim.fn.pumvisible() == 1 and "<C-n>" or "<C-j>"
end, { expr = true })

vim.keymap.set("i", "<C-k>", function()
  return vim.fn.pumvisible() == 1 and "<C-p>" or "<C-k>"
end, { expr = true })

vim.keymap.set({ "n", "v" }, "c", '"_c')

vim.keymap.set("n", "<C-z>", "<Nop>")
vim.keymap.set("i", "<C-z>", "<Nop>")
vim.keymap.set("v", "<C-z>", "<Nop>")

vim.keymap.set("n", "<leader>rr", function()
  local file = vim.fn.expand("%:p")
  package.loaded[file] = nil
  vim.cmd("luafile " .. file)
  print("Reloaded " .. file)
end, { desc = "Reload current config file" })

vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

local themes = { "catppuccin", "vscode", "tokyonight", "rose-pine" }
local current = 1

vim.keymap.set("n", "<leader>tt", function()
  current = current % #themes + 1
  vim.cmd.colorscheme(themes[current])
  print("Theme: " .. themes[current])
end)
