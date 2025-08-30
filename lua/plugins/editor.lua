return {
  -- Fuzzy finder
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("fzf-lua").setup({
        winopts = {
          height = 0.85,
          width = 0.80,
          row = 0.35,
          col = 0.50,
          preview = {
            layout = "flex",
            flip_columns = 130,
          },
        },
      })
    end,
  },

  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
        ts_config = {
          lua = { "string", "source" },
          javascript = { "string", "template_string" },
        },
        disable_filetype = { "TelescopePrompt", "spectre_panel" },
      })
    end,
  },

  -- Surround
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = true,
  },

  -- Comment
  {
    "numToStr/Comment.nvim",
    config = true,
  },

  -- Better text objects
  {
    "echasnovski/mini.ai",
    version = false,
    config = function()
      require("mini.ai").setup()
    end,
  },

  -- Git integration
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gstatus", "Gblame", "Gpush", "Gpull" },
  },

  -- Git signs in gutter
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "▎" },
          change = { text = "▎" },
          delete = { text = "" },
          topdelete = { text = "" },
          changedelete = { text = "▎" },
          untracked = { text = "▎" },
        },
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = false,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol",
          delay = 1000,
          ignore_whitespace = false,
        },
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil,
        max_file_length = 40000,
        preview_config = {
          border = "single",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return "<Ignore>"
          end, { expr = true, desc = "Next hunk" })

          map("n", "[c", function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return "<Ignore>"
          end, { expr = true, desc = "Previous hunk" })

          -- Actions
          map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
          map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
          map("v", "<leader>hs", function()
            gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "Stage hunk" })
          map("v", "<leader>hr", function()
            gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "Reset hunk" })
          map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer" })
          map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
          map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
          map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
          map("n", "<leader>hb", function()
            gs.blame_line({ full = true })
          end, { desc = "Blame line" })
          map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle blame line" })
          map("n", "<leader>hd", gs.diffthis, { desc = "Diff this" })
          map("n", "<leader>hD", function()
            gs.diffthis("~")
          end, { desc = "Diff this ~" })
          map("n", "<leader>td", gs.toggle_deleted, { desc = "Toggle deleted" })

          -- Text object
          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
        end,
      })
    end,
  },

  -- GitHub integration
  {
    "tpope/vim-rhubarb",
    dependencies = { "tpope/vim-fugitive" },
  },

  -- Git blame
  {
    "f-person/git-blame.nvim",
    event = "BufReadPre",
    config = function()
      require("gitblame").setup({
        enabled = true,
        message_template = " <summary> • <date> • <author>",
        date_format = "%m-%d-%Y %H:%M:%S",
        virtual_text_column = 1,
      })
    end,
  },

  -- Unimpaired mappings
  {
    "tpope/vim-unimpaired",
  },

  -- Which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      require("which-key").setup()
    end,
  },

  -- Todo comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
  },

  -- Better quickfix
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
  },

  -- Trouble
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup()
      vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { desc = "Toggle trouble" })
      vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
        { desc = "Workspace diagnostics" })
      vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { desc = "Document diagnostics" })
      vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { desc = "Quickfix" })
      vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { desc = "Location list" })
    end,
  },

  -- Floating terminal
  {
    "voldikss/vim-floaterm",
    config = function()
      -- Floaterm設定
      vim.g.floaterm_width = 0.8
      vim.g.floaterm_height = 0.8
      vim.g.floaterm_position = "center"
      vim.g.floaterm_borderchars = "─│─│╭╮╯╰"
      vim.g.floaterm_autoclose = 2
      vim.g.floaterm_opener = "edit"
      
      -- キーマッピング
      vim.keymap.set("n", "<leader>tt", "<cmd>FloatermToggle<cr>", { desc = "Toggle floaterm" })
      vim.keymap.set("n", "<leader>tn", "<cmd>FloatermNew<cr>", { desc = "New floaterm" })
      vim.keymap.set("n", "<leader>tk", "<cmd>FloatermKill<cr>", { desc = "Kill floaterm" })
      vim.keymap.set("n", "<leader>t]", "<cmd>FloatermNext<cr>", { desc = "Next floaterm" })
      vim.keymap.set("n", "<leader>t[", "<cmd>FloatermPrev<cr>", { desc = "Previous floaterm" })
      
      -- ターミナルモード内でのキーマッピング
      vim.keymap.set("t", "<leader>tt", "<C-\\><C-n><cmd>FloatermToggle<cr>", { desc = "Toggle floaterm" })
      vim.keymap.set("t", "<leader>tn", "<C-\\><C-n><cmd>FloatermNew<cr>", { desc = "New floaterm" })
      vim.keymap.set("t", "<leader>tk", "<C-\\><C-n><cmd>FloatermKill<cr>", { desc = "Kill floaterm" })
      vim.keymap.set("t", "<leader>t]", "<C-\\><C-n><cmd>FloatermNext<cr>", { desc = "Next floaterm" })
      vim.keymap.set("t", "<leader>t[", "<C-\\><C-n><cmd>FloatermPrev<cr>", { desc = "Previous floaterm" })
      
      -- 便利なコマンド用ショートカット
      vim.keymap.set("n", "<leader>tg", "<cmd>FloatermNew lazygit<cr>", { desc = "Open lazygit" })
      vim.keymap.set("n", "<leader>td", "<cmd>FloatermNew lazydocker<cr>", { desc = "Open lazydocker" })
      vim.keymap.set("n", "<leader>tr", "<cmd>FloatermNew ranger<cr>", { desc = "Open ranger" })
    end,
  },
}

