function! vimcastle#state#menu#enter(state) abort
 	call a:state.actions().clear()
	call a:state.actions().add('n', 'New Game')
	call a:state.actions().add('s', 'High Scores')
	call a:state.actions().add('h', 'Help')
	call a:state.actions().add('q', 'Quit')

	call a:state.clearlog()
	call a:state.addlogrnd([
				\'Adventure!',
				\'Exciting!',
				\'Amazing!',
				\'Get ready!',
				\'Castles and monsters!',
				\])
	call a:state.addlog('DEV: This game is not finished, it''s not even fun yet :) Stay tuned for the basic gameplay mechanisms first, then I''ll work on story elements.')
	call a:state.addlog('Please share your ideas and feedback at <https://github.com/christianrondeau/vimcastle>')
	call a:state.addlog('  - Christian')
endfunction

function! vimcastle#state#menu#action(key, state) abort
	if(a:key ==# 'n')
		call s:action_newgame(a:state)
		return 1
	elseif(a:key ==# 's')
		call s:action_highscores(a:state)
		return 1
	else
		return 0
	endif
endfunction

function! s:action_newgame(state) abort
	call a:state.reset()
	let a:state.scene = vimcastle#scene#loadintro('main')
	call a:state.enter('explore')
	call a:state.scene.enter.invoke(a:state)
endfunction

function! s:action_highscores(state) abort
	call a:state.enter('highscores')
endfunction
