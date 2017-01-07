
function! vimcastle#character#create(longname, shortname, health)
	let character = {
		\ 'name': {
			\ 'long': a:longname,
			\ 'short': a:shortname
		\ },
		\ 'health': {
			\ 'current': a:health,
			\ 'max': a:health
			\ }
		\ }
	return character
endfunction
