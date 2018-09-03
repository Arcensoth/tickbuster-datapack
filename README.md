# Tickbuster
Lag-free background computation with subtick timing.

Field       | Value
----------- | -----
Category    | Utility
Namespace   | `tickbuster`
Scorespace  | `tkb`

- [Q&A](#q-a)
  - [What does it do?](#what-does-it-do)
  - [How do I use it?](#how-do-i-use-it)
  - [How does it work?](#how-does-it-work)
  - [Can I use the worldborder for anything else?](#can-i-use-the-worldborder-for-anything-else)
  - [Why are some of my computations being cut-off?](#why-are-some-of-my-computations-being-cut-off)
  - [Why is the after-loop hook not running?](#why-is-the-after-loop-hook-not-running)
  - [Where did the idea come from?](#where-did-the-idea-come-from)
- [Configuration](#configuration)
  - [Target tick time](#target-tick-time)
  - [Benchmarking](#benchmarking)
  - [Overclocking](#overclocking)
  - [Debug mode](#debug-mode)
- [Scoreboard](#scoreboard)
  - [`tkb.config` objective](#tkbconfig-objective)
  - [`tkb.bench` objective](#tkbbench-objective)
  - [`tkb.math` objective](#tkbmath-objective)
- [Entity Tags](#entity-tags)
- [Event Hooks](#event-hooks)

## Q&A
### What does it do?
It lets you run tagged functions as many times per tick as possible without causing lag.

The idea is that all tagged functions will run as many times per tick as possible, via round-robin, without causing lag.

### How do I use it?
Add your functions to the `#tickbuster:hooks/loop` tag to include them as background computation.

It is recommended you split your background computation into small, dividable slices, and only run what is necessary each iteration. Large/complex background functions have the potential to hog the pipeline and may still cause lag on their own.

### How does it work?
It works thanks to the fact that the worldborder runs on system time and updates asynchronous to the main gameloop.

Unlike anything else in commands, this allows us to determine the amount of time that passes between commands in the same tick (subtick timing). This comes at the cost of using the worldborder for its intended purpose, hence the requirement for exclusive worldborder control.

### Can I use the worldborder for anything else?
No, this module **requires exclusive control of the worldborder**.

Unfortunately the worldborder is our only viable means of measuring real-time passage with commands. If any commands outside this module modify the worldborder, something is almost guaranteed to go wrong.

Note that other commands may safely continue to query the worldborder via `worldborder get`; the danger is in setting the worldborder such as with `worldborder add` and `worldbnorder set`.

### Why are some of my computations being cut-off?
Most likely because `maxCommandChainLength` is being hit during the subtick loop.

Depending on how inexpensive your background computation is, you may need to increase the `maxCommandChainLength` to prevent the subtick loop from hitting the command cap before the target tick time. This usually won't happen with the default value unless you're running many small operations per iteration.

### Why is the after-loop hook not running?
See: [Why are some of my computations being cut-off?](#why-are-some-of-my-computations-being-cut-off)

If you run into an issue where `#tickbuster:hooks/after_loop` does not run, it's probably because the subtick loop is hitting `maxCommandChainLength` during the subtick loop and being cut-off before actually reaching the target tick time. In this case, the after-loop hook will never even get a chance to run.

### Where did the idea come from?
Based on Dr. Brian Lorgon111's [lagless prioritized command scheduler concept](https://www.youtube.com/watch?v=lhJM9LmD2Gg) to "maximize command programming CPU utilization without introducing game lag." The concept has been simplified and adapted for Minecraft 1.13 in the form of a datapack.

## Configuration
The objective `tkb.config` is used to hold configuration values via fakeplayers. There are also various entity tags available that will change behaviour. Operators may change scoreboard values and assign tags to players directly.

### Target tick time
The target tick time is a threshold, in milliseconds, that tells the system when to break from the subtick loop. As soon as a tick lasts up to this threshold, the system will yield control back to the game.

The default target tick time is set well below the game's built-in 50ms target:
```
scoreboard players set $target tkb.config 20
```

Something a bit less conservative:
```
scoreboard players set $target tkb.config 40
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

### Benchmarking
TODO

### Overclocking
Normally the target tick time is capped at `50` but there is a toggle that will allow you to go beyond. Generally this is not recommended because it will directly result in lag and high CPU usage. **Use at your own risk.**

Enable overclocking:
```
scoreboard players set $overclock tkb.config 1
```

Disable overclocking:
```
scoreboard players set $overclock tkb.config 0
```

### Debug mode
Expose players to debugging mechanisms:
```
tag <targets> add tickbuster.debug
```

## Scoreboard
Objective     | Criteria  | Usage     | Description
------------- | --------- | --------- | -----------
`tkb.config`  | `dummy`   | Input     | Reserved for configuration options.
`tkb.bench`   | `dummy`   | Read-only | Reserved for benchmark calculations.
`tkb.math`    | `dummy`   | Read-only | Reserved for sensitive operations.
`tkb.module`  | `dummy`   | Read-only | Reserved for SMF.

### `tkb.config` objective
Fakeplayer    | Default | Description
------------- | ------- | -----------
`$autobench`  | `0`     | The number of ticks to automatically benchmark at. Set to `0` to disable.
`$overclock`  | `0`     | Whether to allow [overclocking](#overclocking) the target tick time.
`$target`     | `20`    | The [target tick time](#target-tick-time), in milliseconds.

### `tkb.bench` objective
**These values are read-only and should not be altered.**

Fakeplayer        | Description
----------------- | -----------
`$current_iters`  | The number of iterations, over the course of the current tick.
`$iters_per_tick` | The average number of iterations per tick, over the course of the benchmark.
`$total_iters`    | The total number of iterations, over the course of the benchmark.
`$total_ticks`    | The totla number of ticks, over the course of the benchmark.

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
