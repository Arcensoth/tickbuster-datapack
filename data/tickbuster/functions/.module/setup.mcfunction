#> tickbuster:.module/setup

scoreboard objectives add __temp__ dummy

scoreboard objectives add tkb.config dummy
scoreboard objectives add tkb.math dummy

# triggers
scoreboard objectives add tkb.target trigger
scoreboard objectives add tkb.overclock trigger

# defaults
execute unless score $overclock tkb.config matches -2147483648.. run scoreboard players set $overclock tkb.config 0
execute unless score $target tkb.config matches -2147483648.. run scoreboard players set $target tkb.config 20

# sync config
function tickbuster:config/sync
