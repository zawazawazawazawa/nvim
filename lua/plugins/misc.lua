return {
  -- Image preview
  {
    "3rd/image.nvim",
    ft = { "markdown", "norg", "typst" },
    config = function()
      require("image").setup({
        backend = "kitty",
        processor = "magick_cli",
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            filetypes = { "markdown", "vimwiki" },
          },
          neorg = {
            enabled = true,
            filetypes = { "norg" },
          },
          typst = {
            enabled = true,
            filetypes = { "typst" },
          },
          html = {
            enabled = false,
          },
          css = {
            enabled = false,
          },
        },
        max_width = nil,
        max_height = nil,
        max_width_window_percentage = nil,
        max_height_window_percentage = 50,
        window_overlap_clear_enabled = false,
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "snacks_notif" },
        editor_only_render_when_focused = false,
        tmux_show_only_in_active_window = false,
        hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" },
      })
    end,
  },

  -- CSV support
  {
    "chrisbra/csv.vim",
    ft = { "csv", "tsv" },
    config = function()
      -- CSVファイルを開いた時に自動的に列を整列
      vim.g.csv_autocmd_arrange = 1
      -- 区切り文字の設定
      vim.g.csv_delim = ','
      -- ヘッダー行を強調表示
      vim.g.csv_highlight_column = 'y'
    end,
  },

  -- Terraform
  {
    "hashivim/vim-terraform",
    ft = { "terraform", "tf", "hcl" },
  },

  -- Dart
  {
    "dart-lang/dart-vim-plugin",
    ft = "dart",
  },
}