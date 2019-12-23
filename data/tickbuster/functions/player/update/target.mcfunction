#> tickbuster:player/update/target
#
# @context player

# set target
scoreboard players operation $target tkb.config = @s tkb.target
execute if score $target tkb.config matches ..-1 run scoreboard players set $target tkb.config 0

tellraw @a[tag=tickbuster.admin] [{"text": "", "color": "gray"}, {"text": "[Tickbuster]", "color": "aqua"}, " ", {"selector": "@s"}, {"text": " set the target tick time to "}, {"score": {"name": "$target", "objective": "tkb.config"}, "color": "aqua"}, {"text": " mspt."}]

# sync
function tickbuster:util/sync_config

scoreboard players set @s tkb.target -2147483648
