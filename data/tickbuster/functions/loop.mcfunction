# tickbuster:loop

# Calculate how many milliseconds have passed in the current tick, by counting the number of blocks the worldborder has moved.
execute store result score $worldborder tkb.math run worldborder get

# Run loop handles.
function #tickbuster:hooks/loop

# If we've still got time, keep looping.
execute if score $worldborder tkb.math matches ..1049 run function tickbuster:loop

# Otherwise, break out and let the tick run off.
