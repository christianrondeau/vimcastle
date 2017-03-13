function! vimcastle#states#menu#create() abort
	let instance = {}
	let instance.enter = function('s:enter')
	let instance.action = function('s:action')
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
	
	call a:game.actions
				\.add('newgame', 'n', 'New Game')
				\.add('highscores', 's', 'High Scores')
				\.add('', 'h', 'Help')
				\.add('', 'q', 'Quit')
endfunction

function! s:action(name, game) abort
	execute 'return s:action_' . a:name . '(a:game)'
endfunction

function! s:action_newgame(game) abort
	call a:game.reset()
	"TODO: There must be a better way...
	let a:game.scene = vimcastle#scene#loadintro('main')
	let a:game.event = a:game.scene.enter.invoke(a:game)
	return a:game.enter('explore')
endfunction

function! s:action_highscores(game) abort
	return a:game.enter('highscores')
endfunction
