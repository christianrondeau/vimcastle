let s:state = {}

function! vimcastle#initstate() abort
	let s:state.player = vimcastle#character#create('Player', 'You', 100)
	let s:state.enemy = vimcastle#character#create('Enemy', 'Enem.', 12)
endfunction

function! vimcastle#initmappings() abort
	nnoremap <buffer> 1 :call vimcastle#hit()<cr>
	nnoremap <buffer> q :bd<cr>
endfunction

function! vimcastle#hit() abort
	let s:state.enemy.health.current -= 1
	call vimcastle#ui#draw(s:state)
endfunction

function! vimcastle#start() abort
	call vimcastle#ui#init()
	call vimcastle#initstate()
	call vimcastle#initmappings()
	call vimcastle#ui#draw(s:state)
endfunction
