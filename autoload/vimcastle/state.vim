let s:state = {}

function! vimcastle#state#init() abort
	call vimcastle#state#clear()
	let s:state.player = vimcastle#character#create('Player', 'You', 100)
	let s:state.enemy = vimcastle#character#create('Enemy', 'Enemy', 12)

	let s:state.actions = [
		\{
		\  'name': 'Attack with <rust. short sword>',
		\  'fn': function('s:hit')
		\}
		\]
endfunction

function! vimcastle#state#clear() abort
	let s:state = {}
endfunction

function! vimcastle#state#get() abort
	return s:state
endfunction

function! vimcastle#state#action(key) abort
	if(a:key > 0 && a:key <= len(s:state.actions))
		call s:state.actions[a:key-1].fn()
		return 1
	endif
	if(a:key == "q")
		call vimcastle#quit()
		return 0
	endif
	return 0
endfunction

function! s:hit() abort
	let s:state.enemy.health.current -= 1
endfunction
