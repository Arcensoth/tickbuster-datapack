# tickbuster:handles/before_loop

execute store result score $worldborder temp run worldborder get

tellraw @a[tag=tickbuster.debug] [{"text": "[tickbuster:handles/before_loop] Worldborder before game simulation: ", "color": "gray"}, {"score": {"objective": "temp", "name": "$worldborder"}}]

scoreboard players set $wbcounter temp 0
