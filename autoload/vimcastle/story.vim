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
