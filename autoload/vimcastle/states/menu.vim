function! vimcastle#states#menu#create() abort
	let instance = {}
	let instance.enter = function('s:enter')
	let instance.action_newgame = function('s:action_newgame')
	let instance.action_continue = function('s:action_continue')
	let instance.action_highscores = function('s:action_highscores')
	return instance
endfunction

function! s:enter(game) abort dict
	call a:game.clearlog()
	call a:game.addlogrnd([
				\'Adventure!',
				\'Exciting!',
				\'Amazing!',
				\'Get ready!',
				\'Castles and monsters!',
				\])
	call a:game.addlog('DEV: This game is not finished, it''s not even fun yet :) Stay tuned for the basic gameplay mechanisms first, then I''ll work on story elements.')
	call a:game.addlog('Please share your ideas and feedback at <https://github.com/christianrondeau/vimcastle>')
	call a:game.addlog('  - Christian')
	
	call a:game.actions.add('newgame', 'n', 'New Game')

	if(vimcastle#io#setup())
		if(vimcastle#io#hassave())
			call a:game.actions.add('continue', 'c', 'Continue')
		endif
	else
		"TODO: Actually avoid saving every turn
		call a:game.addlog('ERROR: Cannot access "' . vimcastle#io#path('') . '". Your game will not be saved.')
	endif

	call a:game.actions
				\.add('highscores', 's', 'High Scores')
				\.add('', 'h', 'Help')
				\.add('', 'q', 'Quit')
endfunction

function! s:action_newgame(game) abort
	call a:game.reset()
	let a:game.scene = vimcastle#scene#loadintro('main')
	let a:game.event = a:game.scene.enter.invoke(a:game)
	return a:game.enter('explore')
endfunction

function! s:action_continue(game) abort
	call a:game.reset()
	"TODO: Remove this an load the scene
	let a:game.scene = vimcastle#scene#loadintro('main')
	call a:game.load(vimcastle#io#load())
endfunction

function! s:action_highscores(game) abort
	return a:game.enter('highscores')
endfunction
