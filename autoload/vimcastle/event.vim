let s:EventClass = {}

function! vimcastle#event#create(name) abort
	let event = copy(s:EventClass)
	let event.name = a:name
	let event.texts = []
	return event
endfunction

function! s:EventClass.text(texts) dict abort
	call add(self.texts, type(a:texts) == 1 ? [a:texts] : a:texts)
	return self
endfunction

function! s:EventClass.explore(text) dict abort
	let self.action_explore_text = a:text
	return self
endfunction

function! s:EventClass.fight(text, monsters) dict abort
	let self.monsters = a:monsters
	let self.action_fight_text = a:text
	return self
endfunction

function! s:EventClass.enterscene(text, scene) dict abort
	let self.nextscene = a:scene
	let self.action_enterscene_text = a:text
	return self
endfunction

function! s:EventClass.effect(fn) dict abort
	call vimcastle#utils#validate(a:fn, 2)
	let self.effect_fn = a:fn
	return self
endfunction

function! s:EventClass.invoke(state) dict abort
	if(exists('self.monsters'))
		let a:state.enemy = self.monsters.rnd().invoke()
	endif
	if(exists('self.effect_fn'))
		try
			call self.effect_fn(a:state)
		catch
			throw 'There was an error in effect of ' . a:state.scene.story . '/' . a:state.scene.name . '/' . self.name . ': ' . v:exception
		endtry
	endif

	let a:state.log = []
	for lineoptions in self.texts
		let line = vimcastle#utils#oneof(lineoptions)
		call add(a:state.log, a:state.msg(line))
	endfor

	call a:state.actions.clear()
	if(exists('self.action_fight_text'))
		call a:state.actions.add('f', self.action_fight_text, function('s:action_fight'))
	endif
	if(exists('self.action_enterscene_text'))
		" NOTE: Cannot use arglist in 7.4
		" call a:state.actions.add('e', self.action_enterscene_text, function('s:action_enterscene', [self.nextscene]))
		let a:state.nextscene = self.nextscene
		call a:state.actions.add('e', self.action_enterscene_text, function('s:action_enterscene'))
	endif
	if(exists('self.action_explore_text'))
		call a:state.actions.add('c', self.action_explore_text, function('s:action_explore'))
	endif
endfunction

function! s:action_explore(state)
	let a:state.stats.events += 1
	let result = a:state.scene.events.rnd().invoke(a:state)
endfunction

function! s:action_fight(state)
	let a:state.stats.fights += 1
	let a:state.nextaction = function('s:action_explore')
	call a:state.enter('fight')
endfunction

function! s:action_enterscene(state)
	let a:state.stats.scenes += 1
	let a:state.scene = vimcastle#scene#load(a:state.scene.story, a:state.nextscene)
	call a:state.scene.enter.invoke(a:state)
endfunction

