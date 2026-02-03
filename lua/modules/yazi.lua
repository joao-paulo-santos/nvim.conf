-- lua/modules/yazi.lua
local M = {}

local uv = vim.loop

local function safe_close(win, buf)
  if win and vim.api.nvim_win_is_valid(win) then
    pcall(vim.api.nvim_win_close, win, true)
  end
  if buf and vim.api.nvim_buf_is_valid(buf) then
    pcall(vim.api.nvim_buf_delete, buf, { force = true })
  end
end

local function read_tmp_first_line(path)
  if not path or path == "" then
    return nil
  end
  local ok, lines = pcall(vim.fn.readfile, path)
  if not ok or not lines or #lines == 0 then
    return nil
  end
  return lines[1]
end

function M.open_picker(opts)
  opts = opts or {}
  local tmp = vim.fn.tempname()

  -- start dir: file's directory or cwd
  local start_dir = vim.fn.expand("%:p:h")
  if start_dir == "" then
    start_dir = vim.loop.cwd()
  end

  -- floating window geometry
  local width = math.floor(vim.o.columns * 0.9)
  local height = math.floor(vim.o.lines * 0.9)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- create a scratch buffer for the terminal
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_name(buf, "Yazi Picker")
  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")

  -- open floating window
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })

  -- make the buffer the current buffer for termopen
  local cur_win = vim.api.nvim_get_current_win()
  vim.api.nvim_set_current_win(win)

  -- start the terminal job in the buffer; pass cwd instead of cd && ...
  local job = vim.fn.termopen(
    "cd " .. vim.fn.fnameescape(start_dir) .. " && yazi --chooser-file " .. tmp, {
      on_exit = vim.schedule_wrap(function(_, exit_code, _)
        -- read chosen file (first line)
        local path = read_tmp_first_line(tmp)

        -- cleanup tmp file (best-effort)
        pcall(uv.fs_unlink, tmp)

        -- close floating UI
        safe_close(win, buf)

        -- if user selected a file, open it
        if path and path ~= "" then
          vim.schedule(function()
            vim.cmd("edit " .. vim.fn.fnameescape(path))
          end)
        end
      end),
    })

  -- ensure we return focus to the floating window and enter insert mode
  vim.api.nvim_set_current_win(win)
  vim.cmd("startinsert")

  -- restore previous window when the floating window is closed
  -- (optional) keep a reference to previous window to restore focus
  if cur_win and vim.api.nvim_win_is_valid(cur_win) then
    -- when the terminal exits, focus will be moved by the on_exit handler;
    -- but if you want to restore focus earlier, you can do it here:
    -- vim.api.nvim_set_current_win(cur_win)
  end

  return job, tmp, win, buf
end

return M
