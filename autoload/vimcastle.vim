function! s:initmappings() abort
	let keys = 
				\ range(char2nr('0'), char2nr('9')) +
				\ range(char2nr('a'), char2nr('z')) +
				\ range(char2nr('A'), char2nr('Z'))
	for key in keys
		let char = nr2char(key)
		execute "nnoremap <silent> <buffer> " . char . " :call vimcastle#action('" . char . "')<CR>"
	endfor
endfunction

function! vimcastle#action(key) abort
	if(vimcastle#state#action(a:key))
		call vimcastle#ui#draw(vimcastle#state#get())
	endif
endfunction

function! vimcastle#start() abort
	call vimcastle#state#init()
	call vimcastle#ui#init()
	call s:initmappings()
	call vimcastle#ui#draw(vimcastle#state#get())
endfunction
