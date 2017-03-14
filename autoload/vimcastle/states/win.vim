function! vimcastle#states#win#create() abort
	let instance = {}
	let instance.enter = function('s:enter')
	let instance.action = function('s:action')
	return instance
endfunction

function! s:enter(game) abort dict
	let [ignored, nextlevelxp] = vimcastle#levelling#forxp(a:game.player.xp)

	let xp = a:game.enemy.xp
	let a:game.player.xp += xp
	unlet a:game.enemy

	let [expectedlevel, ignored] = vimcastle#levelling#forxp(a:game.player.xp)

	call a:game.addlog('You gained:')
	call a:game.addlog('  * ' . xp . ' xp! (' . a:game.player.xp . '/' . nextlevelxp . ' xp)')

	if(a:game.player.level < expectedlevel)
		call a:game.actions.add('levelup', 'u', 'Level up!')
	else
		call a:game.actions.add('continue', 'c', 'Continue')
	endif
endfunction

function! s:action(name, game) abort dict
	execute 'call s:action_' . a:name . '(a:game)'
endfunction

function! s:action_continue(game) abort
	call a:game.enter('explore')
	let a:game.event = a:game.scene.events.rnd().invoke(a:game)
	call a:game.event.enter(a:game)
	return 1
endfunction

function! s:action_levelup(game) abort
	call a:game.enter('levelup')
	return 1
endfunction
