-- Navigating windows
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Switch to left window'})
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Switch to down window'})
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Switch to up window'})
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Switch to right window'})

-- Navigating buffers
vim.keymap.set('n', '<leader>bb', '<C-^>', { desc = 'Switch to alternate buffer' })
vim.keymap.set('n', '<leader>bn', ':bnext<cr>', { desc = 'Next buffer' })
vim.keymap.set('n', '<leader>bp', ':bprevious<cr>', { desc = 'Previous buffer' })
