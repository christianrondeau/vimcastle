function! s:initmappings() abort
	nmapclear <buffer>
	let keys = 
				\ range(char2nr('0'), char2nr('9')) +
				\ range(char2nr('a'), char2nr('z')) +
				\ range(char2nr('A'), char2nr('Z'))
	for key in keys
		let key = nr2char(key)
		execute "nnoremap <silent> <buffer> " . key . " :call vimcastle#action('" . key . "')<CR>"
	endfor

	nnoremap <silent> <buffer> <CR> :call vimcastle#action('cr')<CR>
	nnoremap <silent> <buffer> <TAB> :call vimcastle#action('tab')<CR>

	nnoremap <buffer> <LeftMouse> <NOP>
endfunction

function! vimcastle#action(key) abort
	let state = vimcastle#state#get()
	if(state.action(a:key))
		call vimcastle#ui#draw(state)
	endif
endfunction

function! vimcastle#start() abort
	let state = vimcastle#state#init()
	call vimcastle#ui#init()
	call s:initmappings()
	call vimcastle#ui#draw(state)
endfunction

function! vimcastle#quit() abort
	let state = vimcastle#state#get()
	call state.clear()
	call vimcastle#ui#quit()
endfunction
