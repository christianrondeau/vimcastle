function! vimcastle#ui#common#drawtitle(screen, title) abort
	call setline(1, s:getcentered(a:screen.width, a:title, '-'))
endfunction

function! s:getcentered(width, title, pad) abort
	let titlew = strlen(a:title) + 2
	if(a:width <= titlew)
		return a:title[0:a:width-1]
	endif
	let leftw = (a:width / 2) - (titlew / 2)
	let rightw = a:width - leftw - titlew
	let line = repeat(a:pad, leftw) . ' ' . a:title . ' ' . repeat(a:pad, rightw)
	return line
endfunction

function! vimcastle#ui#common#drawscreencenter(screen, img) abort
	let w = strlen(a:img[0])
	let h = len(a:img)
	let y = (a:screen.height - h) / 2
	let x = (a:screen.width - w) / 2
	let xpad = repeat(' ', x)
	let i = 0
	while(i < len(a:img))
		call append(i, xpad . a:img[i])
		let i += 1
	endwhile
	while(y > 0)
		call append(0, '')
		let y -= 1
	endwhile
endfunction

