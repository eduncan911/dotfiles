set nocompatible

" plugin manager: vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
let g:plug_timeout=120
call plug#begin('~/.vim/plugged')
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-obsession' 
    \ | Plug 'dhruvasagar/vim-prosession'
  Plug 'scrooloose/syntastic'
  Plug 'majutsushi/tagbar'
  Plug 'airblade/vim-gitgutter'
  Plug 'vim-scripts/scratch.vim'
  Plug 'vim-airline/vim-airline' 
    \ | Plug 'edkolev/tmuxline.vim'
    \ | Plug 'vim-airline/vim-airline-themes'
    \ | Plug 'altercation/vim-colors-solarized'

  " dev plugins
  Plug 'fatih/vim-go', { 'do' : 'vim +GoUpdateBinaries +qall && gometalinter --install --update' }

  " neovim specific plugins
  if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do' : 'vim +UpdateRemotePlugins +qall' }
      \ | Plug 'zchee/deoplete-go', { 'do' : 'make'}
  else
    Plug 'Shougo/neocomplete.vim'
  endif
call plug#end()

" overriding sensible settings
let mapleader='\'
set clipboard=unnamed
set hidden
set wrap
set linebreak
set formatoptions-=t        " 
set directory^=~/.vim/swp// " put all swap files here
set number                  " line numbers
set noshowmode              " hide the status line's "-- INSERT --"
"set timeoutlen=50
"set ttimeoutlen=0

" cursor and mouse
set mouse=a  " allow mouse to change cursor/select lines (use r to disable it)
set cursorline     " highlight the cursor's line
"set cursorcolumn  " highlight the cursor's column

" Explorer
let g:netrw_liststyle=3
let g:netrw_winsize=20      " percentage of window size when opened
let g:netrw_banner=0        " clean up the window
let g:netrw_browse_split=4

" highlighting and marking
nnoremap <silent> <Leader>ll ml:execute 'match Search /\%'.line('.').'l/'<CR>
nnoremap <silent> <Leader><CR> :call clearmatches()<CR>

" navigation
map <C-J> :bprev<CR>
map <C-K> :bnext<CR>
"map <C-j> <C-w>j
"map <C-k> <C-w>k
"map <C-l> <C-w>l
"map <C-h> <C-w>h
map <Tab><Tab> <C-W>w
imap <Tab><Tab> <Esc><C-W>w
nmap <leader>pp :set paste!<CR>

" clipboard sharing
set clipboard=unnamed
nmap <C-C> :.w !pbcopy<CR><CR>
vmap <C-C> :w !pbcopy<CR><CR>
nmap <C-V> :set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
imap <C-V> <Esc>:set paste<CR>:r !pbpaste<CR>:set nopaste<CR>

" searching
set incsearch   " show search matches as you type
set hlsearch    " highlight search results
set ignorecase  " case insensative search
set smartcase   " if a capital letter is included in search, make it case-sensitive
nnoremap <CR> :nohlsearch<Bar>:echo<CR>

" fixing scrolling issues with syntax highlighting
syntax sync minlines=256
set synmaxcol=128
set lazyredraw

" ide-like intellisense
"set completeopt=longest,menuone
"inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"inoremap <expr> <C-n> pumvisible() ? '<C-n>' : 
"			\ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
"inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
"			\ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

function! s:on_load(name, exec) 
  if has_key(g:plugs[a:name], 'on') || has_key(g:plugs[a:name], 'for')
    execute 'autocmd! User' a:name a:exec
  else
    execute 'autocmd VimEnter *' a:exec
  aendif
endfunction

