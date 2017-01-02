let s:rndseed = localtime() % 0x10000

function! vimcastle#utils#rnd(n) abort
	let s:rndseed = (s:rndseed * 31421 + 6927) % 0x10000
	return s:rndseed * a:n / 0x10000
endfunction
