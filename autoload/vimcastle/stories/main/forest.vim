function! vimcastle#stories#main#forest#load(scene) abort
	let a:scene.label = 'Forest'
	let a:scene.enter = s:event_enter()
	call a:scene.events.add(1, s:event_encounter())
endfunction

function! s:event_enter() abort
	return vimcastle#event#create('enter')
				\.text('You enter the forest, and prepare for the worst')
				\.explore('Go deeper in the forest')
endfunction

function! s:event_encounter()
	return vimcastle#event#create('encounter')
				\.text('You hear a sound from behind a tree, and you see %e!')
				\.text('Out of a hole, mumps %e!')
				\.fight('Fight!', s:getmonsters())
endfunction

function! s:getmonsters() abort
	let repo = vimcastle#repository#create()
	call repo.add(10, s:monster_wolf())
	call repo.add(2, s:monster_foresttroll())
	return repo
endfunction

function! s:monster_wolf()
	return vimcastle#monstergen#create('Wolf', 'Wolf', 8).weapon(vimcastle#equippablegen#weapon('Paw', 'Paw', 5, 10))
endfunction

function! s:monster_foresttroll()
	return vimcastle#monstergen#create('Forest Troll', 'F. Troll', 50).weapon(vimcastle#equippablegen#weapon('Fists', 'Fists', 20, 50))
endfunction
