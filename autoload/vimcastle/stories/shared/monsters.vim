function! vimcastle#stories#shared#monsters#list(dict) abort
	let dict.ogre = s:monster_ogre()
	let dict.rat = s:monster_rat()
endfunction

function! s:monster_ogre()
	let monster = vimcastle#character#create('Ogre', 'Ogre', 50)
	let monster.weapon = s:weapon_club()
	return monster
endfunction

function! s:monster_rat()
	let monster = vimcastle#character#create('Rat', 'Rat', 8)
	let monster.weapon = s:weapon_ratclaw()
	return monster
endfunction
