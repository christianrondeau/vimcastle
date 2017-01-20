function! vimcastle#stories#main#plains#load(scene) abort
	let a:scene.label = 'Plains'
	let a:scene.enter = s:event_enter()
	call a:scene.events.add(20, s:event_nothing())
	call a:scene.events.add(20, s:event_encounter())
	call a:scene.events.add(4, s:event_heal())
	call a:scene.events.add(2, s:event_forestentrance())
endfunction

function! s:event_enter() abort
	return vimcastle#event#create('enter')
				\.text('The sun is shining, and the plains are crawling with monsters. A perfect day to go outside!')
				\.explore('Start walking forward')
endfunction

function! s:event_nothing()
	return vimcastle#event#create('nothing')
				\.text(['You wander aimlessly...', 'You walk around...', 'You see... nothing.', 'Nope. Nothing.'])
				\.explore('Continue')
endfunction

function! s:event_heal()
	return vimcastle#event#create('heal')
				\.text(['You see a pond of fresh water. You drink for it and feel refreshed.', 'You see an abandoned house. You rest in it for a little bit.',  'You see a camp, and decide to rest for a few minutes.'])
				\.effect(function('s:effect_heal'))
				\.explore('Continue')
endfunction

function! s:effect_heal(state)
	let a:state.player.health.current = a:state.player.health.max
endfunction

function! s:event_encounter()
	return vimcastle#event#create('encounter')
				\.text(['You encounter %<enemy.name>!', 'Oh no! %<enemy.name> stands before you, ready to attack!', '%<enemy.name> suddenly jumps from behind a tree!'])
				\.fight('Fight!', vimcastle#stories#main#plains#monsters#get())
endfunction

function! s:event_forestentrance()
	return vimcastle#event#create('forestentrance')
				\.text('You face a dense forest. you see movement in the dark.')
				\.enterscene('Enter the forest', 'forest')
				\.explore('Avoid the forest for now')
endfunction
