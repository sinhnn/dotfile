" File              : /home/sinhnn/.vim/svim/systemc.vim
" Author            : sinhnn <sinhnn.92@gmail.com>
" Date              : 06.01.2018
" Last Modified Date: 06.01.2018
" Last Modified By  : sinhnn <sinhnn.92@gmail.com>
" SYSTEMC  -------------------------------------------------------------------------
if exists("b:loaded_systemc")
	finish
endif

let s:is_systemc = Check_SystemC()
if s:is_systemc == "systemc"
	let b:loaded_systemc=1
	UltiSnipsAddFiletypes systemc
endif

