function! vimcastle#stories#main#village#monsters#get() abort
	let repo = vimcastle#repository#create()
	call repo.add(12, s:monster_rat())
	call repo.add(8, s:monster_goblin())
	return repo
endfunction

function! s:monster_rat() abort
	return vimcastle#monstergen#create('Rat')
				\.description('A small furry and furious creature.')
				\.health(8)
				\.level(1)
				\.xp(1)
				\.stat('spd', 3)
				\.stat('dex', 1)
				\.modifier(3, 'Small', -3)
				\.modifier(5, 'Ordinary', -3)
				\.modifier(2, 'Big', 6)
				\.weapon(vimcastle#equippablegen#weapon('Claw', 2, 4))
endfunction

function! s:monster_goblin() abort
	return vimcastle#monstergen#create('Drunkard')
				\.description('This guy is clearly drunk. And has been for a very, very long time.')
				\.health(20)
				\.level(2)
				\.xp(2)
				\.stat('spd', 1)
				\.stat('dex', 0)
				\.modifier(3, 'Tall', -5)
				\.modifier(5, 'Moustachioed', 0)
				\.modifier(2, 'Fumbling', -5)
				\.weapon(vimcastle#equippablegen#weapon('Claw', 1, 8))
endfunction

