" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" =============== Pathogen Initialization ===============
" This loads all the plugins in ~/.vim/bundle
" Use tpope's pathogen plugin to manage all other plugins

"runtime bundle/pathogen/autoload/pathogen/pathogen.vim
call pathogen#infect()
call pathogen#infect("langs")
call pathogen#helptags()

" ================ General Config ====================

" Change leader to a comma because the backslash is too far away
" That means all \x commands turn into ,x
let mapleader=","

set number                      "Line numbers are good
" Use Vim settings, rather then Vi settings (much better!).
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set shortmess+=filmnrxoOtT      " abbrev. of messages (avoids 'hit enter')
set showmatch                   " show matching parenthesis/brackets
set autoread                    "Reload files changed outside vim
set wrap
set whichwrap+=<,>,h,l
set encoding=utf8

" Automatic replacements
cmap W w 
cmap Q q 

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

" No sound on errors
set noerrorbells
set novisualbell

"turn on syntax highlighting
syntax on

" When vimrc is edited, reload it
autocmd! bufwritepost ~/.vimrc source ~/.vimrc

if has('cmdline_info')
    set ruler                   " show the ruler
    " a ruler on steroids
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
    set showcmd                 " show partial commands in status line and
                                "   selected characters/lines in visual mode
endif

if has('statusline')
    set laststatus=1           " show statusline only if there are > 1 windows
    " a statusline, also on steroids
    set statusline=%<%f\ %=\:\b%n%y%m%r%w\ %l,%c%V\ %P
endif

" ================ Search Settings  =================

set incsearch        "Find the next match as we type the search
set hlsearch         "Hilight searches by default
set viminfo='100,f1  "Save up to 100 marks, enable capital marks
" make searches case-insensitive, unless they contain upper-case letters:
set ignorecase
set smartcase

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set textwidth=79

set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
                                "   just press F12 when you are going to
                                "   paste several lines of text so they won't
                                "   be indented
                                "   When in paste mode, everything is inserted
                                "   literally.

filetype plugin on
filetype indent on

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing

" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Command line =====================

set ruler                   " show the ruler
" a ruler on steroids
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
set showcmd                 " show partial commands in status line and

" ================ Look and Feel ====================

set gcr=a:blinkon0              "Disable cursor blink
if $TERM =~ "-256color"
  set t_Co=256
endif
colorscheme desert
set background=dark

"statusline setup
set statusline=%#DiffAdd#
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline=%#DiffAdd#
set statusline+=%f\
set statusline+=%#LineNr# "switch to colors used for line number
set statusline+=%{fugitive#statusline()}
set statusline+=%#DiffAdd#  "switch back to normal
set statusline+=%=      "left/right separator
set statusline+=%m      "modified flag

"display a warning if &paste is set
set statusline+=%#DiffChange#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%#LineNr# "switch to colors used for line number
set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight
set statusline+=%#DiffAdd# "switch to colors used for line number
set statusline+=%c:     "cursor column
set statusline+=%l/%L   "cursor line/total lines
"set statusline+=\ %P    "percent through file
set laststatus=2

"return the syntax highlight group under the cursor ''
function! StatuslineCurrentHighlight()
    let name = synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
        return ''
    else
        return '[' . name . ']'
    endif
endfunction



" tasklist mapping
" Detect every TODO or FIXME and creates a task list
"map <leader>td <Plug>TaskList

" Toggel gundo revision history
"map <leader>g :GundoToggle<CR>

"let g:pyflakes_use_quickfix = 0

" map the pep 8 check
"let g:pep8_map='<leader>8'

" tab completion, using supertab
"au FileType python set omnifunc=pythoncomplete#Complete
"let g:SuperTabDefaultCompletionType = "context"

"set completeopt=menuone,longest,preview

" assume the /g flag on :s substitutions to replace all matches in a line:
"set gdefault

" use <F6> to cycle through split windows (and <Shift>+<F6> to cycle backwards,
" where possible):
"nnoremap <F6> <C-W>w
"nnoremap <S-F6> <C-W>W

" use <Ctrl>+N/<Ctrl>+P to cycle through files:
"nnoremap <C-N> :next<CR>
"nnoremap <C-P> :prev<CR>
" [<Ctrl>+N by default is like j, and <Ctrl>+P like k.]

" have % bounce between angled brackets, as well as t'other kinds:
"set matchpairs+=<:>

" remap makegreen, otherwise it colides
"map <unique> <silent> <Leader>tr :call MakeGreen()<cr>

" map ack search (like grep)
" The exclamation mark is added to prevent Ack to open the first result
" automaticaly.
"nmap <leader>a <Esc>:Ack!

" replace default grep with ack-grep
"set grepprg=ack-grep

" django-nose integration
"map <leader>dn :set makeprg=python\ manage.py\ test\|:call MakeGreen()<CR>
"map <leader>dn :set makeprg=bin/test-1.3 \|:call MakeGreen()<CR>

" Taglist
"let Tlist_Ctags_Cmd='/usr/bin/ctags'
"map T :TaskList<CR>
"map P :TlistToggle<CR>

" py.test
" Execute the tests
"nmap <silent><Leader>tf <Esc>:Pytest file<CR>
"nmap <silent><Leader>tc <Esc>:Pytest class<CR>
"nmap <silent><Leader>tm <Esc>:Pytest method<CR>
" cycle through test errors
"nmap <silent><Leader>tn <Esc>:Pytest next<CR>
"nmap <silent><Leader>tp <Esc>:Pytest previous<CR>
"nmap <silent><Leader>te <Esc>:Pytest error<CR>

" git specific statusline
"%{fugitive#statusline()}

" 256 colors only if you can handle it
"if $TERM =~ "-256color"
"  set t_Co=256
"  colorscheme zenburn
"endif
" change default colorscheme
"colorscheme blackboard
" colorscheme wombat256
"set background=dark

" toggle NERDTreeBrowser
"map <leader>n :NERDTreeToggle<CR>

" refactor python
"map <leader>j :RopeGotoDefinition<CR>
"map <leader>r :RopeRename<CR>

" RopeOpenProject
"map <C-X>po <C+x>po       
" Add the virtualenv's site-packages to vim path
"py << EOF
"import os.path
"import sys
"import vim
"if 'VIRTUAL_ENV' in os.environ:
"    project_base_dir = os.environ['VIRTUAL_ENV']
"    sys.path.insert(0, project_base_dir)
"    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"    execfile(activate_this, dict(__file__=activate_this))
"EOF

" vim: set sw=4 ts=4 sts=0 et tw=78 nofen fdm=indent ft=vim :
