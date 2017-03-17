let s:originalfolder =  '~/.vimcastle'
let s:folder = s:originalfolder

function! vimcastle#io#setup() abort
	let homedir = s:homedir()
	try
		if(!isdirectory(homedir))
			call mkdir(homedir, '')
		endif
		return 1
	catch
		echom 'Cannot access "' . homedir . '": ' . v:exception
		return 0
	endtry
endfunction

function! vimcastle#io#path(fname) abort
	return s:homedir() . '/' . a:fname
endfunction

function! s:homedir() abort
	return expand(s:folder)
endfunction

function! vimcastle#io#save(gamedata) abort
	let data = {}
	execute 'let data = ' . a:datastr
endfunction

function! vimcastle#io#load() abort
	return string(data)
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
