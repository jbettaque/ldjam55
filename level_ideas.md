# Minions

- Default, can interact, can step, can finish (Homunculus)
- Slow, Can't interact, can step (Zombie)
- Flies, can't step, can interact
- can fight

# Components

- [x] start / summoning spot
- [ ] goal
- [x] wall
- [x] ground
- [x] pit
- [ ] moveable boxes
- [ ] mines sacrifice a minion


- switch
- step on plate
- door, trap
- draw bridge
- secondary summoning spot
- timer / timed button
- teleporter (toggelable or instant)
- resummoner
- key/lock
- guard

# Puzzle Matrix

|        | Box | Button |  Door   | Key |  Lever  |  Mine   |  Plate  |  Spike  |
|:------:|:---:|:------:|:-------:|:---:|:-------:|:-------:|:-------:|:-------:|
|  Box   |     |   -    |    -    |  -  |    -    |    -    |    -    |    -    |
| Button |     |        |    -    |  -  |    -    |    -    |    -    |    -    |
|  Door  |     |        | &check; |  -  |    -    |    -    |    -    |    -    |
|  Key   |     |        |         |     |    -    |    -    |    -    |    -    |
| Lever  |     |        | &check; |     | &check; |    -    |    -    |    -    |
|  Mine  |     |        |         |     |         | &check; |    -    |    -    |
| Plate  |     |        | &check; |     |         |         | &check; |    -    |
| Spike  |     |        |         |     |         |         | &check; | &check; |
