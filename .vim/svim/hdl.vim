if exists("b:loaded_hdl")
	finish
endif
let b:loaded_hdl=1

" VHDL  ------------------------------------------------------------------------
function! HDL()
    setlocal comments=:--
	set expandtab
	" ---- Plug 'suoto/vim-hdl'  ---------------------------------------------------
	let g:vimhdl_conf_file = './msim.prj'
	let g:syntastic_vhdl_compiler = 'vcom'
	let g:syntastic_verilog_compiler = 'vlog'
	let g:syntastic_vhdl_checkers = ['vimhdl']
	let g:syntastic_verilog_checkers = ['vimhdl']

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
	" --------------------------------------------------------------------------
	"Dictionary
	iabb cn =>
	iabb veq :=
	iabb seq <=
	iabb con constant
	iabb si signal
	iabb un unsigned
	iabb sig signed 
	iabb slv std_logic_vector
	iabb lv logic_vector
	iabb int integer
	iabb gen generic
	iabb dt downto
	iabb va variable
	iabb ar array
	iabb ty type
	iabb comp component
	iabb ot0 others => '0'
	iabb tou to_unsigned
	iabb toi to_integer
endfunction
call HDL()
