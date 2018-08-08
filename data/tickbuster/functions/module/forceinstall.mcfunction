# tickbuster:module/forceinstall

function tickbuster:module/api/setup

scoreboard objectives add tkb.module dummy
scoreboard players set $installed tkb.module 1

function tickbuster:module/values

scoreboard players operation $vmajor tkb.module = $vmajor temp
scoreboard players operation $vminor tkb.module = $vminor temp
scoreboard players operation $vpatch tkb.module = $vpatch temp
scoreboard players operation $vdev tkb.module = $vdev temp

tellraw @s [{"text": "[Tickbuster]", "color": "aqua"}, {"text": " Module has been ", "color": "white"}, {"text": "installed", "color": "green"}, {"text": ".", "color": "white"}]

playsound minecraft:entity.player.levelup player @s ~ ~ ~ 1 2 0.5

function tickbuster:module/scan
