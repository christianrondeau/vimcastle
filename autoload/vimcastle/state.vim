let s:state = {}

function! vimcastle#state#init() abort
	let s:state.player = vimcastle#character#create('Player', 'You', 100)
	let s:state.enemy = vimcastle#character#create('Enemy', 'Enemy', 12)
endfunction

function! vimcastle#state#get() abort
	return s:state
endfunction

function! vimcastle#state#action(key) abort
	if(a:key == '1')
		let s:state.enemy.health.current -= 1
	else
	endif
endfunction
