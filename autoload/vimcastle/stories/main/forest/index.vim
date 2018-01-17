function! vimcastle#stories#main#forest#index#info() abort
	return {
				\  'label': 'Forest',
				\  'level': 7
				\}
endfunction

function! vimcastle#stories#main#forest#index#load(scene) abort
	let a:scene.info = vimcastle#stories#main#forest#index#info()
	let a:scene.enter = s:event_enter()
	call a:scene.events.add(30, s:event_nothing())
	call a:scene.events.add(60, s:event_encounter())
	call a:scene.events.add(1, s:event_boss())
	call a:scene.events.add(1, s:event_heal())
	call a:scene.events.add(1, s:event_plainsentrance())
endfunction

function! s:event_enter() abort
	return vimcastle#eventgen#create()
				\.text([
				\ 'You enter the forest, and prepare for the worst'
				\])
				\.explore('Go deeper in the forest')
endfunction

function! s:event_nothing() abort
	return vimcastle#eventgen#create()
				\.text([
				\ 'It''s dark, your hear noises but nothing happens.',
				\ 'You walk among huge roots, only to find... more huge roots.',
				\ 'The trees are gigantic, and sometimes you think you hear screaming, far away.'
				\])
				\.explore('Continue')
endfunction

function! s:event_encounter() abort
	return vimcastle#eventgen#create()
				\.text([
				\ 'You hear a sound from behind a tree, and you see %<enemy.name>!',
				\ 'Out of a hole, jumps %<enemy.name>!'
				\])
				\.fight('Fight!', vimcastle#stories#main#forest#monsters#get())
endfunction

function! s:event_heal() abort
	return vimcastle#eventgen#create()
				\.text([
				\ 'You see some herbs that can heal your wounds. You rub them on you.',
				\ 'There is a small, hidden cavern that seems easy to barricade using surrounding rocks. You sit down and relax for a while.',
				\ 'There is a small clearing. You decide to sit down and rest.'
				\])
				\.effect('heal', 10)
				\.explore('Continue')
endfunction

function! s:event_boss() abort
	let boss = vimcastle#monstergen#create('Troll Boss')
				\.health(250)
				\.level(15)
				\.xp(60)
				\.stat('spd', 2)
				\.weapon(vimcastle#equippablegen#weapon('Rock Fist', 6, 14))
	return vimcastle#eventgen#create()
				\.text([
				\ 'You feel the earth shake, and out of the dark comes the infamous %<enemy.name>. Prepare yourself.'
				\])
				\.fight('Fight!', vimcastle#repository#single(boss))
endfunction

function! s:event_plainsentrance() abort
	return vimcastle#eventgen#create()
				\.text([
				\ 'You see a clearing. This looks like the plains, where you come from.'
				\])
				\.enterscene('Go back to the open plains', 'plains')
				\.explore('Stay inside the forest')
endfunction
