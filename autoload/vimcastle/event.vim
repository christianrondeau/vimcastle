let s:EventClass = {}

function! vimcastle#event#create() abort
	let event = copy(s:EventClass)
	let event.texts = []
	return event
endfunction

function! s:EventClass.text(text) dict abort
	call add(self.texts, a:text)
	return self
endfunction

function! s:EventClass.explore(text) dict abort
	let self.explore = a:text
	return self
endfunction

function! s:EventClass.fight(text, monsters) dict abort
	let self.monsters = a:monsters
	let self.fight = a:text
	return self
endfunction

function! s:EventClass.enterscene(text, scene) dict abort
	let self.nextscene = a:scene
	let self.enterscene = a:text
	return self
endfunction

function! s:EventClass.effect(fn) dict abort
	let self.effect = a:fn
	return self
endfunction

function! s:EventClass.invoke(state) dict abort
	if(exists('self.monsters'))
		let a:state.enemy = self.monsters.rnd()()
	endif
	if(exists('self.effect'))
		call self.effect(a:state)
	endif

	let text = vimcastle#utils#oneof(self.texts)
	call self.processtext(text, a:state)
	let a:state.log = [text]

	call a:state.actions.clear()
	if(exists('self.fight'))
		call a:state.actions.add('c', self.fight, function('s:action_fight'))
	endif
	if(exists('self.enterscene'))
		call a:state.actions.add('c', self.enterscene, function('s:action_enterscene'))
	endif
	if(exists('self.explore'))
		call a:state.actions.add('c', self.explore, function('s:action_explore'))
	endif
endfunction

function! s:EventClass.processtext(text, state)
	let text = a:text
	if(exists('a:state.enemy'))
		let text = substitute(text, '%e', '<' . a:state.enemy.name.long . '>', 'ge')
	endif
	return text
endfunction

function! s:action_explore(state)
	let result = a:state.scene.events.rnd().invoke(a:state)
endfunction

function! s:action_fight(state)
	let a:state.nextaction = function('s:action_continue')
	call a:state.enter('fight')
endfunction

function! s:action_enterscene(state)
	let a:state.scene.load(a:state.story.name, self.nextscene)
	call a:state.scene.begin(a:state)
endfunction

