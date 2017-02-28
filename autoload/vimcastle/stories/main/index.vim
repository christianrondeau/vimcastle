function! vimcastle#stories#main#index#load(state) abort
	return vimcastle#stories#main#intro#index#load(a:state)
endfunction

function! vimcastle#stories#main#index#scenes() abort
	return [
				\ 'plains',
				\ 'forest',
				\]
endfunction
