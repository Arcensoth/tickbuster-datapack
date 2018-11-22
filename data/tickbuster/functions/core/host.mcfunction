# tickbuster:core/host

# main entry point into post-tick operations (after game simulation)
# run by the host player

# Don't start the sub-tick loop unless there are votes to do so.
execute if score $vote tkb.math matches 1.. run function tickbuster:core/main