function! CraigSetup()
  " sourced: http://blog.mojotech.com/a-veterans-vimrc/

  " os x backspace fix
  set backspace=indent,eol,start
  set modelines=0   " dont need modelines and the potential security hazard

  " show trailing whitespace chars
  "set list
  set listchars=tab:>-,trail:.,extends:#,nbsp:.

  " default history is only 20
  set history=100
  set undolevels=100

  " tab -> spaces
  set expandtab
  set tabstop=2       " a tab is 4 spaces
  set softtabstop=2   " tab size when insterting/pasting
  set shiftwidth=2    " number of spaces to use for autoindenting
  set shiftround      " use multiple of shiftwidth when indenting with '<' and '>'
  set smarttab        " insert tabs on the start of a line according to shiftwidth, not tabstop

  set autoindent " always set autoindenting on
  set copyindent " copy the previous indentation on autoindenting

  " set foldenable      " fold by default
  set nofoldenable      " dont fold by default
  set foldmethod=indent " fold based on indentation
  set foldnestmax=10    " deepest fold is 10 levels
  set foldlevel=1

  set scrolloff=4

  set shortmess=tWI

  set visualbell    " don't beep
  set noerrorbells  " don't beep

  set autoread      " Auto read when a file is changed on disk

  " get around vim's funky regex and use normal regex
  nnoremap / /v     
  vnoremap / /v

  " Turn on spell check for certain filetypes automatically
  autocmd BufRead,BufNewFile *.md setlocal spell spelllang=en_us
  autocmd BufRead,BufNewFile *.markdown setlocal spell spelllang=en_us
  autocmd BufRead,BufNewFile *.txt setlocal spell spelllang=en_us
  autocmd FileType gitcommit setlocal spell spelllang=en_us

  " Autowrap text to 80 chars for certain filetypes
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80
  autocmd BufRead,BufNewFile *.markdown setlocal textwidth=80
  autocmd BufRead,BufNewFile *.txt setlocal textwidth=80
  autocmd FileType gitcommit setlocal textwidth=80
endfunction

" toggle scratch buffer (scratch.vim plugin)
function! ToggleScratch()
  if expand('%') == g:ScratchBufferName
    quit
  else
    Sscratch
  endif
endfunction
map <leader>ss :call ToggleScratch()<CR>

function! ColorSchemeSetup()
  " term color support
  if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
    set t_Co=256
    " disable Background Color Erase (BCE) so that color schemes
    " render properly when inside 256-color tmux and GNU screen.
    " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
  endif

  " fixing 256 colors in tmux
  set t_Co=256                        " force vim to use 256 colors

  " solarized theme
  set background=dark
  colorscheme solarized
endfunction

function! TagbarSetup()
  nmap <F8> :TagbarToggle<CR>
  " ctags
  let g:tagbar_type_go = {  
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
      \ 'p:package',
      \ 'i:imports:1',
      \ 'c:constants',
      \ 'v:variables',
      \ 't:types',
      \ 'n:interfaces',
      \ 'w:fields',
      \ 'e:embedded',
      \ 'm:methods',
      \ 'r:constructor',
      \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
      \ 't' : 'ctype',
      \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
      \ 'ctype' : 't',
      \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
  \ }
endfunction

function! SyntasticSetup()
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 0 " use :lopen / :lclose to open/show
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0

  " vim-go fixes
  let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
  let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
endfunction

function! AirlineSetup()
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#enabled = 1
  "let g:airline#extensions#tabline#left_sep = ' '
  "let g:airline#extensions#tabline#left_alt_sep = '|'
  "let g:airline_powerline_fonts = 1    " use when font isn't patched
  if !exists('g:airline_symbols')
    let g:airline_symbols = {} " fixes fontconfig versions
  endif
  let g:airline_symbols.space = "\ua0"
endfunction

function! VimGoSetup()
  " vim-go related mappings
  au FileType go nmap <Leader>r <Plug>(go-run)
  au FileType go nmap <Leader>b <Plug>(go-build)
  au FileType go nmap <Leader>t <Plug>(go-test)
  au FileType go nmap <Leader>i <Plug>(go-info)
  au FileType go nmap <Leader>s <Plug>(go-implements)
  au FileType go nmap <Leader>c <Plug>(go-coverage)
  au FileType go nmap <Leader>e <Plug>(go-rename)
  au FileType go nmap <Leader>gi <Plug>(go-imports)
  au FileType go nmap <Leader>gI <Plug>(go-install)
  au FileType go nmap <Leader>gd <Plug>(go-doc)
  au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
  au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
  au FileType go nmap <Leader>ds <Plug>(go-def-split)
  au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
  au FileType go nmap <Leader>dt <Plug>(go-def-tab)
  let g:go_auto_type_info = 1
  let g:go_fmt_command = "gofmt"
  let g:go_fmt_experimental = 1
  let g:go_dispatch_enabled = 0	" vim-dispatch needed
  let g:go_metalinter_autosave = 1
  let g:go_metalinter_autosave_enabled = ['vet', 'golint']
  let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
  let g:go_term_enabled = 0
  let g:go_term_mode = "vertical"
  let g:go_highlight_functions = 1
  let g:go_highlight_methods = 1
  let g:go_highlight_structs = 1
  let g:go_highlight_interfaces = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_extra_types = 1
  let g:go_highlight_build_constraints = 1
  let g:go_highlight_chan_whitespace_error = 1
