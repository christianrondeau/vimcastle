function! vimcastle#stories#main#intro#weapons#get() abort
	let repo = vimcastle#repository#create()
	call repo.add(2, s:stick())
	call repo.add(1, s:sword())
	return repo
endfunction

function! s:stick() abort
	return vimcastle#equippablegen#weapon('Stick', 1, 2)
				\.noprefix(10)
				\.prefix(1, 'Broken', 'dmg', 0, -1)
				\.prefix(1, 'Pointy', 'dmg', 1, 1)
endfunction

function! s:sword() abort
	return vimcastle#equippablegen#weapon('Wooden Sword', 1, 3)
				\.noprefix(10)
				\.prefix(1, 'Broken', 'dmg', 0, -1)
				\.prefix(1, 'Nice', 'dmg', 1, 1)
				\.nosuffix(10)
endfunction

