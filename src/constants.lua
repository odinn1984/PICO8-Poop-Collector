-- Global Constant Definitions
-- By Odinn1984

-- Buttons
BUTTON_LEFT = 0
BUTTON_RIGHT = 1
BUTTON_UP = 2
BUTTON_DOWN = 3
BUTTON_O = 4
BUTTON_X = 5

-- Actions
ACT_MOVE_LEFT = "LEFT"
ACT_MOVE_RIGHT = "RIGHT"
ACT_JUMP = "JUMP"
ACT_FALL = "FALL"

-- Directions
DIRECTION_LEFT = -1
DIRECTION_NONE = 0
DIRECTION_RIGHT = 1

-- Sprite Flags
FLAG_COLLIDE = 0x1
FLAG_PICKUP_POOP = 0x2
FLAG_EXIT = 0x4
FLAG_DOOR = 0x8
FLAG_PLAYER_STARTR = 0x10
FLAG_PLAYER_STARTL = 0x20

-- SFX
SFX_JUMP = 0
SFX_PICKUP_POOP = 1
SFX_DOOR_OPEN = 2
SFX_LEVEL_EXIT = 3
SFX_WIN = 4
SFX_START_GAME = 5
SFX_TICK = 6
SFX_TICK_ALARM = 7
SFX_MAIN_MENU_BUTTON = 9
SFX_GETTING_READY = 10
SFX_DIE = 11

-- Music
MSC_MAIN_NONE=-1
MSC_GAME_WIN=0
MSC_MAIN_MENU=1
MSC_GAME_OVER=1

-- Sprites
SPR_EMPTY = 8
SPR_POOP_1 = 49
SPR_POOP_2 = 50
SPR_PLAYER_IDLE = 64
SPR_PLAYER_WALK_1 = 65
SPR_PLAYER_WALK_2 = 66
SPR_PLAYER_JUMP = 67
SPR_PLAYER_FALL = 68
SPR_CLOSED_DOOR = 33
SPR_OPEN_DOOR = 34
SPR_TIMER = 35
SPR_LIVES = 36
SPR_RIGHT = 59
SPR_UP = 60
SPR_DOWN = 58
SPR_LEFT = 61
SPR_C = 62
SPR_X = 63
SPR_BIG_POOP = 80
SPR_GAME_TITLE = 72

-- Game States
STATE_MAIN_MENU = 0
STATE_GAME_LOOP = 1
STATE_GAME_PAUSE = 2
STATE_GAME_WIN = 3
STATE_GAME_LOST = 4
STATE_GAME_OVER = 5

-- Strings
NUM_DIFFICULTIES = 3
EASY_DIFFICULTY = 1
NORMAL_DIFFICULTY = 2
HARD_DIFFICULTY = 3
