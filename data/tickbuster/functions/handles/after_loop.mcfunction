# tickbuster:handles/after_loop

tellraw @a[tag=tickbuster.debug] [{"text": "[tickbuster:handles/after_loop] Worldborder after game simulation: ", "color": "gray"}, {"score": {"objective": "temp", "name": "$worldborder"}}]

tellraw @a[tag=tickbuster.debug] [{"text": "[tickbuster:handles/before_loop] Number of iterations run: ", "color": "gray"}, {"score": {"objective": "temp", "name": "$wbcounter"}}]
