set nocompatible              " be iMproved, required
filetype off                  " required
set exrc

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" ==== PLUGINS ====
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-scripts/L9'
Plugin 'scrooloose/nerdtree'
Plugin 'airblade/vim-gitgutter'
Plugin 'mattn/emmet-vim'
Plugin 'tpope/vim-surround'
Plugin 'godlygeek/tabular'
Plugin 'zivyangll/git-blame.vim'
Plugin 'dense-analysis/ale'
Plugin 'dhruvasagar/vim-table-mode'
Plugin 'iamcco/markdown-preview.nvim'
" ==== END PLUGINS ====

call vundle#end()
filetype plugin indent on

" ==== BASIC ====
syntax enable
set ruler
set hidden
set number
set laststatus=2
set smartindent
set sts=2 sw=2 et
set shiftwidth=2
set tabstop=2
set hlsearch
set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»
map <F9> :ter<CR>
map <F6> :! grep -rn "TODO"
map <F5> :noh<CR>
map <C-r> :edit<CR>
map <C-F5> :edit!<CR>
map <C-j> :tabnext<CR>
map <C-k> :tabprev<CR>
map <F4> :set list<CR>
map <F3> :set nolist<CR>

set statusline+=%f\ -\ FileType:\ %y
" ==== NERDTREE ====
let NERDTreeIgnore = ['\.pyc$', '\.o$', '\.so$', '\.a$', '\.swp', '\.swo', '\.swn', '\.swm', '[a-zA-Z]*egg[a-zA-Z]*', '[a-zA-Z]*cache[a-zA-Z]*']
let NERDTreeShowHidden=0
let g:NERDTreeWinPos="left"
let g:NERDTreeDirArrows=0
map <C-f> :NERDTreeToggle<CR>

"==== A.L.E. ====
let g:ale_linters = {'python': ['pycodestyle', 'autopep8']}
let g:ale_linters_explicit = 1
let g:ale_lint_on_insert_leave = 1
let g:ale_fix_on_save = 1
let g:ale_fixers = {'python': ['autopep8']}

"==== Markdown Preview =====
let g:mkdp_auto_start = 1
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 1
"set secure
