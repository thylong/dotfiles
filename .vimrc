set shell=/bin/bash

set nocompatible              " be iMproved, required
set cursorline
" Make Vim more useful
set nocompatible
set clipboard=unnamed
" Enhance command-line completion
set wildmenu
set wildignore=*.swp,*.bak,*.pyc,*.class
set esckeys
" Allow backspace in insert mode
set backspace=indent,eol,start
" Optimize for fast terminal connections
set ttyfast
set encoding=utf-8 nobomb " Use UTF-8 without BOM
let mapleader=","
" Don’t add empty newlines at the end of files
set binary
set noeol
set noswapfile
set nobackup
set viminfo+=! " make sure vim history works
map <C-J> <C-W>j<C-W>_ " open and maximize the split below
map <C-K> <C-W>k<C-W>_ " open and maximize the split above
set wmh=0 " reduces splits to a single line
" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure
" Highlight current line
set cursorline
" Enable line numbers
set number
" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,nbsp:_
set list
" Highlight searches
set hlsearch
" Ignore case of searches
set ignorecase
" Highlight dynamically as pattern is typed
set incsearch
" Always show status line
set laststatus=2
set nomodeline
" Disable error bells
set visualbell
set noerrorbells
set history=1000
set undolevels=1000
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Show the cursor position
set ruler
" Don’t show the intro message when starting Vim
set shortmess=atI
" Show the current mode
set showmode
" Show the filename in the window titlebar
set title
" Show the (partial) command as it’s being typed
set showcmd
" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Strip trailing whitespace (,ss)
function! StripWhitespace()
        let save_cursor = getpos(".")
        let old_query = getreg('/')
        :%s/\s\+$//e
        call setpos('.', save_cursor)
        call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>
" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>


" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
" Plugin 'altercation/vim-colors-solarized'
Plugin 'Shougo/vimproc', {'do': 'make'}
Plugin 'Shougo/unite.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'bling/vim-airline'
Plugin 'evidens/vim-twig'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'klen/python-mode'
Plugin 'm2mdas/phpcomplete-extended'
Plugin 'chase/vim-ansible-yaml'
Plugin 'vim-scripts/L9'
Plugin 'vim-scripts/Syntastic'
Plugin 'scrooloose/nerdtree'
" Plugin 'Valloric/YouCompleteMe'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin on    " required

" Color options {{{
" See http://www.vim.org/tips/tip.php?tip_id=1312
" 256 colors may be needed for any other colorscheme except solarized
"set t_Co=256
" Needed for solarized: Use the 16 colors terminal option to get VIM to look
" like GVIM with solarized colors.
" colorscheme solarized
set t_Co=16
syntax on
" set background=dark
" }}}


" Configuration of Plugins {{

" vim-airline
let g:airline_theme = 'solarized'
let g:airline_powerline_fonts = 1
set noshowmode " vim-airline show already the insert
let g:solarized_termtrans = 1
let g:solarized_termcolors=256

" klen/python-mode
autocmd FileType python set omnifunc=RopeOmni
let g:pymode_rope = 1
"Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
" Auto check on save
let g:pymode_lint_write = 1
" Support virtualenv
let g:pymode_virtualenv = 1
" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>b'
" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all
" Don't autofold code
let g:pymode_folding = 0
let g:pymode_rope_completion = 1

" NERDTree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" m2mdas/phpcomplete-extended
autocmd FileType php set omnifunc=phpcomplete_extended#CompletePHP

" Syntastic
" Available checkers are: php, phpcs, phpmd.
" Let's stick to the php executable only.
let g:ycm_filetype_blacklist = {
      \ 'python': 1
      \}
let g:syntastic_php_checkers = ['php']
let g:syntastic_mode_map = {'passive_filetypes': ['html', 'python']}
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" }}

set tabstop=4 softtabstop=4 shiftwidth=4 expandtab autoindent smartindent

" Ctrl-Space for completions. Heck Yeah!
inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
            \ "\<lt>C-n>" :
            \ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
            \ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
            \ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>
nnoremap <C-p> :Unite file_rec/async<cr>
nnoremap <space>/ :Unite grep:.<cr>

set paste
