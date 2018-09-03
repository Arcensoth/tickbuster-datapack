# tickbuster:bench/after_loop

# tag this function with `tickbuster:hooks/after_loop` to run benchmarks

scoreboard players add $total_ticks tkb.bench 1
scoreboard players operation $total_iters tkb.bench += $current_iters tkb.bench

execute if score $autobench tkb.config matches 1.. if score $total_ticks tkb.bench >= $autobench tkb.config run function tickbuster:bench/proc
