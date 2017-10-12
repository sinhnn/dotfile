call plug#begin('~/.vim/plugged')


Plug 'https://github.com/vim-scripts/let-modeline.vim'
" Github
Plug 'airblade/vim-gitgutter'

" Colorscheme
Plug 'https://github.com/endel/vim-github-colorscheme'
Plug 'altercation/vim-colors-solarized'
Plug 'https://github.com/dim13/smyck.vim'
Plug 'google/vim-colorscheme-primary'
Plug 'https://github.com/morhetz/gruvbox'



"
Plug 'majutsushi/tagbar'
Plug 'https://github.com/tmhedberg/matchit'
Plug 'scrooloose/nerdtree'

" Code documentation
Plug 'vim-scripts/DoxygenToolkit.vim'

" 
Plug 'junegunn/fzf', {'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'mileszs/ack.vim'
Plug 'ctrlpvim/ctrlp.vim'

"Completion
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-surround'
"Plug 'https://github.com/ervandew/supertab'

"Fomat
Plug 'Yggdroot/indentLine'
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdcommenter'

" C/CPP languages
Plug 'Rip-Rip/clang_complete', {'do': 'make install'}
Plug 'rhysd/vim-clang-format'
Plug 'scrooloose/syntastic'

" GDB
Plug 'vim-scripts/Conque-GDB'

" Latex
"Plug 'https://github.com/vim-latex/vim-latex'
"Plug 'https://github.com/lervag/vimtex'

" HDL languages
Plug 'Kocha/vim-systemc'
Plug 'nachumk/systemverilog.vim'
Plug 'suoto/hdlcc'
Plug 'suoto/vim-hdl'

"
if has('nvim')
	Plug 'neomake/neomake'
	Plug 'http://git.vhdltool.com/vhdl-tool/syntastic-vhdl-tool'
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	let g:deoplete#enable_at_startup = 1
""	Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
endif
call plug#end()

" -------------------- Common -------------------------------------------
syntax enable
if has('gui_running')
	set background=light
	colorscheme github
else
	set t_Co=256
	"let g:solarized_termcolors=256
	set background=dark
	let g:solarized_contrast = "high"
	colorscheme solarized
	"hi QuickFixLine cterm=None ctermbg=256 guibg=#ffff00
	"hi Comment ctermfg=61 guifg=#80afff
	"hi! link Comment vimCommentString

endif

"if has('nvim') == 1
"	colorscheme PaperColor "default
"	set background=dark
"endif
set autoread
set showmatch
set autoindent
set incsearch
set wildmenu
"set wildmode=list:longest,full
set completeopt=menu,longest
set cmdheight=2
set undolevels=100
set history=100
set tabstop=4
set shiftwidth=4
set nofoldenable
set incsearch
set ignorecase
set smartcase
set hid
set showfulltag
set hlsearch

" ---------- Developer  --------------------------------------------------------
set textwidth=80
"set tags+=tags,tags,TAGS
set laststatus=1
set makeef=./errors.err
set errorformat=%f:%l:%m  " errorformat work with `grep -n` well
set fo+=c fo+=r fo-=o
" -----------------------------------------------------------------------------

" -------------------- Shortcuts  ----------------------------------------------
map <F3>      : NERDTreeToggle<CR>
map <F4>      : TagbarToggle<CR>
nnoremap <F5> : make<bar>cw<CR><CR><CR>
map <C-S-n>   : silent !xterm&<CR><CR>
map <C-e>     : silent cnext <CR><CR>
map <F4>      : TagbarToggle<CR>
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)
let mapleader = ','

"let g:python3_host_prog = '/usr/bin/python2'
let g:ackprg = 'ag --vimgrep'
let NERDTreeIgnore=['\~$', '^\.git', '\.swp$','\.o']

" let g:clang_library_path='/usr/lib64/llvm/'
" --- Plug 'scrooloose/syntastic'  ---------------------------------------------
"  Notes: if g:syntastic_cpp_compiler='sccom', make sure empty SYSTEMC_HOME env
"  or point to systemc in Questasim/Modelsim
let g:author="Ngoc-Sinh Nguyen"
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_config_file='.clang_complete'
let g:syntastic_sccom_config_file='.clang_complete'
let g:syntastic_c_config_file='.clang_complete'

" ------------------------------------------------------------------------------
"
" Plug 'scrooloose/nerdcommenter'  ---------------------------------------------
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
let g:NERDTrimTrailingWhitespace = 1
"  -----------------------------------------------------------------------------

" ---- Plug 'suoto/vim-hdl'  ---------------------------------------------------
let g:vimhdl_conf_file = './msim.prj'
let g:syntastic_vhdl_checkers = ['vimhdl']
" ------------------------------------------------------------------------------

