local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  group = "YankHighlight",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- Terminal settings
augroup("TerminalSettings", { clear = true })
autocmd("TermOpen", {
  group = "TerminalSettings",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.cmd("startinsert")
  end,
})

-- Format on save
augroup("FormatOnSave", { clear = true })
autocmd("BufWritePre", {
  group = "FormatOnSave",
  pattern = "*",
  callback = function()
    local clients = vim.lsp.get_active_clients()
    if #clients > 0 then
      vim.lsp.buf.format({ async = false })
    end
  end,
})

-- Focused window highlight
augroup("FocusedWindow", { clear = true })
autocmd("WinEnter", {
  group = "FocusedWindow",
  callback = function()
    vim.wo.winhighlight = "Normal:ActiveWindow"
  end,
})
autocmd("WinLeave", {
  group = "FocusedWindow",
  callback = function()
    vim.wo.winhighlight = ""
  end,
})

-- Create highlight group for active window
autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "ActiveWindow", { bg = "#2a2a3e" })
  end,
})

-- Unfold all on file open
autocmd("BufRead", {
  pattern = "*",
  command = "normal! zR",
})

-- Disable diagnostics in node_modules
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*/node_modules/*",
  callback = function()
    vim.diagnostic.disable(0)
  end,
})

-- Auto create directory when saving file
autocmd("BufWritePre", {
  pattern = "*",
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Auto open Netrw on startup
autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    -- Only open if no files were specified
    if vim.fn.argc() == 0 then
      vim.cmd("Texplore")
    end
  end,
})