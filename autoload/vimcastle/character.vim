let s:monsters = [
	\  { 'name': { 'short': 'rat', 'long': 'rat'}, 'health': 10 },
	\  { 'name': { 'short': 'ogre', 'long': 'ogre'}, 'health': 50 }
	\]
let s:modifiers = [
	\  { 'name': { 'short': 'fbl', 'long': 'feeble'}, 'health': 80 },
	\  { 'name': { 'short': 'str', 'long': 'strong'}, 'health': 120 }
	\]

function! vimcastle#character#random()
	let monster = s:monsters[vimcastle#utils#rnd(len(s:monsters))]
	let modifier = s:modifiers[vimcastle#utils#rnd(len(s:modifiers))]
	return vimcastle#character#create(modifier.name.long . ' ' . monster.name.long, modifier.name.short . ' ' . monster.name.short, monster.health * modifier.health / 100)
endfunction

function! vimcastle#character#create(longname, shortname, health)
	let character = {
		\ 'name': {
			\ 'long': a:longname,
			\ 'short': a:shortname
		\ },
		\ 'health': {
			\ 'current': a:health,
			\ 'max': a:health
			\ }
		\ }
	return character
endfunction
