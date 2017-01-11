function! vimcastle#stories#main#forest#load(scene) abort
	let a:scene.label = 'Forest'
	let a:scene.enter = s:event_enter()
	call a:scene.events.add('encounter', 1, s:event_encounter())
endfunction

function! s:event_enter() abort
	return vimcastle#event#create('enter')
				\.text('You enter the forest, and prepare for the worst')
				\.explore('Go deeper in the forest')
endfunction

function! s:event_encounter()
	return vimcastle#event#create('encounter')
				\.text('You encounter %e!')
				\.fight('Fight!', s:getmonsters())
endfunction

function! s:getmonsters() abort
	let repo = vimcastle#repository#create()
	call repo.add('wolf', 10, function('s:monster_wolf'))
	call repo.add('foresttroll', 2, function('s:monster_foresttroll'))
	return repo
endfunction

function! s:monster_wolf()
	return vimcastle#character#create('Wolf', 'Wolf', 8, vimcastle#weapon#create('claw', 5, 10))
endfunction

function! s:monster_foresttroll()
	return vimcastle#character#create('Forest Troll', 'F. Troll', 50, vimcastle#weapon#create('fists', 20, 50))
endfunction
