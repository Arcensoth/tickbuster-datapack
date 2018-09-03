# tickbuster:debug/before_loop

execute store result score $worldborder tkb.math run worldborder get

tellraw @a[tag=tickbuster.debug] [{"text": "[tickbuster:debug/before_loop] Worldborder before game simulation: ", "color": "gray"}, {"score": {"objective": "tkb.math", "name": "$worldborder"}}]
