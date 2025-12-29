-- OPTIONS
local set = vim.opt

--line nums
set.relativenumber = true
set.number = true
set.cursorline = true

-- indentation and tabs
set.tabstop = 4
set.shiftwidth = 4
set.autoindent = true
set.expandtab = true

-- search settings
set.ignorecase = true
set.smartcase = true

-- LSP and completion settings
set.completeopt = "menu,menuone,noselect"
set.updatetime = 300
set.signcolumn = "yes"

-- Better editing experience
set.mouse = "a"
set.clipboard = "unnamedplus"
set.undofile = true
set.undodir = vim.fn.stdpath("data") .. "/undodir"

-- Better search
set.hlsearch = true
set.incsearch = true

-- Better window management
set.splitbelow = true
set.splitright = true

-- Better terminal behavior
set.scrolloff = 8
set.sidescrolloff = 8

-- Disable swap files
set.swapfile = false

-- Better file handling
set.hidden = true
set.wrap = false
set.linebreak = true
