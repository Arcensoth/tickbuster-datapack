# tickbuster:core/main

# Run before-loop handles.
function #tickbuster:hooks/before_loop

# Get an initial measurement.
execute store result score $worldborder tkb.math run worldborder get

# Start the subtick loop... if we have any time to begin with.
execute if score $worldborder tkb.math < $targetwb tkb.math run function tickbuster:core/loop

# Reset votes for next tick.
scoreboard players set $vote tkb.math 0

# Run after-loop handles.
function #tickbuster:hooks/after_loop
