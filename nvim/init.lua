-- =========================
-- Basic settings
-- =========================
vim.g.mapleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.undofile = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.termguicolors = true

-- =========================
-- lazy.nvim bootstrap
-- =========================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- =========================
-- Plugins
-- =========================
require("lazy").setup({
  -- Colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({ flavour = "mocha" })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- FZF (Fixed for Windows)
  {
    "junegunn/fzf.vim",
    dependencies = { "junegunn/fzf" }, 
    keys = {
      { "<leader><leader>", ":Files<CR>", desc = "Find files" },
      { "<leader>,", ":Buffers<CR>", desc = "Find buffers" },
      { "<leader>/", ":Rg<CR>", desc = "Search project" },
    },
  },

  -- File explorer (oil)
  {
    "stevearc/oil.nvim",
    keys = { { "-", ":Oil<CR>", desc = "Browse files" } },
    config = function() require("oil").setup({ view_options = { show_hidden = true } }) end,
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

  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    build = "cd app && npm install",
    init = function() vim.g.mkdp_filetypes = { "markdown" } end,
    keys = { { "<leader>mp", ":MarkdownPreviewToggle<CR>", desc = "Markdown preview" } },
  },

  -- =========================
  -- LSP + completion stack
  -- =========================
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      require("mason").setup({})
      require("mason-lspconfig").setup({
        ensure_installed = { "bashls", "powershell_es", "pyright", "marksman" },
        automatic_installation = true,
      })

      local cmp = require("cmp")
      local luasnip = require("luasnip") 
      local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

      cmp.setup({
        snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
            else fallback() end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then luasnip.jump(-1)
            else fallback() end
          end, { "i", "s" }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          { name = "buffer" },
        },
      })

      local on_attach = function(_, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      end

      -- Setup servers
      local lspconfig = require("lspconfig")
      local servers = { "bashls", "powershell_es", "pyright", "marksman" }
      
      for _, server in ipairs(servers) do
        local config = {
          on_attach = on_attach,
          capabilities = lsp_capabilities,
        }

        -- Specific fix for PowerShell Editor Services on Windows
        if server == "powershell_es" then
          config.bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services"
        end

        lspconfig[server].setup(config)
      end
    end,
  },
})
