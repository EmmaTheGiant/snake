# final-game
now that i am used to gosu, i will make as full of a game as i can

## the idea
i was thinking of making an rpg style game.
my teacher said i can copy an existing game, or make my own.
i was thinking about making an undertale style game or something basic.

### undertale style
if i make an undertale style game, im gonna need different files for the different rooms
maybe make a .rm file for each one
and then have the monsters be .ms files.

`ruins.rm`

```
[
[1,1,1,2,2,1,1,1]
[1,0,0,0,0,1,0,1]
[1,0,1,1,1,0,0,1]
[1,0,0,1,1,0,1,1]
[1,1,0,1,1,0,1,1]
[1,1,0,0,0,0,1,1]
[1,1,0,0,0,0,1,1]
[1,1,1,3,3,1,1,1]
]
```
this would be the room file
`0 is grass`

`1 is brick`

`2 is up room`

`3 is down room`

`4 is left room`

`5 is right room`

### monsters
monsters would be represented in a `monster_name.ms` file that would read like this

```
hp max
strength
array of attack id's
image path
```
