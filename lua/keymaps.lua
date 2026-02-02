local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- leader
vim.g.mapleader = " "

-- quality of life
map("n", "<leader>w", "<cmd>w<cr>", opts)
map("n", "<leader>q", "<cmd>q<cr>", opts)
map("n", "<leader>h", "<cmd>nohlsearch<cr>", opts)

-- window navigation (keep these if you like them)
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)


vim.keymap.set("n", "<leader>y", function()
  local tmp = vim.fn.tempname()

  vim.cmd("terminal yazi --chooser-file " .. tmp)
  vim.cmd("startinsert")

  vim.api.nvim_create_autocmd("TermClose", {
    buffer = 0,
    once = true,
    callback = function()
      local f = io.open(tmp, "r")
      if not f then return end

      local path = f:read("*l")
      f:close()

      if not path or path == "" then
        return
      end

      -- schedule the file opening so Neovim treats it normally
      vim.schedule(function()
        -- update working directory
        vim.cmd("cd " .. vim.fn.fnamemodify(path, ":h"))

        -- open file normally (this triggers filetype + Treesitter automatically)
        vim.cmd("edit " .. path)
      end)
    end,
  })
end, { desc = "Open Yazi file picker" })
