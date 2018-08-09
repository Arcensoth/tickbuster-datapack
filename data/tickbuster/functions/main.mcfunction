# tickbuster:main

# Get an initial measurement.
execute store result score $worldborder tkb.math run worldborder get
scoreboard players operation $blocks tkb.math = $worldborder tkb.math
scoreboard players remove $blocks tkb.math 1000

# Run before-loop handles.
# TODO
# function #tickbuster:before_loop
tellraw @a [{"text": "Worldborder before: ", "color": "red"}, {"score": {"objective": "tkb.math", "name": "$worldborder"}}]
scoreboard players set $counter tkb.math 0

# Start the subtick loop... if we have any time to begin with.
execute if score $blocks tkb.math matches ..49 run function tickbuster:loop

# Run after-loop handles.
# TODO
# function #tickbuster:after_loop
tellraw @a [{"text": "Worldborder after: ", "color": "red"}, {"score": {"objective": "tkb.math", "name": "$worldborder"}}]
tellraw @a [{"text": "Counter: ", "color": "red"}, {"score": {"objective": "tkb.math", "name": "$counter"}}]
