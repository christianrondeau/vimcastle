function! vimcastle#ui#common#drawtitle(screen, title) abort
	call setline(1, s:getcentered(a:screen.width, a:title, '-'))
	call append(line('$'), '')
endfunction

function! s:getcentered(width, title, pad) abort
	let titlew = strlen(a:title) + 2
	let leftw = (a:width / 2) - (titlew / 2)
	let rightw = a:width - leftw - titlew
	let line = repeat(leftw, a:pad) . ' ' . a:title . ' ' . repeat(rightw, a:pad)
	return line
endfunction
