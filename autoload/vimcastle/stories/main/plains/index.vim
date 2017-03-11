function! vimcastle#stories#main#plains#index#info() abort
	return {
				\  'label': 'Plains',
				\  'level': 1
				\}
endfunction

function! vimcastle#stories#main#plains#index#load(scene) abort
	let a:scene.info = vimcastle#stories#main#plains#index#info()
	let a:scene.enter = s:event_enter()

	call a:scene.events.add(30, s:event_nothing())
	call a:scene.events.add(20, s:event_encounter())
	call a:scene.events.add(3, s:event_heal())
	call a:scene.events.add(2, s:event_findweapon())
	call a:scene.events.add(2, s:event_findarmor())
	call a:scene.events.add(2, s:event_finditem())

	call a:scene.events.add(2, s:event_forestentrance())

	call a:scene.events.once(1, s:event_gainhealth())
	call a:scene.events.once(1, s:event_gainstr())
	call a:scene.events.once(2, s:event_boss())
endfunction

function! s:event_enter() abort
	return vimcastle#eventgen#create('enter')
				\.text([
				\ 'The sun is shining, and the plains are crawling with monsters. A perfect day to go outside!'
				\])
				\.explore('Start walking forward')
endfunction

function! s:event_nothing() abort
	return vimcastle#eventgen#create('nothing')
				\.text([
				\ 'You wander aimlessly...',
				\ 'You walk around...',
				\ 'You see... nothing.',
				\ 'Nope. Nothing.'
				\])
				\.explore('Continue')
endfunction

function! s:event_heal() abort
	return vimcastle#eventgen#create('heal')
				\.text([
				\ 'You see a pond of fresh water. You drink for it and feel refreshed.',
				\ 'You see an abandoned house. You rest in it for a little bit.',
				\ 'You see a camp, and decide to rest for a few minutes.'
				\])
				\.effect('heal', 20)
				\.explore('Continue')
endfunction

function! s:event_finditem() abort
	return vimcastle#eventgen#create('finditem')
				\.text([
				\ 'You stumble on something... Oh, it''s a %<ground>!',
				\ 'You find a dead body holding a satchel. You open it, and you find a %<ground>.',
				\])
				\.finditem(vimcastle#stories#main#plains#items#get())
				\.explore('Leave it there and continue')
endfunction

function! s:event_gainhealth() abort
	return vimcastle#eventgen#create('gainhealth')
				\.text([
				\ 'You find a shrine, with a soft, magical feeling around it. You touch it.',
				\])
				\.effect('gainhealth', 5)
				\.explore('Leave the shrine')
endfunction

function! s:event_gainstr() abort
	return vimcastle#eventgen#create('gainstr')
				\.text([
				\ 'You stop by a small house with an elder cutting wood. You decide to help him.',
				\])
				\.effect('gainstr', 1)
				\.explore('Say bye and leave')
endfunction

function! s:event_findweapon() abort
	return vimcastle#eventgen#create('findweapon')
				\.text([
				\ 'You find a weapon rack with containing %<ground>!',
				\])
				\.findequippable(vimcastle#stories#main#plains#weapons#get())
				\.explore('Leave it there and continue')
endfunction

function! s:event_findarmor() abort
	return vimcastle#eventgen#create('findarmor')
				\.text([
				\ 'You find %<ground> lying on the ground!',
				\])
				\.findequippable(vimcastle#stories#main#plains#armors#get())
				\.explore('Leave it there and continue')
endfunction

function! s:event_encounter() abort
	return vimcastle#eventgen#create('encounter')
				\.text([
				\ 'You encounter %<enemy.name>!',
				\ 'Oh no! %<enemy.name> stands before you, ready to attack!',
				\ '%<enemy.name> suddenly jumps from behind a tree!'
				\])
				\.fight('Fight!', vimcastle#stories#main#plains#monsters#get())
endfunction

function! s:event_boss() abort
	let boss = vimcastle#monstergen#create('Sl. Joe', 'Sloppy Joe')
				\.description('He''s sloppy, but don''t underestimate his strength. You might get a bruise, or you might lose an arm.')
				\.health(100)
				\.level(5)
				\.xp(20)
				\.stat('spd', 0)
				\.weapon(vimcastle#equippablegen#weapon('Hammer', 'Hammer', 0, 8))
	return vimcastle#eventgen#create('encounter')
				\.text(['Oh no! It''s %<enemy.name>, brace yourself!'])
				\.fight('Fight!', vimcastle#repository#single(boss))
endfunction


function! s:event_forestentrance() abort
	return vimcastle#eventgen#create('forestentrance')
				\.text([
				\ 'You face a dense forest. you see movement in the dark.'
				\])
				\.enterscene('Enter the forest', 'forest')
				\.explore('Avoid the forest for now')
endfunction
