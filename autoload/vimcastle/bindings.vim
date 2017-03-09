let s:BindingsClass = {}

function! vimcastle#bindings#create() abort
	let instance = copy(s:BindingsClass)
	call instance.clear()
	return instance
endfunction

function! s:BindingsClass.add(name, key, label) dict abort
	call add(self.display, {
		\  'name': a:name,
		\  'key': a:key,
		\  'label': a:label
		\})
endfunction

function! s:BindingsClass.addDefault() dict abort
	let self.default = 1
endfunction

function! s:BindingsClass.clear() dict abort
	let self.display = []
endfunction

function! s:BindingsClass.invokeByKey(key, state) dict abort
	if(exists('self.default'))
		execute 'call vimcastle#state#' . a:state.screen . '#action("", a:state)'
		return 1
	endif

	" TODO: Rename display
	for binding in self.display
		if(binding.key ==# a:key)

			execute 'call vimcastle#state#' . a:state.screen . '#action(binding.name, a:state)'
			return 1
		endif
	endfor
	return 0
endfunction

function! s:BindingsClass.invokeDefault(state) dict abort
	return self.invokeByKey('', a:state)
endfunction
