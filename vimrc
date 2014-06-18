set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'Valloric/YouCompleteMe'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'fatih/vim-go' 
Plugin 'derekwyatt/vim-scala'
Plugin 'kien/ctrlp.vim'
Plugin 'mileszs/ack.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'SirVer/ultisnips'
Plugin 'Raimondi/delimitMate'
Plugin 't9md/vim-choosewin'
Plugin 'fatih/molokai'
Plugin 'kchmck/vim-coffee-script'
Plugin 'tomtom/tcomment_vim'
Plugin 'majutsushi/tagbar'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'ekalinin/Dockerfile.vim'

call vundle#end()            " required
filetype plugin indent on    " required

"
" Settings
" 
set noerrorbells                " No beeps
set number                      " Show line numbers
set backspace=indent,eol,start  " Makes backspace key more powerful.
set showcmd                     " Show me what I'm typing
set showmode                    " Show current mode.

set noswapfile                  " Don't use swapfile
set nobackup            	" Don't create annoying backup files
set splitright                  " Split vertical windows right to the current windows
set splitbelow                  " Split horizontal windows below to the current windows
set encoding=utf-8              " Set default encoding to UTF-8
set autowrite                   " Automatically save before :next, :make etc.
set autoread                    " Automatically reread changed files without asking me anything
set laststatus=2

set fileformats=unix,dos,mac    " Prefer Unix over Windows over OS 9 formats

"http://stackoverflow.com/questions/20186975/vim-mac-how-to-copy-to-clipboard-without-pbcopy
set clipboard^=unnamed 
set clipboard^=unnamedplus

set noshowmatch                   " Do not show matching brackets by flickering
set nocursorcolumn
set lazyredraw          	" Wait to redraw "
set incsearch                   " Shows the match while typing
set hlsearch                    " Highlight found searches
set ignorecase                  " Search case insensitive...
set smartcase                   " ... but not when search pattern contains upper case characters
set ttyfast 

" speed up syntax highlighting
set nocursorcolumn
set nocursorline
syntax sync minlines=256
set re=1

set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

