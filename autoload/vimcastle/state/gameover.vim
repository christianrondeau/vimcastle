function! vimcastle#state#gameover#enter(state) abort
	let a:state.stats.score = s:computescore(a:state.stats)

	call s:writehighscore(a:state.stats)

	call a:state.clearlog()
	call a:state.actions().addDefault('Restart', function('s:action_restart'))
endfunction

function! s:computescore(stats) abort
	if(!exists('a:stats'))
		return 0
	endif
	
	let score = 0
	let score += a:stats.events * 2
	let score += a:stats.fights * 10
	let score += a:stats.scenes * 20
	return score
endfunction

function! s:writehighscore(stats) abort
	if(vimcastle#io#setup())
		let highscoresfile = vimcastle#io#path('highscores.csv')
		let highscores = []
		if(filereadable(highscoresfile))
			let highscores = readfile(highscoresfile)
		endif
		call add(highscores, s:tocsv(a:stats))
		call reverse(sort(highscores, 'n'))
		call writefile(highscores[0:9], highscoresfile)
	endif
endfunction

function! s:tocsv(stats) abort
	return join([a:stats.score, a:stats.events, a:stats.fights, a:stats.scenes], ',')
endfunction

function! s:action_restart(state) abort
	call a:state.reset()
	call a:state.enter('intro')
endfunction
