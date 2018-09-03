# tickbuster:bench/tell

tellraw @s [{"text": "[tickbuster:bench] Averaged ", "color": "gray"}, {"score": {"name": "$iters_per_tick", "objective": "tkb.bench"}, "color": "aqua"}, {"text": " iterations per tick over ", "color": "gray"}, {"score": {"name": "$total_ticks", "objective": "tkb.bench"}}, {"text": " ticks."}]
