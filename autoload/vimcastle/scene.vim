let s:SceneClass = {}

function! vimcastle#scene#create(label) abort
	let scene = copy(s:SceneClass)
	scene.label = label
	let scene.weapons = vimcastle#repository#create()
	let scene.events = vimcastle#repository#create()
	let scene.monsters = repository#create()
	return scene
endfunction
