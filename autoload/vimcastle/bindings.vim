let s:BindingsClass = {}

function! vimcastle#bindings#create() abort
	let instance = copy(s:BindingsClass)
	call instance.clear()
	return instance
endfunction

function! s:BindingsClass.add(key, label) dict abort
	call add(self.display, {
		\  'key': a:key,
		\  'label': a:label
		\})
endfunction

function! s:BindingsClass.addDefault(label) dict abort
	call self.add('', a:label)
endfunction

function! s:BindingsClass.clear() dict abort
	let self.display = []
endfunction

function! s:BindingsClass.invokeByKey(key, state) dict abort
	execute 'let result = vimcastle#state#' . a:state.screen . '#action(a:key, a:state)'
	return result
endfunction

function! s:BindingsClass.invokeDefault(state) dict abort
	return self.invokeByKey('', a:state)
endfunction
