function! vimcastle#stories#main#intro#index#info() abort
	return {
				\  'label': 'Intro',
				\  'level': 0
				\}
endfunction

function! vimcastle#stories#main#intro#index#load(scene) abort
	let a:scene.info = vimcastle#stories#main#intro#index#info()
	let a:scene.enter = s:event_enter()
endfunction

function! s:event_enter() abort
	return vimcastle#eventgen#create('enter')
				\.before(function('s:setup'))
				\.text(['You are a barber in a small village.', 'You are a bored kid who wants to do something important.', 'You are an old warrior looking for adventure.', 'You are lost and you don''t know who you are.'])
				\.text('You pack up your stuff, pick up your %<player.weapon> and get ready for adventure!')
				\.enterscene('Start exploring!', 'plains')
endfunction

function! s:setup(state) abort
	let a:state.player = vimcastle#character#create({ 'short': 'Plr.', 'long': 'Player' }, 30)
				\.setstat('con', vimcastle#utils#rnd(2) + 2)
				\.setstat('str', vimcastle#utils#rnd(2) + 2)
				\.setstat('spd', vimcastle#utils#rnd(2) + 2)
				\.setstat('dex', vimcastle#utils#rnd(3))
				\.equip(vimcastle#stories#main#intro#weapons#get().rnd().invoke())
				\.equip(vimcastle#stories#main#intro#armors#get().rnd().invoke())
	let a:state.player.level = 1
	let a:state.player.xp = 0
	let a:state.player.items = [
				\ vimcastle#stories#main#intro#items#get().rnd()
				\]
endfunction
