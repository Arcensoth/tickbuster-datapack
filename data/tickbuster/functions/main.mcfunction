# tickbuster:main

# Get an initial measurement.
execute store result score $worldborder tkb.math run worldborder get
scoreboard players operation $blocks tkb.math = $worldborder tkb.math
scoreboard players remove $blocks tkb.math 1000

# Run before-loop handles.
function #tickbuster:hooks/before_loop

# Start the subtick loop... if we have any time to begin with.
execute if score $blocks tkb.math matches ..49 run function tickbuster:loop

# Run after-loop handles.
function #tickbuster:hooks/after_loop
