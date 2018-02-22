" File              : hdl.vim
" Author            : sinhnn <sinhnn.92@gmail.com>
" Date              : 06.01.2018
" Last Modified Date: 06.01.2018
" Last Modified By  : sinhnn <sinhnn.92@gmail.com>
"
"Dictionary
abclear
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
iabb ot0 (others => '0')
iabb ot1 (others => '1')
iabb oot0 (others => (others => '0'))
iabb tou to_unsigned
iabb tos to_signed
iabb toi to_integer
iabb << sll
iabb >> srl
iabb slr srl


"if exists("b:loaded_hdl")
"	finish
"endif
"let b:loaded_hdl=1
" VHDL  ------------------------------------------------------------------------
setlocal comments=:--
set expandtab
" ---- Plug 'suoto/vim-hdl'  ---------------------------------------------------
let g:vimhdl_conf_file = 'msim.prj'
let g:syntastic_vhdl_compiler = 'vcom'
let g:syntastic_verilog_compiler = 'vlog'
let g:syntastic_vhdl_checkers = ['vimhdl']
let g:syntastic_verilog_checkers = ['vimhdl']
