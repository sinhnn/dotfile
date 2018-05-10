" File              : .vimrc
" Author            : sinhnn <sinhnn.92@gmail.com>
" Date              : 06.01.2018
" Last Modified Date: 10.02.2018
" Last Modified By  : sinhnn <sinhnn.92@gmail.com>
call plug#begin('~/.vim/plugged')
" Ultility
Plug 'https://github.com/vim-scripts/let-modeline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'https://github.com/tmhedberg/matchit'
Plug 'junegunn/fzf', {'do': './install --all'}
Plug 'junegunn/fzf.vim'
if has('nvim')
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
endif
Plug 'mileszs/ack.vim'
Plug 'https://github.com/ntpeters/vim-better-whitespace'
Plug 'https://github.com/tpope/vim-vinegar'
Plug 'https://github.com/tpope/vim-repeat'
Plug 'https://github.com/vim-scripts/visualrepeat'
" Color
Plug 'https://github.com/endel/vim-github-colorscheme'
Plug 'altercation/vim-colors-solarized'
Plug 'https://github.com/dracula/vim'
Plug 'https://github.com/jeffkreeftmeijer/vim-dim'
" Common programming langugages
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/DoxygenToolkit.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-surround'
Plug 'Yggdroot/indentLine'
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdcommenter'
Plug 'https://github.com/scrooloose/nerdtree'
Plug 'https://github.com/vim-scripts/vim-nerdtree_plugin_open'
"Plug 'https://github.com/JamshedVesuna/vim-markdown-preview'
" C/C++
" HDL
Plug 'Kocha/vim-systemc'
Plug 'nachumk/systemverilog.vim'
"
"Plug 'https://github.com/matze/vim-tex-fold'
"
call plug#end()
" -------------------- Common -------------------------------------------
set t_Co=256
set background=dark
let g:solarized_termcolors=256
let g:solarized_termtrans=1
syntax enable

if has('nvim')
    let g:deoplete#enable_at_startup = 1
endif
colorscheme solarized
if has('gui_running')
	set guifont=Noto\ Mono\ 9
	set number
	map <S-Insert> <MiddleMouse>
	inoremap <S-Insert> <MiddleMouse>
	cmap <S-Insert> <MiddleMouse>
	let $PATH .= ':/home/sinhnn/.bin/'
endif

set wildmenu
set wildmode=list:longest,full,full
set completeopt+=menu,preview
set shiftwidth=4
set tabstop=4
set incsearch
set hlsearch
set undolevels=100
set history=100
set showmatch
set showfulltag
set textwidth=79
set colorcolumn=+1
set modeline
set visualbell
"set laststatus=2
"set errorformat=%f:%l:%m  " errorformat work with `grep -n` well
autocmd VimLeave * mksession! ~/.last_session.vim
let mapleader = ','
map <leader>gf :e <cfile><cr>

command! CloseHiddenBuffers call s:CloseHiddenBuffers()

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
map <c-u> :Snippets<cr>
map <c-n> : NERDTreeToggle<cr>
imap <c-u> <ESC>:Snippets<cr>

let g:nerdtree_plugin_open_cmd = 'xdg-open'
let g:ctrlp_cmd = 'CtrlP'
" Plug 'mileszs/ack.vim'
let g:ackprg = 'ag --vimgrep'
let g:author="sinhnn"
let g:mail="sinhnn.92@gmail.com"
" --- Plug 'junegunn/vim-easy-align'  ------------------------------------------
let g:easy_align_delimiters = {
	\ ':': { 'pattern': ':', 'left_margin': 1, 'right_margin': 1, 'stick_to_left': 0 },
	\ ')': {'pattern': ')', 'left_margin': 1, 'right_margin': 0, 'stick_to_left': 0 },
	\ '(': { 'pattern': '(', 'left_margin': 1, 'right_margin': 1, 'stick_to_left': 0 },
	\ }
" --- Plug 'junegunn/fzf.vim'  -------------------------------------------------
let g:fzf_history_dir = '~/.local/share/fzf-history'
set rtp+=~/.fzf
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
" Load my scripts  -------------------------------------------------------------
let g:tex_flavor = "latex"
au FileType {tex,latex} let g:indentLine_conceallevel=0
au BufWritePost *.{cpp,h,hpp} source ~/.vim/svim/systemc.vim
source ~/.vim/svim/code_style.vim
au FileType {vhdl,vhd} source ~/.vim/svim/hdl.vim
au FileType {haskell} set expandtab
" --- Plug 'SirVer/ultisnips'  -------------------------------------------------
let g:snips_author=g:author
" --- Plug 'vim-scripts/DoxygenToolkit.vim'  -----------------------------------
let g:DoxygenToolkit_authorName=g:author
if (expand('%:e') =='vhd')
	let g:DoxygenToolkit_startCommentTag="-- "
	let g:DoxygenToolkit_interCommentTag="-- "
	let g:DoxygenToolkit_endCommentTag="-- "
	let g:DoxygenToolkit_startCommentBlock = "-- "
	let g:DoxygenToolkit_endCommentBlock = "-- "
	let g:DoxygenToolkit_interCommentBlock = "-- "
endif

"command! -nargs=1 NERDTreeOnlyFileType :let NERDTreeIgnore += ['\(\.<f-args>\)\@<!$[[file]]']
command! -nargs=1 NERDTreeShowOnlyFileType exec
			\"let NERDTreeIgnore =  ['\\(\\." . <f-args> . "\\\)\\@<!$[[file]]'] \| NERDTree"

command! NERDTreeShowOnlyC NERDTreeShowOnlyFileType c\|h\|cpp\|hpp
" fun! NERDTreeOnlyFileType(ext)
" 	:let NERDTreeIgnore += ['\(\.ext\)\@<!$[[file]]']
" 	:NERDTree
" endf

function! s:CloseHiddenBuffers()
  let open_buffers = []

  for i in range(tabpagenr('$'))
    call extend(open_buffers, tabpagebuflist(i + 1))
  endfor

  for num in range(1, bufnr("$") + 1)
    if buflisted(num) && index(open_buffers, num) == -1
      exec "bdelete ".num
    endif
  endfor
endfunction
