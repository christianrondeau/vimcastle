function! vimcastle#stories#main#plains#items#get() abort
	let repo = vimcastle#repository#create()
  call repo.add(1, {'label': 'Travel cookies', 'effect': function('vimcastle#effects#heal'), 'value': 5})
  call repo.add(3, {'label': 'Small healing potion', 'effect': function('vimcastle#effects#heal'), 'value': 10})
  call repo.add(1, {'label': 'Small healing kit', 'effect': function('vimcastle#effects#heal'), 'value': 15})
	return repo
endfunction
