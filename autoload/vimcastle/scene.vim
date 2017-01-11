let s:SceneClass = {}

function! vimcastle#scene#create() abort
	let scene = copy(s:SceneClass)
	let scene.weapons = vimcastle#repository#create()
	let scene.events = vimcastle#repository#create()
	let scene.monsters = vimcastle#repository#create()
	return scene
endfunction

function! vimcastle#scene#load(story, name) abort
	let scene = vimcastle#scene#create()
	let scene.story = a:story
	let scene.name = a:name
	execute 'call vimcastle#stories#' . a:story . '#' . a:name . '#load(scene)'
	if(!exists('scene.label'))
		throw 'Scene ' . a:story . '/' . a:name . ' does not define a "label"'
	endif
	if(!exists('scene.enter'))
		throw 'Scene ' . a:story . '/' . a:name . ' does not define the "enter" event'
	endif
	return scene
endfunction
