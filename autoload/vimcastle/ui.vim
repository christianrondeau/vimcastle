" Initialization {{{

let s:screen = {}
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
	let s:screen.width = a:width
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

	call vimcastle#ui#fight#draw(s:screen, a:state)

	normal! gg
	setlocal nomodifiable
endfunction

" }}}
