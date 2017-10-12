" CPP  -------------------------------------------------------------------------
if exists("b:loaded_ccpp")
	finish
endif
let b:loaded_ccpp=1

function! CCPP()
    if !filereadable("Makefile")
        if (&ft=='c')
            setlocal makeprg=gcc\ \-c\ -o\ %.o\ %\ $*
        elseif (&ft=='cpp')
            setlocal makeprg=g++\ -c\ -o\ %.o\ %\ $*
        endif
    endif
	set expandtab "Tab indent to space indent
	set cindent

	set omnifunc=ClangComplete
	set completefunc=ClangComplete
endfunction
call CCPP()

"function! SCCOM()
"	let g:syntastic_cpp_compiler="sccom"
"	let g:syntastic_cpp_compiler_options="-fPIC -c
"				\ -I/home/applications/Questasim/10.1d/questasim/include/systemc
"				\ -I/home/applications/Questasim/10.1d/questasim/include
"				\ -I/home/applications/Questasim/10.1d/questasim/include/ac_types
"				\ -DMTI_SYSTEMC"
"endfunction
