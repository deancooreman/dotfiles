-- option.lua

local set = vim.opt

-- lines and columns

set.number = true
set.cursorline = true

-- scrolling behavior

set.scrolloff = 3

-- identation and wrap

set.autoindent = true
set.expandtab = true
set.linebreak = true
set.shiftround = true
set.shiftwidth = 2
set.showbreak = "↪"
set.softtabstop = 2
set.tabstop = 2

-- save, back-up and undo files

set.autoread = true
set.autowrite = true
set.backup = false
set.hidden = true
set.swapfile = false
set.undodir = vim.fn.stdpath("data") .."/undodir"
set.undofile = true
set.updatetime = 50

-- search settings

set.incsearch = true
set.ignorecase = true
set.smartcase = true

-- backspace behavior

set.backspace = "indent,eol,start"

-- use desktop clipboard

set.clipboard:append("unnamedplus")

-- Session options

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