" --- Plug 'junegunn/vim-easy-align'  ------------------------------------------
let g:easy_align_delimiters = {
	\ ':': { 'pattern': ':', 'left_margin': 1, 'right_margin': 1, 'stick_to_left': 0 },
	\ ')': { 'pattern': ')', 'left_margin': 1, 'right_margin': 0, 'stick_to_left': 0 },
	\ '(': { 'pattern': '(', 'left_margin': 1, 'right_margin': 1, 'stick_to_left': 0 },
	\ 'w': { 'pattern': '\>', 'left_margin': 0, 'right_margin': 1, 'stick_to_left': 0 },
	\ }

command! -range EasyAlignByWord  <line1>,<line2>EasyAlign *w
" ------------------------------------------------------------------------------

let g:tex_flavor = "latex" " All .tex is latex file

" --- Plug 'junegunn/fzf.vim'  -------------------------------------------------
let g:fzf_history_dir = '~/.local/share/fzf-history'
command! Template call fzf#vim#files('~/Templates/txt/template', <bang>0)
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
set rtp+=~/.fzf
"  -----------------------------------------------------------------------------
"
" Load my scripts  -------------------------------------------------------------
source ~/.vim/svim/code_style.vim
au FileType {tex,latex} let g:indentLine_conceallevel=0
au FileType {c,cpp} source ~/.vim/svim/ccpp.vim
au FileType {cpp} source ~/.vim/svim/systemc.vim
au BufWritePost *.{cpp,h,hpp} source ~/.vim/svim/systemc.vim
au FileType {vhdl,vhd,verilog,systemverilog} source ${HOME}/.vim/svim/hdl.vim
au FileType {tex,bib,latex} source ${HOME}/.vim/svim/tex.vim

" Quit Buffer when quit file
au BufEnter * call MyLastWindow()
function! MyLastWindow()
    if &buftype=="quickfix" || &buftype=="nofile"
        if winbufnr(2) == -1
            quit!
        endif
    endif
endfunction

" --- Plug 'SirVer/ultisnips'  -------------------------------------------------
let g:snips_author=g:author
let g:UltiSnipsListSnippets="<c-u>"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "vim-snippets"]
let g:UltiSnipsEditSplit="vertical"
" ------------------------------------------------------------------------------

" --- Plug 'vim-scripts/DoxygenToolkit.vim'  -----------------------------------
let g:DoxygenToolkit_authorName=g:author
let g:DoxygenToolkit_briefTag_pre="\\brief  "
let g:DoxygenToolkit_paramTag_pre="\\param "
let g:DoxygenToolkit_returnTag="\\returns   "
let g:DoxygenToolkit_blockHeader="--------------------------------------------------------------------------"
let g:DoxygenToolkit_blockFooter="--------------------------------------------------------------------------"
if (expand('%:e') =='vhd')
	let g:DoxygenToolkit_startCommentTag="-- "
	let g:DoxygenToolkit_interCommentTag="-- "
	let g:DoxygenToolkit_endCommentTag="-- "
	let g:DoxygenToolkit_startCommentBlock = "-- "
	let g:DoxygenToolkit_endCommentBlock = "-- "
	let g:DoxygenToolkit_interCommentBlock = "-- "
endif
"  -----------------------------------------------------------------------------

" --- Plug 'majutsushi/tagbar' ------------------------------------------------
let g:tagbar_left = 0
let g:tagbar_type_systemverilog= {
    \ 'ctagstype' : 'systemverilog',
    \ 'kinds'     : [
        \'m:modules',
        \'a:parameters',
        \'o:ports',
        \'d:defines',
        \'c:classes',
        \'t:tasks',
        \'f:functions',
        \'i:interfaces',
        \'v:variables',
        \'e:typedefs'
  \]
\}
let g:tagbar_type_vhdl = {
    \ 'ctagsbin': 'vhdl-tool',
    \ 'ctagsargs': 'ctags -o -',
    \ 'ctagstype': 'vhdl',
    \ 'kinds' : [
        \'d:prototypes',
        \'b:package bodies',
        \'e:entities',
        \'a:architectures',
        \'t:types',
        \'p:processes',
        \'f:functions',
        \'r:procedures',
        \'c:constants',
        \'T:subtypes',
        \'r:records',
        \'C:components',
        \'P:packages',
        \'l:locals',
        \'i:instantiations',
        \'s:signals',
        \'v:variables:1:0'
    \ ],
    \ 'sro' : '::',
    \ 'kind2scope' : {
         \ 'a' : 'architecture',
         \ 'b' : 'packagebody',
         \ 'P' : 'package',
         \ 'p' : 'process'
    \ },
    \ 'scope2kinds' : {
         \ 'architecture' : 'a',
         \ 'packagebody'  : 'b',
         \ 'package'      : 'P',
         \ 'process'      : 'p'
    \ }
	\}
let g:tagbar_type_systemc = {
    \ 'ctagstype': 'systemc',
    \ 'kinds' : [
        \'o:ports',
        \'c:constants',
        \'s:signals',
        \'v:variable'
    \]
\}
" ------------------------------------------------------------------------------
