function! vimcastle#stories#main#plains#monsters#register(monsters) abort
	call a:monsters.add('rat', 10, function('s:rat'))
	call a:monsters.add('ogre', 2, function('s:ogre'))
endfunction

function! s:rat()
	return vimcastle#character#create('Rat', 'Rat', 8, vimcastle#weapon#create('claw', 1, 2))
endfunction

function! s:ogre()
	return vimcastle#character#create('Ogre', 'Ogre', 50, vimcastle#weapon#create('club', 2, 4))
endfunction
