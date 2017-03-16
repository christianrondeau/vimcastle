# Vimcastle Contribution Guide

Vimcastle is a randomly generated game, built for quick and relax games. There is no game loop, no timing features. Only actions, and results.

## Architecture

Everything starts in [vimcastle.vim](autoload/vimcastle.vim).

1. We prepare the UI in [ui.vim](autoload/vimcastle/ui.vim)
2. We bind most keys to `vimcastle#action` and avoid multi-key mappings by reducing `timeoutlen`
3. We create the original `game` and enter a default `state`

After this, nothing happens. Every time a key is pressed:

1. The `vimcastle#action` function finds which `action` is mapped to that key, and invokes it on the current `state`
2. The `state` changes the `game` as needed, and potentially goes to another `state` using `game.enter`

## Tests

This project uses [Vader](https://github.com/junegunn/vader.vim) to make sure everything works as the game gets more complex.

Because of the random nature of the game, two tests are of high interest:

* [runthrough.vader](tests/runthrough.vader) plays the game multiple times, and compiles statistics to make sure that the player survives a minimal amount of turns and dies after a maximum amount of turns on average.
* [stories.vader](tests/stories.vader) tries to fight every monster and create every equippable item, and reports the per-monster difficulty.

Both tests rely on [testutils.vim](autoload/vimcastle/testutils.vim) to auto-play the game and make reasonable automated decisions.

## Concepts

* `action`: Something bound to a key, specific to a state; e.g. `inventory` in the state `explore` opens the Inventory screen.
* `character`: A generic name for both `monster` and `player`.
* `equippable`: Represents weapons, armors and other items that can be "equipped" by a character. Only one equippable item can be used by `slot`. The only "special" slot is the `weapon` slot, used when *attacking* in a fight and having `dmg` stats.
* `event`: Very similar to a `state`, but is always shown in the `explore` state. This defines what the player can do and see, and is persisted between states. An example of an event could be `encounter`, or `finditem`.
* `game`: Contains the whole state of the game.
* `gen`: A suffix for generators. An example: `eventgen` generates `event`, and `monstergen` generates a `monster`.
* `monster`: A potential enemy; once in a fight with the player, it becomes an `enemy`.
* `state`: The object that controls what to do when `enter`ing that state, and what to do when a key is pressed. All states are in the [states folder](autoload/vimcastle/states/).
* `scene`: A set of events, monsters, items, etc. in which the player evolves.
* `screen`: Represents both the current `state`, and which `ui` to draw. The [screens](autoload/vimcastle/screens/) folder contains all user interfaces for [states](autoload/vimcastle/states/)
* `stat`: A character property that drives game mechanics, like `str` for strengths, which mainly drives the attack damage.
* `story`: The parent of all `scenes`; defines an entry point, and the player can move between scenes of a story, but not between stories.
