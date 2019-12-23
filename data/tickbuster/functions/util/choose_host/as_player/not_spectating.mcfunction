#> tickbuster:util/choose_host/as_player/not_spectating
#
# @context player, non-spectator

# Only players within the build limit are eligible to be the host.
execute if entity @s[y=0, dy=255] run function tickbuster:util/choose_host/as_player/not_spectating/within_build_limit
