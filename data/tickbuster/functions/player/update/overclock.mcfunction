# tickbuster:player/update/overclock

# toggle overclock
execute store success score $overclock tkb.config if score $overclock tkb.config matches 0

# DEBUG
execute if score $overclock tkb.config matches 0 run tellraw @a[tag=nengine.debug] [{"text": "[tickbuster:player/update/overclock] ", "color": "gray"}, {"selector": "@s"}, {"text": "disabled", "color": "red"}, {"text": " overclocking."}]
execute unless score $overclock tkb.config matches 0 run tellraw @a[tag=nengine.debug] [{"text": "[tickbuster:player/update/overclock] ", "color": "gray"}, {"selector": "@s"}, {"text": "enabled", "color": "green"}, {"text": " overclocking."}]

scoreboard players set @s tkb.overclock 0
