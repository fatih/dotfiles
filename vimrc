call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-scriptease'
Plug 'moll/vim-bbye'
Plug 'rking/ag.vim'
Plug 'mhinz/vim-sayonara'
Plug 'itchyny/lightline.vim'
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh' }
Plug 'git://git.wincent.com/command-t.git'
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'garyburd/go-explorer'
Plug 'fatih/vim-nginx' , {'for' : 'nginx'}
Plug 'fatih/molokai'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'SirVer/ultisnips'
Plug 'kchmck/vim-coffee-script', {'for' : 'coffee'}
Plug 'tomtom/tcomment_vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'ekalinin/Dockerfile.vim', {'for' : 'Dockerfile'}
Plug 'JazzCore/ctrlp-cmatcher', {'do': './install.sh'}
Plug 'cespare/vim-toml', {'for' : 'toml'}
Plug 'elzr/vim-json', {'for' : 'json'}
Plug 'corylanou/vim-present', {'for' : 'present'}


call plug#end()

set nocompatible              " be iMproved, required
filetype off                  " required

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
set nobackup            	    " Don't create annoying backup files
set splitright                  " Split vertical windows right to the current windows
set splitbelow                  " Split horizontal windows below to the current windows
set encoding=utf-8              " Set default encoding to UTF-8
set autowrite                   " Automatically save before :next, :make etc.
set autoread                    " Automatically reread changed files without asking me anything
set laststatus=2
set hidden

set fileformats=unix,dos,mac    " Prefer Unix over Windows over OS 9 formats

"http://stackoverflow.com/questions/20186975/vim-mac-how-to-copy-to-clipboard-without-pbcopy
set clipboard^=unnamed
set clipboard^=unnamedplus

set noshowmatch                 " Do not show matching brackets by flickering
set nocursorcolumn
set noshowmode                  " We show the mode with airlien or lightline
set incsearch                   " Shows the match while typing
set hlsearch                    " Highlight found searches
set ignorecase                  " Search case insensitive...
set smartcase                   " ... but not when search pattern contains upper case characters
set ttyfast
set ttymouse=xterm2
set ttyscroll=3
set lazyredraw          	    " Wait to redraw "

" speed up syntax highlighting
set nocursorcolumn
set nocursorline

syntax sync minlines=256
set synmaxcol=300
set re=1
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" open help vertically

command! -nargs=* -complete=help Help vertical belowright help <args>
autocmd FileType help wincmd L

if has("gui_macvim")
  " No toolbars, menu or scrollbars in the GUI
  set guifont=Source\ Code\ Pro:h12
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
  " set background=dark
  let g:molokai_original=1
  colorscheme molokai
  set t_Co=256

  "syntax enable
  ""colorscheme jellybeans

  "set background=dark
  "colorscheme solarized
endif

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

" simulate tab shortcuts
map gb :bnext<cr>
map gB :bprevious<cr>

nnoremap <silent> <leader>q :Sayonara<CR>

" function! CloseSplitOrDeleteBuffer()
"   let totalBufNr = len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
"   let totalWinNr = winnr('$')
"
"   " there is only one buffer and one window, close VIM
"   if totalBufNr == 1 && totalWinNr == 1
"     quit
"   endif
"
"   let curNr = winnr()
"   let curBuf = bufnr('%')
"
"   "try to move on next split
"   wincmd w
"   if winnr() == curNr
"     " there is no split, delete the buffer only
"     exe 'bdelete!'
"   elseif curBuf != bufnr('%')
"     "there is split with another buffer, move back and delete it
"     wincmd W
"     exe 'bdelete!'
"   else
"     "there is split with same buffer, just close the split
"     wincmd W
"     close!
"   endif
" endfunction

" Replace the current buffer with the given new file. That means a new file
" will be open in a buffer while the old one will be deleted
com! -nargs=1 -complete=file Breplace edit <args>| bdelete #

