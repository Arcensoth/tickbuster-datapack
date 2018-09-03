# tickbuster:bench/after_loop

# tag this function with `tickbuster:hooks/after_loop` to run benchmarks

scoreboard players add $total_ticks tkb.bench 1
scoreboard players operation $total_iters tkb.bench += $current_iters tkb.bench