endfunction

function! DeopleteSetup()
  " deoplete.vim
  " commands: https://github.com/Shougo/deoplete.nvim
  let g:deoplete#enable_at_startup = 1
  "set completeopt+=longest
  set completeopt+=menuone
  set completeopt+=noinsert
  set completeopt-=preview
  let g:deoplete#enable_ignore_case = 'ignorecase'
  "let g:deoplete#auto_completion_start_length = 0
  let g:min_pattern_length = 0

  " https://github.com/Shougo/deoplete.nvim/issues/117
  let g:deoplete#omni#input_patterns = {}
  let g:deoplete#omni#input_patterns.html = '<[^>]*'
  let g:deoplete#omni#input_patterns.xml  = '<[^>]*'
  let g:deoplete#omni#input_patterns.md   = '<[^>]*'
  let g:deoplete#omni#input_patterns.css   = '^\s\+\w\+\|\w\+[):;]\?\s\+\w*\|[@!]'
  let g:deoplete#omni#input_patterns.scss   = '^\s\+\w\+\|\w\+[):;]\?\s\+\w*\|[@!]'
  let g:deoplete#omni#input_patterns.sass   = '^\s\+\w\+\|\w\+[):;]\?\s\+\w*\|[@!]'
  let g:deoplete#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)\w*'
  let g:deoplete#omni#input_patterns.cpp = ['[^. *\t]\.\w*', '[^. *\t]\::\w*', '[^. *\t]\->\w*', '[<"].*/']
  let g:deoplete#omni#input_patterns.javascript = '[^. \t]\.\%(\h\w*\)\?'
  let g:deoplete#omni#input_patterns.go = '[^.[:digit:] *\t]\.\w*'
  let g:deoplete#omni#input_patterns.ruby = ['[^. *\t]\.\w*', '\h\w*::']
  let g:deoplete#ignore_sources = {}
  let g:deoplete#ignore_sources._ = ['buffer', 'vim', 'member']

  let g:deoplete#sources#go = 'vim-go'
  let g:deoplete#sources#go#align_class = 1

  "inoremap <expr><C-n> deoplete#mappings#manual_complete()
endfunction

function! NeocompleteSetup()
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_auto_select = 1
  let g:neocomplete#enable_smart_case = 1
  let g:neocomplete#sources#syntax#min_keyword_length = 3 
  let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

  " Plugin key-mappings.
  inoremap <expr><C-g>     neocomplete#undo_completion()
  inoremap <expr><C-l>     neocomplete#complete_common_string()

  " <CR>: close popup and save indent.
  "inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  "function! s:my_cr_function()
  "  return neocomplete#close_popup() . "\<CR>"
  "endfunction
  " <TAB>: completion.
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>" <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><C-y>  neocomplete#close_popup()
  inoremap <expr><C-e>  neocomplete#cancel_popup()

  let g:neocomplete#data_directory = '~/.vim/tmp/neocomplete'
  let g:neocomplete#sources#tags#cache_limit_size = 16777216 " 16MB

  " fuzzy completion breaks dot-repeat more noticeably
  " https://github.com/Shougo/neocomplete.vim/issues/332
  let g:neocomplete#enable_fuzzy_completion = 0

  " always use completions from all buffers
  if !exists('g:neocomplete#same_filetypes')
    let g:neocomplete#same_filetypes = {}
  endif
  let g:neocomplete#same_filetypes._ = '_'
endfunction

call AirlineSetup()
call SyntasticSetup()
call VimGoSetup()
call DeopleteSetup()
call TagbarSetup()
call ColorSchemeSetup()
call CraigSetup()
