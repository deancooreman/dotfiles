-- Leader key
vim.g.mapleader=" "

-- Line numbers
vim.o.number=true

-- Distance from cursor
vim.o.relativenumber=true

-- Plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({
  "tpope/vim-fugitive",
})
