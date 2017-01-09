function! vimcastle#stories#shared#weapons#register(dict) abort
	let dict.club = vimcastle#weapon#monster('club', 1, 4)
	let dict.ratclaw = vimcastle#weapon#ratclaw('claw', 1, 2)

	let dict.rustshortsword = vimcastle#weapon#equippable('rust. short sword', 2, 5)
endfunction
