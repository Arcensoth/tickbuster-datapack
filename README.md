# Tickbuster
Lag-free background computation with subtick timing.

[![imp-module-badge]](https://github.com/Arcensoth/imp-datapack)
[![github-release-badge]](https://github.com/Arcensoth/tickbuster-datapack/releases)

[![Showcase](https://i.imgur.com/Fwuup46.png)](https://i.imgur.com/Fwuup46.png)

- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
- [User functions](#user-functions)
- [Chat triggers](#chat-triggers)
- [Scoreboard objectives](#scoreboard-objectives)
- [Entity tags](#entity-tags)
- [Event hooks](#event-hooks)
- [FAQ](#faq)

## Installation
Run `function tickbuster:.module/setup` to add required scoreboard objectives. There are no other datapack dependencies.

## Configuration
- [Target tick time](#target-tick-time)
- [Overclocking](#overclocking)
- [Administration](#administration)
- [Debugging](#debugging)

The module may be configured via [triggers](#chat-triggers) by anyone assigned as a [module admin](#administration), however [player tags](#entity-tags) must be assigned directly by server operators.

### Target tick time
The target tick time is a threshold, in milliseconds, that tells the system when to break from the subtick loop. As soon as a tick lasts up to this threshold, the system will yield control back to the game.

The default target tick time is set well below the game's built-in 50ms target:
```
trigger tkb.target set 20
```

Something a bit less conservative:
```
trigger tkb.target set 40
```

Pushing the game to its limit:
```
trigger tkb.target set 50
```

Setting the target `0` will effectively disable any background computation:
```
trigger tkb.target set 0
```

Allowed values are `0..50` and anything outside this range will wrap accordingly - unless [overclocking](#overclocking) is enabled, in which case anything within `0..1000` is permitted.

### Overclocking
Normally the target tick time is capped at `50` but there is a toggle that will allow you to go beyond. Generally this is not recommended because it will directly result in lag and high CPU usage. **Use at your own risk.**

Toggle overclocking:
```
trigger tkb.overclock
```

### Administration
Allow a player to manage the module:
```
tag <player> add tickbuster.admin
```

### Debugging
Expose a player to debugging mechanisms:
```
tag <player> add tickbuster.debug
```

## Usage
- [Going sub-tick](#going-sub-tick)
- [Voting system](#voting-system)

### Going sub-tick
There are two important things you need to do in order to integrate with the sub-tick loop:

1. **Add a single function to the `#tickbuster:vote` tag that conditionally calls `tickbuster:api/vote/in`.** You should only vote when there's work to do in the current tick. These votes are used to determine whether to run the sub-tick loop at all and when to break it.
2. **Add any other functions to the `#tickbuster:loop` tag to include them as background computation.** Keep in mind that these functions may run even if you have not voted-in. The recommended best-practice is to keep track of whether you have voted-in, and use this as an escape condition in your entry point to the sub-tick loop.

It is recommended you split your background computation into small, dividable slices, and only run what is necessary each iteration. Large/complex background functions have the potential to hog the pipeline and may still cause lag on their own.

### Voting system
In any given tick, the sub-tick loop will not run unless there is at least one vote to do so. This can be achieved by calling `tickbuster:api/vote/in` - from a function tagged with `#tickbuster:vote` - once for each module (or any other unit of computation) that wishes to utilize the sub-tick loop in the current tick.

Once the sub-tick loop has begun, it will continue until either:

1. the target tick time has been reached, causing the sub-tick loop to run off the end; or
2. all votes have been removed, causing the sub-tick loop to break early.

It may be useful to break out of the sub-tick loop early if there is no further computation to be done in the current tick. However, because several modules may be using the sub-tick loop in any given tick, it is generally unwise to assume you are the only one using it. Instead, you may vote to break out of the sub-tick loop (usually in your `#tickbuster:loop` handle) by calling `tickbuster:api/vote/out`. If all of the modules that opted-in also opt-out, the sub-tick loop will break early.

Note that generally **you should not remove any more votes than you added**; i.e. calling `vote/out` more than `vote/in` in any given tick.

## User functions
Function                        | Description
------------------------------- | -----------
`tickbuster:-user\001_admin`    | Mark the executing player as a module admin.

## Chat triggers
Trigger         | Description
--------------- | -----------
`tkb.overclock` | Toggle [overclocking](#overclocking).
`tkb.target`    | Set the [target tick time](#target-tick-time).

## Scoreboard objectives
Objective     | Criteria  | Usage     | Description
------------- | --------- | --------- | -----------
`tkb.config`  | `dummy`   | Input     | Reserved for configuration options.
`tkb.math`    | `dummy`   | Read-only | Reserved for internal calculations.

## Entity tags
Entity Tag          | Description
------------------- | -----------
`tickbuster.admin`  | Present on players who are [managing the module](#administration).
`tickbuster.debug`  | Present on players who are [debugging the module](#debugging).

## Event hooks
Function Tag                | Description
--------------------------- | -----------
`#tickbuster:after_loop`    | Run once per tick, after the target tick time has been met and the subtick loop runs off.
`#tickbuster:before_loop`   | Run once per tick, before entering the subtick loop.
`#tickbuster:break_loop`    | Run *at most* once per tick whenever the sub-tick loop is broken, before `after_loop` is run.
`#tickbuster:loop`          | The main subtick loop, run an arbitrary number of times each tick until the target tick time is met.
`#tickbuster:vote`          | The callback voting procedure, used to collect votes before determining whether to run the sub-tick loop.

## FAQ
- [What does it do?](#what-does-it-do)
- [How do I use it?](#how-do-i-use-it)
- [How does it work?](#how-does-it-work)
- [Can I use the worldborder for anything else?](#can-i-use-the-worldborder-for-anything-else)
- [Why are some of my computations being cut-off?](#why-are-some-of-my-computations-being-cut-off)
- [Why is the after-loop hook not running?](#why-is-the-after-loop-hook-not-running)
- [Where did the idea come from?](#where-did-the-idea-come-from)

### What does it do?
It lets you run tagged functions as many times per tick as possible without causing lag.

The idea is that all tagged functions will run as many times per tick as possible, via round-robin, without causing lag.

### How do I use it?
All you need to do is tag your background functions with the appropriate function tag, and vote for the sub-tick loop each tick you want it to run. See the [usage section](#usage) for details.

### How does it work?
It works thanks to the fact that the worldborder runs on system time and updates asynchronous to the main gameloop.

Unlike anything else in commands, this allows us to determine the amount of time that passes between commands in the same tick (subtick timing). This comes at the cost of using the worldborder for its intended purpose, hence the requirement for exclusive worldborder control.

### Can I use the worldborder for anything else?
No, this module **requires exclusive control of the worldborder**.

Unfortunately the worldborder is our only viable means of measuring real-time passage with commands. If any commands outside this module modify the worldborder, something is almost guaranteed to go wrong.

Note that other commands may safely continue to query the worldborder via `worldborder get`; the danger is in setting the worldborder such as with `worldborder add` and `worldborder set`.

### Why are some of my computations being cut-off?
Most likely because `maxCommandChainLength` is being hit during the subtick loop.

Depending on how inexpensive your background computation is, you may need to increase the `maxCommandChainLength` to prevent the subtick loop from hitting the command cap before the target tick time. This usually won't happen with the default value unless you're running many small operations per iteration.

### Why is the after-loop hook not running?
See: [Why are some of my computations being cut-off?](#why-are-some-of-my-computations-being-cut-off)

If you run into an issue where `#tickbuster:after_loop` does not run, it's probably because the subtick loop is hitting `maxCommandChainLength` during the subtick loop and being cut-off before actually reaching the target tick time. In this case, the after-loop hook will never even get a chance to run.

### Where did the idea come from?
Based on Dr. Brian Lorgon111's [lagless prioritized command scheduler concept](https://www.youtube.com/watch?v=lhJM9LmD2Gg) to "maximize command programming CPU utilization without introducing game lag." The concept has been simplified and adapted for general use in the form of a datapack.

[imp-module-badge]: https://img.shields.io/static/v1.svg?label=imp&message=module&color=%23AA8ED6&logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAoCAYAAACM/rhtAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAAYdEVYdFNvZnR3YXJlAHBhaW50Lm5ldCA0LjEuNv1OCegAAAH2SURBVFhH1Zk9TgJRFIWHSEhYAbU2WNHTkbAMjYX27MHYETdACwkFBnZBo6V70BVoTIyD35l3gQwgMGbGuX7JCXPvfT8nb37ziBaLxUkcxz30oF/F0RHQrkr7FrpBfTREM5OOlVOtpbbWbS87vdjBCuIRqlufFJQr1NpogF5Dj8OorfVpE1ZsuBTU6mgUegSIeypMLV5B7hE1rW8CcRfNUWzNMqO+oDG6NmwCpXNyT6HVGnJTTTy2OAX5N3SLmoQTfn9tbBMbS2M20R16D5U05McyeG/xTqjnZmyTQ2PLmwxeWewOedP5P+PgK6T8IE/odHlnbl2gZWOewh1PcB3SfpCnxJwgrpF4DqXyMS81sxfwtIqp1RPkdB3OQ7l8zMv6jUNCr6/CnndZkRdom73E4MBqbpCnxBzH+ip5CWk/mKeqVk+fQy6RN5fPwCXyJoN9i90hbzI4tNgd8iaDM4vdIW//wqD7U+z+JnH/mPH9oObX96tOEPj9WBAEvj+3yPn+YBUktbVR+irKA6S2RlZQn4RmpTIxO9vgvIFKu6M1tzyYnd3QrkOjj9Dl77A5O2ZjPzS+QJ+ha/FoLnRp0x+HmSx8JTVHZnNL6K/TXdg1aWMfd1p/gkEaDFLUBub+GyILDFbYFnBuMEdhm+i5w0S5/w2xTRR9AyY9bVacGuF5AAAAAElFTkSuQmCC
[github-release-badge]: https://img.shields.io/github/release/Arcensoth/tickbuster-datapack.svg?logo=github
