let s:screen = {}
let s:bufname = 'game.vimcastle'

function! vimcastle#ui#init(dedicated) abort
	call vimcastle#ui#clear()
	call s:opengamebuffer(a:dedicated)
	call vimcastle#ui#updatescreen()
endfunction

function! vimcastle#ui#clear() abort
	let s:screen = {}
endfunction

function! vimcastle#ui#quit(dedicated) abort
	call vimcastle#ui#clear()
	if(s:isingamebuffer())
		if a:dedicated
			qall
		else
			bdelete
		endif
	endif
endfunction

function! vimcastle#ui#updatescreen() abort
	let s:screen.width = winwidth(0)
	let s:screen.height = winheight(0)
endfunction

function! vimcastle#ui#draw(state) abort
	if(!s:isingamebuffer() || !exists('a:state.screen')) | return | endif

	setlocal modifiable
	silent %delete

	execute 'call vimcastle#ui#' . a:state.screen . '#draw(s:screen, a:state)'

	call cursor(1, 1)
	setlocal nomodifiable
endfunction

function! s:opengamebuffer(dedicated) abort
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
		call s:configuregamebuffer(a:dedicated)
		setlocal nomodifiable
	endif
endfunction

function! s:configuregamebuffer(dedicated) abort
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
		if(a:dedicated)
			set laststatus=0
			set noshowcmd

			if has('gui')
				set guioptions-=m  "remove menu bar
				set guioptions-=T  "remove toolbar
			endif

			highlight NonText guifg=bg ctermfg=bg
			highlight EndOfBuffer ctermfg=bg ctermbg=bg
		endif

		call s:global2buf('timeoutlen', '1')
		call s:global2buf('showcmd', '0')
		call s:global2buf('hlsearch', '0')
endfunction

function! s:global2buf(name, value) abort
	let dobackupandapply = 'if(!exists(''g:vimcastle_bak_' . a:name . ''')) | let g:vimcastle_bak_' . a:name . ' = &' . a:name . ' | endif | let &' . a:name . '=' . a:value
	let dorestore = 'if(exists(''g:vimcastle_bak_' . a:name . ''')) | let &' . a:name . ' = g:vimcastle_bak_' . a:name . ' | unlet g:vimcastle_bak_' . a:name . ' | endif'

	execute 'augroup Vimcastle_ui_' . a:name
	autocmd!
	execute 'autocmd BufEnter <buffer> ' . dobackupandapply
	execute 'autocmd BufLeave,BufDelete <buffer> ' . dorestore
	execute 'augroup END'

	execute dobackupandapply
endfunction

function! s:isingamebuffer() abort
	return bufname('') == s:bufname
endfunction