function! DeleteInactiveBufs()
    "From tabpagebuflist() help, get a list of all buffers in all tabs
    let tablist = []
    for i in range(tabpagenr('$'))
        call extend(tablist, tabpagebuflist(i + 1))
    endfor

    "Below originally inspired by Hara Krishna Dara and Keith Roberts
    "http://tech.groups.yahoo.com/group/vim/message/56425
    let nWipeouts = 0
    for i in range(1, bufnr('$'))
        if bufexists(i) && !getbufvar(i,"&mod") && index(tablist, i) == -1
        "bufno exists AND isn't modified AND isn't in the list of buffers open in windows and tabs
            silent exec 'bwipeout' i
            let nWipeouts = nWipeouts + 1
        endif
    endfor
    echomsg nWipeouts . ' buffer(s) wiped out'
endfunction

command! Ball :call DeleteInactiveBufs()

" Yank the word under the cursor, go into insert mode one line below, execute
" the snippet `fa`, which puts the yanked word inside the `fa` snippet and
" finish
nmap <silent> <leader>z yiwofa<tab><esc><cr>

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

" Center the screen
nnoremap <space> zz

" Move up and down on splitted lines (on small width screens)
map <Up> gk
map <Down> gj
map k gk
map j gj

" Just go out in insert mode
imap jk <ESC>l

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

" sometimes this happens and I hate it
map :Vs :vs
map :Sp :sp

