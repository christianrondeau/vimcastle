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

	let self.mappings[a:key] = a:fn
	call add(self.display, {
		\  'key': a:key,
		\  'label': a:label
		\})
endfunction

function! s:BindingsClass.addDefault(label, fn) dict abort
	let self.mappings['any'] = a:fn
endfunction

function! s:BindingsClass.clear() dict abort
	let self.display = []
	let self.mappings = {}
endfunction

function! s:BindingsClass.invokeByKey(key, state) dict abort
	if(has_key(self.mappings, a:key))
		let l:Fn = self.mappings[a:key]
		call l:Fn(a:state)
		return 1
	endif
endfunction

function! s:BindingsClass.invokeDefault(state) dict abort
	return self.invokeByKey('any', a:state)
endfunction

function! s:noop(state) abort
endfunction
