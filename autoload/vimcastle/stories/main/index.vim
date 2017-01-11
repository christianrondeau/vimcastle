function! vimcastle#stories#main#index#load(scene) abort
	let a:scene.label = 'Beginning'
	let a:scene.enter = s:event_enter()
endfunction

function! s:event_enter() abort
	return vimcastle#event#create()
				\.text('You face a dense forest. you see movement in the dark.')
				\.effect(function('s:effect_setup'))
				\.enterscene('Start exploring!', 'plains')
endfunction

function! s:effect_setup(state) abort
	let a:state.player = vimcastle#character#create('Player', 'You', 60, vimcastle#stories#main#plains#weapons#get().rnd()())
endfunction
