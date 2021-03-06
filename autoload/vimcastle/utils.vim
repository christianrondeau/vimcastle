let s:rndseed = localtime() % 0x10000

function! vimcastle#utils#setnextrnd(n) abort
	let t = type(a:n)
	if(t == 0)
		let s:nextrnd = [a:n]
	elseif(t == 3)
		let s:nextrnd = a:n
	else
		throw 'Invalid rnd: ' . t
	endif
endfunction

function! vimcastle#utils#resetrnd() abort
	if(exists('s:nextrnd'))
		unlet s:nextrnd
	endif
endfunction

function! vimcastle#utils#rnd(n) abort
	if(exists('s:nextrnd'))
		let v = s:nextrnd[0]
		if(len(s:nextrnd) > 1)
			let s:nextrnd = s:nextrnd[1:]
		endif
		if(v >= a:n)
			let v = a:n - 1
		endif
		return v
	endif

	let s:rndseed = (s:rndseed * 31421 + 6927) % 0x10000
	return s:rndseed * a:n / 0x10000
endfunction

function! vimcastle#utils#oneof(list) abort
	return a:list[vimcastle#utils#rnd(len(a:list))]
endfunction

" Saving {{{

function! vimcastle#utils#copydatatodict(obj, ...) abort
	let except = []
	if(a:0 >= 1)
		let except = a:1
	endif
	let data = {}
	for key in keys(a:obj)
		if(index(except, key) == -1 && type(a:obj[key]) != 2)
			let data[key] = a:obj[key]
		endif
	endfor
	return data
endfunction

function! vimcastle#utils#copydatafromdict(obj, data, ...) abort
	let except = []
	if(a:0 >= 1)
		let except = a:1
	endif
	for key in keys(a:data)
		if(index(except, key == -1))
			let a:obj[key] = a:data[key]
		endif
	endfor
endfunction

" }}}
