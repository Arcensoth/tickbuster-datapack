# tickbuster:update_target

tellraw @a[tag=tickbuster.debug] [{"text": "[tickbuster:update_target] Updating target configuration from ", "color": "gray"}, {"score": {"objective": "tkb.math", "name": "$targetms"}}, {"text": " to "}, {"score": {"objective": "tkb.config", "name": "$target"}}]

# cap values
execute if score $target tkb.config matches ..-1 run scoreboard players set $target tkb.config 0
execute if score $target tkb.config matches 51.. run scoreboard players set $target tkb.config 50

# synchronize
scoreboard players operation $targetms tkb.math = $target tkb.config

# adjust target blocks
scoreboard players set $targetwb tkb.math 59999000
scoreboard players operation $targetwb tkb.math += $targetms tkb.math
