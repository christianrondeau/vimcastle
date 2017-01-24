function! vimcastle#resolver#hit(attacker, defender) abort
	if(!exists('a:attacker.equipment.weapon'))
		return 0
	endif

	" Attacker Weapon
	let weapon = a:attacker.equipment.weapon
	let dmgmin = weapon.dmg.min
	let dmgmax = weapon.dmg.max
	let dmg = vimcastle#utils#rnd(dmgmax - dmgmin + 1) + dmgmin

	" Defender Armor
	let dmg -= a:defender.getstat('def', 1)

	" Attacker Strength
	let dmg += a:attacker.getstat('str', 1)

	" Minimum Damage
	if(dmg < 0)
		let dmg = 0
	endif

	" Maximum Damage
	let a:defender.health -= dmg
	if(a:defender.health < 0)
		let a:defender.health = 0
	endif

	" Critical
	if(dmg > 0)
		let dex = a:attacker.getstat('dex', 1)
		let roll = vimcastle#utils#rnd(100)
		if(roll <= dex)
			let dmg = (dmg * 2) . ' critical'
		endif
	endif

	" Final Damage
	return dmg
endfunction
