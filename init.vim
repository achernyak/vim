:imap fd <Esc>
let mapleader = " "
let g:mapleader = " "

set noerrorbells
set backspace=indent,eol,start   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set noshowmode
set incsearch     " do incremental searching
set hlsearch      " Highlight found searches 
set ignorecase    " Search case insensitive...
set smartcase     " ... but not when search pattern contains upper case chars
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set lazyredraw
set hidden
set ttyfast
set smarttab

" speed up syntax highlighting
set nocursorcolumn
set nocursorline

" softwrap
set wrap
set linebreak
set nolist
set formatoptions=qrn1
set relativenumber
set textwidth=79
set colorcolumn=+1

" mail line wrapping
au BufRead /tmp/mutt-* set tw=72

set autoindent
set complete-=i
set showmatch
set smarttab

" Softtabs, 4 spaces
set et
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Time out on key codes but no mappings.
set notimeout
set ttimeout
set ttimeoutlen=10

" Use one space, not two, after punctuation.
set nojoinspaces

" Numbers
set number
set numberwidth=5

" Better Completion
set complete=.,w,b,u,t

" Switch between the last two files
nnoremap <Leader>b <c-^>

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" vim-test mappings
nnoremap <silent> <Leader>t :TestFile<CR>
nnoremap <silent> <Leader>s :TestNearest<CR>
nnoremap <silent> <Leader>l :TestLast<CR>
nnoremap <silent> <Leader>a :TestSuite<CR>
nnoremap <silent> <Leader>gt :TestVisit<CR>

" Run commands that require an interactive shell
nnoremap <Leader>r :RunInInteractiveShell<space>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Quicker buffer movement
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
nnoremap gb :ls<CR>:b

" Open file relative to the current file
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" Better CTRL-U
inoremap <C-U> <C-G>u<C-U>

" Remove search highlight
nnoremap <leader><leader> :nohlsearch<CR>

if has('mouse')
  set mouse=a
endif

" If linux then set ttymouse
let s:uname = system("echo -n \"$(uname)\"")
if !v:shell_error && s:uname == "Linux" && !has('nvim')
  set ttymouse=xterm
endif

if &history < 1000
  set history=50
endif

if &tabpagemax < 50
  set tabpagemax=50
endif

if !empty(&viminfo)
  set viminfo^=!
endif

if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
    au!

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    autocmd BufReadPost *
          \ if line("'\"") > 1 && line("'\"") <= line("$") |
          \	exe "normal! g`\"" |
          \ endif

  augroup END
else
endif " has("autocmd")

call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

Plug 'neomake/neomake'

Plug 'sheerun/vim-polyglot'

Plug 'Valloric/YouCompleteMe'

Plug 'xolox/vim-misc'

Plug 'ctrlpvim/ctrlp.vim'

Plug 'majutsushi/tagbar'

Plug 'tpope/vim-surround'

Plug 'MarcWeber/vim-addon-mw-utils'

Plug 'tomtom/tlib_vim'

Plug 'easymotion/vim-easymotion'

Plug 'jiangmiao/auto-pairs'

Plug 'sjl/gundo.vim'

" Visual
Plug 'vim-airline/vim-airline'

Plug 'vim-airline/vim-airline-themes'

Plug 'altercation/vim-colors-solarized'

" Snippets
Plug 'SirVer/ultisnips'

Plug 'honza/vim-snippets'

" Git
Plug 'airblade/vim-gitgutter'

Plug 'tpope/vim-fugitive'

" Go
Plug 'fatih/vim-go', { 'for': 'go' }

" Javascript 
Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'benjie/neomake-local-eslint.vim', { 'for': ['javascript', 'javascript.jsx'] }

" Rails
Plug 'tpope/vim-rails', { 'for': 'ruby' }

call plug#end()

set background=dark
let g:solarized_termcolors=256
let g:solarized_termtrans=1
colorscheme solarized

" Neomake makers
let g:neomake_jsx_enabled_makers = ['eslint']

" Neomake
autocmd! BufEnter,BufWritePost * Neomake
let g:neomake_warning_sign = {
  \ 'text': 'W',
  \ 'texthl': 'WarningMsg',
  \}

let g:neomake_error_sign = {
  \ 'text': 'E',
  \ 'texthl': 'ErrorMsg',
  \}

" Neomake keybindings
nmap <Leader>o :lopen<CR>
nmap <Leader>c :lclose<CR>
nmap <Leader>, :ll<CR>
nmap <Leader>n :lnext<CR>
nmap <Leader>p :lprev<CR>

" Configure CtrlP to ingore git ignored files
let g:ctrlp_cmd = 'CtrlPBuffer'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']

" Tern
let g:tern_map_keys=1
let g:tern_show_argument_hints='on_hold'

"Airline
let g:airline#extensions#tabline#enable=1
let g:airline_powerline_fonts=1
let g:airline_theme='solarized'
