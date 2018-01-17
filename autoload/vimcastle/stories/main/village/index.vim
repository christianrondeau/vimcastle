function! vimcastle#stories#main#village#index#info() abort
	return {
				\  'label': 'Village',
				\  'level': 1
				\}
endfunction

function! vimcastle#stories#main#village#index#load(scene) abort
	let a:scene.info = vimcastle#stories#main#village#index#info()
	let a:scene.enter = s:event_enter()

	call a:scene.events.add(12, s:event_nothing())
	call a:scene.events.add(6, s:event_encounter())
	call a:scene.events.add(7, s:event_encounter_opt())
	call a:scene.events.add(5, s:event_finditem())
	call a:scene.events.add(4, s:event_heal())
	call a:scene.events.add(2, s:event_plains())
	call a:scene.events.once(5, s:event_puzzle1())
	call a:scene.events.named('puzzle1_correct', s:event_puzzle1_correct())
	call a:scene.events.named('puzzle1_wrong', s:event_puzzle1_wrong())
endfunction

function! s:event_enter() abort
	return vimcastle#eventgen#create()
				\.text([
				\ 'The sun is shining, and the village is crawling with rats and angry drunkards. A perfect day to play outside!'
				\])
				\.explore('Start roaming the streets')
endfunction

function! s:event_nothing() abort
	return vimcastle#eventgen#create()
				\.text([
				\ 'The streets are pretty clean, except for the broken glass everywhere, the mud and the filth. So, yeah. Not exactly clean. You continue on your way.',
				\ 'A group of children throw something at you behind your back. But thanks to your amazing reflexes, you turn around just in time to receive it in the face. You see them flee around a corner, giggling. Bah, not worth it. You just ignore them.',
				\ 'Hey, there''s someone waving at you! Not sure if you know who they are, so you wave back. You then see who they were waving to. You blush and walk away.',
				\ 'You see an old lady trying to climb some stairs. Since you''re a nice person, you help her up. One stair. She can get someone else for the other four. "No need to thank me!" and you whistle back on your way.',
				\ 'That''s a pretty boring village. Nothing to see here.',
				\ 'You smell some pie. Clearly raspberry pie. Does "pie" ends with an "e"? Anyway you got no money, so, walk away.',
				\])
				\.explore('Continue')
endfunction

function! s:event_heal() abort
	return vimcastle#eventgen#create()
				\.text([
				\ 'Someone offers some trial bread! Just to make sure you like it, you try five of them, but won''t buy any. Thanks anyway!',
				\ 'There is a very nice fountain in the middle of the marketplace. A few things float in it, but you drink it anyway. Interesting taste...',
				\])
				\.effect('heal', 10)
				\.explore('Continue')
endfunction

function! s:event_finditem() abort
	return vimcastle#eventgen#create()
				\.text([
				\ 'It seems like someone left %<ground> lying on a restaurant table! Zoink!',
				\ 'Jackpot! Looks like a full trashcan! Searching through some uninteresting junk, you find %<ground>!',
				\])
				\.finditem(vimcastle#stories#main#village#items#get())
				\.explore('Leave it there and continue')
endfunction

function! s:event_encounter() abort
	return vimcastle#eventgen#create()
				\.text([
				\ 'You walk by a bar, and you suddenly see %<enemy.name> running towards you!',
				\])
				\.fight('Fight!', vimcastle#stories#main#village#monsters#get())
endfunction

function! s:event_encounter_opt() abort
	return vimcastle#eventgen#create()
				\.text([
				\ '%<enemy.name> looks at you wrong. Real wrong. What will you do about it?',
				\])
				\.fight('Fight!', vimcastle#stories#main#village#monsters#get())
				\.explore('Avoid the fight')
endfunction

function! s:event_plains() abort
	return vimcastle#eventgen#create()
				\.text([
				\ 'Hey! Here''s the village exit! Will you start your adventure for real now?'
				\])
				\.enterscene('Exit the village', 'plains')
				\.explore('Continue exploring the village')
endfunction

function! s:event_puzzle1() abort
	return vimcastle#eventgen#create()
				\.text( 'An old man stops an holds you by the shoulder. He says:')
				\.text( '- Do you know Samanth?')
				\.choice('Yeah... Sure!', 'puzzle1_correct')
				\.choice('Who?', 'puzzle1_wrong')
endfunction

function! s:event_puzzle1_correct() abort
	let ring = vimcastle#equippablegen#create('ring', 'Samanth''s Ring').stat('def', 2)
	return vimcastle#eventgen#create()
				\.text('- Good! Can you give him his %<ground>? I''m not feeling like walking today.')
				\.findequippable(vimcastle#repository#single(ring))
				\.explore('No way!')
endfunction

function! s:event_puzzle1_wrong() abort
	return vimcastle#eventgen#create()
				\.text('The stranger scoffs and walks away.')
				\.explore('Shrug and continue')
endfunction

