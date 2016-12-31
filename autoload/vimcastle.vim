function! s:initmappings() abort
	let keys = 
				\ range(char2nr('0'), char2nr('9')) +
				\ range(char2nr('a'), char2nr('z')) +
				\ range(char2nr('A'), char2nr('Z'))
	for key in keys
		let key = nr2char(key)
		execute "nnoremap <silent> <buffer> " . key . " :call vimcastle#action('" . key . "')<CR>"
	endfor

	nnoremap <silent> <buffer> <CR> :call vimcastle#action('CR')<CR>
	nnoremap <silent> <buffer> <ESC> :call vimcastle#action('ESC')<CR>
	nnoremap <silent> <buffer> <TAB> :call vimcastle#action('TAB')<CR>

	nnoremap <silent> <buffer> <LeftMouse> <NOP>
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

function! vimcastle#enter(name) abort
	call vimcastle#state#enter(a:name)
	call vimcastle#ui#draw(vimcastle#state#get())
endfunction

function! vimcastle#quit() abort
		call vimcastle#state#clear()
		call vimcastle#ui#quit()
endfunction
