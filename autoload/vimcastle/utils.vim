let s:rndseed = localtime() % 0x10000
let s:nextrnd = -1
let s:_ = {}

function! vimcastle#utils#get() abort
	return s:_
endfunction

function! s:_.setnextrnd(n) dict abort
	let s:nextrnd = a:n
endfunction

function! s:_.rnd(n) dict abort
	if(s:nextrnd >= 0)
		let v = s:nextrnd
		let s:nextrnd = -1
		return v
	endif
	let s:rndseed = (s:rndseed * 31421 + 6927) % 0x10000
	return s:rndseed * a:n / 0x10000
endfunction

function! s:_.oneof(list) dict abort
	return a:list[s:_.rnd(len(a:list))]
endfunction
