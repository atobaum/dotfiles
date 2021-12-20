set langmenu=en_US.UTF-8
set enc=utf8
language messages en_US.UTF-8
set guifont=D2Coding_ligature:h12

set ts=4
set sw=4
set sts=4
set backspace=indent,eol,start
set mouse=a

set number relativenumber
set nu rnu
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

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

" moving window keymap
if has('nvim')
	tnoremap <A-h> <C-\><C-n><C-w>h
	tnoremap <A-j> <C-\><C-n><C-w>j
	tnoremap <A-k> <C-\><C-n><C-w>k
	tnoremap <A-l> <C-\><C-n><C-w>l
endif
noremap <A-h> <C-w>h
noremap <A-j> <C-w>j
noremap <A-k> <C-w>k
noremap <A-l> <C-w>l

call plug#begin('~/.vim/plugged')

" theme
Plug 'nanotech/jellybeans.vim'

"bar
Plug 'itchyny/lightline.vim'
Plug 'bling/vim-bufferline'

" git
Plug 'tpope/vim-fugitive'
" numberline 옆에 추가/삭제 확인
Plug 'airblade/vim-gitgutter'

Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/syntastic'

" vimwiki
Plug 'mhinz/vim-startify'
Plug 'vim-scripts/vimwiki'

" quick move
Plug 'Lokaltog/vim-easymotion'
Plug 'ctrlpvim/ctrlp.vim'

Plug 'tpope/vim-surround'
Plug 'tmhedberg/matchit'
Plug 'jiangmiao/auto-pairs'

" Plug 'valloric/youcompleteme', { 'do': 'python3 ./install.py --clangd-completer --go-completer --ts-completer'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'

" tsx highlight
Plug 'ianks/vim-tsx'

" ctags
Plug 'vim-scripts/ctags.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
call plug#end()            " required
filetype plugin indent on    " required

" startify
let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   MRU']            },
          \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ { 'type': 'commands',  'header': ['   Commands']       },
          \ ]
let g:startify_bookmarks = [
	\ { 'rc': '~/.config/nvim/init.vim' }
	\ ]
let g:startify_change_to_vcs_root = 1
let g:startify_files_number = 5
let g:startify_custom_header = ''

" tagbar
"set tag=./tags
nmap <F8> :TagbarToggle<CR>
let g:tagbar_width = 35
let g:tagbar_type_vimwiki = {
    \ 'ctagstype' : 'vimwiki',
    \ 'sort': 0,
    \ 'kinds' : [
		\ 'h:Heading',
    \ ],
	\ 'deffile': '~/.config/ctags/vimwiki.ctags'
	\ }
let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'kinds' : [
            \ 'h:headings',
            \ 'l:links',
            \ 'i:images'
        \ ],
    \ 'sort' : 0,
	\ }
augroup vimwiki_tagbar
    autocmd BufRead,BufNewFile *wiki/*.md TagbarOpen
    autocmd VimLeavePre *.md TagbarClose
augroup END

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories = ['~/.config/nvim/UltiSnips']

" coc.nvim
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" ycm/ you complete me
" let g:ycm_key_list_select_completion = ['<C-n>']
" let g:ycm_key_list_previous_completion=['<C-p>']
" let g:ycm_server_python_interpreter = '/usr/bin/python3'
" let g:ycm_collect_identifiers_from_comments_and_strings = 1
" let g:ycm_complete_in_strings = 1
" let g:ycm_complete_in_comments = 1
" let g:ycm_min_num_of_chars_for_completion = 1
" let g:ycm_filetype_blacklist = {
" 	\'markdown': 1,
" 	\'vimwiki': 1
" 	\}

" crtlp setting
set wildignore+=*/tmp/*,*.so,*.swp,*.zip  
let g:ctrlp_working_path_mode='r'
let g:ctrlp_custom_ignre = {
	\ 'dir': '\.git$\|tmp$\|node_modules$',
	\ 'file': '\v\.(exe|dll|png|jpg|jpng)$\|tags'
	\ }

" NERDTree map
map <Leader>nt <ESC>:NERDTree<CR>

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" lightline
let g:lightline = {
			\ 'active': {
			\ 	'left': [ [ 'mode', 'paste' ],
			\ 			  [ 'gitbranch', 'readonly', 'filename', 'modified' ]
			\ 	],
			\ 	},
			\ 	'conponent_function': {
			\ 		'gitbranch': 'fugitive#head',
			\ 	}
			\ }

"theme
set t_Co=256
syntax enable
set background=dark
colorscheme jellybeans
let g:jellybeans_overrides = {
\	'background': { 'ctermbg': 'none', '256ctermbg': 'none' },
\}
if has('termguicolors') && &termguicolors
    let g:jellybeans_overrides['background']['guibg'] = 'none'
endif
let g:airline_powerline_fonts = 1

if has("syntax")
	syntax on
endif

