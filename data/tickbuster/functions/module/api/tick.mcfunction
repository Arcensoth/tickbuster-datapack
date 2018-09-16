# tickbuster:module/api/tick

# Move the worldborder by 1000 blocks over the course of 1 second, which equates to 1 block per millisecond. We can then detect how many milliseconds of real time have passed during the rest of the tick.
worldborder set 59999000
worldborder add 1000 1

# Make sure that `minecraft:enter_block` is the last criteria to be fulfilled, later in the tick.
advancement revoke @a only tickbuster:internal/host

# Choose an arbitrary player as the host for this tick.
advancement grant @a[sort=arbitrary,limit=1] only tickbuster:internal/host host
