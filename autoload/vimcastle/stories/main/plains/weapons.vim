function! vimcastle#stories#main#plains#weapons#get() abort
	let repo = vimcastle#repository#create()
	call repo.add(1, s:sword())
	call repo.add(1, s:woodaxe())
	return repo
endfunction

function! s:sword() abort
	return vimcastle#equippablegen#weapon('Short Sword', 2, 5)
				\.noprefix(10)
				\.prefix(6, 'Rusted', 'dmg', -1, 0)
				\.prefix(4, 'Shiny', 'dmg', 2, 1)
				\.prefix(1, 'Broken', 'dmg', -1, -3)
				\.nosuffix(10)
				\.suffix(1, 'of Strength', 'str', 1)
endfunction

function! s:woodaxe() abort
	return vimcastle#equippablegen#weapon('Wood Axe', 2, 5)
				\.noprefix(10)
				\.prefix(6, 'Rusted', 'dmg', -1, 0)
				\.prefix(4, 'Sharp', 'dmg', 2, 1)
				\.prefix(1, 'Broken', 'dmg', -1, -3)
				\.nosuffix(10)
				\.suffix(1, 'of Defense', 'def', 1)
endfunction
