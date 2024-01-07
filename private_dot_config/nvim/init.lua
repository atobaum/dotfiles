-- set up options
vim.opt.langmenu = 'en_US.UTF-8'
vim.opt.enc = 'utf8'
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.sts = 4
vim.opt.backspace = 'indent,eol,start'
vim.opt.mouse = 'a'

vim.opt.number = true
vim.wo.relativenumber = true

vim.g.mapleader = ' '

-- 검색할 때 다 하이라이팅
vim.opt.hls = true
-- reset highlighting
vim.api.nvim_set_keymap('', '<F12>', ':nohlsearch<CR>', {})
vim.api.nvim_set_keymap('i', '<F12>', '<ESC>:nohlsearch<CR>i', {})
vim.api.nvim_set_keymap('v', '<F12>', '<ESC>:nohlsearch<CR>gv', {})

-- 검색할때 대소문자 무시
vim.opt.ignorecase = true

-- 검색할때 패턴에 대문자 있으면 ignorecase 없애고 대소문자 판별
vim.opt.smartcase = true

vim.go.python3_host_prog = '~/.pyenv/versions/py3nvim/bin/python'

require('plugins')
require("core/keymapping")
