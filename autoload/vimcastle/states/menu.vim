function! vimcastle#states#menu#create() abort
	let instance = {}
	let instance.cansave = 0
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

	if(vimcastle#io#hassave())
		try
			let save = vimcastle#io#load()
			call a:game.actions.add('continue', 'c', 'Continue (' . save.scene.name . ', ' . save.screen . ', level ' . save.player.level . ')')
		catch
			call a:game.addlog('ERROR: Corrupt save game (' . v:exception . ')')
		endtry
	endif

	if(vimcastle#io#hashighscores())
		call a:game.actions.add('highscores', 's', 'High Scores')
	endif

	call a:game.actions
				\.add('', 'h', 'Help')
				\.add('', 'q', 'Quit')
endfunction

function! s:action_newgame(game) abort
	if(vimcastle#io#hassave())
		if(!confirm('This will overwrite your saved game. Are you sure?'))
			return a:game.enter('menu')
		endif
	endif

	call a:game.reset()
	let a:game.scene = vimcastle#scene#loadintro('main')
	let a:game.event = a:game.scene.enter.invoke(a:game)
	return a:game.enter('explore')
endfunction

function! s:action_continue(game) abort
	call a:game.reset()
	let a:game.scene = vimcastle#scene#loadintro('main')
	call a:game.load(vimcastle#io#load())
endfunction

function! s:action_highscores(game) abort
	return a:game.enter('highscores')
endfunction
