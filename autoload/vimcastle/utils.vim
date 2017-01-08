let s:rndseed = localtime() % 0x10000
let s:_ = {}

function! vimcastle#utils#get() abort
	return s:_
endfunction

function! s:_.rnd(n) dict abort
	let s:rndseed = (s:rndseed * 31421 + 6927) % 0x10000
	return s:rndseed * a:n / 0x10000
endfunction

function! s:_.oneof(list) dict abort
	return a:list[s:_.rnd(len(a:list))]
endfunction
