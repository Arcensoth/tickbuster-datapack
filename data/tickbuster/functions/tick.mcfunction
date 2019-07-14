# tickbuster:tick

# Move the worldborder by 1000 blocks over the course of 1 second, which equates to 1 block per millisecond. We can then detect how many milliseconds of real time have passed during the rest of the tick.
worldborder set 59999000
worldborder add 1000 1

# Make sure that `minecraft:enter_block` is the last criteria to be fulfilled,
# later in the tick, by ensuring that nobody already has it. Just to be safe,
# we also revoke the manually-applied `host` criteria while we're at it.
advancement revoke @a only tickbuster:internal/host enter_block
advancement revoke @a only tickbuster:internal/host host

# NOTE The dummy criteria `keep` was introduced to help reduce log spam.
# The third criteria `keep` exists solely as a work-around for (what is
# presumably) a bug where the client tries to unload the advancement once all
# criteria are gone, flooding the game log with warnings in the process.
# Unfortunately the log still gets flooded with infos, because for some reason
# the client feels the need to announce that it is reloading advancements after
# any change to criteria takes place.

# Choose an arbitrary player as the host for this tick.
advancement grant @a[sort=arbitrary,limit=1] only tickbuster:internal/host host
