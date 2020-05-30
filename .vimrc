set langmenu=en_US.UTF-8
set enc=utf8
language messages en_US.UTF-8
set guifont=D2Coding_ligature:h12

set ts=4
set sw=4
set sts=4
set nu
set backspace=indent,eol,start

"검색할 때 다 하이라이팅
set hls
" reset highlighting
map <F12> :nohlsearch<CR>
imap <F12> <ESC>:nohlsearch<CR>i
vmap <F12> <ESC>:nohlsearch<CR>gv

set nocompatible
filetype plugin on
runtime macros/matchit.vim

"검색할때 대소문자 무시
set ignorecase
"검색할때 패턴에 대문자 있으면 ignorecase 없애고 대소문자 판별
set smartcase

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"
" " let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" theme
Plugin 'morhetz/gruvbox'
Plugin 'vim-airline/vim-airline'

" git
Plugin 'tpope/vim-fugitive'
Plugin 'vim-gitgutter'

" numberline 옆에 추가/삭제 확인
Plugin 'scrooloose/nerdtree'

Plugin 'syntastic'

" quick move
Plugin 'Lokaltog/vim-easymotion'
Plugin 'ctrlpvim/ctrlp.vim'

Plugin 'surround.vim'
Plugin 'tmhedberg/matchit'
Plugin 'neoclide/coc.nvim', {'branch':'release', 'do': './install.sh'}
Plugin 'jiangmiao/auto-pairs'
call vundle#end()            " required
filetype plugin indent on    " required

"nvm
let g:coc_node_path = "/home/kuuften/.nvm/versions/node/v12.16.1/bin/node"

set t_Co=256
colorscheme gruvbox
let g:gruvbox_contrast_dark = 'hard'
highlight Normal ctermbg=NONE

if has("syntax")
	syntax on
endif

" NERDTree map
map <Leader>nt <ESC>:NERDTree<CR>

" ctrl p ignore setting
let g:ctrlp_custom_ignre = {
	\ 'dir': '\.git$\|tmp$\|node_modules$',
	\ 'file': '\v\.(exe|dll)$'
	\ }

let g:airline_powerline_fonts = 1

" syntastic setting
let g:syntastic_python_checkers = ['pep8']

set background=dark
