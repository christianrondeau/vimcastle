function! vimcastle#stories#main#plains#weapons#register(weapons) abort
	let a:weapons.sword = function('s:sword')
endfunction

function! s:sword()
	return vimcastle#weapon#create('rust. short sword', 2, 5)
endfunction
