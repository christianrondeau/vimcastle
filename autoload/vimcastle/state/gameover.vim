function! vimcastle#state#gameover#enter(state) abort
	let a:state.stats.score = s:computescore(a:state.stats)
	call a:state.clearlog()
 	call a:state.actions().clear()
	call a:state.actions().addDefault('Restart', function('s:action_restart'))
endfunction

function! s:computescore(stats) abort
	if(!exists('a:stats'))
		return 0
	endif
	
	let score = 0
	let score += a:stats.events * 2
	let score += a:stats.scenes * 20
	let score += a:stats.fights * 10
	return score
endfunction

function! s:action_restart(state) abort
	call a:state.reset()
	call a:state.enter('intro')
endfunction
