#> tickbuster:player/update/overclock
#
# @context player

# toggle overclock
execute store success score $overclock tkb.config if score $overclock tkb.config matches 0

execute if score $overclock tkb.config matches 0 run tellraw @a[tag=tickbuster.admin] [{"text": "", "color": "gray"}, {"text": "[Tickbuster]", "color": "aqua"}, " ", {"selector": "@s"}, " ", {"text": "disabled", "color": "red"}, {"text": " overclocking."}]
execute unless score $overclock tkb.config matches 0 run tellraw @a[tag=tickbuster.admin] [{"text": "", "color": "gray"}, {"text": "[Tickbuster]", "color": "aqua"}, " ", {"selector": "@s"}, " ", {"text": "enabled", "color": "green"}, {"text": " overclocking."}]

# sync
function tickbuster:util/sync_config

scoreboard players set @s tkb.overclock 0