if has("gui_macvim")
    " No toolbars, menu or scrollbars in the GUI
    " set guifont=Source\ Code\ Pro:h13
    set guifont=Source\ Code\ Pro:h13
    set clipboard+=unnamed
    set vb t_vb=
    set guioptions-=m  "no menu
    set guioptions-=T  "no toolbar
    set guioptions-=l
    set guioptions-=L
    set guioptions-=r  "no scrollbar
    set guioptions-=R

    let macvim_skip_colorscheme=1
    let g:molokai_original=1
    colorscheme molokai
    highlight SignColumn guibg=#272822

    " Open ctrlp with cmd+p
    " let g:ctrlp_map = '<D-p>'

    " Open goto symbol on current buffer
    nmap <D-r> :MyCtrlPTag<cr>
    imap <D-r> <esc>:MyCtrlPTag<cr>

    " Open goto symbol on all buffers
    nmap <D-R> :CtrlPBufTagAll<cr>
    imap <D-R> <esc>:CtrlPBufTagAll<cr>

    " Open goto file
    nmap <D-t> :CtrlP<cr>
    imap <D-t> <esc>:CtrlP<cr>

    " Comment lines with cmd+/
    map <D-/> :TComment<cr>
    vmap <D-/> :TComment<cr>gv

    " Indent lines with cmd+[ and cmd+]
    nmap <D-]> >>
    nmap <D-[> <<
    vmap <D-[> <gv
    vmap <D-]> >gv

    " This mapping makes Ctrl-Tab switch between tabs.
    " Ctrl-Shift-Tab goes the other way.
    noremap <C-Tab> :tabnext<CR>
    noremap <C-S-Tab> :tabprev<CR>

    " switch between tabs with cmd+1, cmd+2,..."
    map <D-1> 1gt
    map <D-2> 2gt
    map <D-3> 3gt
    map <D-4> 4gt
    map <D-5> 5gt
    map <D-6> 6gt
    map <D-7> 7gt
    map <D-8> 8gt
    map <D-9> 9gt

    " until we have default MacVim shortcuts this is the only way to use it in
    " insert mode
    imap <D-1> <esc>1gt
    imap <D-2> <esc>2gt
    imap <D-3> <esc>3gt
    imap <D-4> <esc>4gt
    imap <D-5> <esc>5gt
    imap <D-6> <esc>6gt
    imap <D-7> <esc>7gt
    imap <D-8> <esc>8gt
    imap <D-9> <esc>9gt
else
    syntax enable
    set background=dark

    let macvim_skip_colorscheme=1
    let g:molokai_original=1
    colorscheme molokai
    highlight SignColumn guibg=#272822
    highlight VertSplit ctermbg=bg ctermfg=bg 
    set t_Co=256
endif

" Stop completion with enter, in addition to default ctrl+y
imap <expr> <CR> pumvisible() ? "\<c-y>" : "<Plug>delimitMateCR"

" ----------------------------------------- "
" Plugin configs 			    			"
" ----------------------------------------- "
" let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
let g:ctrlp_cmd = 'CtrlPMRU'		" search anything (in files, buffers and MRU files at the same time.)
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_max_height = 10		" maxiumum height of match window
let g:ctrlp_switch_buffer = 'et'	" jump to a file if it's open already
let g:ctrlp_mruf_max=450 		" number of recently opened files
let g:ctrlp_max_files=0  		" do not limit the number of searchable files
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'

func! MyPrtMappings()
    let g:ctrlp_prompt_mappings = {
                \ 'AcceptSelection("e")': ['<c-t>'],
                \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
                \ }
endfunc

func! MyCtrlPTag()
    let g:ctrlp_prompt_mappings = {
                \ 'AcceptSelection("e")': ['<cr>', '<2-LeftMouse>'],
                \ 'AcceptSelection("t")': ['<c-t>'],
                \ }
    CtrlPBufTag
endfunc

let g:ctrlp_buffer_func = { 'exit': 'MyPrtMappings' }
com! MyCtrlPTag call MyCtrlPTag()

" TODO: add javascript and some other languages who doesn't have ctags support
" coffee: https://gist.github.com/michaelglass/5210282
" go: http://stackoverflow.com/a/8236826/462233 
" objc:  http://www.gregsexton.org/2011/04/objective-c-exuberant-ctags-regex/
" rust: https://github.com/mozilla/rust/blob/master/src/etc/ctags.rust
let g:ctrlp_buftag_types = {
            \ 'go'     	   : '--language-force=go --golang-types=ftv',
            \ 'coffee'     : '--language-force=coffee --coffee-types=cmfvf',
            \ 'markdown'   : '--language-force=markdown --markdown-types=hik',
            \ 'objc'       : '--language-force=objc --objc-types=mpci',
            \ 'rc'         : '--language-force=rust --rust-types=fTm'
            \ }

let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_min_num_of_chars_for_completion = 1

"create line break when pressing enter
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1


let g:CommandTMaxHeight = 20
let g:CommandTMaxFiles = 500000
let g:CommandTMatchWindowReverse = 1
let g:CommandTMaxCachedDirectories = 0
let g:CommandTAcceptSelectionTabMap = '<CR>'


if has("gui_macvim")
    macmenu &File.New\ Tab key=<nop>
    " nnoremap <silent> <c-p> :CommandT /Users/fatih/Code/koding/<CR>
    nmap <D-p> :CommandT /Users/fatih/Code/koding<CR>
endif
"
augroup filetypedetect
    au BufNewFile,BufRead .tmux.conf*,tmux.conf* setf tmux
augroup END

" This comes first, because we have mappings that depend on leader
" With a map leader it's possible to do extra key combinations
" i.e: <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","


" This trigger takes advantage of the fact that the quickfix window can be
" easily distinguished by its file-type, qf. The wincmd J command is
" equivalent to the Ctrl+W, Shift+J shortcut telling Vim to move a window to
" the very bottom (see :help :wincmd and :help ^WJ).
autocmd FileType qf wincmd J

"Quickfix window
" Automatically open, but do not go to (if there are errors) the quickfix /
" location list window, or close it when is has become empty.
"
" Note: Must allow nesting of autocmds to enable any customizations for
" quickfix buffers.  Note: Normally, :cwindow jumps to the quickfix window if
" the command opens it (but not if it's already open). However, as part of the
" autocmd, this doesn't seem to happen.
" autocmd QuickFixCmdPost [^l]* nested cwindow
" autocmd QuickFixCmdPost    l* nested lwindow

"Dont show me any output when I build something
"Because I am using quickfix for errors
nmap <leader>m :make<CR><enter>

" Some useful quickfix shortcuts
":cc      see the current error
":cn      next error
":cp      previous error
":clist   list all errors
map <C-n> :cn<CR>
map <C-m> :cp<CR>

" Close quickfix easily
nnoremap <leader>a :cclose<CR>

" Remove search highlight
nnoremap <leader><space> :nohlsearch<CR>

" Better split switching
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Fast saving
nmap <leader>w :w!<cr>
nmap <leader>q :q!<cr>

" Center the screen
nnoremap <space> zz

" Move up and down on splitted lines (on small width screens)
map <Up> gk
map <Down> gj
map k gk
map j gj

" Just go out in insert mode
imap jk <ESC>l

" Select search pattern howewever do not jump to the next one
nnoremap <leader>f *N

nnoremap <F6> :setlocal spell! spell?<CR>


" Select search pattern howewever do not jump to the next one
nnoremap <leader>c :TComment<cr>

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

"nnoremap <leader>. :lcd %:p:h<CR>
autocmd BufEnter * silent! lcd %:p:h

" trim all whitespaces away
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Act like D and C
nnoremap Y y$

" Do not show stupid q: window
map q: :q

"Reindent whoel file
map <F7> mzgg=G`z<CR>

au BufNewFile,BufRead *.vim setlocal noet ts=2 sw=2 sts=2
au BufNewFile,BufRead *.txt setlocal noet ts=4 sw=4 
au BufNewFile,BufRead *.md setlocal noet ts=4 sw=4 
" ------------------------------------------"
" Plugin Settings
" ----------------------------------------- "

" golang settings
au BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4

let g:go_fmt_fail_silently = 1

au FileType go nmap gd <Plug>(go-def)
au FileType go nmap <Leader>s <Plug>(go-def-split)
au FileType go nmap <Leader>v <Plug>(go-def-vertical)

au FileType go nmap <Leader>i <Plug>(go-info)

au FileType go nmap  <leader>r  <Plug>(go-run)
au FileType go nmap  <leader>b  <Plug>(go-build)
au FileType go nmap  <leader>t  <Plug>(go-test)

au FileType go nmap <Leader>d <Plug>(go-doc-browser)

" coffeescript settings
autocmd BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab

" scala settings
autocmd BufNewFile,BufReadPost *.scala setl shiftwidth=2 expandtab

" lua settings
autocmd BufNewFile,BufRead *.lua setlocal noet ts=4 sw=4 sts=4

" let g:aghighlight=1
" noremap <Leader>a :Ag! <cword> /Users/fatih/Code/koding <cr>

" Open nerdtree in current dir, write our own custom function because
" NerdTreeToggle just sucks and doesn't work for buffers
function! g:NerdTreeFindToggle()
    if nerdtree#isTreeOpen()
        exec 'NERDTreeClose'
    else
        exec 'NERDTreeFind'
    endif
endfunction

" For toggling
noremap <Leader>n :<C-u>call g:NerdTreeFindToggle()<cr> 

" For refreshing current file and showing current dir
noremap <Leader>j :NERDTreeFind<cr>

"stevelosh

" iTerm2 is currently slow as ball at rendering the nice unicode lines, so for
" now I'll just use ascii pipes.  They're ugly but at least I won't want to kill
" myself when trying to move around a file.
set fillchars=diff:⣿,vert:│
set fillchars=diff:⣿,vert:\|

" Don't try to highlight lines longer than 800 characters.
set synmaxcol=800

" Better Completion
set complete=.,w,b,u,t
set completeopt=longest,menuone

" Resize splits when the window is resized
au VimResized * :wincmd =

" Wildmenu completion {{{
set wildmenu
" set wildmode=list:longest
set wildmode=list:full

set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit

set wildignore+=*.luac                           " Lua byte code

set wildignore+=migrations                       " Django migrations
set wildignore+=*.pyc                            " Python byte code

set wildignore+=*.orig                           " Merge resolution files

nnoremap <leader>ga :Git add %:p<CR><CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gb :Gblame<CR>
vnoremap <leader>gb :Gblame<CR>

" choosewin
nmap  -  <Plug>(choosewin)

" ultisnips
function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res == 0
        if pumvisible()
            return "\<C-N>"
        else
            return "\<TAB>"
        endif
    endif

    return ""
endfunction

function! g:UltiSnips_Reverse()
    call UltiSnips#JumpBackwards()
    if g:ulti_jump_backwards_res == 0
        return "\<C-P>"
    endif

    return ""
endfunction


if !exists("g:UltiSnipsJumpForwardTrigger")
    let g:UltiSnipsJumpForwardTrigger = "<tab>"
endif

if !exists("g:UltiSnipsJumpBackwardTrigger")
    let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
endif

au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
au BufEnter * exec "inoremap <silent> " . g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"


" Prettify json
com! JSONFormat %!python -m json.tool

let g:airline_powerline_fonts = 1

" vim:ts=4:sw=4:et

