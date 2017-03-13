let s:scriptnames = {}

function! callstack#init() abort
	let s:scriptnames = s:getscriptnames()
endfunction

function! callstack#rethrow(exception, throwpoint) abort
	echom 'ERR: ' . a:exception
	for line in callstack#parse(a:exception, a:throwpoint)
		echom '  ' . line
	endfor
	return 'ERR: ' . a:exception
endfunction

function! callstack#parse(exception, throwpoint) abort
	let originalstack = split(a:throwpoint, '\.\.')
	let result = []
	for originalline in originalstack
		if(s:tryparsesnr(result, originalline))
		elseif(s:tryparsedictfunc(result, originalline))
		else
			call add(result, originalline)
		endif
	endfor
	return result
endfunction

function! s:getscriptnames()
	redir => l:scriptnames
	silent! scriptnames
	redir END
	
	let l:scriptspersnr = {}
	for l:scriptname in split(l:scriptnames, "\n")
		let l:scriptsnr = split(l:scriptname, ":")
		let l:scriptspersnr[l:scriptsnr[0]] = substitute(l:scriptsnr[1], '\v^ ', '', 'e')
	endfor
	return l:scriptspersnr
endfunction

function! s:tryparsesnr(result, throwline)
	let snr = matchstrpos(a:throwline, '\v\<SNR\>[0-9]+')
	if(snr[0] != '')
		let snrval = snr[0][5:]
		let line = has_key(s:scriptnames, snrval) ? s:scriptnames[snrval] : ('(unknown script: ' . snrval . ')')
		let line .= ' s:' . a:throwline[snr[2]+1:]
		call add(a:result, line)
		return 1
	endif
endfunction

function! s:tryparsedictfunc(result, throwline)
	let l:fnid = ''

	if(l:fnid == '')
		let num = matchstrpos(a:throwline, '\vfunction [0-9]+')
		if(num[0] != '')
			let l:fnid = str2nr(num[0][9:])
		endif
	endif

	if(l:fnid == '')
		let num = matchstrpos(a:throwline, '\v^[0-9]+')
		if(num[0] != '')
			let l:fnid = str2nr(num[0])
		endif
	endif

	if(l:fnid == '')
		return 0
	endif

	redir => l:fnref
	execute 'silent! verbose function {' . l:fnid . '}'
	redir END
	let l:fnreflines = split(l:fnref, "\n")
	let l:lastset = l:fnreflines[1]
	let l:lastset = l:lastset[matchend(l:lastset, 'Last set from '):]
	let l:fnref = join([l:fnreflines[0]] + l:fnreflines[2:], ' | ')
	let l:fnref = substitute(l:fnref, '\v(\t+| +)', ' ', 'ge')
	let l:fnref = substitute(l:fnref, '\v^[\t ]', '', 'e')
	call add(a:result, l:lastset . ' ' . l:fnref[0:60] . '...')
endfunction
