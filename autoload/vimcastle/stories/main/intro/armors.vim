function! vimcastle#stories#main#intro#armors#get() abort
	let repo = vimcastle#repository#create()
	call repo.add(3, s:rags())
	call repo.add(1, s:travelclothes())
	return repo
endfunction

function! s:rags() abort
	return vimcastle#equippablegen#armor('Rags', 'Rags', 1)
				\.noprefix(10)
				\.prefix(2, 'Tor.', 'Torn', 'def', -1)
				\.prefix(1, 'L.', 'Light', 'spd', 2)
endfunction

function! s:travelclothes() abort
	return vimcastle#equippablegen#armor('Cloth.', 'Clothes', 3)
				\.noprefix(20)
				\.prefix(2, 'Trav.', 'Traver', 'def', 1)
				\.prefix(2, 'Cl.', 'Clean', 'def', 1)
				\.prefix(1, 'L.', 'Light', 'spd', 1)
endfunction
