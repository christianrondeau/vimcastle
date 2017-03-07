let s:originalfolder =  '~/.vimcastle'
let s:folder = s:originalfolder

function! vimcastle#io#setup() abort
	let homedir = s:homedir()
	if(!isdirectory(homedir))
		call mkdir(homedir, '')
	endif
endfunction

function! vimcastle#io#path(fname) abort
	return s:homedir() . '/' . a:fname
endfunction

function! vimcastle#io#setfolder(path) abort
	let s:folder = a:path
	call vimcastle#io#setup()
endfunction

function! vimcastle#io#restorefolder() abort
	let s:folder = s:originalfolder
endfunction

function! s:homedir() abort
	return expand(s:folder)
endfunction
