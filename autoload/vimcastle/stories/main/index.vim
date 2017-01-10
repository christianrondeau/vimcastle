function! vimcastle#stories#main#index#begin(state) abort
	let a:state.scene = vimcastle#stories#main#plains#load()
	let a:state.player = vimcastle#character#create('Player', 'You', 60, a:state.scene.weapons.sword())
endfunction
