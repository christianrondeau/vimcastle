function! vimcastle#stories#main#plains#monsters#get() abort
	let repo = vimcastle#repository#create()
	call repo.add('rat', 10, function('s:rat'))
	call repo.add('ogre', 2, function('s:ogre'))
	return repo
endfunction

function! s:rat()
	return vimcastle#character#create('Rat', 'Rat', 8, vimcastle#weapon#create('claw', 1, 2))
endfunction

function! s:ogre()
	return vimcastle#character#create('Ogre', 'Ogre', 50, vimcastle#weapon#create('club', 2, 4))
endfunction
