let s:ActionsClass = {}

function! vimcastle#actions#create() abort
	let instance = copy(s:ActionsClass)
	call instance.clear()
	return instance
endfunction

function! s:ActionsClass.addNoop(key, label) dict abort
	call self.add(a:key, a:label, function('s:noop'))
endfunction

function! s:ActionsClass.add(key, label, fn) dict abort
	call add(self.items, {
		\  'key': a:key,
		\  'label': a:label,
		\  'fn': a:fn,
		\})
endfunction

function! s:ActionsClass.addDefault(label, fn) dict abort
	call self.add('any', a:label, a:fn)
endfunction

function! s:ActionsClass.clear() dict abort
	let self.items = []
endfunction

function! s:ActionsClass.getByKey(key) dict abort
	let i = 0
	while i < len(self.items)
		let item = self.items[i]
		if(item.key ==# a:key)
			return item
		endif
		let i += 1
	endwhile
endfunction

function! s:ActionsClass.invokeByKey(key, state) dict abort
	let item = self.getByKey(a:key)
	if(type(item) == 4) " is dict
		call item.fn(a:state)
		return 1
	endif
endfunction

function! s:ActionsClass.invokeDefault(state) dict abort
	return self.invokeByKey('any', a:state)
endfunction

function! s:noop(state) abort
endfunction
