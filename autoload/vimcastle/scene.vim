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
	return scene
endfunction

function! s:SceneClass.addevent() dict abort
	return vimcastle#event#create()
endfunction
