set nocompatible

" plugin manager: vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
let g:plug_timeout=120
call plug#begin('~/.vim/plugged')
  Plug 'tpope/vim-obsession'
    \ | Plug 'dhruvasagar/vim-prosession'
  Plug 'scrooloose/syntastic'
  Plug 'majutsushi/tagbar'
  Plug 'airblade/vim-gitgutter' 
  Plug 'vim-scripts/scratch.vim'                " <Leader>ss for scratch window
  Plug 'vim-airline/vim-airline'
    \ | Plug 'edkolev/tmuxline.vim'
    \ | Plug 'vim-airline/vim-airline-themes'
    \ | Plug 'altercation/vim-colors-solarized'
    \ | Plug 'robertmeta/nofrils'
  Plug 'flazz/vim-colorschemes'
  Plug 'moll/vim-bbye'                         " :Bdelete :Bd to close buffer

  " dev plugins
  "Plug 'fatih/vim-go', { 'do' : 'vim +GoUpdateBinaries +qall && gometalinter --install --update' }
  Plug 'fatih/vim-go', { 'for' : 'go' }
  Plug 'cespare/vim-toml', { 'for' : 'toml' }
  Plug 'pangloss/vim-javascript', { 'for' : 'js' }
  Plug 'moll/vim-node'
  Plug 'othree/html5-syntax.vim'
  Plug 'othree/html5.vim'
  Plug 'groenewege/vim-less'
  Plug 'othree/javascript-libraries-syntax.vim'
  Plug 'vim-scripts/indentpython.vim'

  " neovim specific plugins
  if has('nvim')
    Plug 'Shougo/deoplete.nvim',
      \ | Plug 'zchee/deoplete-go',
      \ | Plug 'zchee/deoplete-jedi'
  else
    Plug 'tpope/vim-sensible'
    Plug 'Shougo/neocomplete.vim'
  endif
call plug#end()

" overriding sensible settings
set encoding=utf-8          " not sure if this is set already
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

" clear useless status messages
"nmap <silent> :w<CR> :w<CR>

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
nmap <Tab><Tab> <C-W>w      " move to window bottom-right of cursor
nmap <S-Tab><S-Tab> <C-W>W  " move to window top-left of cursor
"imap <Tab><Tab> <Esc><C-W>w
nmap <leader>pp :set paste!<CR>

" clipboard sharing
nmap <C-V> :set paste<CR>"*p<Bar>:set nopaste<CR>
imap <C-V> <Esc>:set paste<CR>"*p<Bar>:set nopaste<CR>

" searching
set incsearch   " show search matches as you type
set hlsearch    " highlight search results
set ignorecase  " case insensative search
set smartcase   " if a capital letter is included in search, make it case-sensitive
nnoremap <CR> :nohlsearch<Bar>:echo<CR>

" fixing scrolling issues with syntax highlighting
syntax sync minlines=256
set synmaxcol=256
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

  " history and undos
  set history=1000
  set undolevels=1000
  set undofile
  set undodir=~/.vim/undodir

  " tab -> spaces
  set expandtab
  set tabstop=4       " a tab is 2 or 4 spaces
  set softtabstop=4   " tab size when insterting/pasting
  set shiftwidth=4    " number of spaces to use for autoindenting
  set shiftround      " use multiple of shiftwidth when indenting with '<' and '>'
  set smarttab        " insert tabs on the start of a line according to shiftwidth, not tabstop
  set autoindent " always set autoindenting on
  set copyindent " copy the previous indentation on autoindenting

  " set foldenable      " fold by default
  set nofoldenable      " dont fold by default
  set foldmethod=indent " fold based on indentation
  set foldnestmax=10    " deepest fold is 10 levels
  set foldlevel=1

  set scrolloff=4       " when scrolling up/down, do so from 10 lines of top/bottom

  set shortmess=atWI

  set visualbell    " don't beep
  set noerrorbells  " don't beep

  set autoread      " Auto read when a file is changed on disk

  " get around vim's funky regex and use normal regex
  nnoremap / /\v
  vnoremap / /\v

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

