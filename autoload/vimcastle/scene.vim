let s:SceneClass = {}

function! vimcastle#scene#create() abort
	let scene = copy(s:SceneClass)
	let scene.events = vimcastle#repository#create()
	return scene
endfunction

function! vimcastle#scene#loadintro(story) abort
	return vimcastle#scene#load(a:story, 'intro')
endfunction

function! vimcastle#scene#load(story, name) abort
	let scene = vimcastle#scene#create()
	let scene.story = a:story
	let scene.name = a:name
	execute 'call vimcastle#stories#' . a:story . '#' . a:name . '#index#load(scene)'
	if(!exists('scene.info.label'))
		throw 'Scene ' . a:story . '/' . a:name . ' does not define a "info.label"'
	endif
	if(!exists('scene.enter'))
		throw 'Scene ' . a:story . '/' . a:name . ' does not define the "enter" event'
	endif
	return scene
endfunction
