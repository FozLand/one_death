# one_death
This mod overrides all previously registered on_dieplayer callbacks with a single callback that checks whether or not the player is already dead. Then the previously registered callbacks are called only if the player is still alive.

## How to use
Add every mod that registers an on_dieplayer callback to the depends.txt file.
