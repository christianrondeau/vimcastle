let s:w = -1
let s:winnr = -1

function! vimcastle#ui#init() abort
	call vimcastle#ui#opengamebuffer()
	call vimcastle#ui#setscreenwidth(winwidth(0))
endfunction

function! vimcastle#ui#setscreenwidth(width) abort
	let s:w = a:width
endfunction

function! vimcastle#ui#opengamebuffer() abort
	let s:winnr = bufwinnr('^game.vimcastle$')
	if (s:winnr >= 0)
		execute winnr . 'wincmd w'
		setlocal modifiable
		normal! ggdG
		setlocal nomodifiable
	else
		execute 'new game.vimcastle'
		let s:winnr = winnr()
		setlocal buftype=nofile
		setlocal bufhidden=wipe
		call vimcastle#ui#configuregamebuffer()
		setlocal nomodifiable
	endif
endfunction

function! vimcastle#ui#configuregamebuffer() abort
		setlocal filetype=vimcastle
		setlocal foldcolumn=0
		setlocal noswapfile
		setlocal nonumber
		setlocal norelativenumber
		setlocal noshowmatch
		setlocal nolist
		setlocal wrap
endfunction

function! vimcastle#ui#draw(state) abort
	setlocal modifiable
	normal! ggdG

	call s:drawtitle("Fight!")
	call s:drawsides(a:state.player.name.short,a:state.enemy.name.short)
	call s:drawbars(a:state.player.health, a:state.enemy.health, '-')
	call s:drawactions()

	normal! gg
	setlocal nomodifiable
endfunction

function! s:drawtitle(title) abort
	let titlew = strlen(a:title) + 2
	let leftw = (s:w / 2) - (titlew / 2)
	let rightw = s:w - leftw - titlew
	execute "normal! " . leftw . "i-"
	execute "normal! a " . a:title . " "
	execute "normal! " . rightw . "a-"
	normal! 2o
endfunction

function! s:drawsides(left, right) abort
	let pad = s:w - strlen(a:left) - strlen(a:right) - 3
	execute "normal! i " . a:left
	execute "normal! " . pad . "A "
	execute "normal! A " . a:right
	normal! o
endfunction

function! s:drawbars(lefthealth, righthealth, char) abort
	call s:drawsides(
				\ s:getbar(a:lefthealth.current, a:lefthealth.max, a:char) . " " . a:lefthealth.current,
				\ a:righthealth.current . " " . s:getbar(a:righthealth.current, a:righthealth.max, a:char)
				\ )
	normal! o
endfunction

function! s:getbar(val, max, char) abort
	let barwidth = s:w / 2 - 8
	let filled = a:val * barwidth / a:max
	let bar = "[" . repeat(a:char, filled) . repeat(" ", barwidth - filled) . "]"
	return bar
endfunction

function! s:drawactions() abort
	normal! i1) Attack
	normal! o
endfunction
