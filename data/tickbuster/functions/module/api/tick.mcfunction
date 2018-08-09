# tickbuster:module/api/tick

# Move the worldborder by 1000 blocks over the course of 1 second, which equates to 1 block per millisecond. We can then detect how many milliseconds of real time have passed during the rest of the tick. Once 50 blocks have passed, the game will begin to lag.
# TODO higher accuracy?
worldborder set 1000
worldborder add 1000 1

# Choose a random player as the host for this tick.
advancement grant @r only tickbuster:internal/host host
