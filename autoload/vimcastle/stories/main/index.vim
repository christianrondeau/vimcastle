function! vimcastle#stories#main#index#setup(story) abort
	let a:story.begin = function('s:begin')
endfunction

function! s:begin(state) abort
	let a:state.env = s:env_plains()
	let a:state.player = vimcastle#character#create('Player', 'You', 60)
	let a:state.enter('explore')
	call s:event_begin(a:state)
endfunction

function! s:event_begin(state)
	let a:state.log = ['You pack up your stuff and you are ready to go!']
	call a:state.actions.clear()
	call a:state.actions.add('c', 'Start walking forward', function('s:action_continue'))
endfunction

function! s:event_nothing(state)
	let a:state.log = ['You wander aimlessly...']
	call a:state.actions.clear()
	call a:state.actions.add('c', 'Continue', function('s:action_continue'))
endfunction

function! s:event_fight(state)
	let a:state.enemy = a:state.env.enemies[vimcastle#utils#rnd(len(a:state.env.enemies))]()
	let a:state.log = ['You wander aimlessly when you encounter <' . a:state.enemy.name.long . '>!']
	call a:state.actions.clear()
	call a:state.actions.add('f', 'Fight!', function('s:action_fight'))
endfunction

function! s:env_plains()
	let env = {}
	let env.label = 'Plains'
	let env.events = [
	\  function('s:event_nothing'),
	\  function('s:event_fight'),
	\]
	let env.enemies = [
	\  function('s:enemy_ogre'),
	\  function('s:enemy_rat'),
	\]
	return env
endfunction

function! s:enemy_ogre()
	return vimcastle#character#create('Ogre', 'Ogre', 50)
endfunction

function! s:enemy_rat()
	return vimcastle#character#create('Rat', 'Rat', 8)
endfunction

function! s:action_continue(state)
	call a:state.env.events[vimcastle#utils#rnd(len(a:state.env.events))](a:state)
endfunction

function! s:action_fight(state)
	let a:state.nextaction = function('s:action_continue')
	call a:state.enter('fight')
endfunction

