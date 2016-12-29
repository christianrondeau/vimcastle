function! vimcastle#ui#common#drawtitle(screen, title) abort
	let titlew = strlen(a:title) + 2
	let leftw = (a:screen.width / 2) - (titlew / 2)
	let rightw = a:screen.width - leftw - titlew
	execute "normal! " . leftw . "i-"
	execute "normal! a " . a:title . " "
	execute "normal! " . rightw . "a-"
	normal! 2o
endfunction
