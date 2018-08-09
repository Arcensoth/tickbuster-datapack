# tickbuster:main

# Run before-loop handles.
function #tickbuster:hooks/before_loop

# Get an initial measurement.
execute store result score $worldborder temp run worldborder get

# Start the subtick loop... if we have any time to begin with.
execute if score $worldborder temp < $targetwb tkb.math run function tickbuster:loop

# Run after-loop handles.
function #tickbuster:hooks/after_loop
