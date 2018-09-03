# tickbuster:bench/print

scoreboard players operation $iters_per_tick tkb.bench = $total_iters tkb.bench
scoreboard players operation $iters_per_tick tkb.bench /= $total_ticks tkb.bench

tellraw @a[tag=tickbuster.debug] [{"text": "[tickbuster:bench] Averaged ", "color": "gray"}, {"score": {"name": "$iters_per_tick", "objective": "tkb.bench"}, "color": "aqua"}, {"text": " iterations per tick over ", "color": "gray"}, {"score": {"name": "$total_ticks", "objective": "tkb.bench"}}, {"text": " ticks."}]
