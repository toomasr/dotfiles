" My VIM configuration file. It has been a mess from the early 2000s. Hopefully
" with this bootstrap repository it will get better and better. Lets see!
"
" It assumes you've installed
"   pathogen - https://github.com/tpope/vim-pathogen
" set up pathogen, https://github.com/tpope/vim-pathogen
execute pathogen#infect()
filetype plugin indent on
filetype off
syntax enable

set nocompatible
set laststatus=2  " Always show the status line
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%03p%%]\ [LEN=%04L]
set nocursorline  " No current line highlighting

set nobackup
set backspace=2                                             " Allow backspacing over everything in insert mode
set textwidth=0                                             " Don't wrap words by default

set history=50                                              " keep 50 lines of command line history

set showcmd                                                 " Show (partial) command in status line.
set showmatch                                               " Show matching brackets.
set ignorecase                                              " Do case insensitive matching
set autowrite                                               " Automatically save before commands like :next and :make

set autoindent                                              " Copy indent from current line when starting a new line
set pastetoggle=<F10>

set autoread                                                 " reload files when changed on disk, i.e. via `git checkout`
set directory-=.                                             " don't store swapfiles in the current directory
set encoding=utf-8
set expandtab                                                " expand tabs to spaces
set incsearch                                                " search as you type
set laststatus=2                                             " always show statusline
set list                                                     " show trailing whitespace
set listchars=tab:▸\ ,trail:
set number                                                   " show line numbers
set ruler                                                    " show where you are
set scrolloff=3                                              " show context above/below cursorline
set shiftwidth=2                                             " normal mode indentation commands use 2 spaces
set smartcase                                                " case-sensitive search if any caps
set softtabstop=2                                            " insert mode tab and backspace use 2 spaces
set tabstop=2                                                " actual tabs occupy 8 characters
set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc
set wildmenu                                                 " show a navigable menu for tab completion
set wildmode=longest,list,full

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

map <C-RIGHT> <ESC>:bn<CR>
map <C-LEFT> <ESC>:bp<CR>
map gf :edit <cfile><CR>

map < <gv
map > >gv

map ,web :3<cr>:r ~/.vim/snippets/header.html<cr>

" Naviagations using keys up/down/left/right
" Disabling default keys to learn the hjkl
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
nnoremap j gj
nnoremap k gk

" Highlight searches (use <C-L> to temporarily turn off highlighting)
" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
set hlsearch
nnoremap <C-L> :nohl<CR><C-L>

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

""
"" Python specific settings
""

" Full Python syntax highlighting, when combined with 'syntax on' above
let python_highlight_all=1

" Number of spaces that a pre-existing tab is equal to.
" For the amount of space used for a new tab use shiftwidth.
au BufRead,BufNewFile *py set tabstop=4

" What to use for an indent.
" This will affect Ctrl-T and 'autoindent'.
" Python: 4 spaces
au BufRead,BufNewFile *.py set shiftwidth=4
au BufRead,BufNewFile *.py set expandtab

" Make backspacing easier
au BufRead,BufNewFile *.py set softtabstop=4

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py match BadWhitespace /\s\+$/

" Wrap text after a certain number of characters
au BufRead,BufNewFile *.py set textwidth=79

" Use UNIX (\n) line endings.
au BufRead,BufNewFile *.py set fileformat=unix

" The following line sets the smartindent mode for *.py files. It means that
" after typing lines which start with any of the keywords in the list (ie.
" def, class, if, etc) the next line will automatically indent itself to the
" next level of indentation:
au BufRead,BufNewFile *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

" Remove any extra whitespace from the ends of lines when saving a file
autocmd BufWritePre *.py normal m`:%s/\s\+$//e``

" keyboard shortcuts
let mapleader = ','
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <leader>l :Align
map <leader>t :CommandT<CR>
nmap <leader>a :Ack 
nmap <leader>b :CtrlPBuffer<CR>
nmap <leader>d :NERDTreeToggle<CR>
nmap <leader>n :NERDTree<CR>
" nmap <leader>t :CtrlP<CR>
" nmap <leader>T :CtrlPClearCache<CR>:CtrlP<CR><CR>
nmap <leader>] :TagbarToggle<CR>
nmap <leader><space> :call whitespace#strip_trailing()<CR>
nmap <leader>g :GitGutterToggle<CR>
nmap <leader>c <Plug>Kwbd
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" fdoc is yaml
autocmd BufRead,BufNewFile *.fdoc set filetype=yaml
" md is markdown
autocmd BufRead,BufNewFile *.md set filetype=markdown
" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" Fix Cursor in TMUX
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Go crazy!
if filereadable(expand("~/.vimrc.local"))
  " In your .vimrc.local, you might like:
  "
  " set autowrite
  " set nocursorline
  " set nowritebackup
  " set whichwrap+=<,>,h,l,[,] " Wrap arrow keys between lines
  "
  " autocmd! bufwritepost .vimrc source ~/.vimrc
  " noremap! jj <ESC>
  source ~/.vimrc.local
endif

" Some stuff from https://www.destroyallsoftware.com/file-navigation-in-vim.html

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" expand current directory
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" start the edit prompt with current directory
map <leader>e :edit %%
map <leader>f :CommandTFlush<cr>\|:CommandT<cr>
map <leader>gf :CommandTFlush<cr>\|:CommandT %%<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RemoveFancyCharacters COMMAND
" Remove smart quotes, etc.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RemoveFancyCharacters()
    let typo = {}
    let typo["“"] = '"'
    let typo["”"] = '"'
    let typo["‘"] = "'"
    let typo["’"] = "'"
    let typo["–"] = '--'
    let typo["—"] = '---'
    let typo["…"] = '...'
    :exe ":%s/".join(keys(typo), '\|').'/\=typo[submatch(0)]/ge'
endfunction
command! RemoveFancyCharacters :call RemoveFancyCharacters()
