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

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

map J :bp<CR>
map K :bn<CR>

"vin-plug
"curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

call plug#begin('~/.local/share/nvim/plugged')

Plug 'morhetz/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
"Plug 'artur-shaik/vim-javacomplete2'

call plug#end()

colorscheme gruvbox 
"colorscheme desert 

"airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

"autocmd FileType java setlocal omnifunc=javacomplete#Complete
