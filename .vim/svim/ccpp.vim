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

	let g:syntastic_cpp_config_file='.clang_complete'
	let g:syntastic_cpp_cpplint_exec = 'cpplint'
	
	let g:syntastic_cpplint_config_file='.clang_complete'
	let g:syntastic_cpp_cppclean_args=system("cat .clang_complete | tr '\r\n' ' '")
	let g:syntastic_cppcheck_config_file='.clang_complete'
	let g:syntastic_cpp_checkers=['gcc'] ",'cpplint', 'cppclean', 'cppcheck']
	
	let g:syntastic_c_config_file='.clang_complete'
	let g:syntastic_c_checkers=['gcc'] ", 'checkpatch', 'cpplint', 'cppclean', 'cppcheck']
	let g:syntastic_c_cppclean_args=system("cat .clang_complete | tr '\r\n' ' '")
	let g:syntastic_checkpatch_config_file='.clang_complete'


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
