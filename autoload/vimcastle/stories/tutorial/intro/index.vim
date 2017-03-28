function! vimcastle#stories#tutorial#intro#index#info() abort
	return {
				\  'label': 'Tutorial 1',
				\  'level': 1
				\}
endfunction

function! vimcastle#stories#tutorial#intro#index#load(scene) abort
	let a:scene.info = vimcastle#stories#tutorial#intro#index#info()
	let a:scene.enter = s:event_enter()

	call a:scene.events.add(1, s:event_void())

	call a:scene.events.named('intro2', s:event_intro2())
	call a:scene.events.named('weapon', s:event_weapon())
	call a:scene.events.named('armor', s:event_armor())
endfunction

function! s:event_enter() abort
	return vimcastle#eventgen#create()
				\.before(function('s:setup'))
				\.text('Welcome to Vimcastle, a randomly generated game where you can play without even leaving your favorite editor!')
				\.text('For now, press <c> to get started.')
				\.text('You can quit at any time with <q>.')
				\.explore('Ok, let''s get started!')
				\.next('intro2')
endfunction

function! s:setup(state) abort
	let weapon = vimcastle#equippablegen#weapon('None', 0, 0).invoke()
	let armor = vimcastle#equippablegen#armor('None', 0).invoke()
	let a:state.player = vimcastle#character#create('Player', 30)
				\.setstat('con', 1)
				\.setstat('str', 1)
				\.setstat('spd', 1)
				\.setstat('dex', 1)
				\.equip(weapon)
				\.equip(armor)
	let a:state.player.level = 1
	let a:state.player.xp = 0
	let a:state.player.items = []
	let a:state.player.health = a:state.player.getmaxhealth()
endfunction

function! s:event_void() abort
	return vimcastle#eventgen#create()
				\.text('Oops! The tutorial is over.')
endfunction

function! s:event_intro2() abort
	return vimcastle#eventgen#create()
				\.text('On the top right, you can see your health. At the bottom, the list of actions you can do.')
				\.text('For now, let''s get you some equipment.')
				\.explore('Oh yeah!')
				\.next('weapon')
endfunction

function! s:event_weapon() abort
	let weapon = vimcastle#equippablegen#weapon('Pointy Stick', 3, 7)
	return vimcastle#eventgen#create()
				\.text('Here''s a nice %<ground>, just for you!')
				\.text('You can see below that this weapon is better than what you have (nothing), and that it can do between 3 and 7 damage.')
				\.text('You can equip it now!')
				\.findequippable(vimcastle#repository#single(weapon))
				\.next('armor')
endfunction

function! s:event_armor() abort
	let armor = vimcastle#equippablegen#armor('Potato Bag', 2).stat('spd', 1)
	return vimcastle#eventgen#create()
				\.text('You now have %<player.weapon>! You can look at its stats using your <i>nventory.')
				\.text('Now, you need some armor. What a coincidence, there''s a nice %<ground> here!')
				\.text('Not only this armor will protect you from <2> damage, it will boost your speed by <1>!')
				\.findequippable(vimcastle#repository#single(armor))
				\.next('fight')
endfunction