function! VimJavascriptSetup()
  let g:javascript_enable_domhtmlcss = 0 	" 1 = Enables HTML/CSS syntax highlighting in JavaScript files
  let g:javascript_ignore_javaScriptdoc = 0 " 1 = Disables JSDoc syntax highlighting
endfunction

function! Html5VimSetup()
  let g:html5_event_handler_attributes_complete = 1 " 0 = Disable event-handler attributes support
  let g:html5_rdfa_attributes_complete = 1          " 0 = Disable RDFa attributes support
  let g:html5_microdata_attributes_complete = 1     " 0 = Disable microdata attributes support
  let g:html5_aria_attributes_complete = 1          " 0 = Disable WAI-ARIA attribute support

  au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2
endfunction

function! VimLessSetup() 
  autocmd BufNewFile,BufRead *.less set filetype=less
  autocmd FileType less set omnifunc=csscomplete#CompleteCSS

  " map .less to .css , lessc is required.
  "nnoremap <Leader>m :w <BAR> !lessc % > %:t:r.css<CR><space>
endfunction

function! JSlibSyntaxSetup()
  " Support libs id:
  " jQuery: jquery
  " underscore.js: underscore
  " Lo-Dash: underscore
  " Backbone.js: backbone
  " prelude.ls: prelude
  " AngularJS: angularjs
  " AngularUI: angularui
  " AngularUI Router: angularuirouter
  " React: react
  " Flux: flux
  " RequireJS: requirejs
  " Sugar.js: sugar
  " Jasmine: jasmine
  " Chai: chai
  " Handlebars: handlebars
  let g:used_javascript_libs = 'underscore,backbone,react'

  " example local vimrc setup for specific projects
  "autocmd BufReadPre *.js let b:javascript_lib_use_jquery = 1
  "autocmd BufReadPre *.js let b:javascript_lib_use_underscore = 1
  "autocmd BufReadPre *.js let b:javascript_lib_use_backbone = 1
  "autocmd BufReadPre *.js let b:javascript_lib_use_prelude = 0
  "autocmd BufReadPre *.js let b:javascript_lib_use_angularjs = 0
endfunction

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
  
  " switch between bg colors
  "set background=dark
  "let g:nofrils_strbackgrounds=1
  "call togglebg#map("<F5>")

  " solarized theme options
  "
  " option name               default     optional
  " ------------------------------------------------
  " g:solarized_termcolors=   16      |   256
  " g:solarized_termtrans =   0       |   1
  " g:solarized_degrade   =   0       |   1
  " g:solarized_bold      =   1       |   0
  " g:solarized_underline =   1       |   0
  " g:solarized_italic    =   1       |   0
  " g:solarized_contrast  =   "normal"|   "high" or "low"
  " g:solarized_visibility=   "normal"|   "high" or "low"
  " ------------------------------------------------
  "let g:solarized_contrast   = "high"
  "let g:solarized_visibility = "normal"

  " solarized benokai 256-grayvim 256-jungle 256_noir Monokai solarized
  " nofrils-dark nofris-light
  colorscheme Monokai
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
  let g:syntastic_check_on_open = 0
  let g:syntastic_check_on_wq = 0
  let g:syntastic_aggregate_errors = 0 

  " symbols
  let g:syntastic_error_symbol = '->'
  let g:syntastic_warning_symbol = '->'
  let g:syntastic_style_error_symbol = '->'
  let g:syntastic_style_warning_symbol = '->'
  "let g:syntastic_stl_format = '[S line:%F (%t)]'
  let g:syntastic_stl_format = '[%t]'

  " colors
  "highlight SyntasticError
  "highlight SyntasticWarninga
  "highlight SyntasticErrorLine 
  "highlight SyntasticWarningLine
  highlight SyntasticErrorSign  ctermfg=000 ctermbg=001 guibg=#FF0000
  highlight SyntasticWarningSign  ctermfg=000 ctermbg=003 guibg=#000000

  " go
  let g:syntastic_go_checkers = ['gometalinter'] " everything + kitchensink
  let g:syntastic_go_gometalinter_args = '--config=/Users/eric/.gometalinter.conf'
  "let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']

  " python 
  let g:syntastic_python_checkers = ['pylint']  " maybe add pep8
  let g:syntastic_python_pylint_post_args="--max-line-length=120"
  let g:syntastic_python_flake8_args='--ignore=E501,E225'

  " javascript
  " see http://www.panozzaj.com/blog/2015/08/28/must-have-vim-javascript-setup/ for more JS exclusions
  let g:syntastic_javascript_checkers = ['jshint']
  
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

