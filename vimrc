" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible


" =============== VAM Initialization ===============
" VAM is an addon manager similar to pathogen. You specify your requirements,
" and VAM installs them if missing including any dependency. You can specify
" plugin names from a pool or repository locations. There is a special syntax
" to support github repositories.
" https://github.com/MarcWeber/vim-addon-manager

fun! EnsureVamIsOnDisk(vam_install_path)
  " windows users may want to use http://mawercer.de/~marc/vam/index.php
  " to fetch VAM, VAM-known-repositories and the listed plugins
  " without having to install curl, 7-zip and git tools first
  " -> BUG [4] (git-less installation)
  let is_installed_c = "isdirectory(a:vam_install_path.'/vim-addon-manager/autoload')"
  if eval(is_installed_c)
    return 1
  else
    if 1 == confirm("Clone VAM into ".a:vam_install_path."?","&Y\n&N")
      " I'm sorry having to add this reminder. Eventually it'll pay off.
      call confirm("Remind yourself that most plugins ship with ".
                  \"documentation (README*, doc/*.txt). It is your ".
                  \"first source of knowledge. If you can't find ".
                  \"the info you're looking for in reasonable ".
                  \"time ask maintainers to improve documentation")
      call mkdir(a:vam_install_path, 'p')
      execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '.shellescape(a:vam_install_path, 1).'/vim-addon-manager'
      " VAM runs helptags automatically when you install or update 
      " plugins
      exec 'helptags '.fnameescape(a:vam_install_path.'/vim-addon-manager/doc')
    endif
    return eval(is_installed_c)
  endif
endf

fun! SetupVAM()
  " Set advanced options like this:
  " let g:vim_addon_manager = {}
  " let g:vim_addon_manager['key'] = value

  " Example: drop git sources unless git is in PATH. Same plugins can
  " be installed from www.vim.org. Lookup MergeSources to get more control
  " let g:vim_addon_manager['drop_git_sources'] = !executable('git')
  " let g:vim_addon_manager.debug_activation = 1

  " VAM install location:
  let vam_install_path = expand('$HOME') . '/.vim/vim-addons'
  if !EnsureVamIsOnDisk(vam_install_path)
    echohl ErrorMsg
    echomsg "No VAM found!"
    echohl NONE
    return
  endif
  exec 'set runtimepath+='.vam_install_path.'/vim-addon-manager'

  " Tell VAM which plugins to fetch & load:
  call vam#ActivateAddons(["github:nvie/vim-flake8", "github:mileszs/ack.vim", "github:kien/ctrlp.vim", "github:ddollar/nerdcommenter", "github:scrooloose/syntastic", "github:majutsushi/tagbar", "github:tpope/vim-fugitive", "github:vim-scripts/ZoomWin", "github:chrisbra/NrrwRgn", "github:vim-scripts/TaskList.vim", "github:sjl/gundo.vim", "github:vim-scripts/YankRing.vim", "github:scrooloose/nerdtree", "snipmate-snippets", "github:int3/vim-extradite", "github:ervandew/supertab", "github:dterei/VimBookmarking", "github:sjbach/lusty", "github:tpope/vim-surround", "github:tsaleh/vim-matchit", "Gist", "github:mattn/webapi-vim"], {'auto_install' : 0})
  " sample: call vam#ActivateAddons(['pluginA','pluginB', ...], {'auto_install' : 0})

  " Addons are put into vam_install_path/plugin-name directory
  " unless those directories exist. Then they are activated.
  " Activating means adding addon dirs to rtp and do some additional
  " magic

  " How to find addon names?
  " - look up source from pool
  " - (<c-x><c-p> complete plugin names):
  " You can use name rewritings to point to sources:
  "    ..ActivateAddons(["github:foo", .. => github://foo/vim-addon-foo
  "    ..ActivateAddons(["github:user/repo", .. => github://user/repo
  " Also see section "2.2. names of addons and addon sources" in VAM's documentation
endfun
call SetupVAM()


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


" ================ Key mappings and Plugin configuration =============

" Don't have to use Shift to get into command mode, just hit semicolon
nnoremap ; :

"Go to last edit location with ,.
nnoremap ,. '.

" ,q to toggle quickfix window (where you have stuff like GitGrep)
" ,qo to open it back up (rare)
nmap <silent> ,q :cclose<CR>
nmap <silent> ,oq :copen<CR>

