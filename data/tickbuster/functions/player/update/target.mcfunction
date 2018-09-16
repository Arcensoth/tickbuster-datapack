# tickbuster:player/update/target

# set target
scoreboard players operation $target tkb.config = @s tkb.target

# cap values, unless overclocking is enabled
execute if score $target tkb.config matches ..-1 run scoreboard players set $target tkb.config 0
execute if score $target tkb.config matches 51.. unless score $overclock tkb.config matches 1.. run scoreboard players set $target tkb.config 50

# sync
function tickbuster:sync

# DEBUG
tellraw @a[tag=nengine.debug] [{"text": "[tickbuster:player/update/target] "}, {"selector": "@s"}, {"text": " set target to ", "color": "gray"}, {"score": {"name": "$target", "objective": "tkb.config"}, "color": "aqua"}, {"text": "."}]

scoreboard players set @s tkb.target -2147483648
