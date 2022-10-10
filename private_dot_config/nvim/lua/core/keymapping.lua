-- nvim-tree
vim.keymap.set('n', '<Leader>nt', ':NvimTreeToggle<CR>')

-- Switch buffer
vim.keymap.set('n', '<S-h>', ':bprevious<CR>')
vim.keymap.set('n', '<S-l>', ':bnext<CR>')

-- Resizing panes
vim.keymap.set('n', '<Left>', ':vertical resize -1<CR>')
vim.keymap.set('n', '<Right>', ':vertical resize +1<CR>')
vim.keymap.set('n', '<Up>', ':resize -1<CR>')
vim.keymap.set('n', '<Down>', ':resize +1<CR>')
