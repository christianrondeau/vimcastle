function! vimcastle#stories#main#plains#weapons#get() abort
	let repo = vimcastle#repository#create()
	call repo.add(1, s:sword())
	return repo
endfunction

function! s:sword()
	return vimcastle#weapongen#create('S. Swrd', 'Short Sword', 2, 5)
				\.prefix(10, 'Ord.', 'Ordinary', 0, 0)
				\.prefix(6, 'Rust.', 'Rusted', -1, 0)
				\.prefix(4, 'Sh.', 'Shiny', 2, 1)
				\.prefix(1, 'Brk.', 'Broken', -1, -3)
endfunction
