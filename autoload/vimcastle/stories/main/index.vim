function! vimcastle#stories#main#index#setup(story) abort
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
	let log = s:event_nothing_logs[vimcastle#utils#rnd(len(s:event_nothing_logs))]
	let a:state.log = [log]
	call a:state.actions.clear()
	call a:state.actions.add('c', 'Continue', function('s:action_continue'))
endfunction

function! s:event_fight(state)
	let a:state.enemy = a:state.env.enemies[vimcastle#utils#rnd(len(a:state.env.enemies))]()
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

function! s:enemy_ogre()
	let enemy = vimcastle#character#create('Ogre', 'Ogre', 50)
	let enemy.weapon = s:weapon_club()
	return enemy
endfunction

function! s:enemy_rat()
	let enemy = vimcastle#character#create('Rat', 'Rat', 8)
	let enemy.weapon = s:weapon_ratclaw()
	return enemy
endfunction

function! s:weapon_club()
	return {
		\'name': { 'short': 'club' },
		\'dmg': { 'min': 1, 'max': 2 },
		\}
endfunction

function! s:weapon_rustedshortsword()
	return {
		\'name': { 'short': 'rust. short sword' },
		\'dmg': { 'min': 2, 'max': 5 },
		\}
endfunction

function! s:weapon_ratclaw()
	return {
		\'name': { 'short': 'rust. short sword' },
		\'dmg': { 'min': 1, 'max': 2 },
		\}
endfunction

function! s:action_continue(state)
	call a:state.env.events[vimcastle#utils#rnd(len(a:state.env.events))](a:state)
endfunction

function! s:action_fight(state)
	let a:state.nextaction = function('s:action_continue')
	call a:state.enter('fight')
endfunction

function! s:action_enterforest(state)
	let a:state.env = s:env_forest()
	call s:event_fight(a:state)
endfunction

