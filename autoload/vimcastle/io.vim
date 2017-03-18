let s:originalfolder =  '~/.vimcastle'
let s:folder = s:originalfolder
let s:savefile = 'save.json'

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

function! vimcastle#io#hassave() abort
	return filereadable(vimcastle#io#path(s:savefile))
endfunction

function! vimcastle#io#clearsave() abort
  if(vimcastle#io#hassave())
		return delete(vimcastle#io#path(s:savefile))
  endif
endfunction

function! vimcastle#io#save(data) abort
	call writefile([string(a:data)], vimcastle#io#path(s:savefile))
endfunction

function! vimcastle#io#load() abort
	let str = readfile(vimcastle#io#path(s:savefile))
	let data = {}
	execute 'let data = ' . str[0]
	return data
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
