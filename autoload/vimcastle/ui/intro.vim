function! vimcastle#ui#intro#draw(screen, state) abort
	call s:drawframe(a:screen, [
		\ '__   ___',
		\ '\ \ /  /',
		\ ' \ v  / ',
		\ '  \  /  ',
		\ '   \/   ',
		\ '        ',
		\ '        ',
		\ '        ',
		\ '        '
		\])

	call s:drawframe(a:screen, [
		\ '__   _____  ',
		\ '\ \ /  / |  ',
		\ ' \ v  /| |  ',
		\ '  \  / | |  ',
		\ '   \/  |/   ',
		\ '            ',
		\ '            ',
		\ '            ',
		\ '            '
		\])

	call s:drawframe(a:screen, [
		\ '__   ______    __ ',
		\ '\ \ /  / | \  /  |',
		\ ' \ v  /| |  \/   |',
		\ '  \  / | ||\__/| |',
		\ '   \/  |//     |/ ',
		\ '                  ',
		\ '                  ',
		\ '                  ',
		\ '                  '
		\])

	call s:drawframe(a:screen, [
		\ '__   ______    __ ',
		\ '\ \ /  / | \  /  |',
		\ ' \ v  /| |  \/   |',
		\ '  \  / | ||\__/| |',
		\ '   \/  |//     |/ ',
		\ '                  ',
		\ ' C  A  S  T  L  E ',
		\ '                  ',
		\ '                  ',
		\])

	call s:drawframe(a:screen, [
		\ '__   ______    __ ',
		\ '\ \ /  / | \  /  |',
		\ ' \ v  /| |  \/   |',
		\ '  \  / | ||\__/| |',
		\ '   \/  |//     |/ ',
		\ '                  ',
		\ ' C  A  S  T  L  E ',
		\ '                  ',
		\ '      <start>     '
		\])
endfunction

function! s:drawframe(screen, img) abort
	redraw
	sleep 200m
	silent %delete
	call vimcastle#ui#common#drawscreencenter(a:screen, a:img)
endfunction
