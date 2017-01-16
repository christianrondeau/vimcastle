function! vimcastle#state#menu#enter(state) abort
	call a:state.nav.add('n', 'New Game', function('s:nav_newgame'))
	call a:state.nav.add('h', 'Help', function('s:nav_help'))
	call a:state.nav.add('q', 'Quit', function('s:nav_noop'))

	let a:state.log = [vimcastle#utils#oneof([
				\'Adventure!',
				\'Exciting!',
				\'Amazing!',
				\'Get ready!',
				\'Castles and monsters!',
				\])]
endfunction

function! s:nav_newgame(state) abort
	call a:state.reset()
	let a:state.scene = vimcastle#scene#load('main', 'index')
	call a:state.enter('explore')
	call a:state.scene.enter.invoke(a:state)
endfunction

function! s:nav_help(state) abort
	help Vimcastle
endfunction

function! s:nav_noop(state) abort
endfunction
