#> tickbuster:tick
#
# @context root

# Sync players.
execute as @a at @s run function tickbuster:player/sync

# Call for votes.
function #tickbuster:vote

# Don't do anything unless there are votes.
execute if score $vote tkb.math matches 1.. run function tickbuster:tick/with_votes
