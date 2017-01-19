function! vimcastle#stories#main#plains#armors#get() abort
	let repo = vimcastle#repository#create()
	call repo.add(1, s:rags())
	return repo
endfunction

function! s:rags()
	return vimcastle#equippablegen#armor('Rags', 'Rags', 1)
				\.noprefix(10)
				\.prefix(2, 'Tor.', 'Torned', 'def', -1, -1)
				\.prefix(2, 'Cl.', 'Clean', 'def', 1, 1)
endfunction