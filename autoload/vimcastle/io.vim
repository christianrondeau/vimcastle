let s:originalfolder =  '~/.vimcastle'
let s:folder = s:originalfolder
let s:savefile = 'save.dat'
let s:configfile = 'config.vim'
let s:enabled = 0

function! vimcastle#io#setup() abort
	let homedir = s:homedir()
	try
		if(!isdirectory(homedir))
			call mkdir(homedir, '')
		endif
		let s:enabled = 1
	catch
		echom 'Cannot access "' . homedir . '": ' . v:exception
		let s:enabled = 0
	endtry
	return s:enabled
endfunction

function! vimcastle#io#path(fname) abort
	return s:homedir() . '/' . a:fname
endfunction

function! s:homedir() abort
	return expand(s:folder)
endfunction

function! vimcastle#io#config() abort
	let configfile = vimcastle#io#path(s:configfile)
	if(filereadable(configfile))
		execute 'source ' . configfile
	endif
endfunction

function! vimcastle#io#hassave() abort
	if(!s:enabled)
		return 0
	endif

	return filereadable(vimcastle#io#path(s:savefile))
endfunction

function! vimcastle#io#clearsave() abort
	if(!s:enabled)
		return 0
	endif

  if(vimcastle#io#hassave())
		return delete(vimcastle#io#path(s:savefile))
  endif
endfunction

function! vimcastle#io#save(data) abort
	if(!s:enabled)
		return 0
	endif

	call writefile([string(a:data)], vimcastle#io#path(s:savefile))
endfunction

function! vimcastle#io#load() abort
	if(!s:enabled)
		throw 'io is disabled'
	endif

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
