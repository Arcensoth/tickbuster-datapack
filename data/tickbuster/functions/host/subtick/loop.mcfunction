#> tickbuster:host/subtick/loop
#
# The heart of the sub-tick loop. This function runs recursively, calling itself
# along with all of the tagged functions.
#
# This processes continues indefinitely until either:
# 1. the configured sub-tick target time is reached; or
# 2. all of the votes have been depleted and the loop is broken.
#
# @context host player

# Run loop handles.
function #tickbuster:loop

# Calculate how many milliseconds have passed in the current tick, by counting the number of blocks the worldborder has moved.
execute store result score $worldborder tkb.math run worldborder get

# If we've still got time, keep looping.
execute if score $worldborder tkb.math < $targetwb tkb.math run function tickbuster:host/subtick/loop

# Otherwise, break out and let the tick run off.
