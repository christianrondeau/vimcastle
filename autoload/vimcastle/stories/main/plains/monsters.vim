function! vimcastle#stories#main#plains#monsters#get() abort
	let repo = vimcastle#repository#create()
	call repo.add(10, s:monster_rat())
	call repo.add(2, s:monster_ogre())
	return repo
endfunction

function! s:monster_rat()
	return vimcastle#monstergen#create('Rat', 'Rat', 8)
				\.modifier(3, 'Sm.', 'Small', -3)
				\.modifier(5, 'Ord.', 'Ordinary', -3)
				\.modifier(2, 'Big', 'Big', 1)
				\.weapon(vimcastle#equippablegen#weapon('Claw', 'Claw', 1, 2))
endfunction

function! s:monster_ogre()
	return vimcastle#monstergen#create('Ogre', 'Ogre', 50)
				\.weapon(vimcastle#equippablegen#weapon('Club', 'Club', 2, 4))
endfunction
