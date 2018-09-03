# tickbuster:bench/proc

function tickbuster:bench/calc

execute as @a[tag=tickbuster.debug] run function tickbuster:bench/tell

# just in case a non-debug player is here
execute as @s[tag=!tickbuster.debug] run function tickbuster:bench/tell

function tickbuster:bench/clear
