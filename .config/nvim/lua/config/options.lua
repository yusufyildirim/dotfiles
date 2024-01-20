-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- disable netrw
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

local opt = vim.opt
opt.clipboard = ""
opt.showtabline = 0

-- indent
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- open splits in a more natural direction
-- https://vimtricks.com/p/open-splits-more-naturally/
opt.splitright = true
opt.splitbelow = true

-- other config
vim.g.tmux_navigator_disable_when_zoomed = 1
vim.g.undotree_SplitWidth = 40
