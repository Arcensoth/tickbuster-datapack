# tickbuster:main

# Get an initial measurement.
execute store result score $worldborder tkb.math run worldborder get

# Run before-loop handles.
function #tickbuster:hooks/before_loop

# Start the subtick loop... if we have any time to begin with.
execute if score $worldborder tkb.math matches ..59999049 run function tickbuster:loop

# Run after-loop handles.
function #tickbuster:hooks/after_loop
