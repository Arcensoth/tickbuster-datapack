#> tickbuster:api/vote/out

# >>> DO NOT CALL THIS MORE THAN ONCE PER TICK PER MODULE <<<
# Vote to break out of the sub-tick loop. Normally this is called from within
# the sub-tick loop. Calling this more than once per tick in your module is BAD
# because that's stealing votes from other modules that may still need to run.

# first decrement the vote
scoreboard players remove $vote tkb.math 1

# then check if it's time to break
execute if score $vote tkb.math matches ..0 run function tickbuster:host/subtick/break
