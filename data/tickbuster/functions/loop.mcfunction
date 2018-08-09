# tickbuster:loop

# Calculate how many milliseconds have passed in the current tick, by counting the number of blocks the worldborder has moved.
execute store result score $worldborder tkb.math run worldborder get
scoreboard players operation $blocks tkb.math = $worldborder tkb.math
scoreboard players remove $blocks tkb.math 1000

# Run loop handles.
# TODO
# function #tickbuster:loop
scoreboard players add $counter tkb.math 1
# tellraw @a [{"text": "Worldborder: ", "color": "red"}, {"score": {"objective": "tkb.math", "name": "$worldborder"}}]

# If we've still got time, keep looping.
# TODO
# execute if score $blocks tkb.math matches ..49 run function tickbuster:loop
# TODO remove fallback break condition after testing
execute if score $blocks tkb.math matches ..49 if score $counter tkb.math matches ..10000 run function tickbuster:loop

# Otherwise, break out and let the tick run off.
