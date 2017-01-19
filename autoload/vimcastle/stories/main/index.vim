function! vimcastle#stories#main#index#load(scene) abort
	let a:scene.label = 'Beginning'
	let a:scene.enter = s:event_enter()
endfunction

function! s:event_enter() abort
	return vimcastle#event#create('enter')
				\.text('You pack up your stuff, pick up your %<player.weapon> and get ready for adventure!')
				\.effect(function('s:effect_setup'))
				\.enterscene('Start exploring!', 'plains')
endfunction

function! s:effect_setup(state) abort
	let a:state.player = vimcastle#character#create({ 'short': 'Plr.', 'long': 'Player' }, 60)
				\.setstat('str', vimcastle#utils#rnd(3))
				\.equipweapon(vimcastle#stories#main#plains#weapons#get().rnd().invoke())
				\.equiparmor(vimcastle#stories#main#plains#armors#get().rnd().invoke())
endfunction
