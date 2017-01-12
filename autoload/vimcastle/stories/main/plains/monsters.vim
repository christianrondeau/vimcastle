function! vimcastle#stories#main#plains#monsters#get() abort
	let repo = vimcastle#repository#create()
	call repo.add(10, function('s:monster_rat'))
	call repo.add(2, function('s:monster_ogre'))
	return repo
endfunction

function! s:monster_rat()
	return vimcastle#character#create('Rat', 'Rat', 8, vimcastle#weapon#create('claw', 1, 2))
endfunction

function! s:monster_ogre()
	return vimcastle#character#create('Ogre', 'Ogre', 50, vimcastle#weapon#create('club', 2, 4))
endfunction
