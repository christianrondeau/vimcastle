let s:game = {}

function! vimcastle#start(dedicated) abort
	if(!has('patch-7.4.849'))
		throw 'Requires at least vim 7.4.849'
	endif

	call callstack#init()
	try
		let s:game = vimcastle#game#create()
		call vimcastle#ui#init(a:dedicated)
		call vimcastle#mappings#init()
		call s:game.enter('intro')
		call vimcastle#ui#draw(s:game)

		augroup Vimcastle_ui
			autocmd!
			autocmd VimResized <buffer> call vimcastle#ui#updatescreen() | call vimcastle#ui#draw(s:game)
		augroup END

		execute 'nnoremap <silent> <buffer> q :call vimcastle#quit(' . a:dedicated . ')<CR>'
		execute 'nnoremap <silent> <buffer> h :call vimcastle#help()<CR>'
	catch
		throw callstack#rethrow(v:exception, v:throwpoint)
	endtry
endfunction

function! vimcastle#action(key) abort
	try
		if(exists('s:game') && s:game.action(a:key))
			call vimcastle#ui#draw(s:game)
		endif
	catch
		throw callstack#rethrow(v:exception, v:throwpoint)
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

