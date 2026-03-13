return {
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      require("tokyonight").setup({ flavour = "moon" })
      vim.cmd.colorscheme("tokyonight")
    end,
  },
}

