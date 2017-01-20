function! vimcastle#state#menu#enter(state) abort
	call a:state.nav.add('n', 'New Game', function('s:nav_newgame'))
	call a:state.nav.add('h', 'Help', function('s:nav_noop'))
	call a:state.nav.add('q', 'Quit', function('s:nav_noop'))

	call a:state.addlog([
				\'Adventure!',
				\'Exciting!',
				\'Amazing!',
				\'Get ready!',
				\'Castles and monsters!',
				\])
	call a:state.addlog('')
	call a:state.addlog('DEV: This game is not finished, it''s not even fun yet :) Stay tuned for the basic gameplay mechanisms first, then I''ll work on story elements.')
	call a:state.addlog('Please share your ideas and feedback at <https://github.com/christianrondeau/vimcastle>')
	call a:state.addlog('  - Christian')
endfunction

function! s:nav_newgame(state) abort
	call a:state.reset()
	let a:state.scene = vimcastle#scene#load('main', 'index')
	call a:state.enter('explore')
	call a:state.scene.enter.invoke(a:state)
endfunction

function! s:nav_noop(state) abort
endfunction
