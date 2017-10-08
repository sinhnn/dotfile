" SYSTEMC  -------------------------------------------------------------------------
if exists("b:loaded_systemc")
	finish
endif

let s:is_systemc = Check_SystemC()
if s:is_systemc == "systemc" 
	let b:loaded_systemc=1
	iabb bit sc_bit
	iabb lg sc_logic
	iabb lv sc_lv
	iabb uint sc_uint
	iabb sen sensitive <<

	UltiSnipsAddFiletypes systemc
endif

