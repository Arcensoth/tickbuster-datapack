# tickbuster:handles/before_loop

tellraw @a [{"text": "Worldborder before: ", "color": "red"}, {"score": {"objective": "tkb.math", "name": "$worldborder"}}]
scoreboard players set $counter tkb.math 0
