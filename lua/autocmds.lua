local M = {}

function M.setup_yank_highlight()
  -- Optional: define a custom highlight group (adjust colors to your colorscheme)
  vim.api.nvim_set_hl(0, "YankHighlight", { link = "Visual" })

  -- Create an augroup so we can clear/reload safely
  local group = vim.api.nvim_create_augroup("YankHighlightGroup", { clear = true })

  vim.api.nvim_create_autocmd("TextYankPost", {
    group = group,
    callback = function(event)
      -- Use the built-in helper; timeout controls how long the highlight stays (ms)
      vim.highlight.on_yank({
        higroup = "YankHighlight",
        timeout = 200,
        on_visual = true,
      })
    end,
  })
end

function M.setup_session_restore()
  local group = vim.api.nvim_create_augroup("PersistenceRestoreGroup", { clear = true })

  vim.api.nvim_create_autocmd("VimEnter", {
    group = group,
    callback = function()
      -- Only restore if we didn't start nvim with any file arguments
      vim.schedule(function()
        if vim.fn.argc() == 0 and not vim.g.started_with_stdin then
          require("persistence").load()
        end
      end)
    end,
    nested = true, -- important to allow other autocmds (like LSP) to fire after load
  })

  vim.api.nvim_create_autocmd("User", {
    pattern = { "PersistedLoadPost", "PersistenceLoadPost" }, -- Covers both plugins
    group = group,
    callback = function()
      -- The discussion suggests a small delay is necessary
      vim.defer_fn(function()
        vim.cmd("normal! zx") -- Recompute folds
        vim.cmd("normal! zR") -- Open all folds (optional, if you want them open)
      end, 100)
    end,
  })
end

return M
