set encoding=utf-8
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'

" Vundle help
""""""""""""""
" :PluginList          - list configured bundles
" :PluginInstall(!)    - install(update) bundles
" :PluginSearch(!) foo - search(or refresh cache first) for foo
" :PluginClean(!)      - confirm(or auto-approve) removal of unused bundles

Plugin 'godlygeek/tabular'

" VCS
" Plugin 'tpope/vim-fugitive'

" System
Plugin 'kien/ctrlp.vim'
Plugin 'mileszs/ack.vim'
" Plugin 'mattn/webapi-vim'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-surround'
Plugin 'Raimondi/delimitMate'
" Plugin 'vim-scripts/Gist.vim'
" Plugin 'scrooloose/syntastic'
" Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/rainbow_parentheses.vim'
" Plugin 'sophacles/vim-bundle-sparkup'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'honza/vim-snippets'
Plugin 'AutoComplPop'

" Syntaxes and such.
Plugin 'leshill/vim-json'
" Plugin 'othree/html5.vim'
Plugin 'garbas/vim-snipmate'
Plugin 'itspriddle/vim-jquery'
" Plugin 'tpope/vim-cucumber'
Plugin 'plasticboy/vim-markdown'
Plugin 'kchmck/vim-coffee-script'
Plugin 'mustache/vim-mustache-handlebars'
" Plugin 'dsawardekar/ember.vim'

" Python & Django bundles
" Plugin 'nvie/vim-flake8'
" Plugin 'fs111/pydoc.vim'
" Plugin 'vim-scripts/python_match.vim'
" Plugin 'jmcantrell/vim-virtualenv'

" Ruby & Rails bundles
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-endwise'
" Plugin 'tpope/vim-rails'
" Plugin 'tpope/vim-bundler'

" Fun, but not useful
Plugin 'mgutz/vim-colors'
Plugin 'skammer/vim-css-color'
" Plugin 'ehamberg/vim-cute-python'
" Plugin 'chriskempson/base16-vim'
" Plugin 'chreekat/vim-paren-crosshairs'
Plugin 'altercation/vim-colors-solarized'

call vundle#end()            " required

" Configurations
""""""""""""""""
set background=light

" Wildmenu completion
"""""""""""""""""""""
set wildmenu
set wildmode=list:longest
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=*.luac                           " Lua byte code
set wildignore+=*.pyc                            " Python byte code
set wildignore+=**.class                          " Cursed Java class files

" Save when losing focus
set autowriteall " Auto-save files when switching buffers or leaving vim.
au FocusLost * silent! :wa
au TabLeave * silent! :wa

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

if !has("gui_running")
    set background=dark
    colorscheme desert
else
    set background=dark
    colorscheme solarized
endif

" Basic
syntax on
filetype plugin indent on     " required!

