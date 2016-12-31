function! vimcastle#ui#intro#draw(screen, state) abort
	let frame = [
		\ ' __   ______    __ ',
		\ ' \ \ /  / | \  /  |',
		\ '  \ v  /| |  \/   |',
		\ '   \  / | ||\__/| |',
		\ '    \/  |//     |/ ',
		\ '                   ',
		\ '  C  A  S  T  L  E '
		\]
	call s:drawcenter(a:screen, frame)
endfunction

function! s:drawcenter(screen, img)
	let w = strlen(a:img[0])
	let h = len(a:img)
	let y = (a:screen.height / 2) - (h / 2)
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

