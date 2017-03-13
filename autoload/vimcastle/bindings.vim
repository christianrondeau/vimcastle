let s:BindingsClass = {}

function! vimcastle#bindings#create() abort
	let instance = copy(s:BindingsClass)
	call instance.clear()
	return instance
endfunction

function! vimcastle#bindings#default() abort
	let instance = vimcastle#bindings#create()
	call instance.addDefault()
	return instance
endfunction

function! s:BindingsClass.add(name, key, label) dict abort
	call add(self.display, {
		\  'name': a:name,
		\  'key': a:key,
		\  'label': a:label
		\})
	return self
endfunction

function! s:BindingsClass.addDefault() dict abort
	let self.default = 1
	return self
endfunction

"TODO: This will become useless
function! s:BindingsClass.clear() dict abort
	let self.display = []
endfunction

function! s:BindingsClass.keyToName(key) dict abort
	if(exists('self.default'))
		return 'default'
	endif

	for binding in self.display
		if(binding.key ==# a:key)
			return binding.name
		endif
	endfor
	return ''
endfunction

"TODO: Remove this
function! s:BindingsClass.invokeByKey(key, state) dict abort
	if(exists('self.default'))
		execute 'call vimcastle#states#' . a:state.screen . '#action("", a:state)'
		return 1
	endif

	" TODO: Rename display
	for binding in self.display
		if(binding.key ==# a:key)

			execute 'call vimcastle#states#' . a:state.screen . '#action(binding.name, a:state)'
			return 1
		endif
	endfor
	return 0
endfunction

function! s:BindingsClass.invokeDefault(state) dict abort
	return self.invokeByKey('', a:state)
endfunction
