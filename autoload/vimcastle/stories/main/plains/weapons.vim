function! vimcastle#stories#main#plains#weapons#get() abort
	let repo = vimcastle#repository#create()
	call repo.add('sword', 1, function('s:sword'))
	return repo
endfunction

function! s:sword()
	return vimcastle#weapon#create('rust. short sword', 2, 5)
endfunction
