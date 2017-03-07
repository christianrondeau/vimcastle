function! vimcastle#io#setup() abort
	let homedir = s:homedir()
	if(!isdirectory(homedir))
		call mkdir(homedir, '')
	endif
endfunction

function! vimcastle#io#path(fname) abort
	return s:homedir() . '/' . a:fname
endfunction

function! s:homedir() abort
	return expand('~/.vimcastle')
endfunction
