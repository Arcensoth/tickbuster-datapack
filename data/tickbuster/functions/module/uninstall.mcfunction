# tickbuster:module/uninstall

execute if score $installed tkb.module matches 1.. run summon minecraft:area_effect_cloud ~ ~ ~ {Tags:["tickbuster.temp.installed"]}
execute unless entity @e[tag=tickbuster.temp.installed] run tellraw @s [{"text":"[SMF]", "color": "aqua"}, {"text": " Module not installed.", "color": "white"}]
execute if entity @e[tag=tickbuster.temp.installed] run function tickbuster:module/forceuninstall
kill @e[tag=tickbuster.temp.installed]
