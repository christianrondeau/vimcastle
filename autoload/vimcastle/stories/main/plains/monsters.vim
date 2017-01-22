function! vimcastle#stories#main#plains#monsters#get() abort
	let repo = vimcastle#repository#create()
	call repo.add(10, s:monster_rat())
	call repo.add(2, s:monster_ogre())
	return repo
endfunction

function! s:monster_rat() abort
	return vimcastle#monstergen#create('Rat', 'Rat')
				\.health(8)
				\.level(1)
				\.xp(1)
				\.stat('spd', 3)
				\.stat('dex', 1)
				\.modifier(3, 'Sm.', 'Small', -3)
				\.modifier(5, 'Ord.', 'Ordinary', -3)
				\.modifier(2, 'Big', 'Big', 1)
				\.weapon(vimcastle#equippablegen#weapon('Claw', 'Claw', 1, 2))
endfunction

function! s:monster_ogre() abort
	return vimcastle#monstergen#create('Ogre', 'Ogre')
				\.health(50)
				\.level(2)
				\.xp(3)
				\.stat('spd', 1)
				\.stat('dex', 0)
				\.weapon(vimcastle#equippablegen#weapon('Club', 'Club', 2, 4))
endfunction
