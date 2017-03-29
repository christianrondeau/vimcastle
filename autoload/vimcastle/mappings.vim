function! vimcastle#mappings#init() abort
	nmapclear <buffer>

	let keys = 
				\ range(char2nr('0'), char2nr('9')) +
				\ range(char2nr('a'), char2nr('z')) +
				\ range(char2nr('A'), char2nr('Z'))

	for key in keys
		let key = nr2char(key)
		execute 'nnoremap <silent> <buffer> ' . key . ' :call vimcastle#action(''' . key . ''')<CR>'
	endfor

	nnoremap <buffer> j <C-e>
	nnoremap <buffer> <DOWN> <C-e>
	nnoremap <buffer> k <C-y>
	nnoremap <buffer> <UP> <C-y>

	nnoremap <silent> <buffer> <CR> :call vimcastle#action('cr')<CR>
	nnoremap <silent> <buffer> <TAB> :call vimcastle#action('tab')<CR>

	nnoremap <buffer> <LeftMouse> <NOP>
endfunction

