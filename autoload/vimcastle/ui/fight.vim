function! vimcastle#ui#fight#draw(screen, state) abort
	call vimcastle#ui#common#drawtitle(a:screen, "Fight!")
	call append(line('$'), '')
	call s:drawsides(a:screen, a:state.player.name.short,a:state.enemy.name.short)
	call s:drawbars(a:screen, a:state.player.health, a:state.enemy.health, '-')
	call append(line('$'), '')
	call s:drawactions(a:state.actions)
endfunction

function! s:drawsides(screen, left, right) abort
	let pad = a:screen.width - strlen(a:left) - strlen(a:right) - 2
	call append(line('$'), ' ' . a:left . repeat(' ', pad) . a:right)
endfunction

function! s:drawbars(screen, lefthealth, righthealth, char) abort
	let barwidth = a:screen.width / 2 - 8
	call s:drawsides(
		\ a:screen,
		\ s:getbar(barwidth, a:lefthealth.current, a:lefthealth.max, a:char) .
		\ " " . a:lefthealth.current,
		\ a:righthealth.current . " " . 
		\ s:getbar(barwidth, a:righthealth.current, a:righthealth.max, a:char)
		\ )
endfunction

function! s:getbar(barwidth, val, max, char) abort
	if(a:val > 0 && a:max > 0)
		let filled = a:val * a:barwidth / a:max
	else
		let filled = 0
	endif
	let bar = "[" . repeat(a:char, filled) . repeat(" ", a:barwidth - filled) . "]"
	return bar
endfunction

function! s:drawactions(actions) abort
	let i = 0
	while(i < len(a:actions))
		let action = a:actions[i]
		call append(line('$'), (i+1) . ') ' . action.name)
		let i += 1
	endwhile
endfunction