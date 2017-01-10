let s:SceneClass = {}

function! vimcastle#scene#create(label) abort
	let scene = copy(s:SceneClass)
	let scene.label = a:label
	let scene.weapons = vimcastle#repository#create()
	let scene.events = vimcastle#repository#create()
	let scene.monsters = vimcastle#repository#create()
	return scene
endfunction