set number        " always show line numbers
set hidden        " Allow un-saved buffers in background
set clipboard=unnamed " Share system clipboard.
set backspace=indent,eol,start " Make backspace behave normally.
set directory=/tmp// " swap files
set backupskip=/tmp/*,/private/tmp/*
set ffs=unix,dos,mac "Default file types
set nowrap        " don't wrap lines
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                  "  case-sensitive otherwise
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep

let g:CSSLint_FileTypeList = ['css', 'less', 'sess']

" Remove the toolbar if we're running under a GUI (e.g. MacVIM).
if has("gui_running")
  set guioptions=-t
endif

" Special characters for hilighting non-priting spaces/tabs/etc.
set list listchars=tab:»\ ,trail:·

" Default Tabs & spaces
set tabstop=4     " a tab is four spaces
set shiftwidth=4  " number of spaces to use for autoindenting
set softtabstop=4
set expandtab
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set smarttab      " insert tabs on the start of a line according to
                  "    shiftwidth, not tabstop
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set smartindent

" General Code Folding
""""""""""""""""""""""
set foldmethod=indent
set foldlevel=99

" Highlight VCS conflict markers
""""""""""""""""""""""""""""""""
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" I CAN HAZ NORMAL REGEXES?
"""""""""""""""""""""""""""
nnoremap / /\v
vnoremap / /\v


" General auto-commands
"""""""""""""""""""""""
autocmd FileType * setlocal colorcolumn=0
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red

" Get rid of trailing whitespace highlighting in mutt.
autocmd FileType mail highlight clear ExtraWhitespace
autocmd FileType mail setlocal listchars=

let g:mustache_abbreviations = 1

" Reformat XML files
au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"

" Crontab auto-commands
"""""""""""""""""""""""
autocmd FileType crontab setlocal backupcopy=yes

" turn-on distraction free writing mode for markdown files
" au BufNewFile,BufRead *.{md,mdown,mkd,mkdn,markdown,mdwn} call DistractionFreeWriting()

function! DistractionFreeWriting()
    colorscheme iawriter
    set background=light
    set lines=60 columns=100           " size of the editable area
    set fuoptions=background:#00f5f6f6 " macvim specific setting for editor's background color
    set guioptions-=r                  " remove right scrollbar
    set laststatus=2                   " don't show status line
    set noruler                        " don't show ruler
    set fullscreen                     " go to fullscreen editing mode
    set linebreak                      " break the lines on words
endfunction

:map <F8> :call DistractionFreeWriting()<CR>

" Toggle spellcheck in normal mode
:map <F5> :setlocal spell! spelllang=en_us<CR>

" Ruby Configurations
"""""""""""""""""""""
autocmd filetype ruby setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd Filetype eruby setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType cucumber compiler cucumber | setl makeprg=cucumber\ \"%:p\"
autocmd FileType ruby
      \ if expand('%') =~# '_test\.rb$' |
      \   compiler rubyunit | setl makeprg=testrb\ \"%:p\" |
      \ elseif expand('%') =~# '_spec\.rb$' |
      \   compiler rspec | setl makeprg=rspec\ \"%:p\" |
      \ else |
      \   compiler ruby | setl makeprg=ruby\ -wc\ \"%:p\" |
      \ endif
autocmd User Bundler
            \ if &makeprg !~# 'bundle' | setl makeprg^=bundle\ exec\  | endif

" PHP Configurations
""""""""""""""""""""
autocmd FileType php setlocal colorcolumn=100

" HTML configurations
"""""""""""""""""""""
autocmd FileType html setlocal shiftwidth=2 expandtab tabstop=2 softtabstop=2
" autocmd FileType htmldjango setlocal shiftwidth=2 expandtab tabstop=2 softtabstop=2

" Python configurations
"""""""""""""""""""""""
" autocmd FileType python setlocal shiftwidth=4 expandtab tabstop=4 softtabstop=4
" autocmd FileType python setlocal colorcolumn=80
" autocmd FileType python map <buffer> <F4> :call Flake8()<CR>
" autocmd FileType python autocmd BufWritePre * :%s/\s\+$//e
" autocmd FileType python set omnifunc=pythoncomplete#Complete
"
" autocmd FileType python set ft=python.django " For SnipMate
" autocmd FileType htmldjango set ft=htmldjango.html " For SnipMate
" autocmd FileType html set ft=htmldjango.html " For SnipMate

" CSS Configurations
"""""""""""""""""""""""""""""
autocmd FileType scss set ft=scss.css " For SnipMate
autocmd FileType sass set ft=sass.css " For SnipMate
autocmd FileType css set omnifunc=csscomplete#CompleteCSS


" Coffeescript configurations
"""""""""""""""""""""""""""""
au BufNewFile,BufReadPost *.coffee setlocal foldmethod=indent
au BufNewFile,BufReadPost *.coffee setlocal shiftwidth=2 expandtab

" Javascript configurations
"""""""""""""""""""""""""""
au BufNewFile,BufReadPost *.js setlocal shiftwidth=2 expandtab

" Vim JavaScript Configuration
"""""""""""""""""""""""""""
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

" Make sure we hilight extra whitespace in the most annoying way possible.
highlight ExtraWhitespace ctermbg=red guibg=red
" highlight Normal ctermfg=grey ctermbg=darkblue

match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

" Custom mappings
""""""""""""""""""

" General
noremap <silent> <F4> :QFix<CR>


" Change leader
let mapleader = ","
let g:mapleader = ","

" Get rid of search hilighting with ,/
nnoremap <silent> <leader>/ :nohlsearch<CR>

" Fix those pesky situations where you edit & need sudo to save
cmap w!! w !sudo tee % >/dev/null


" Plugin configurations
"""""""""""""""""""""""

" Pyflakes
"autocmd BufWritePost *.py call Flake8()
" let g:flake8_ignore="E128,E501"
" let g:syntastic_python_checker_args='--ignore=E501,E128'

" TaskList
"map <leader>l <Plug>TaskList

" TagBar
nnoremap <silent> <F2> :TagbarToggle<CR>
let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
let g:tagbar_autoshowtag = 1
let g:tagbar_autofocus = 1

" crtl-p
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files --exclude-standard -co']

" SnipMate
let g:snippets_dir = "~/.vim/bundle/snipmate-snippets"

" Sparkup
" let g:sparkupExecuteMapping = '<c-y>'
" let g:sparkupNextMapping = '<c-k>'

" Jedi
" let g:jedi#goto_command = "<leader>g"

" Double rainbow - What does it mean!?
" au VimEnter * RainbowParenthesesToggle
" au Syntax * RainbowParenthesesLoadRound
" au Syntax * RainbowParenthesesLoadSquare
" au Syntax * RainbowParenthesesLoadBraces

set laststatus=2
" let g:syntastic_enable_signs = 1
" let g:syntastic_auto_jump = 0
" let g:syntastic_puppet_lint_disable = 0

" Navigation
set scrolloff=8
nmap <C-k> 5k
nmap <C-j> 5j

" Shorcuts
:imap jj <Esc> " Exit from insert mode
map ,w :w!<CR>
map ,q :q!<CR>
map ,e :NERDTreeToggle<CR>

" Bubble single lines
" nmap <C-Up> [e
" nmap <C-Down> ]e
" Bubble multiple lines
" vmap <C-Up> [egv
" vmap <C-Down> ]egv
