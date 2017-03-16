if exists('b:current_syntax')
	finish
endif

" Title: --- something ---
syntax match vimcastleTitle "\v^-+.*-+$"
highlight link vimcastleTitle Type

" Menus: 1) something
syntax match vimcastleMenu "\v^.\)"
highlight link vimcastleMenu Operator

" Objects: <something>
syntax region vimcastleObject start=/\v\</ end=/\v\>/
highlight link vimcastleObject String

" Details: (something)
syntax region vimcastleDetails start=/\v\(/ end=/\v\)/
highlight link vimcastleDetails Comment

" Partial Bars: [---   ]
syntax match vimcastleBarPartial "\v\[-+ +\]"
highlight link vimcastleBarPartial Constant

" Empty Bars: [      ]
syntax match vimcastleBarEmpty "\v\[ +\]"
highlight link vimcastleBarEmpty Error

" Full Bars: [------]
syntax match vimcastleBarFull "\v\[-+\]"
highlight link vimcastleBarFull String

" Increase: 4 -> 5
syntax match vimcastleBarFull "\v-\> [0-9]+"
highlight link vimcastleBarFull String

let b:current_syntax = 'vimcastle'

