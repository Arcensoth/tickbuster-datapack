# tickbuster:core/host

# main entry point into post-tick operations (after game simulation)
# run by the host player

# Revoke the entire advancement again. Technically this isn't necessary, but if
# we don't do this here then it leads to a bunch of clent issues and log spam.
# See issue #1 on the bug tracker for details:
# https://github.com/Arcensoth/tickbuster-datapack/issues/1
advancement revoke @a only tickbuster:internal/host

# Don't start the sub-tick loop unless there are votes to do so.
execute if score $vote tkb.math matches 1.. run function tickbuster:core/main
