" File              : /home/sinhnn/.vim/svim/ccpp.vim
" Author            : sinhnn <sinhnn.92@gmail.com>
" Date              : 06.01.2018
" Last Modified Date: 06.01.2018
" Last Modified By  : sinhnn <sinhnn.92@gmail.com>
" CPP  -------------------------------------------------------------------------
if exists("b:loaded_ccpp")
	finish
endif
let b:loaded_ccpp=1
function! CCPP()
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
