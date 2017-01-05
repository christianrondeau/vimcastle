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
	if(exists("s:laststate"))
		unlet s:laststate
	endif
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
	if(exists("s:laststate"))
		call vimcastle#ui#draw(s:laststate)
	endif
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
		execute 'edit ' . s:bufname

		let l:winnr = winnr()
		setlocal buftype=nofile
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

		" These settings are permanent
		" setlocal noshowcmd
		" setlocal nohlsearch
		" highlight NonText guifg=bg
		" highlight EndOfBuffer ctermfg=bg ctermbg=bg

		augroup Vimcastle_ui
			autocmd!
			autocmd VimResized <buffer> call vimcastle#ui#updatescreen() | call vimcastle#ui#redraw()

			" Prevent mappings like `cs` to interfere with game controls
			autocmd BufEnter <buffer> let g:vimcastle_bak_timeoutlen = &timeoutlen | set timeoutlen=1
			autocmd BufLeave <buffer> let &timeoutlen = g:vimcastle_bak_timeoutlen | unlet g:vimcastle_bak_timeoutlen
		augroup END
endfunction

function! s:isingamebuffer() abort
	return bufname('') == s:bufname
endfunction

