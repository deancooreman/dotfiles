-- init.lua

-- disable netrw (using oil.nvim)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = " "

require("config.options")
require("config.keybinds")
require("config.lazy")

