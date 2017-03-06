function! vimcastle#stories#main#plains#monsters#get() abort
	let repo = vimcastle#repository#create()
	call repo.add(12, s:monster_rat())
	call repo.add(8, s:monster_goblin())
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
				\.modifier(2, 'Big', 'Big', 6)
				\.weapon(vimcastle#equippablegen#weapon('Claw', 'Claw', 2, 4))
endfunction

function! s:monster_goblin() abort
	return vimcastle#monstergen#create('Goblin', 'Goblin')
				\.health(20)
				\.level(2)
				\.xp(2)
				\.stat('spd', 4)
				\.stat('dex', 2)
				\.modifier(3, 'Feeb.', 'Feeble', -5)
				\.modifier(5, 'Bad', 'Bad', 0)
				\.modifier(2, 'Evil', 'Evil', 12)
				\.weapon(vimcastle#equippablegen#weapon('Claw', 'Claw', 1, 8))
endfunction

function! s:monster_ogre() abort
	return vimcastle#monstergen#create('Ogre', 'Ogre')
				\.health(40)
				\.level(3)
				\.xp(4)
				\.stat('spd', 1)
				\.stat('dex', 0)
				\.weapon(vimcastle#equippablegen#weapon('Club', 'Club', 4, 8))
endfunction
