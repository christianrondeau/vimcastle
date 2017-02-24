function! vimcastle#stories#main#plains#items#get() abort
	let repo = vimcastle#repository#create()

  call repo.add(1, {'label': 'Travel cookies', 'effect': 'heal', 'value': 5})
  call repo.add(3, {'label': 'Small healing potion', 'effect': 'heal', 'value': 10})
  call repo.add(1, {'label': 'Small healing kit', 'effect': 'heal', 'value': 15})

  call repo.add(1, {'label': 'Scroll of minor constitution', 'effect': 'gainhealth', 'value': 5})
  call repo.add(1, {'label': 'Scroll of minor strength', 'effect': 'gainstr', 'value': 5})

	return repo
endfunction
