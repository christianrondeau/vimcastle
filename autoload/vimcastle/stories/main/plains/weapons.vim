function! vimcastle#stories#main#plains#weapons#get() abort
	let repo = vimcastle#repository#create()
	call repo.add(1, s:sword())
	return repo
endfunction

function! s:sword()
	return vimcastle#equippablegen#weapon('S. Swrd', 'Short Sword', 2, 5)
				\.noprefix(10)
				\.prefix(6, 'Rust.', 'Rusted', 'dmg', -1, 0)
				\.prefix(4, 'Sh.', 'Shiny', 'dmg', 2, 1)
				\.prefix(1, 'Brk.', 'Broken', 'dmg', -1, -3)
				\.nosuffix(10)
				\.suffix(1, 'of Str.', 'of Strength', 'str', 1)
endfunction
