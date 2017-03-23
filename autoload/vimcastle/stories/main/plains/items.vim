function! vimcastle#stories#main#plains#items#get() abort
	let repo = vimcastle#repository#create()

  call repo.add(1, {'label': 'Travel cookies (+10)', 'effect': 'heal', 'value': 10})
  call repo.add(3, {'label': 'Small healing potion (+30)', 'effect': 'heal', 'value': 30})
  call repo.add(1, {'label': 'Small healing kit (+45)', 'effect': 'heal', 'value': 45})

  call repo.add(1, {'label': 'Small throwing dagger (15 dmg)', 'effect': 'damage', 'value': 15})

  call repo.add(1, {'label': 'Scroll of minor constitution', 'effect': 'gainhealth', 'value': 1})
  call repo.add(1, {'label': 'Scroll of minor strength', 'effect': 'gainstr', 'value': 1})

	return repo
endfunction
