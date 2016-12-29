function! s:initmappings() abort
	for c in range(char2nr('0'), char2nr('9')) + range(char2nr('a'), char2nr('z'))
		let char = nr2char(c)
		execute "nnoremap <buffer> " . char . " :call vimcastle#action('" . char . "')<CR>"
	endfor
endfunction

function! vimcastle#action(key) abort
	call vimcastle#state#action(a:key)
	call vimcastle#ui#draw(vimcastle#state#get())
endfunction

function! vimcastle#start() abort
	call vimcastle#state#init()
	call vimcastle#ui#init()
	call s:initmappings()
	call vimcastle#ui#draw(vimcastle#state#get())
endfunction
