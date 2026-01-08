
local global = vim.g
local o = vim.opt

global.mapleader = " "
global.maplocalleader = ","

o.colorcolumn = "120"

if vim.fn.has("clipboard") == 1 then
    o.clipboard = "unnamedplus"
else 
    o.clipboard = "unnamed"
end

o.completeopt = {'menu', 'menuone', 'noselect'}
o.mouse = 'a'

-- Tab
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true

-- UI config
o.number = true
o.relativenumber = true
o.cursorline = true
o.splitbelow = true
o.splitright = true
o.showmode = false

-- Searching
o.incsearch = true
o.hlsearch = false
o.ignorecase = true
o.smartcase = true

o.splitbelow = true
o.splitright = true

o.ignorecase = true
o.termguicolors = true

