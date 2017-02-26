function! vimcastle#stories#main#intro#items#get() abort
	let repo = vimcastle#repository#create()

  call repo.add(1, {'label': 'Travel cookies', 'effect': 'heal', 'value': 5})
  call repo.add(3, {'label': 'Small healing potion', 'effect': 'heal', 'value': 10})

	return repo
endfunction
