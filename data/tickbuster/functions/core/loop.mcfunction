# tickbuster:core/loop

# Run loop handles.
function #tickbuster:hooks/loop

# Calculate how many milliseconds have passed in the current tick, by counting the number of blocks the worldborder has moved.
execute store result score $worldborder temp run worldborder get

# If we've still got time, keep looping.
execute if score $worldborder temp < $targetwb tkb.math run function tickbuster:core/loop

# Otherwise, break out and let the tick run off.
