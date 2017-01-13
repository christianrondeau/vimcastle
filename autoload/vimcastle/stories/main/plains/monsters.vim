function! vimcastle#stories#main#plains#monsters#get() abort
	let repo = vimcastle#repository#create()
	call repo.add(10, s:monster_rat())
	call repo.add(2, s:monster_ogre())
	return repo
endfunction

function! s:monster_rat()
	return vimcastle#monster#create('Rat', 'Rat', 8).weapon(vimcastle#weapon#short('Claw', 1, 2))
endfunction

function! s:monster_ogre()
	return vimcastle#monster#create('Ogre', 'Ogre', 50).weapon(vimcastle#weapon#short('Club', 2, 4))
endfunction
