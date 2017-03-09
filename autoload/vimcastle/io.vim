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

function! s:homedir() abort
	return expand(s:folder)
endfunction

" Test methods {{{

function! vimcastle#io#before(path) abort
	let s:folder = a:path
	call vimcastle#io#setup()
endfunction

function! vimcastle#io#after() abort
	let s:folder = s:originalfolder
endfunction

" }}}
