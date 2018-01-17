" File              : .vimrc
" Author            : sinhnn <sinhnn.92@gmail.com>
" Date              : 06.01.2018
" Last Modified Date: 06.01.2018
" Last Modified By  : sinhnn <sinhnn.92@gmail.com>
call plug#begin('~/.vim/plugged')
" Ultility
Plug 'https://github.com/vim-scripts/let-modeline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'https://github.com/tmhedberg/matchit'
Plug 'junegunn/fzf', {'do': './install --all'}
Plug 'junegunn/fzf.vim'
Plug 'https://github.com/kien/ctrlp.vim'
Plug 'mileszs/ack.vim'
Plug 'https://github.com/ntpeters/vim-better-whitespace'
Plug 'https://github.com/alpertuna/vim-header'
Plug 'https://github.com/tpope/vim-vinegar'
Plug 'https://github.com/tpope/vim-repeat'
Plug 'https://github.com/vim-scripts/visualrepeat'
" Color
Plug 'https://github.com/endel/vim-github-colorscheme'
Plug 'altercation/vim-colors-solarized'
" Common programming langugages
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/DoxygenToolkit.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-surround'
Plug 'Yggdroot/indentLine'
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/syntastic', {'do': 'pip install --user cpplint cppclean && cabal install hlint' }
" C/C++
"Plug 'Rip-Rip/clang_complete', {'do': 'make install'}
"Plug 'rhysd/vim-clang-format'
"Plug 'vim-scripts/Conque-GDB'
" HDL
Plug 'Kocha/vim-systemc'
Plug 'nachumk/systemverilog.vim'
Plug 'https://github.com/suoto/hdlcc', {'do': 'cd ../ && pip install --user ./hdlcc'}
Plug 'suoto/vim-hdl'
"Plug 'https://github.com/jwwebbopen/VHDLTools', {'do': 'dos2unix scripts/*.pl'}
"
call plug#end()
" -------------------- Common -------------------------------------------
if has('gui_running')
	set guifont=MonoSpace\ 14
	inoremap <C-v> <ESC>"+pa
	inoremap <S-Insert> <ESC>"+pa
	vnoremap <C-c> "+y
	vnoremap <C-d> "+d
	cmap <C-d> "+d
	cmap <C-d> "+y
	set t_Co=256
endif

set background=dark
colorscheme solarized
syntax enable
"set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set autoread
set autoindent
set wildmenu
set completeopt=menu,longest
set cmdheight=2
set tabstop=4
set shiftwidth=4
set nofoldenable
set incsearch
set ignorecase
set hlsearch
set smartcase
set hid
set undolevels=100
set history=100
set showmatch
set showfulltag
set textwidth=80
set laststatus=2
set errorformat=%f:%l:%m  " errorformat work with `grep -n` well
set fo+=c fo+=r fo-=o
set colorcolumn=+1
autocmd VimLeave * mksession! ~/.last_session.vim
let mapleader = ','
command! CloseHiddenBuffers call s:CloseHiddenBuffers()
let g:ctrlp_map = '<c-p>'
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

let g:ctrlp_cmd = 'CtrlP'
let g:netrw_banner = 1
let g:solarized_termcolors=256
let g:solarized_contrast = "high"

" Plug 'mileszs/ack.vim'
let g:ackprg = 'ag --vimgrep'
" --- Plug 'scrooloose/syntastic'  ---------------------------------------------
"  Notes: if g:syntastic_cpp_compiler='sccom', make sure empty SYSTEMC_HOME env
"  or point to systemc in Questasim/Modelsim
let g:author="sinhnn"
let g:mail="sinhnn.92@gmail.com"
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq   = 0
let g:syntastic_tex_checkers  = ['lacheck']
let g:syntastic_cpp_checkers  = ['gcc', 'cpplint', 'cppclean']
let g:syntastic_c_checkers    = ['gcc', 'cpplint', 'cppclean']
" --- Plug 'junegunn/vim-easy-align'  ------------------------------------------
let g:easy_align_delimiters = {
	\ ':': { 'pattern': ':', 'left_margin': 1, 'right_margin': 1, 'stick_to_left': 0 },
	\ ')': { 'pattern': ')', 'left_margin': 1, 'right_margin': 0, 'stick_to_left': 0 },
	\ '(': { 'pattern': '(', 'left_margin': 1, 'right_margin': 1, 'stick_to_left': 0 },
	\ }
" --- Plug 'junegunn/fzf.vim'  -------------------------------------------------
let g:fzf_history_dir = '~/.local/share/fzf-history'
set rtp+=~/.fzf
"nmap <leader><tab> <plug>(fzf-maps-n)
"xmap <leader><tab> <plug>(fzf-maps-x)
"omap <leader><tab> <plug>(fzf-maps-o)
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
" Load my scripts  -------------------------------------------------------------
au FileType {tex,latex} let g:indentLine_conceallevel=0
au BufWritePost *.{cpp,h,hpp} source ~/.vim/svim/systemc.vim
au FileType {vhdl,vhd} source ~/.vim/svim/hdl.vim
au FileType {haskell} set expandtab
"au FileType {tex,bib,latex} source ~/.vim/svim/tex.vim
" --- Plug 'SirVer/ultisnips'  -------------------------------------------------
let g:snips_author=g:author
let g:UltiSnipsEditSplit="vertical"
" --- Plug 'https://github.com/alpertuna/vim-header'
let g:header_auto_add_header = 0
let g:header_field_author =g:author
let g:header_field_author_email = g:mail
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
