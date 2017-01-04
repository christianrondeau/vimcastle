let s:screen = {}
let s:laststate = {}
let s:bufname = 'game.vimcastle'

function! vimcastle#ui#init() abort
	call vimcastle#ui#clear()
	call s:opengamebuffer()
	call vimcastle#ui#updatescreen()
endfunction

function! vimcastle#ui#clear() abort
	let s:screen = {}
	let s:laststate = {}
endfunction

function! vimcastle#ui#quit() abort
	call vimcastle#ui#clear()
	if(s:isingamebuffer())
		bdelete
	endif
endfunction

function! vimcastle#ui#updatescreen() abort
	let s:screen.width = winwidth(0)
	let s:screen.height = winheight(0)
endfunction

function! vimcastle#ui#redraw() abort
	call vimcastle#ui#draw(s:laststate)
endfunction

function! vimcastle#ui#draw(state) abort
	let s:laststate = a:state
	if(!s:isingamebuffer()) | echom 'Wrong buffer!' | return | endif

	setlocal modifiable
	silent %delete

	execute 'call vimcastle#ui#' . a:state.screen . '#draw(s:screen, a:state)'

	call cursor(1, 1)
	setlocal nomodifiable
endfunction

function! s:opengamebuffer() abort
	let l:winnr = bufwinnr('^' . s:bufname . '$')
	if (l:winnr >= 0)
		execute l:winnr . 'wincmd w'
		setlocal modifiable
		silent %delete
		setlocal nomodifiable
	else
		execute 'new ' . s:bufname
		let l:winnr = winnr()
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
		autocmd VimResized <buffer> call vimcastle#ui#updatescreen()
	augroup END
endfunction

function! s:isingamebuffer() abort
	return bufname('') == s:bufname
endfunction

