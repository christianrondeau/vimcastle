let s:StoryClass = {}

function! vimcastle#story#create() abort
	let story = copy(s:StoryClass)
	return story
endfunction

function! vimcastle#story#load(name) abort
	let story = vimcastle#story#create()
	let story.name = a:name
	return story
endfunction

function! s:StoryClass.begin(state) dict abort
	execute 'call vimcastle#stories#' . self.name. '#index#begin(a:state)'
endfunction
