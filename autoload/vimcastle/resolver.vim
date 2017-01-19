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
	let dmg -= a:defender.getstat('def')

	" Attacker Strength
	let dmg += a:attacker.getstat('str')

	" Minimum Damage
	if(dmg < 0)
		let dmg = 0
	endif

	" Maximum Damage
	let a:defender.health.current -= dmg
	if(a:defender.health.current < 0)
		let a:defender.health.current = 0
	endif

	" Final Damage
	return dmg
endfunction
