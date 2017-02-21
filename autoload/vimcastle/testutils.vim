let s:VimcastleTestutilsClass = {}

function! vimcastle#testutils#create() abort
	let utils = copy(s:VimcastleTestutilsClass)
	let utils.totalturns = 0
	let utils.playthroughsturns = []
	return utils
endfunction

function! s:VimcastleTestutilsClass.playgames(maxplaythroughs, maxturns) dict abort
	let totalstats = {}
	let totalstats.playthroughs = 0
	let totalstats.turns = 0
	let totalstats.playthroughsturns = []

	while(totalstats.playthroughs < a:maxplaythroughs)
		let totalstats.playthroughs += 1
		let gamestats = self.playgame(a:maxturns)
		let totalstats.turns += gamestats.turns
		call add(totalstats.playthroughsturns, gamestats.turns)
	endwhile

	let totalstats.avgturns = totalstats.turns / a:maxplaythroughs
	return totalstats
endfunction

function! s:VimcastleTestutilsClass.playgame(maxturns) dict abort
	let stats = {}
	let stats.turns = 0
	let stats.log = []

	let state = vimcastle#state#create()
	let state.scene = vimcastle#scene#load('main', 'index')
	call state.enter('explore')
	call state.scene.enter.invoke(state)

	while stats.turns < a:maxturns && state.screen != 'gameover'
		let stats.turns += 1
		call add(stats.log, '---- TURN ' . stats.turns)
		call self.playdefault(state)
		let stats.log += state.log
	endwhile

	return stats
endfunction

function! s:VimcastleTestutilsClass.playdefault(state) dict abort
		let actions = a:state.actions()
		let key = actions.display[0].key
		call actions.invokeByKey(key, a:state)
endfunction
