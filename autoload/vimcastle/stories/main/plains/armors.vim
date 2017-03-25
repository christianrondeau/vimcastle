function! vimcastle#stories#main#plains#armors#get() abort
	let repo = vimcastle#repository#create()
	call repo.add(1, s:robe())
	call repo.add(1, s:apprenticegear())
	return repo
endfunction

function! s:robe() abort
	return vimcastle#equippablegen#armor('Robe', 2)
				\.noprefix(10)
				\.prefix(2, 'Torn', 'def', -1)
				\.prefix(2, 'Clean', 'def', 1)
				\.prefix(1, 'Light', 'spd', 2)
endfunction

function! s:apprenticegear() abort
	return vimcastle#equippablegen#armor('Apprentice Gear', 3)
				\.noprefix(10)
				\.prefix(2, 'Used', 'def', -1)
				\.prefix(2, 'New', 'def', 1)
endfunction

