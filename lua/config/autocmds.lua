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
    vim.wo.winhighlight = "Normal:NormalNC"
  end,
})

-- Create highlight groups for active/inactive windows
autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    -- フォーカス中のウィンドウの背景色（黒っぽい色）
    vim.api.nvim_set_hl(0, "ActiveWindow", { bg = "#0a0a0f" })
    -- フォーカスが外れたウィンドウの背景色（薄い色）
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "#1a1a2e" })
    -- オプション: ステータスラインやその他の要素も調整可能
    vim.api.nvim_set_hl(0, "WinBarNC", { bg = "#1a1a2e", fg = "#808080" })
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
    local file = (vim.uv or vim.loop).fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})
