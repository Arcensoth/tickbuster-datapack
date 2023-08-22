#> tickbuster:host/subtick/break
#
# This function is called if/when all of the votes have been depleted.
#
# @context host player

# Run break handles.
function #tickbuster:break_loop

# Fool the sub-tick loop into thinking time is up by forcefully resizing the worldborder.
worldborder set 59999968

# The sub-tick loop will run-off at the end of the current iteration.
# Or, if invoked in the before-tick-loop, the sub-tick loop will not run at all.
