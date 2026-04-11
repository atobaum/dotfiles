-- Workaround: Neovim 0.12 + VSCode terminal Shift+digit bug
-- https://github.com/neovim/neovim/issues/38651
if vim.env.TERM_PROGRAM == 'vscode' then
  local shifted_digits = {
    ['<S-1>'] = '!', ['<S-2>'] = '@', ['<S-3>'] = '#',
    ['<S-4>'] = '$', ['<S-5>'] = '%', ['<S-6>'] = '^',
    ['<S-7>'] = '&', ['<S-8>'] = '*', ['<S-9>'] = '(',
    ['<S-0>'] = ')',
  }
  for lhs, rhs in pairs(shifted_digits) do
    vim.keymap.set({ 'n', 'x', 'i' }, lhs, rhs, { noremap = true, silent = true })
    vim.keymap.set('c', lhs, function() return rhs end, { expr = true, noremap = true })
  end
end

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

require('plugins')
require("core/keymapping")

-- built-in treesitter highlighting
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})
