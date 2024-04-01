vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set softtabstop=4")

-- vim.cmd("set autoread")
-- vim.cmd("set autoindent")
-- vim.cmd("set smartindent")
 
vim.cmd("set ruler")
vim.cmd("set nu")
vim.cmd("set rnu")
vim.cmd("set ignorecase")
-- vim.cmd("set noswapfile")

vim.keymap.set('n', 'J', ':bp<CR>', {})
vim.keymap.set('n', 'K', ':bn<CR>', {})

vim.g.mapleader = " "
