function! vimcastle#screens#actions#draw(bindings) abort
	let i = 0
	while(i < len(a:bindings.display))
		let binding = a:bindings.display[i]
		call append(line('$'), binding.key . ') ' . binding.label)
		let i += 1
	endwhile
endfunction
