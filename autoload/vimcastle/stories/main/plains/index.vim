let s:_ = vimcastle#utils#get()

function! vimcastle#stories#main#plains#index#load() abort
	let scene = vimcastle#scene#create('Plains')
	call vimcastle#stories#main#plains#weapons#register(scene.weapons)
	call vimcastle#stories#main#plains#monsters#register(scene.monsters)
	call vimcastle#stories#main#plains#events#register(scene)
	let scene.enter = function('s:enter')
	return scene
endfunction

function! s:enter(state) abort
	let a:state.log = ['You pack up your stuff and you are ready to go!']
	call a:state.actions.clear()
	call a:state.actions.add('c', 'Start walking forward', function('s:action_continue'))
endfunction

function! s:action_continue(state)
	let result = a:state.scene.events.rnd()(a:state)
endfunction
