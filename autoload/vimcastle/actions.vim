let s:ActionsClass = {}

function! vimcastle#actions#create() abort
	let instance = copy(s:ActionsClass)
	let instance.save = function('s:save')
	let instance.load = function('s:load')
	call instance.clear()
	return instance
endfunction

function! s:ActionsClass.add(name, key, label) dict abort
	call add(self.bindings, {
		\  'name': a:name,
		\  'key': a:key,
		\  'label': a:label
		\})
	return self
endfunction

function! s:ActionsClass.addDefault() dict abort
	let self.default = 1
	return self
endfunction

function! s:ActionsClass.clear() dict abort
	let self.default = 0
	let self.bindings = []
	return self
endfunction

function! s:ActionsClass.keyToName(key) dict abort
	if(self.default)
		return 'default'
	endif

	for binding in self.bindings
		if(binding.key ==# a:key)
			return binding.name
		endif
	endfor
	return ''
endfunction

function! s:ActionsClass.names() dict abort
	if(self.default)
		return ['default']
	endif

	let names = []
	for binding in self.bindings
		call add(names, binding.name)
	endfor
	return names
endfunction

function! s:ActionsClass.keys() dict abort
	if(self.default)
		return ['default']
	endif

	let keys = []
	for binding in self.bindings
		call add(keys, binding.key)
	endfor
	return keys
endfunction

" Save {{{

function! s:save() abort dict
	return vimcastle#utils#copydatatodict(self)
endfunction

function! s:load(data) abort dict
	call vimcastle#utils#copydatafromdict(self, a:data)
endfunction

" }}}
