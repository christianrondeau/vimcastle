let s:_ = vimcastle#utils#get()

function! vimcastle#stories#main#plains#events#register(scene) abort
	call scene.events.add('nothing', 20, function('s:event_nothing'))
	call scene.events.add('heal', 4, function('s:event_heal'))
	call scene.events.add('encounter', 10, function('s:event_encounter'))
	call scene.events.add('forestentrance', 2, function('s:event_forestentrance'))
endfunction

let s:event_nothing_logs = ['You wander aimlessly...', 'You walk around...', 'You see... nothing.', 'Nope. Nothing.']
function! s:event_nothing(state)
	let log = s:_.oneof(s:event_nothing_logs)
	let a:state.log = [log]
	call a:state.actions.clear()
	call a:state.actions.add('c', 'Continue', function('s:action_continue'))
endfunction

let s:event_heal_logs = ['You see a pond of fresh water. You drink for it and feel refreshed.', 'You see an abandoned house. You rest in it for a little bit.', 'You see a camp, and decide to rest for a few minutes.']
function! s:event_heal(state)
	let log = s:_.oneof(s:event_heal_logs)
	let a:state.log = [log, 'Your health is now full!']
	let a:state.player.health.current = a:state.player.health.max
	call a:state.actions.clear()
	call a:state.actions.add('c', 'Continue', function('s:action_continue'))
endfunction

function! s:event_encounter(state)
	let a:state.enemy = s:_.oneof(a:state.env.monsters)()
	let a:state.log = ['You wander aimlessly when you encounter <' . a:state.enemy.name.long . '>!']
	call a:state.actions.clear()
	call a:state.actions.add('f', 'Fight!', function('s:action_fight'))
endfunction

function! s:event_forestentrance(state)
	let a:state.log = ['You face a dense forest. you see movement in the dark.']
	call a:state.actions.clear()
	call a:state.actions.add('e', 'Enter the forest', function('s:action_enterforest'))
	call a:state.actions.add('c', 'Continue', function('s:action_continue'))
endfunction
