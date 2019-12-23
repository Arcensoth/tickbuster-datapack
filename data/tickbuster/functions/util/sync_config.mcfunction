#> tickbuster:util/sync_config
#
# @context any

# cap target, unless overclocking is enabled
scoreboard players operation $target tkb.math = $target tkb.config
execute if score $target tkb.math matches 51.. unless score $overclock tkb.config matches 1.. run scoreboard players set $target tkb.math 50

# adjust target blocks
scoreboard players set $targetwb tkb.math 59999000
scoreboard players operation $targetwb tkb.math += $target tkb.math
