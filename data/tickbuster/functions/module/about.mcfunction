# tickbuster:module/about

function tickbuster:module/values

tellraw @s [{"text":"[Tickbuster]", "color": "aqua"}, {"text": " #### Tickbuster ####", "color": "light_purple"}]

tellraw @s [{"text":"[Tickbuster]", "color": "aqua"}, {"text": " Lag-free background computation with subtick timing.", "color": "gray"}]

execute if score $vdev temp matches ..0 run tellraw @s [{"text":"[Tickbuster]", "color": "aqua"}, {"text": " v", "color": "dark_gray", "extra": [{"score": {"name": "$vmajor", "objective": "temp"}}, {"text": "."}, {"score": {"name": "$vminor", "objective": "temp"}}, {"text": "."}, {"score": {"name": "$vpatch", "objective": "temp"}}]}, {"text": " for Minecraft 1.13", "color": "dark_gray"}]
execute if score $vdev temp matches 1.. run tellraw @s [{"text":"[Tickbuster]", "color": "aqua"}, {"text": " v", "color": "dark_gray", "extra": [{"score": {"name": "$vmajor", "objective": "temp"}}, {"text": "."}, {"score": {"name": "$vminor", "objective": "temp"}}, {"text": "."}, {"score": {"name": "$vpatch", "objective": "temp"}}]}, {"text": "-dev", "color": "dark_gray", "extra": [{"score": {"name": "$vdev", "objective": "temp"}}]}, {"text": " for Minecraft 1.13", "color": "dark_gray"}]

tellraw @s [{"text":"[Tickbuster]", "color": "aqua"}, {"text": " Authors:", "color": "gray"}]
function tickbuster:module/api/authors

function tickbuster:module/api/extras

playsound minecraft:block.enchantment_table.use player @s ~ ~ ~ 2.0 1.25
