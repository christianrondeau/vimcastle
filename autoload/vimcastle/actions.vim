let s:BindingsClass = {}

function! vimcastle#bindings#create() abort
	let instance = copy(s:BindingsClass)
	call instance.clear()
	return instance
endfunction

function! s:BindingsClass.addNoop(key, label) dict abort
	call self.add(a:key, a:label, function('s:noop'))
endfunction

function! s:BindingsClass.add(key, label, fn) dict abort
	call vimcastle#utils#validate(a:key, 1)
	call vimcastle#utils#validate(a:label, 1)
	call vimcastle#utils#validate(a:fn, 2)

	call add(self.items, {
		\  'key': a:key,
		\  'label': a:label,
		\  'fn': a:fn,
		\})
endfunction

function! s:BindingsClass.addDefault(label, fn) dict abort
	call self.add('any', a:label, a:fn)
endfunction

function! s:BindingsClass.clear() dict abort
	let self.enabled = 1
	let self.items = []
endfunction

function! s:BindingsClass.getByKey(key) dict abort
	let i = 0
	while i < len(self.items)
		let item = self.items[i]
		if(item.key ==# a:key)
			return item
		endif
		let i += 1
	endwhile
endfunction

function! s:BindingsClass.invokeByKey(key, state) dict abort
	if(!self.enabled)
		return 0
	endif
	let item = self.getByKey(a:key)
	if(type(item) == 4) " is dict
		call item.fn(a:state)
		return 1
	endif
endfunction

function! s:BindingsClass.invokeDefault(state) dict abort
	return self.invokeByKey('any', a:state)
endfunction

function! s:noop(state) abort
endfunction
