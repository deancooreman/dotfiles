return {
  -- FZF
  {
    "junegunn/fzf.vim",
    dependencies = { "junegunn/fzf" },
    keys = {
      { "<leader><leader>", ":Files<CR>",   desc = "Find files" },
      { "<leader>,",        ":Buffers<CR>", desc = "Find buffers" },
      { "<leader>/",        ":Rg<CR>",      desc = "Search project" },
    },
  },

  -- File explorer
  {
    "stevearc/oil.nvim",
    keys = { { "-", ":Oil<CR>", desc = "Browse files" } },
    config = function()
      require("oil").setup({ view_options = { show_hidden = true } })
    end,
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function() require("nvim-autopairs").setup({}) end,
  },

  -- Comments
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function() require("Comment").setup({}) end,
  },

  -- Auto session
  {
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup({
        auto_restore = true,
        auto_restore_last_session = true,
        auto_save = true,
        enabled = true,
        suppressed_dirs = {
          vim.fn.expand("~"),
          vim.fn.expand("~/Downloads"),
          vim.fn.expand("~/Desktop"),
        },
      })

      vim.keymap.set("n", "<leader>ls", ":SessionSearch<CR>", {
        noremap = true,
        desc = "Search sessions",
      })
    end,
  },
}
