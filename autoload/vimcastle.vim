let s:game = {}

function! vimcastle#start(dedicated) abort
	if(!has('patch-7.4.849'))
		throw 'Requires at least vim 7.4.849'
	endif

	if(!vimcastle#io#setup())
		echom 'WARNING: Could not initialize home folder. Your game will not be saved.'
	endif

	call callstack#init()
	try
		let s:game = vimcastle#game#create()
		call vimcastle#ui#init(a:dedicated)
		call vimcastle#mappings#init()
		call vimcastle#io#config()
		call s:game.enter('intro')
		call vimcastle#ui#draw(s:game)

		augroup Vimcastle_ui
			autocmd!
			autocmd VimResized <buffer> call vimcastle#ui#updatescreen() | call vimcastle#ui#draw(s:game)
		augroup END

		execute 'nnoremap <silent> <buffer> q :call vimcastle#quit(' . a:dedicated . ')<CR>'
		execute 'nnoremap <silent> <buffer> h :call vimcastle#help()<CR>'
	catch
		call s:handleerr(v:exception, v:throwpoint)
	endtry
endfunction

function! vimcastle#action(key) abort
	try
		if(exists('s:game') && s:game.action(a:key))
			call vimcastle#ui#draw(s:game)
		endif
	catch
		call s:handleerr(v:exception, v:throwpoint)
	endtry
endfunction

function! vimcastle#help() abort
	help vimcastle
	nnoremap <silent> <buffer> q :q<CR>
endfunction

function! vimcastle#quit(dedicated) abort
	let ok = 0
	if a:dedicated
		let ok = confirm('Quit Vim?')
	else
		let ok = confirm('Exit Vimcastle?')
	endif
	if(!ok)
		return
	endif

	let s:game = {}
	call vimcastle#ui#quit(a:dedicated)
endfunction

function! s:handleerr(exception, throwpoint) abort
	let callstack = callstack#parse(a:throwpoint)
	call vimcastle#io#savecrashlog(s:game, a:exception, callstack)
	echom 'ERR: ' . a:exception
	for line in callstack
		echom '  ' . line
	endfor
	throw 'ERR: ' . a:exception
endfunction
