# tickbuster:module/api/setup

scoreboard objectives add tkb.config dummy
scoreboard objectives add tkb.math dummy

# trigger target update
scoreboard players set $targetms tkb.math 0
scoreboard players set $targetwb tkb.math 59999000
scoreboard players set $target tkb.config 40
