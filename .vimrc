" File              : .vimrc
" Author            : sinhnn <sinhnn.92@gmail.com>
" Date              : 06.01.2018
" Last Modified Date: 11.09.2018
" Last Modified By  : sinhnn <sinhnn.92@gmail.com>
call plug#begin('~/.vim/plugged')
" Ultility
Plug 'airblade/vim-gitgutter'
Plug 'https://github.com/tmhedberg/matchit'
Plug 'https://github.com/ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', {'do': './install --all'}
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'https://github.com/tpope/vim-repeat'
Plug 'https://github.com/vim-scripts/visualrepeat'
" Plug 'majutsushi/tagbar'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'https://github.com/scrooloose/nerdtree'

" Coding style
Plug 'Yggdroot/indentLine'
Plug 'https://github.com/alpertuna/vim-header'
Plug 'vim-scripts/DoxygenToolkit.vim'
Plug 'junegunn/vim-easy-align'

" Color
Plug 'https://github.com/endel/vim-github-colorscheme'
Plug 'altercation/vim-colors-solarized'
Plug 'https://github.com/dracula/vim'
Plug 'https://github.com/jeffkreeftmeijer/vim-dim'
Plug 'https://github.com/Erichain/vim-monokai-pro.git'

call plug#end()
" -------------------- Common -------------------------------------------
let g:author="sinhnn"
let g:mail="sinhnn.92@gmail.com"

set t_Co=256
set background=dark
syntax enable
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
set laststatus=2
set errorformat=%f:%l:%m  "compatible with `grep -n`
set number
" UTF-8 (Vietnamese)
set enc=utf-8
set fileencodings=utf-8
set fileformats=unix,dos,mac
highlight StatusLine cterm=bold ctermfg=white ctermbg=blue

map <S-Insert> <MiddleMouse>
inoremap <S-Insert> <MiddleMouse>
cmap <S-Insert> <MiddleMouse>

let mapleader = ','
map <leader>gf :e <cfile><cr>

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

let g:ctrlp_cmd = 'CtrlP'

let g:ackprg = 'ag --vimgrep'

let g:easy_align_delimiters = {
	\ ':': { 'pattern': ':', 'left_margin': 1, 'right_margin': 1, 'stick_to_left': 0 },
	\ ')': {'pattern': ')', 'left_margin': 1, 'right_margin': 0, 'stick_to_left': 0 },
	\ '(': { 'pattern': '(', 'left_margin': 1, 'right_margin': 1, 'stick_to_left': 0 },
	\ }

let g:header_field_author = g:author
let g:header_field_author_email = g:mail

let g:fzf_history_dir = '~/.local/share/fzf-history'
set rtp+=~/.fzf
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-j> <plug>(fzf-complete-file)
imap <c-x><c-l> <plug>(fzf-complete-line)

map <c-n> : NERDTreeToggle<cr>
command! -nargs=1 ShowOnlyFileType exec "NERDTreeShowOnlyFileType " . <f-args>
command! ShowOnlyC NERDTreeShowOnlyFileType c\|h\|cpp\|hpp
command! ShowOnlyPy NERDTreeShowOnlyFileType py

command! -nargs=1 NERDTreeShowOnlyFileType exec
	\"let NERDTreeIgnore =  ['\\(\\." . <f-args> . "\\\)\\@<!$[[file]]'] \| NERDTree"
command! NERDTreeShowOnlyC NERDTreeShowOnlyFileType c\|h\|cpp\|hpp

command! CloseHiddenBuffers call s:CloseHiddenBuffers()
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
