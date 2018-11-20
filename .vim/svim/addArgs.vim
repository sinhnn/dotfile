" File              : /home/sinhnn/.vim/svim/addArgs.vim
" Author            : sinhnn <sinhnn.92@gmail.com>
" Date              : 08.10.2018
" Last Modified Date: 08.10.2018
" Last Modified By  : sinhnn <sinhnn.92@gmail.com>

fun! AddArgsPy(...)
	put "# import argparse"
	let s:str = "parser = argparse.ArgumentParser(description = '" . a:000[0] . "')"
	put = s:str
	for arg in a:000[1:]
		let s:str =  "parser.add_argument('--" . arg . "', help = '" . arg . "', default='', required=False)"
		put = s:str
	endfor
	return ''
endf
command! -nargs=* AddArgsPy call AddArgsPy(<f-args>)

fun! AddArgsSh(...)
	let s:cmd = "r !addArg.sh " . join(a:000)
	:exe s:cmd	
	return ''
endf
command! -nargs=* AddArgsSh call AddArgsSh(<f-args>)
