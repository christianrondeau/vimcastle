function! vimcastle#levelling#forxp(xp) abort
	let l:jump = 10
	let l:level = 1
	let l:levelxp = 10
	while l:levelxp <= a:xp
		let l:levelxp += jump
		let l:jump += 10
		let l:level += 1
	endwhile
	return [l:level, l:levelxp]
endfunction
