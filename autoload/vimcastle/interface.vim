let s:w = -1
let s:winnr = -1

function! vimcastle#interface#init() abort
	call vimcastle#interface#opengamebuffer()
	call vimcastle#interface#setscreenwidth(winwidth(0))
endfunction

function! vimcastle#interface#setscreenwidth(width) abort
	let s:w = a:width
endfunction

function! vimcastle#interface#opengamebuffer() abort
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
		call vimcastle#interface#configuregamebuffer()
		setlocal nomodifiable
	endif
endfunction

function! vimcastle#interface#configuregamebuffer() abort
		setlocal filetype=vimcastle
		setlocal foldcolumn=0
		setlocal noswapfile
		setlocal nonumber
		setlocal norelativenumber
		setlocal noshowmatch
		setlocal nolist
		setlocal wrap
endfunction

function! vimcastle#interface#draw(state) abort
	setlocal modifiable
	normal! ggdG

	let title = " Fight! "
	let titlew = strlen(title)
	let leftw = (s:w / 2) - (titlew / 2)
	let rightw = s:w - leftw - titlew
	execute "normal! " . leftw . "i#"
	execute "normal! a" . title
	execute "normal! " . rightw . "a#"
	execute "normal! o# Player: " . a:state.player.health . ""
	execute "normal! o# Enemy: " . a:state.enemy.health . ""
	execute "normal! oPlayer hits enemy for 1 damage"
	execute "normal! o\e" . s:w . "i#"
	normal! gg
	setlocal nomodifiable
endfunction