" ,l to toggle location window (where you have stuff like pep8 warnings)
" ,lo to open it back up (rare)
nmap <silent> ,l :lclose<CR>
nmap <silent> ,ol :lopen<CR>

"Move back and forth through previous and next buffers
"with ,z and ,x
nnoremap <silent> ,z :bp<CR>
nnoremap <silent> ,x :bn<CR>

" Automatic replacements
cmap W w 
cmap Q q 

" Fast saving
nmap <leader>w :w!<cr>

" Fast editing of the .vimrc
map <leader>e :e! ~/.vimrc<cr>

" Adjust viewports to the same size
map <leader>= <c-w>=

" move between windows
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Create window splits easier. The default
" way is Ctrl-w,v and Ctrl-w,s. I remap
" this to vv and ss
nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s

" remap movement inside a line
"nnoremap <silent> a 0   <-- a is taken by 'append text'
"nnoremap <silent> e $

"Clear current search highlight by double tapping //
nmap <silent> // :nohlsearch<CR>

" hit ,f to find the definition of the current class
" this uses ctags. the standard way to get this is Ctrl-]
nnoremap <silent> ,f <C-]>

" use ,F to jump to tag in a vertical split
nnoremap <silent> ,F :let word=expand("<cword>")<CR>:vsp<CR>:wincmd w<cr>:exec("tag ". word)<cr>

" ===== vim zoomwindow
map <silent> ,gz <C-w>o

" ===== gundo
" open on the right so as not to compete with the nerdtree
let g:gundo_right = 1 

" a little wider for wider screens
let g:gundo_width = 60
nmap ,u :GundoToggle<CR>

" ===== NERD tree
" Make nerdtree look nice
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:NERDTreeWinSize = 30
" Cmd-Shift-N for nerd tree
nmap ,n :NERDTreeToggle<CR>

" Open the project tree and expose current file in the nerdtree with Ctrl-\
nnoremap <silent> <C-\> :NERDTreeFind<CR>

" ===== CtrlP fuzzy file search
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn|\.pyc$'

" Default to filename searches - so that appctrl will find application
" controller
let g:ctrlp_by_filename = 1

" We don't want to use Ctrl-p as the mapping because
" it interferes with YankRing (paste, then hit ctrl-p)
let g:ctrlp_map = ',p'
" Additional mapping for buffer search
nnoremap ,b :CtrlPBuffer<cr>
nnoremap <C-b> :CtrlPBuffer<cr>

" clear the cache
nnoremap <silent> ,P :ClearCtrlPCache<cr>

" ===== Flake8
" automatically call the flake8 test on python files
autocmd bufwritepost *.py call Flake8()
let g:flake8_max_line_length=120
autocmd FileType python map <buffer> <leader>8 :call Flake8()<CR>

" ===== Tasklist
" Detect every TODO or FIXME and creates a task list
map <leader>T <Plug>TaskList

" ===== VimBookmarking
" Set anonymous bookmarks
nmap ,Bb :ToggleBookmark<cr>
nmap ,Bn :NextBookmark<cr>
nmap ,Bp :PreviousBookmark<cr>
nmap ,Bc :ClearBookmarks<cr>

" ===== Python
if has('python')
    set makeprg=python\ setup.py\ nosetests
    map <leader>tn :make<CR>
endif

" ===== NerdComments
" Command-/ to toggle comments
map <leader>\ <plug>NERDCommenterToggle

" ===== ack grep
" map ack search (like grep)
" The ack program has to be installed for this
" The exclamation mark is added to prevent Ack to open the first result
" automaticaly.
nmap <leader>a <Esc>:Ack!
" replace default grep with ack-grep
set grepprg=ack-grep

" ===== vim yankring
nmap <silent> ,y :YRShow<CR>
let g:yankring_history_file = '.yankring-history'

" via: http://rails-bestpractices.com/posts/60-remove-trailing-whitespace
" Strip trailing whitespace
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
command! StripTrailingWhitespaces call <SID>StripTrailingWhitespaces()
"nmap ,w :StripTrailingWhitespaces<CR>

" ===== Taglist
map <F4> :TagbarToggle<cr>

" ===== Gist
" Copy gist code to cliboard
let g:gist_clip_command = 'xclip -selection clipboard'
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1
map <leader>Ga :Gist -a<cr>
map <leader>Gp :Gist -p<cr>

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
