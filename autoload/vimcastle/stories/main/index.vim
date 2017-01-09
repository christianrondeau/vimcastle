let s:_ = vimcastle#utils#get()

function! vimcastle#stories#main#index#setup(story) abort
	let a:story.weapons = {}
	call vimcastle#stories#shared#weapons(a:story:weapons)

	let a:story.begin = function('s:begin')
endfunction

function! s:begin(state) abort
	let a:state.player = vimcastle#character#create('Player', 'You', 60)
	let a:state.player.weapon = s:weapon_rustedshortsword()
	let a:state.enter('explore')
	let a:state.env = s:env_plains()
	call s:event_begin(a:state)
endfunction

function! s:event_begin(state)
	let a:state.log = ['You pack up your stuff and you are ready to go!']
	call a:state.actions.clear()
	call a:state.actions.add('c', 'Start walking forward', function('s:action_continue'))
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

function! s:event_fight(state)
	let a:state.enemy = s:_.oneof(a:state.env.enemies)()
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

function! s:env_plains()
	let env = {}
	let env.label = 'Plains'
	let env.events = [
	\  function('s:event_nothing'),
	\  function('s:event_heal'),
	\  function('s:event_fight'),
	\  function('s:event_forestentrance'),
	\]
	let env.enemies = [
	\  function('s:enemy_ogre'),
	\  function('s:enemy_rat'),
	\]
	return env
endfunction

function! s:env_forest()
	let env = {}
	let env.label = 'Forest'
	let env.events = [
	\  function('s:event_fight'),
	\]
	let env.enemies = [
	\  function('s:enemy_ogre'),
	\]
	return env
endfunction



function! s:action_continue(state)
	let result = s:_.oneof(a:state.env.events)(a:state)
endfunction

function! s:action_fight(state)
	let a:state.nextaction = function('s:action_continue')
	call a:state.enter('fight')
endfunction

function! s:action_enterforest(state)
	let a:state.env = s:env_forest()
	call s:event_fight(a:state)
endfunction

