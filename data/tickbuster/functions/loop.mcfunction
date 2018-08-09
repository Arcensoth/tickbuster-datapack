# tickbuster:loop

# Calculate how many milliseconds have passed in the current tick, by counting the number of blocks the worldborder has moved.
execute store result score $worldborder tkb.math run worldborder get
scoreboard players operation $blocks tkb.math = $worldborder tkb.math
scoreboard players remove $blocks tkb.math 1000

# Run loop handles.
function #tickbuster:hooks/loop

# If we've still got time, keep looping.
execute if score $blocks tkb.math matches ..49 run function tickbuster:loop

# Otherwise, break out and let the tick run off.
