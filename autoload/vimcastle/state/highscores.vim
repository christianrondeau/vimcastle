function! vimcastle#state#highscores#enter(state) abort
	call a:state.clearlog()

	call a:state.addlog('Score     Events    Fights    Scenes')
	call a:state.addlog(s:loadhighscores())

 	call a:state.actions().clear()
	call a:state.actions().add('b', 'Menu', function('s:action_menu'))
endfunction

function! s:loadhighscores() abort
	let highscoresfile = vimcastle#io#path('highscores.csv')
	if(!filereadable(highscoresfile))
		return ['-          -          -          -']
	endif
	let rows = []
	for line in readfile(highscoresfile)
		let row = ''
		for item in split(line, ',')
			let col = item
			if(strlen(col) < 10)
				let col .= repeat(' ', 10 - len(col))
			endif
			let row .= col
		endfor
		call add(rows, row)
	endfor
	return rows
endfunction

function! s:action_menu(state) abort
	call a:state.enter('menu')
endfunction
