" Initialization {{{

let s:w = -1
let s:laststate = {}

function! vimcastle#ui#init() abort
	call s:opengamebuffer()
	call vimcastle#ui#setscreenwidth(winwidth(0))
endfunction

function! vimcastle#ui#updatescreenwidth() abort
	call vimcastle#ui#setscreenwidth(winwidth(0))
	call vimcastle#ui#redraw()
endfunction

function! vimcastle#ui#setscreenwidth(width) abort
	let s:w = a:width
endfunction

" }}}

" Buffer setup {{{

let s:winnr = -1

function! s:opengamebuffer() abort
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
		call s:configuregamebuffer()
		setlocal nomodifiable
	endif
endfunction

function! s:configuregamebuffer() abort
		setlocal filetype=vimcastle
		setlocal foldcolumn=0
		setlocal noswapfile
		setlocal nonumber
		setlocal norelativenumber
		setlocal noshowmatch
		setlocal nolist
		setlocal wrap
		setlocal colorcolumn=
		setlocal statusline=
		setlocal nocursorline
		augroup Vimcastle
		autocmd!
		autocmd VimResized <buffer> call vimcastle#ui#updatescreenwidth()
	augroup END
endfunction

" }}}

" Drawing {{{

function! vimcastle#ui#redraw() abort
	call vimcastle#ui#draw(s:laststate)
endfunction

function! vimcastle#ui#draw(state) abort
	let s:laststate = a:state
	setlocal modifiable
	normal! ggdG

	call s:drawtitle("Fight!")
	call s:drawsides(a:state.player.name.short,a:state.enemy.name.short)
	call s:drawbars(a:state.player.health, a:state.enemy.health, '-')
	call s:drawactions(a:state.actions)

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
	if(a:val > 0 && a:max > 0)
		let filled = a:val * barwidth / a:max
	else
		let filled = 0
	endif
	let bar = "[" . repeat(a:char, filled) . repeat(" ", barwidth - filled) . "]"
	return bar
endfunction

function! s:drawactions(actions) abort
	let i = 0
	while(i < len(a:actions))
		let action = a:actions[i]
		execute "normal! i" . (i+1) . ") " . action.name
		normal! o
		let i += 1
	endwhile
endfunction

" }}}
