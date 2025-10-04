local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-a>", "<C-w>", opts)

-- Window management
keymap("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

keymap("n", "<C-S-h>", ":vertical resize -5<CR>", { silent = true })
keymap("n", "<C-S-l>", ":vertical resize +5<CR>", { silent = true })
keymap("n", "<C-S-j>", ":resize +2<CR>", { silent = true })
keymap("n", "<C-S-k>", ":resize -2<CR>", { silent = true })

-- Buffer navigation
keymap("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })
keymap("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

-- Tab navigation
keymap("n", "tn", "<cmd>tabn<CR>", opts)
keymap("n", "tp", "<cmd>tabp<CR>", opts)
keymap("n", "to", "<cmd>tabnew<CR>", opts)
keymap("n", "tx", "<cmd>tabclose<CR>", opts)

-- Terminal
keymap("t", "<Esc>", [[<C-\><C-n>]], opts)
keymap("t", "<C-[>", [[<C-\><C-n>]], opts)
keymap("t", "jj", [[<C-\><C-n>]], opts)
-- keymap("n", "<leader>tt", "<cmd>terminal<CR>", { desc = "Open terminal" }) -- Floatermで代替

-- Insert mode
keymap("i", "jj", "<Esc>", opts)

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Clear search highlighting
keymap("n", "<leader>nh", "<cmd>nohl<CR>", { desc = "Clear search highlights" })

-- Increment/decrement numbers
keymap("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- Copy file path to clipboard
keymap("n", "<leader>cp", '<cmd>let @+=expand("%")<CR>', { desc = "Copy file path" })
keymap("n", "<leader>cP", '<cmd>let @+=expand("%:p")<CR>', { desc = "Copy full file path" })

-- LSP
keymap("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
keymap("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
keymap("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
keymap("n", "gt", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
keymap("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
keymap("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
keymap("n", "gK", vim.lsp.buf.signature_help, { desc = "Signature help" })
keymap("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
keymap("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
keymap("v", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
keymap("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, { desc = "Format document" })
keymap("n", "gl", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
keymap("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
keymap("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
keymap("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

-- Fzf-lua
keymap("n", "<C-p>", "<cmd>lua require('fzf-lua').files()<CR>", { desc = "Find files" })
keymap("n", "<C-\\>", "<cmd>lua require('fzf-lua').buffers()<CR>", { desc = "Find buffers" })
keymap("n", "<C-g>", "<cmd>lua require('fzf-lua').live_grep_glob()<CR>", { desc = "New live grep" })
keymap("n", "<leader>fh", "<cmd>lua require('fzf-lua').help_tags()<CR>", { desc = "Help tags" })
keymap("n", "<leader>fc", "<cmd>lua require('fzf-lua').commands()<CR>", { desc = "Commands" })
keymap("n", "<leader>fo", "<cmd>lua require('fzf-lua').oldfiles()<CR>", { desc = "Recent files" })
keymap("n", "<leader>fb", "<cmd>lua require('fzf-lua').builtin()<CR>", { desc = "Fzf builtin" })

-- Neo-tree
keymap("n", "<leader>E", "<cmd>Neotree toggle<CR>", { desc = "Toggle file explorer" })
keymap("n", "<leader>o", "<cmd>Neotree focus<CR>", { desc = "Focus file explorer" })

-- Git
keymap("n", "<leader>gs", "<cmd>lua require('fzf-lua').git_status()<CR>", { desc = "Git status files" })
keymap("n", "<leader>gc", "<cmd>lua require('fzf-lua').git_commits()<CR>", { desc = "Git commits" })
keymap("n", "<leader>gC", "<cmd>lua require('fzf-lua').git_bcommits()<CR>", { desc = "Buffer git commits" })
keymap("n", "<leader>gf", "<cmd>lua require('fzf-lua').git_files()<CR>", { desc = "Git tracked files" })

-- Git blame
keymap("n", "<leader>gb", "<cmd>GitBlameToggle<CR>", { desc = "Toggle git blame" })
keymap("n", "<leader>gB", "<cmd>GitBlameCopySHA<CR>", { desc = "Copy git blame SHA" })
keymap("n", "<leader>go", "<cmd>GitBlameOpenCommitURL<CR>", { desc = "Open commit URL" })
