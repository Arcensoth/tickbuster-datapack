#> tickbuster:tick/with_votes
#
# @context root

# Choose a host for this tick.
function tickbuster:util/choose_host

# If we found one, continue.
execute if entity @a[tag=tickbuster.host] run function tickbuster:tick/with_votes/with_host

# Otherwise, we have a problem.
execute unless entity @a[tag=tickbuster.host] run function tickbuster:tick/with_votes/without_host
