let s:state = {}

function! vimcastle#state#init() abort
	let s:state.player = vimcastle#character#create('Player', 'You', 100)
	let s:state.enemy = vimcastle#character#create('Enemy', 'Enemy', 12)

	let s:state.actions = [
		\{
		\  'name': 'Attack with <rust. short sword>',
		\  'fn': function('s:hit')
		\}
		\]
endfunction

function! vimcastle#state#get() abort
	return s:state
endfunction

function! vimcastle#state#action(index) abort
	call s:state.actions[a:index-1].fn()
endfunction

function! s:hit() abort
	let s:state.enemy.health.current -= 1
endfunction
