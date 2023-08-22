#> tickbuster:tick/with_votes/with_host
#
# @context root

# Move the worldborder by 1000 blocks over the course of 1 second, which equates
# to 1 block per millisecond. We can then detect how many milliseconds of real
# time have passed during the rest of the tick.
worldborder set 59998968
worldborder add 1000 1

# Make sure that `minecraft:enter_block` is the last criteria to be fulfilled,
# later in the tick, by ensuring that nobody already has it. But we might as
# well revoke the entire advancement anyway just to make sure we don't wind up
# with multiple hosts.
advancement revoke @a only tickbuster:internal/host

# Grant the final criteria for the advancement to the host.
# NOTE Use limit=1 just in case somehow more than one player got the tag.
advancement grant @a[tag=tickbuster.host, limit=1] only tickbuster:internal/host host
