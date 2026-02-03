vim.lsp.enable('lua_ls')
vim.lsp.enable('gopls')
vim.lsp.enable('ts_ls')
vim.lsp.enable('omnisharp')
vim.lsp.enable('clangd')

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    --    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
    --      vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
    --      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    --      vim.keymap.set('i', '<C-Space>', function()
    --        vim.lsp.completion.get()
    --      end)
    --    end
    if not client:supports_method('textDocument/willSaveWaitUntil')
        and client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
  end,
})


-- Diagnostics
vim.diagnostic.config({
  -- Use the default configuration
  -- virtual_lines = true

  -- Alternatively, customize specific options
  virtual_lines = {
    -- Only show virtual line diagnostics for the current cursor line
    current_line = true,
  },
})
