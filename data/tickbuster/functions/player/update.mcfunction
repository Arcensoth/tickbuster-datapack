# tickbuster:player/update

execute if entity @s[tag=tickbuster.admin] run function tickbuster:player/refresh
execute unless entity @s[tag=tickbuster.admin] run function tickbuster:player/disable
