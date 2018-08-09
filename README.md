# Tickbuster
Lag-free background computation with subtick timing.

Field       | Value
----------- | -----
Category    | Utility
Namespace   | `tickbuster`
Scorespace  | `tkb`

- [Configuration](#configuration)
  - [Target tick time](#target-tick-time)
  - [Debug mode](#debug-mode)
- [Scoreboard](#scoreboard)
  - [`tkb.config` objective](#tkbconfig-objective)
  - [`tkb.math` objective](#tkbmath-objective)
- [Entity Tags](#entity-tags)
- [Event Hooks](#event-hooks)

## Usage
- **Add your functions to the `#tickbuster:hooks/loop` tag to include them as background computation.** The goal is for all background functions to run as many times per tick as possible, via round-robin, without causing lag.
- It is recommended you split your background computation into small, dividable slices, and only run what is necessary each iteration. Large/complex background functions have the potential to hog the pipeline and may still cause lag on their own.

## Notes
- **Important!** This module requires exclusive control of the worldborder. If any commands outside this module modify the worldborder, something is almost guaranteed to go wrong.
  - This module is made possible by the fact that the worldborder works off system time and updates asynchronous to the main gameloop. Unlike anything else in commands, this allows us to determine the amount of time that passes between commands in the same tick (subtick timing). This comes at the cost of using the worldborder for its intended purpose, hence the requirement for exclusive worldborder control.
- Depending on how expensive your background computation is, you may need to increase the `maxCommandChainLength` gamerule to prevent the subtick loop from hitting cap. This usually won't happen with the default value unless you're running many small operations per iteration.

## Configuration
The objective `tkb.config` is used to hold configuration values via fakeplayers. There are also various entity tags available that will change behaviour. Operators may change scoreboard values and assign tags to players directly.

### Target tick time
The target tick time is a threshold, in milliseconds, that tells the system when to break from the subtick loop. As soon as a tick lasts up to this threshold, the system will yield control back to the game.

The default target tick time is set safely below the game's built-in 50ms target:
```
scoreboard players set $target tkb.config 40
```

Something a little more conservative:
```
scoreboard players set $target tkb.config 30
```

Pushing the game to its limit:
```
scoreboard players set $target tkb.config 50
```

Setting the target `0` will effectively disable any background computation:
```
scoreboard players set $target tkb.config 0
```

Allowed values are `0..50` and anything outside this range will wrap accordingly.

### Debug mode
Expose players to debugging mechanisms:
```
tag <targets> add tickbuster.debug
```

## Scoreboard
Objective     | Criteria  | Usage     | Description
------------- | --------- | --------- | -----------
`tkb.config`  | `dummy`   | Input     | Reserved for configuration options.
`tkb.math`    | `dummy`   | Read-only | Reserved for sensitive operations.
`tkb.module`  | `dummy`   | Read-only | Reserved for SMF.

### `tkb.config` objective
Fakeplayer  | Default | Description
----------- | ------- | -----------
`$target`   | `40`    | The [target tick time](#target-tick-time), in milliseconds.

### `tkb.math` objective
**These values are read-only and should not be altered.**

Fakeplayer  | Description
----------- | -----------
`$targetms` | Mirrors the configured `$target` to detect updates for re-calculation.
`$targetwb` | The actual value used to compare with the worldborder size.

## Entity Tags
Entity Tag          | Description
------------------- | -----------
`tickbuster.debug`  | Present on players who are debugging the module.

## Event Hooks
Function Tag                    | Description
------------------------------- | -----------
`#tickbuster:hooks/after_loop`  | Run once per tick, after the target tick length has been met and the subtick loop runs off.
`#tickbuster:hooks/before_loop` | Run once per tick, before entering the subtick loop.
`#tickbuster:hooks/loop`        | The main subtick loop, run an arbitrary number of times each tick until the target tick length is met.
