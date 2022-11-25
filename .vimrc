" File              : /home/sinhnn/.vimrc
" Author            : sinhnn <sinhnn.92@gmail.com>
" Date              : 06.01.2018
" Last Modified Date: 08.10.2018
" Last Modified By  : sinhnn <sinhnn.92@gmail.com>
call plug#begin('~/.vim/plugged')
" Ultility
" Plug 'airblade/vim-gitgutter'
Plug 'https://github.com/tmhedberg/matchit'
Plug 'https://github.com/ctrlpvim/ctrlp.vim'
" Plug 'https://github.com/junegunn/fzf', {'do': './install --all'}
Plug 'mileszs/ack.vim'
Plug 'https://github.com/tpope/vim-repeat'
Plug 'https://github.com/vim-scripts/visualrepeat'

" Python
" Plug 'tmhedberg/SimpylFold'
" Plug 'vim-syntastic/syntastic'
" Plug 'neoclide/coc-snippets'


"Plug 'https://github.com/vim-scripts/let-modeline.vim'
Plug 'https://github.com/majutsushi/tagbar'
Plug 'https://github.com/SirVer/ultisnips'
Plug 'https://github.com/honza/vim-snippets'
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/scrooloose/nerdcommenter'
Plug 'https://github.com/scrooloose/nerdtree'
Plug 'https://github.com/jiangmiao/auto-pairs'

" Coding style
Plug 'https://github.com/Yggdroot/indentLine'
Plug 'https://github.com/alpertuna/vim-header'
" Plug 'vim-scripts/DoxygenToolkit.vim'
Plug 'https://github.com/junegunn/vim-easy-align'
Plug 'https://github.com/bitc/vim-bad-whitespace'

" Color
Plug 'https://github.com/tomasiser/vim-code-dark'

call plug#end()
" -------------------- Common -------------------------------------------
let g:author="sinhnn"
let g:mail="sinhnn.92@gmail.com"
let g:snips_author=g:author

set t_Co=256
set background=dark
syntax enable
set wildmenu
"set wildmode=list:longest,full,full
"set completeopt+=menu,preview
set shiftwidth=2
set tabstop=2
set incsearch
set hlsearch
"set undolevels=100
"set history=100
"set showmatch
set showfulltag
set textwidth=79
set colorcolumn=+1
set modeline
" Disable beep and flash
set noeb vb t_vb=
set laststatus=2
set errorformat=%f:%l:%m  "compatible with `grep -n`
set number
" UTF-8 (Vietnamese)
" set enc=utf-8
" set fileencodings=utf-8
" set fileformats=unix
highlight StatusLine cterm=bold ctermfg=white ctermbg=blue

"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
set foldmethod=indent
set foldlevel=99
let g:UltiSnipsEditSplit="vertical"

command! Cwd cd %:p:h
"let g:syntastic_python_checkers = ['pyflakes']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


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
let g:header_auto_add_header = 0

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

function! FillLine( str )
    " set tw to the desired total length
    let tw = &textwidth
    if tw==0 | let tw = 80 | endif
    " strip trailing spaces first
    .s/[[:space:]]*$//
    " calculate total number of 'str's to insert
    let reps = (tw - col("$")) / len(a:str)
    if reps > 0
        .s/$/\=(' '.repeat(a:str, reps))/
    endif
	return ''
endfunction
command! -nargs=1 FilleLine call FillLine(<f-args>)

" :source $HOME/.vim/svim/addArgs.vim
