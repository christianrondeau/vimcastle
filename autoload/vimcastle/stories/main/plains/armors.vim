function! vimcastle#stories#main#plains#armors#get() abort
	let repo = vimcastle#repository#create()
	call repo.add(1, s:robe())
	call repo.add(1, s:apprenticegear())
	return repo
endfunction

function! s:robe() abort
	return vimcastle#equippablegen#armor('Robe', 'Robe', 2)
				\.noprefix(10)
				\.prefix(2, 'Tor.', 'Torn', 'def', -1)
				\.prefix(2, 'Cl.', 'Clean', 'def', 1)
				\.prefix(1, 'L.', 'Light', 'spd', 2)
endfunction

function! s:apprenticegear() abort
	return vimcastle#equippablegen#armor('Appr. Gear', 'Apprentice Gear', 3)
				\.noprefix(10)
				\.prefix(2, 'Us.', 'Used', 'def', -1)
				\.prefix(2, 'New', 'New', 'def', 1)
endfunction
