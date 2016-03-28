set nocompatible

" plugin manager: vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-obsession' 
    \ | Plug 'dhruvasagar/vim-prosession'
  Plug 'scrooloose/syntastic'
  Plug 'majutsushi/tagbar'
  Plug 'airblade/vim-gitgutter'
  Plug 'vim-airline/vim-airline' 
    \ | Plug 'edkolev/tmuxline.vim'
    \ | Plug 'vim-airline/vim-airline-themes'
    \ | Plug 'altercation/vim-colors-solarized'

  " dev plugins
  "Plug 'fatih/vim-go', { 'for' : 'go', 'do' : [':GoUpdateBinaries', 'gometalinter --install --update'] }
  Plug 'fatih/vim-go', { 'for' : 'go' }

  " neovim specific plugins
  if has('nvim')
    "Plug 'Shougo/deoplete.nvim', { 'do' : ':UpdateRemotePlugins' } 
    Plug 'Shougo/deoplete.nvim'
      \ | Plug 'zchee/deoplete-go', { 'do' : 'make'}
  else
    Plug 'Shougo/neocomplete.vim'
  endif
call plug#end()

" overriding sensible settings
set hidden
set wrap
set linebreak
set formatoptions-=t
set tabstop=4
set shiftwidth=4
set directory^=~/.vim/swp//
set number
set noshowmode
set mouse=r
set timeoutlen=50 
set ttimeoutlen=0
let g:netrw_liststyle=3
let g:netrw_winsize=20
let g:netrw_browse_split=4
let g:netrw_banner=0
map <C-J> :bprev<CR>
map <C-K> :bnext<CR>

" improve searching
set incsearch
set hlsearch
nnoremap <CR> :nohlsearch<Bar>:echo<CR>

" IDE-like intellisense
"set completeopt=longest,menuone
"inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"inoremap <expr> <C-n> pumvisible() ? '<C-n>' : 
"			\ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
"inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
			\ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

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
nmap <F8> :TagbarToggle<CR>

" fixing 256 colors in tmux
"set term=xterm-256color
set t_Co=256                        " force vim to use 256 colors

" fixing Background Color Erase when term is set to non-xterm
if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
else
  " switch to fallback mode when there xterm-256color isn't detected
  " (e.g. gnome's Drop Down Shell extension)
"  let g:solarized_termcolors=256
endif

" solarized theme
set background=dark
colorscheme solarized

" SuperTab
"let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
"let g:SuperTabDefaultCompletionType = "context"

function! SyntasticSetup()
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 0 " use :lopen / :lclose to open/show
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0
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
  au FileType go nmap <Leader>i <Plug>(go-info)
  au FileType go nmap <Leader>gd <Plug>(go-doc)
  au FileType go nmap <Leader>r <Plug>(go-run)
  au FileType go nmap <Leader>b <Plug>(go-build)
  au FileType go nmap <Leader>t <Plug>(go-test)
  au FileType go nmap gd <Plug>(go-def-tab)
  let g:go_highlight_functions = 1
  let g:go_highlight_methods = 1
  let g:go_highlight_structs = 1
  let g:go_highlight_interfaces = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_build_constraints = 1  
endfunction

function! DeopleteSetup()
  " deoplete.vim
  " commands: https://github.com/Shougo/deoplete.nvim
  let g:deoplete#enable_at_startup = 1
  set completeopt+=longest
  set completeopt+=menuone
  set completeopt+=noinsert
  "set completeopt-=preview
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

  "if !exists('g:spf13_no_neosnippet_expand')
  "  imap <C-k> <Plug>(neosnippet_expand_or_jump)
  "  smap <C-k> <Plug>(neosnippet_expand_or_jump)
  "  xmap <C-k> <Plug>(neosnippet_expand_target)
  "  smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  "  \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

  "  " For conceal markers.
  "  if has('conceal')
  "    set conceallevel=2 concealcursor=niv
  "  endif
  "endif

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
