function! vimcastle#screens#common#drawtitle(screen, title) abort
	call setline(line('$'), s:getcentered(a:screen.width, a:title, '-'))
		call append(line('$'), '')
endfunction

function! vimcastle#screens#common#drawcenter(screen, text) abort
	call append(line('$'), s:getcentered(a:screen.width, a:text, ' '))
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

function! vimcastle#screens#common#drawscreencenter(screen, img) abort
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

function! vimcastle#screens#common#getbar(barwidth, val, max, char) abort
	if(a:val > 0 && a:max > 0)
		let filled = (a:val > a:max ? a:max : a:val) * a:barwidth / a:max
	else
		let filled = 0
	endif
	let bar = '[' . repeat(a:char, filled) . repeat(' ', a:barwidth - filled) . ']'
	return bar
endfunction

function! vimcastle#screens#common#drawlog(log) abort
	let i = 0
	while(i < len(a:log))
		let entry = a:log[i]
		if(type(entry) == 1)
			call append(line('$'), entry)
		elseif(type(entry) == 3)
			for line in entry
				call append(line('$'), line)
			endfor
		else
			throw 'Invalid log entry: ' . string(entry)
		endif
		call append(line('$'), '')
		let i += 1
	endwhile
endfunction
