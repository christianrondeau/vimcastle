function! vimcastle#stories#main#village#monsters#get() abort
	let repo = vimcastle#repository#create()
	call repo.add(12, s:monster_rat())
	call repo.add(8, s:monster_drunkard())
	call repo.add(4, s:monster_thug())
	return repo
endfunction

function! s:monster_rat() abort
	return vimcastle#monstergen#create('Rat')
				\.description('A small, furry and furious creature.')
				\.health(8)
				\.level(1)
				\.xp(1)
				\.stat('spd', 3)
				\.stat('dex', 1)
				\.modifier(3, 'Small', -3)
				\.modifier(5, 'Furry', 0)
				\.modifier(2, 'Big', 6)
				\.weapon(vimcastle#equippablegen#weapon('Claw', 2, 4))
endfunction

function! s:monster_drunkard() abort
	return vimcastle#monstergen#create('Drunkard')
				\.description('This guy is clearly drunk. Has been for a very, very long time.')
				\.health(20)
				\.level(2)
				\.xp(2)
				\.stat('spd', 1)
				\.stat('dex', 0)
				\.modifier(3, 'Tall', 5)
				\.modifier(5, 'Moustachioed', 0)
				\.modifier(2, 'Fumbling', -5)
				\.weapon(vimcastle#equippablegen#weapon('Broken Bottle', 1, 8))
endfunction

function! s:monster_thug() abort
	return vimcastle#monstergen#create('Thug')
				\.description('This guy knows how to wield this knife. It''s a street fashion faux pas not to wear pants though.')
				\.health(25)
				\.level(3)
				\.xp(3)
				\.stat('spd', 1)
				\.stat('dex', 0)
				\.modifier(3, 'Crazy', 2)
				\.modifier(3, 'Puny', -5)
				\.modifier(2, 'Armed', 5)
				\.weapon(vimcastle#equippablegen#weapon('Knife', 2, 8))
endfunction

