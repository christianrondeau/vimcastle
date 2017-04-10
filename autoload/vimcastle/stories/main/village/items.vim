function! vimcastle#stories#main#village#items#get() abort
	let repo = vimcastle#repository#create()

  call repo.add(1, {'label': 'Cookies (+10)', 'effect': 'heal', 'value': 10})

  call repo.add(1, {'label': 'Smelly garbage stuff (10 dmg)', 'effect': 'damage', 'value': 15})

	return repo
endfunction
