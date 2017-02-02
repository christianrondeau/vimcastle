function! vimcastle#stories#main#index#load(scene) abort
	let a:scene.label = 'Beginning'
	let a:scene.enter = s:event_enter()
endfunction

function! s:event_enter() abort
	return vimcastle#event#create('enter')
				\.effect(function('s:effect_setup'), 0)
				\.text(['You are a barber in a small village.', 'You are a bored kid who wants to do something important.', 'You are an old warrior looking for adventure.', 'You are lost and you don''t know who you are.'])
				\.text('You pack up your stuff, pick up your %<player.weapon> and get ready for adventure!')
				\.text('')
				\.text('(You can open the inventory with <i> and the character sheet with <s>)')
				\.enterscene('Start exploring!', 'plains')
endfunction

function! s:effect_setup(state, value) abort
	let a:state.player = vimcastle#character#create({ 'short': 'Plr.', 'long': 'Player' }, 60)
				\.setstat('str', vimcastle#utils#rnd(2) + 2)
				\.setstat('spd', vimcastle#utils#rnd(2) + 2)
				\.setstat('dex', vimcastle#utils#rnd(3))
				\.equipweapon(vimcastle#stories#main#plains#weapons#get().rnd().invoke())
				\.equiparmor(vimcastle#stories#main#plains#armors#get().rnd().invoke())
	let a:state.player.level = 1
	let a:state.player.xp = 0
endfunction
