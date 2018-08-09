# tickbuster:handles/before_loop

tellraw @a[tag=tickbuster.debug] [{"text": "[tickbuster:handles/before_loop] Worldborder before game simulation: ", "color": "gray"}, {"score": {"objective": "tkb.math", "name": "$worldborder"}}]

scoreboard players set $counter tkb.math 0
