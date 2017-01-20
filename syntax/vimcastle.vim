if exists('b:current_syntax')
	finish
endif

" Title: --- something ---
syntax match vimcastleTitle "\v^-+.*-+$"
highlight link vimcastleTitle Type

" Menu: 1) something
syntax match vimcastleMenu "\v^.\)"
highlight link vimcastleMenu Operator

" Objects: <something>
syntax region vimcastleObject start=/\v\</ end=/\v\>/
highlight link vimcastleObject String

" Bars: [---   ]
syntax region vimcastleBar start=/\v\[/ end=/\v\]/
highlight link vimcastleBar Error


let b:current_syntax = 'vimcastle'

