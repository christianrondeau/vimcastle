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
	call a:scene.events.named('fight1', s:event_fight1())
	call a:scene.events.named('item', s:event_item())
	call a:scene.events.named('heal', s:event_heal())
	call a:scene.events.named('fight2', s:event_fight2())
	call a:scene.events.named('finish', s:event_finish())
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
	let armor = vimcastle#equippablegen#armor('Clothes', 1).invoke()
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
				\.text('You can scroll usimg <j>/<k> or <up>/<down>.')
				\.text('Now, let''s get you some equipment.')
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
				\.next('fight1')
endfunction

function! s:event_fight1() abort
	let monster = vimcastle#monstergen#create('Target Practice Dummy')
				\.description('It will not hit back per se... it may rebound though.')
				\.health(8)
				\.level(1)
				\.xp(1)
				\.stat('spd', 0)
				\.stat('dex', 0)
				\.weapon(vimcastle#equippablegen#weapon('Spring Rebound', 0, 2))
	return vimcastle#eventgen#create()
				\.text('Let''s now test your fighting skills against %<enemy.name>')
				\.text('Note that you can <l>ook at your enemy, but you will lose a turn!')
				\.fight('Bring it on!', vimcastle#repository#single(monster))
				\.next('item')
endfunction

function! s:event_item() abort
	let item = {'label': 'Glass of Eater (+30)', 'effect': 'heal', 'value': 30}
	return vimcastle#eventgen#create()
				\.text('Well done! Here''s a good %<ground>, if you are thirsty.')
				\.text('You can only use items when there is no enemy in front of you, or when you''re in a fight.')
				\.finditem(vimcastle#repository#single(item))
				\.next('heal')
endfunction

function! s:event_heal() abort
	return vimcastle#eventgen#create()
				\.text('Let''s get you patched up for now. You cannot use your item now, because you are full!')
				\.text('Try it now, go to your <i>nventory and try to <u>se your item!')
				\.effect('heal', 20)
				\.explore('Okay, got it.')
				\.next('fight2')
endfunction

function! s:event_fight2() abort
	let monster = vimcastle#monstergen#create('Big Boss')
				\.description('He''s mean, and he''s strong!')
				\.health(50)
				\.level(2)
				\.xp(12)
				\.stat('spd', 0)
				\.stat('dex', 0)
				\.weapon(vimcastle#equippablegen#weapon('Axe of Doom', 3, 6))
	return vimcastle#eventgen#create()
				\.text('Now''s the final test: %<enemy.name>.')
				\.text('Keep in mind that if you open your inventory with <u> in a fight, even if you don''t actually use anything, you''ll lose a turn!')
				\.text('If you win, you will have enough xp to level up! You can spend your point like you see fit. If you win.')
				\.fight('I''m ready!', vimcastle#repository#single(monster))
				\.next('finish')
endfunction

function! s:event_finish() abort
	return vimcastle#eventgen#create()
				\.text('You are GOOD! The tutorial is complete, press <q> to quit and begin your adventure!')
endfunction
