function! vimcastle#stories#main#plains#load(scene) abort
	let a:scene.label = 'Plains'
	call vimcastle#stories#main#plains#weapons#register(a:scene.weapons)
	call vimcastle#stories#main#plains#monsters#register(a:scene.monsters)
	call vimcastle#stories#main#plains#events#register(a:scene)
	let a:scene.enter = function('vimcastle#stories#main#plains#events#enter')
endfunction
