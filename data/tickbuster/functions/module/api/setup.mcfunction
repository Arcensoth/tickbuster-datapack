# tickbuster:module/api/setup

scoreboard objectives add tkb.config dummy
scoreboard objectives add tkb.math dummy

# triggers
scoreboard objectives add tkb.target trigger
scoreboard objectives add tkb.overclock trigger

# defaults
scoreboard players set $overclock tkb.config 0
scoreboard players set $target tkb.config 20

# sync config
function tickbuster:config/sync
