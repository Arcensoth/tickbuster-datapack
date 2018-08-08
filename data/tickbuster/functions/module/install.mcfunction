# tickbuster:module/install

execute if score $installed tkb.module matches 1.. run summon minecraft:area_effect_cloud ~ ~ ~ {Tags:["tickbuster.temp.installed"]}
execute unless entity @e[tag=tickbuster.temp.installed] run function tickbuster:module/forceinstall
execute if entity @e[tag=tickbuster.temp.installed] run tellraw @s [{"text":"[Tickbuster]", "color": "aqua"}, {"text": " Module already installed.", "color": "white"}]
kill @e[tag=tickbuster.temp.installed]
