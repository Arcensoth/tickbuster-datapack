# tickbuster:player/refresh

# Initialize null triggers.
execute unless score @s tkb.overclock matches -2147483648.. run scoreboard players set @s tkb.overclock 0
execute unless score @s tkb.target matches -2147483648.. run scoreboard players set @s tkb.target -2147483648

# Check for and re-enable triggers.

execute unless score @s tkb.overclock matches 0 run function tickbuster:player/update/overclock
scoreboard players enable @a tkb.overclock

execute unless score @s tkb.target matches -2147483648 run function tickbuster:player/update/target
scoreboard players enable @a tkb.target
