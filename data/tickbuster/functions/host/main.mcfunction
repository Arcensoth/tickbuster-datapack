#> tickbuster:host/main
#
# Main entry point into post-game simulation operations. At this point we have
# allowed the majority of the game simulation to run its course.
#
# @context host player

# Revoke the entire advancement again. Technically this isn't necessary, but if
# we don't do this here then it leads to a bunch of clent issues and log spam.
# See issue #1 on the bug tracker for details:
# https://github.com/Arcensoth/tickbuster-datapack/issues/1
advancement revoke @a only tickbuster:internal/host

# Remove the host tag.
tag @s remove tickbuster.host

# Run before-loop handles.
function #tickbuster:before_loop

# Get an initial measurement.
execute store result score $worldborder tkb.math run worldborder get

# Start the subtick loop... if we have any time to begin with.
execute if score $worldborder tkb.math < $targetwb tkb.math run function tickbuster:host/subtick/loop

# Reset votes for next tick.
scoreboard players set $vote tkb.math 0

# Run after-loop handles.
function #tickbuster:after_loop
