let s:RepositoryClass = {}

function! vimcastle#repository#create() abort
	let repository = copy(s:RepositoryClass)
	let repository.totalprobabilities = 0
	let repository.items = []
	return repository
endfunction

function! s:RepositoryClass.add(probability, item) dict abort
	let probability = self.totalprobabilities + a:probability
	call add(self.items, { 'value': a:item, 'probability': probability })
	let self.totalprobabilities = probability
	return self
endfunction

function! s:RepositoryClass.rnd() dict abort
	let roll = vimcastle#utils#rnd(self.totalprobabilities)
	let i = 0
	while(i < len(self.items))
		let item = self.items[i]
		if(roll < item.probability)
			return item.value
		endif
		let i += 1
	endwhile
endfunction