function! TmuxlineSetup()
  " via plugin edkolev/tmuxline.vim'
  "let g:tmuxline_powerline_separators = 0
  
  " custom bar 
  "
  " from tmux manual:
  "     #H    Hostname of local host
  "     #h    Hostname of local host without the domain name
  "     #F    Current window flag
  "     #I    Current window index
  "     #S    Session name
  "     #W    Current window name
  "     #(shell-command)  First line of the command's output
  " string will be passed through strftime(3) before being used.
  let g:tmuxline_preset = {
      \'a'    : '#H',
      \'b'    : '#S',
      \'win'  : ['#I', '#W'],
      \'cwin' : ['#I', '#W'],
      \'y'    : '',
      \'z'    : ['%b %d %I:%M %p %z'] }
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
"  let g:go_auto_type_info = 1
"  let g:go_fmt_command = "gofmt"
"  let g:go_fmt_experimental = 1
"  let g:go_dispatch_enabled = 0	" vim-dispatch needed
"  let g:go_metalinter_autosave = 1
"  let g:go_metalinter_autosave_enabled = ['vet', 'golint']
"  let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
"  let g:go_term_enabled = 0
"  let g:go_term_mode = "vertical"
"  let g:go_highlight_functions = 1
  let g:go_highlight_methods = 1
"  let g:go_highlight_structs = 1
"  let g:go_highlight_interfaces = 1
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

  " go
  let g:deoplete#sources#go = 'vim-go'
  let g:deoplete#sources#go#align_class = 1

  " python
  " :h nvim-python-quickstart
  let g:deoplete#sources#jedi#statement_length = 50
  let g:deoplete#sources#jedi#enable_cache = 1
  let g:deoplete#sources#jedi#show_docstring = 0
  "let g:deoplete#sources#jedi#python_path = 
  "let g:deoplete#sources#jedi#extra_path = 
  "let g:python_host_prog = '/full/path/to/neovim2/bin/python'
  "let g:python3_host_prog = '/full/path/to/neovim3/bin/python'

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

function! PythonSetup()
  " source from ...
  "
  " most to conform to pep8 and make python development easier

  if has('nvim')
    let g:python_host_prog = '/usr/local/bin/python2'
    let g:python3_host_prog = '/usr/local/bin/python3'
  endif

  " pep8 indentions
  au BufNewFile,BufRead *.py set 
    \ tabstop=4 
    \ softtabstop=4
    \ shiftwidth=4
    \ textwidth=79
    \ expandtab
    \ autoindent
    \ fileformat=unix

  " flag unnecessary whitespace
  "au BufNewFile,BufRead *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
endfunction

call CraigSetup()
call ColorSchemeSetup()
call AirlineSetup()
call TmuxlineSetup()
call SyntasticSetup()
call VimGoSetup()
"call DeopleteSetup()
call TagbarSetup()
call VimJavascriptSetup()
call Html5VimSetup()
call VimLessSetup()
call JSlibSyntaxSetup()
call PythonSetup()
