let s:RepositoryClass = {}

function! vimcastle#repository#create() abort
	let repository = copy(s:RepositoryClass)
	let repository.totalprobabilities = 0
	let repository.items = []
	let repository.namedItems = {}
	return repository
endfunction

function! vimcastle#repository#single(item) abort
	return vimcastle#repository#create().add(1, a:item)
endfunction

function! s:RepositoryClass.add(probability, item) dict abort
	return self.additem(a:probability, a:item, 0)
endfunction

function! s:RepositoryClass.once(probability, item) dict abort
	return self.additem(a:probability, a:item, 1)
endfunction

function! s:RepositoryClass.named(name, item) dict abort
	let self.namedItems[a:name] = a:item
	return self
endfunction

function! s:RepositoryClass.additem(probability, item, once) dict abort
	call add(self.items, { 'value': a:item, 'probability': a:probability, 'once': a:once })
	let self.totalprobabilities += a:probability
	return self
endfunction

function! s:RepositoryClass.rnd() dict abort
	if(!len(self.items))
		throw 'No items in the repository'
	endif
	let roll = vimcastle#utils#rnd(self.totalprobabilities)
	let i = 0
	let probability = 0
	while(i < len(self.items))
		let item = self.items[i]
		let probability += item.probability
		if(roll < probability)
			if(item.once)
				call remove(self.items, i)
				let self.totalprobabilities -= item.probability
			endif
			return item.value
		endif
		let i += 1
	endwhile
	throw 'No items matched the given rnd. Roll: "' . roll . '", Total: ' . self.totalprobabilities
endfunction

function! s:RepositoryClass.getNamed(name) dict abort
	if(!len(keys(self.namedItems)))
		throw 'No named items in this repository'
	endif
	if(!has_key(self.namedItems, a:name))
		throw 'No named item found with name  "' . a:name . '" in this repository'
	endif

	return self.namedItems[a:name]
endfunction