"Reindent whoel file
map <F7> mzgg=G`z<CR>


" ========== Steve Losh hacks ==========="

" Don't move on *
" I'd use a function for this but Vim clobbers the last search when you're in
" a function so fuck it, practicality beats purity.
nnoremap <silent> * :let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>

" iTerm2 is currently slow as balls at rendering the nice unicode lines, so for
" now I'll just use ASCII pipes.  They're ugly but at least I won't want to kill
" myself when trying to move around a file.
set fillchars=diff:⣿,vert:│
set fillchars=diff:⣿,vert:\|

" Time out on key codes but not mappings.
" Basically this makes terminal Vim work sanely.
set notimeout
set ttimeout
set ttimeoutlen=10

" Better Completion
set complete=.,w,b,u,t
set completeopt=longest,menuone

" Diffoff
nnoremap <leader>D :diffoff!<cr>

" Resize splits when the window is resized
au VimResized * :wincmd =

" }}}
" Visual Mode */# from Scrooloose {{{

function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction

vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR><c-o>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR><c-o>

" ----------------------------------------- "
" File Type settings 			    		"
" ----------------------------------------- "

au BufNewFile,BufRead *.vim setlocal noet ts=4 sw=4 sts=4
au BufNewFile,BufRead *.txt setlocal noet ts=4 sw=4
au BufNewFile,BufRead *.md setlocal noet ts=4 sw=4

augroup filetypedetect
  au BufNewFile,BufRead .tmux.conf*,tmux.conf* setf tmux
  au BufNewFile,BufRead .nginx.conf*,nginx.conf* setf nginx
augroup END

au FileType nginx setlocal noet ts=4 sw=4 sts=4

" Go settings
au BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4

" coffeescript settings
autocmd BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab

" scala settings
autocmd BufNewFile,BufReadPost *.scala setl shiftwidth=2 expandtab

" lua settings
autocmd BufNewFile,BufRead *.lua setlocal noet ts=4 sw=4 sts=4


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
set wildignore+=go/pkg                       " Go static files
set wildignore+=go/bin                       " Go bin files
set wildignore+=go/bin-vagrant               " Go bin-vagrant files
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.orig                           " Merge resolution files

" Prettify json
" comes with yajl, install: brew install yajl
" I don't use pythons json tool because it sorts the keys
com! JSONFormat %!json_reformat


" ----------------------------------------- "
" Plugin configs 			    			"
" ----------------------------------------- "

" ==================== CtrlP ====================
let g:ctrlp_cmd = 'CtrlPMRU'
let g:ctrlp_match_func  = {'match' : 'matcher#cmatch'}
"  let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}
" let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_max_height = 10		" maxiumum height of match window
let g:ctrlp_switch_buffer = 'et'	" jump to a file if it's open already
let g:ctrlp_mruf_max=450 		" number of recently opened files
let g:ctrlp_max_files=0  		" do not limit the number of searchable files
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'

let g:ctrlp_buftag_types = {
      \ 'go'     	   : '--language-force=go --golang-types=ftv',
      \ 'coffee'     : '--language-force=coffee --coffee-types=cmfvf',
      \ 'markdown'   : '--language-force=markdown --markdown-types=hik',
      \ 'objc'       : '--language-force=objc --objc-types=mpci',
      \ 'rc'         : '--language-force=rust --rust-types=fTm'
      \ }

func! MyCtrlPTag()
  let g:ctrlp_prompt_mappings = {
        \ 'AcceptSelection("e")': ['<cr>', '<2-LeftMouse>'],
        \ 'AcceptSelection("t")': ['<c-t>'],
        \ }
  CtrlPBufTag
endfunc
command! MyCtrlPTag call MyCtrlPTag()

nmap <C-f> :CtrlPCurWD<cr>
imap <C-f> <esc>:CtrlPCurWD<cr>

nmap <C-b> :CtrlPBuffer<cr>
imap <C-b> <esc>:CtrlPBuffer<cr>


" ==================== YouCompleteMe ====================
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_min_num_of_chars_for_completion = 1

" ==================== Fugitive ====================
nnoremap <leader>ga :Git add %:p<CR><CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gp :Gpush<CR>
vnoremap <leader>gb :Gblame<CR>

" ==================== CommandT ====================
let g:CommandTMaxHeight = 20
let g:CommandTMaxFiles = 500000
let g:CommandTMatchWindowReverse = 1
let g:CommandTMaxCachedDirectories = 0
let g:CommandTHighlightColor = 'Typedef'

nmap <C-t> :CommandT /Users/fatih/Code/koding<cr>
imap <C-t> <esc>:CommandT /Users/fatih/Code/koding<cr>

" ==================== Vim-go ====================
let g:go_fmt_fail_silently = 0
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1

let g:go_highlight_space_tab_error = 0
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_extra_types = 0
let g:go_highlight_operators = 0

au FileType go nmap <Leader>s <Plug>(go-def-split)
au FileType go nmap <Leader>v <Plug>(go-def-vertical)
au FileType go nmap <Leader>in <Plug>(go-info)
au FileType go nmap <Leader>ii <Plug>(go-implements)

au FileType go nmap <leader>r  <Plug>(go-run)
au FileType go nmap <leader>b  <Plug>(go-build)
au FileType go nmap <leader>g  <Plug>(go-gbbuild)
au FileType go nmap <leader>t  <Plug>(go-test-compile)
au FileType go nmap <Leader>d <Plug>(go-doc)
au FileType go nmap <Leader>f :GoImports<CR>

" ==================== Vim-json ====================
let g:vim_json_syntax_conceal = 0

" ==================== UltiSnips ====================

function! g:UltiSnips_Complete()
  call UltiSnips#ExpandSnippet()
  if g:ulti_expand_res == 0
    if pumvisible()
      return "\<C-n>"
    else
      call UltiSnips#JumpForwards()
      if g:ulti_jump_forwards_res == 0
        return "\<TAB>"
      endif
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

au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"

" ==================== NerdTree ====================
" Open nerdtree in current dir, write our own custom function because
" NerdTreeToggle just sucks and doesn't work for buffers
function! g:NerdTreeFindToggle()
  if nerdtree#isTreeOpen()
    exec 'NERDTreeClose'
  else
    exec 'NERDTree'
  endif
endfunction

" For toggling
noremap <Leader>n :<C-u>call g:NerdTreeFindToggle()<cr>

" vim:ts=2:sw=2:et
