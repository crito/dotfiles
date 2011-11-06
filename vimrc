" Turn vim filetype system off and use pathogen to load all plugins
" https://github.com/tpope/vim-pathogen
"filetype off
"call pathogen#runtime_append_all_bundles()
"call pathogen#helptags()
call pathogen#infect()
syntax on
filetype plugin indent on

" User Interface
if has('syntax')        " enable syntax highlighting
  let python_highlight_all=1
  syntax on
endif

set so=7                        " Set 7 lines to the cursor - when moving vertical
set cmdheight=2                 " The commandbar height
set wildmode=list:longest,full  " have command-line completion <TAB>
set showmode                    " display the current mode and partially
                                "  typed commands in the status line:
set showmatch                   " show matching parenthesis/brackets
set shortmess+=filmnrxoOtT      " abbrev. of messages (avoids 'hit enter')

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


" Text Formatting
"set wrap                        " wrap long lines
set tabstop=4                   " default 4 spaces as tab
set shiftwidth=4                " use indents of 4 spaces
"set shiftround                  
set textwidth=79                " the text width
set expandtab                   " spaces instead of tabs, CTRL-V<Tab> to insert
                                "  a real space
set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
                                "   just press F12 when you are going to
                                "   paste several lines of text so they won't
                                "   be indented
                                "   When in paste mode, everything is inserted
                                "   literally.
set autoindent                  " always set autoindenting on
"set noautoindent
set smartindent                " smart indent
set cindent                    " cindent
set nosmartindent
set nocindent                                  

" code folding
set foldmethod=indent
set foldnestmax=1
set foldlevel=99

" move between windows
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" tasklist mapping
" Detect every TODO or FIXME and creates a task list
map <leader>td <Plug>TaskList

" Toggel gundo revision history
map <leader>g :GundoToggle<CR>

" syntax highlighting
syntax on                    	" syntax highlighing
filetype on                  	" try to detect filetypes
filetype plugin indent on    	" enable loading indent file for filetype

let g:pyflakes_use_quickfix = 0

" map the pep 8 check
let g:pep8_map='<leader>8'

" tab completion, using supertab
au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"

set completeopt=menuone,longest,preview

"
" 4) Search & Replace
"
set hlsearch        " highlight searches
set incsearch       " do incremental searching

" make searches case-insensitive, unless they contain upper-case letters:
set ignorecase
set smartcase

" Automatic replacements
cmap W w 
cmap Q q 

" assume the /g flag on :s substitutions to replace all matches in a line:
set gdefault

" use <F6> to cycle through split windows (and <Shift>+<F6> to cycle backwards,
" where possible):
nnoremap <F6> <C-W>w
nnoremap <S-F6> <C-W>W

" use <Ctrl>+N/<Ctrl>+P to cycle through files:
nnoremap <C-N> :next<CR>
nnoremap <C-P> :prev<CR>
" [<Ctrl>+N by default is like j, and <Ctrl>+P like k.]

" have % bounce between angled brackets, as well as t'other kinds:
set matchpairs+=<:>

" remap makegreen, otherwise it colides
map <unique> <silent> <Leader>tr :call MakeGreen()<cr>

" map ack search (like grep)
nmap <leader>a <Esc>:Ack!

" replace default grep with ack-grep
set grepprg=ack-grep

" django-nose integration
map <leader>dn :set makeprg=python\ manage.py\ test\|:call MakeGreen()<CR>
"map <leader>dn :set makeprg=bin/test-1.3 \|:call MakeGreen()<CR>

" Taglist
let Tlist_Ctags_Cmd='/usr/bin/ctags'
map T :TaskList<CR>
map P :TlistToggle<CR>

" py.test
" Execute the tests
nmap <silent><Leader>tf <Esc>:Pytest file<CR>
nmap <silent><Leader>tc <Esc>:Pytest class<CR>
nmap <silent><Leader>tm <Esc>:Pytest method<CR>
" cycle through test errors
nmap <silent><Leader>tn <Esc>:Pytest next<CR>
nmap <silent><Leader>tp <Esc>:Pytest previous<CR>
nmap <silent><Leader>te <Esc>:Pytest error<CR>

" git specific statusline
"%{fugitive#statusline()}

" change default colorscheme
"colorscheme blackboard
colorscheme wombat256
"set background=dark

" toggle NERDTreeBrowser
map <leader>n :NERDTreeToggle<CR>

" refactor python
map <leader>j :RopeGotoDefinition<CR>
map <leader>r :RopeRename<CR>

" RopeOpenProject
map <C-X>po <C+x>po       
" Add the virtualenv's site-packages to vim path
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

" vim: set sw=4 ts=4 sts=0 et tw=78 nofen fdm=indent ft=vim :

