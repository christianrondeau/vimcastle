let s:StoryClass = {}

function! vimcastle#story#create() abort
	let instance = copy(s:StoryClass)
	call instance.clear()
	return instance
endfunction

function! s:StoryClass.clear() dict abort
endfunction
