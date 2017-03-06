function! vimcastle#stories#main#forest#monsters#get() abort
	let repo = vimcastle#repository#create()
	call repo.add(10, s:monster_wolf())
	call repo.add(10, s:monster_bear())
	call repo.add(2, s:monster_foresttroll())
	return repo
endfunction

function! s:monster_wolf() abort
	return vimcastle#monstergen#create('Wolf', 'Wolf')
				\.health(30)
				\.level(6)
				\.xp(12)
				\.weapon(vimcastle#equippablegen#weapon('Paw', 'Paw', 8, 14))
endfunction

function! s:monster_bear() abort
	return vimcastle#monstergen#create('Bear', 'Bear')
				\.health(120)
				\.level(7)
				\.xp(26)
				\.weapon(vimcastle#equippablegen#weapon('Paw', 'Paw', 10, 28))
endfunction

function! s:monster_foresttroll() abort
	return vimcastle#monstergen#create('F. Troll', 'Forest Troll')
				\.health(100)
				\.level(8)
				\.xp(40)
				\.weapon(vimcastle#equippablegen#weapon('Fists', 'Fists', 14, 35))
endfunction
