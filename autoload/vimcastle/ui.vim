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
		" highlight NonText guifg=bg
		" highlight EndOfBuffer ctermfg=bg ctermbg=bg

		call s:global2buf('timeoutlen', '1')
		call s:global2buf('showcmd', '0')
		call s:global2buf('hlsearch', '0')

		augroup Vimcastle_ui
			autocmd!
			autocmd VimResized <buffer> call vimcastle#ui#updatescreen() | call vimcastle#ui#redraw()
		augroup END
endfunction

function! s:global2buf(name, value) abort
	let dobackupandapply = 'if(!exists("g:vimcastle_bak_' . a:name . '")) | let g:vimcastle_bak_' . a:name . ' = &' . a:name . ' | endif | let &' . a:name . '=' . a:value
	let dorestore = 'if(exists("g:vimcastle_bak_' . a:name . '")) | let &' . a:name . ' = g:vimcastle_bak_' . a:name . ' | unlet g:vimcastle_bak_' . a:name . ' | endif'

	execute "augroup Vimcastle_ui_" . a:name
	autocmd!
	execute 'autocmd BufEnter <buffer> ' . dobackupandapply
	execute 'autocmd BufLeave,BufDelete <buffer> ' . dorestore
	execute "augroup END"

	execute dobackupandapply
endfunction

function! s:isingamebuffer() abort
	return bufname('') == s:bufname
endfunction

