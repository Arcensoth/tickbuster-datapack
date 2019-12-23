#> tickbuster:tick/with_votes/without_player
#
# @context root

# Warn admins using the action bar.
title @a[tag=tickbuster.admin] actionbar [{"text": "", "color": "red"}, {"text": "[Tickbuster]", "color": "aqua"}, " Failed to find an eligible host player to start the sub-tick loop."]

# Reset votes for next tick.
scoreboard players set $vote tkb.math 0
