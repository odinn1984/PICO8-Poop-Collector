![alt Poop Collector](https://raw.githubusercontent.com/odinn1984/PICO8-Poop-Collector/main/assets/banners/PoopCollectorLogo%202000x400.png?raw=true)

Simple 2D platformer game made with PICO-8, I must admit... This is a SHITTY game :)

## About
This game is a simple platformer where you need to collect poop in a limited amount of time to open the door and clear the level and move to the next one.

This game has 32 level each one with different amounts of poop to collect and different times to clear them.

This game has 2 difficulties:
* Easy
  * Start with 5 lives
  * Each level has extra 4 seconds
  * When resetting a level you don't loose a life
* Normal
  * Start with 5 lives
  * No change in base time for levels
  * When you reset the level you lose 1 life

## How to run?
Clone the repository with:
```bash
gh repo clone odinn1984/PICO8-Poop-Collector
```

Open PICO-8 and run the `folder` command to open the folder where the games are stored and copy the repository to that folder.

Navigate to the `poop-collector.p8` file inside PICO-8 and run 
```bash
load poop-collector.p8
``` 
and then execute the `run` command and play!

## Controls

### In Game
* Left / Right - Navigate
* C / Up - Jump
* X - Reset Level
  * C - Yes
  * X - No

### In Main Menu
* Left / Right - Change starting level
* X - Change Difficulty
* C - Start game

### In End Game Scene (Game Over or Game Finished)
* X - Back to Main Menu
* C - Restart game from the level you started at on the difficulty u started the run at

## TODO
* Add "Best" and "Latest" runs (level reached and total time)
* Add "Level Reached" and "Total Time" in "game over" and only "Total Time" in "game win" states
