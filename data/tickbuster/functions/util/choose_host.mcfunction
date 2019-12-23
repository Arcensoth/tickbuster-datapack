#> tickbuster:util/choose_host
#
# Choose a suitable host player for this tick.
#
# NOTE Not all players are eligible to host.
# This is because only players who are not spectating and are within the build
# limit will activate the `enter_block` trigger.
#
# @context any

# Remove the host tag in case anybody already has it.
tag @a[tag=tickbuster.host] remove tickbuster.host

# Only non-spectators are eligible to host.
execute as @a[gamemode=!spectator] at @s run function tickbuster:util/choose_host/as_player/not_spectating

# Assign host to a single eligible player.
tag @a[tag=tickbuster.__temp__.eligible_host, limit=1] add tickbuster.host

# Remove the eligibility tag.
tag @a[tag=tickbuster.__temp__.eligible_host] remove tickbuster.__temp__.eligible_host
