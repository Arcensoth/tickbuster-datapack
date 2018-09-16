# tickbuster:stop

# Run stop handles.
function #tickbuster:hooks/stop

# Fool the sub-tick loop into thinking time is up by forcefully resizing the worldborder.
worldborder set 60000000

# The sub-tick loop will run-off at the end of the current iteration.
# Or, if invoked in the before-tick-loop, the sub-tick loop will not run at all.
