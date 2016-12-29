" Initialization {{{

let s:winnr = -1
let s:screen = {}
let s:laststate = {}

function! vimcastle#ui#init() abort
	call s:opengamebuffer()
	call vimcastle#ui#updatescreen()
endfunction

function! vimcastle#ui#updatescreen() abort
	let s:screen.width = winwidth(0)
	let s:screen.height = winheight(0)
endfunction

" }}}

" Buffer setup {{{

function! s:opengamebuffer() abort
	let s:winnr = bufwinnr('^game.vimcastle$')
	if (s:winnr >= 0)
		execute s:winnr . 'wincmd w'
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
		autocmd VimResized <buffer> call vimcastle#ui#updatescreen()
	augroup END
endfunction

function! s:isingamebuffer() abort
	return winnr() == s:winnr
endfunction

" }}}

" Drawing {{{

function! vimcastle#ui#redraw() abort
	call vimcastle#ui#draw(s:laststate)
endfunction

function! vimcastle#ui#draw(state) abort
	let s:laststate = a:state
	if(!s:isingamebuffer()) | return | endif

	setlocal modifiable
	normal! ggdG

	call vimcastle#ui#fight#draw(s:screen, a:state)

	normal! gg
	setlocal nomodifiable
endfunction

" }}}
