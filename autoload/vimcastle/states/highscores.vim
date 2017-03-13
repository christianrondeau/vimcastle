function! vimcastle#states#highscores#create() abort
	let instance = {}
	let instance.enter = function('s:enter')
	let instance.action = function('s:action')
	return instance
endfunction

function! s:enter(game) abort dict
	call a:game.clearlog()

	call a:game.addlog('Score     Events    Fights    Scenes')
	call a:game.addlog(s:loadhighscores())

	call a:game.actions
				\.add('back', 'b', 'Menu')
endfunction

function! s:action(name, game) abort dict
	execute 'return s:action_' . a:name . '(a:game)'
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

function! s:action_back(game) abort
	return a:game.enter('menu')
endfunction
