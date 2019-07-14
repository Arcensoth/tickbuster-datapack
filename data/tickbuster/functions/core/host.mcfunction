# tickbuster:core/host

# main entry point into post-tick operations (after game simulation)
# run by the host player

# there've been some issues with log spam due to the way the client handles
# advancement criteria and being over-zealous with reloading advancements
# ramblings follow

# case 1: revoke none of the criteria
# - client reloads all of the advancements
# - based on other testing, this seems to have something to do with the client
#   being notified of thier criteria.

# case 2: revoke enter_block criteria only
# - client does not reload advancements
# - this function triggers multiple times per tick in rapid succession
# - presumably because the enter_block trigger goes off multiple times per tick
# - and because we revoke it, it can re-trigger insantly in the same tick
# - client should still be told about the host criteria though...
# - so why doesn't it reload? because there are so many enter_block going off?

# case 3: revoke host criteria only
# - client does not reload advancements
# - presumably this is because it's not being told about an `impossible`
#   criteria and has no reason to know about `enter_block`? (unsure)
# - so this seems like the solution and we probably don't even need the
#   third `keep` criteria

# case 4: revoke both the enter_block and host criteria
# - client dpes not reload advancements
# - seems to have the same effect as (3)
#   however because we're revoking both advancements in tickbuster:tick anyway,
#   there's no point in doing it here too
# - could say the same for host, except that it seems to be the instigator for
#   the undesirable client updates

# Revoke the `host` advancement because otherwise - for reasons that are not
# fully understood - the client decides to reload all advancements, which not
# only sounds wasteful but also spams the game log.
advancement revoke @a only tickbuster:internal/host host

# Don't start the sub-tick loop unless there are votes to do so.
execute if score $vote tkb.math matches 1.. run function tickbuster:core/main
