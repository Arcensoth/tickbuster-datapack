#> tickbuster:player/sync
#
# @context player

# Make sure admins have their triggers available.
execute if entity @s[tag=tickbuster.admin] run function tickbuster:player/refresh

# All other players should have them disabled.
execute unless entity @s[tag=tickbuster.admin] run function tickbuster:player/disable
