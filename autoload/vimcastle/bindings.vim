let s:BindingsClass = {}

" TODO: Rename actions"
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
	return self
endfunction

function! s:BindingsClass.addDefault() dict abort
	let self.default = 1
	return self
endfunction

function! s:BindingsClass.clear() dict abort
	let self.default = 0
	let self.display = []
	return self
endfunction

function! s:BindingsClass.keyToName(key) dict abort
	if(self.default)
		return 'default'
	endif

	for binding in self.display
		if(binding.key ==# a:key)
			return binding.name
		endif
	endfor
	return ''
endfunction
