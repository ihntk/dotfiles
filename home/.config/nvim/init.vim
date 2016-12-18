set tabstop=4
set shiftwidth=4
set softtabstop=4

set autoread
set autoindent
set smartindent

set ruler
set noswapfile
set rnu
set ignorecase
set background=dark

"vin-plug
call plug#begin('~/.local/share/nvim/plugged')

Plug 'morhetz/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
"Plug 'artur-shaik/vim-javacomplete2'

call plug#end()

colorscheme gruvbox 

let g:airline_powerline_fonts = 1
autocmd FileType java setlocal omnifunc=javacomplete#Complete
