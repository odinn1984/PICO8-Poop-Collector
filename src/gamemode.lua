local number_of_levels = 32
local current_level = 0
local poops_to_collect = 0
local poops_collected = 0
local level_cleared = false
local sec_for_level = 0.0
local sec_remaining = 0.0
local frame_time_interval = 1/60
local ticks = 60
local maps = {}
local difficulty = NORMAL_DIFFICULTY

function initgamemode()
    reload(0x1000, 0x1000, 0x2000)

    maps = get_maps()
    poops_to_collect = 0
    poops_collected = 0
    sec_for_level = 20.0
    sec_remaining = 0.0
end

function updategamemode()
    if not player.ready then
        return true
    end

    local map = get_current_level()

    if poops_collected == poops_to_collect and not level_cleared then
        sfx(SFX_DOOR_OPEN)
        mset(map.doorcelx, map.doorcely, SPR_OPEN_DOOR)
        level_cleared = true
    end

    if ticks >= 60 then
        if sec_remaining > 0.3 then
            if sec_remaining > 5.3 then
                sfx(SFX_TICK)
            else
                sfx(SFX_TICK_ALARM)
            end
        end

        ticks = 0
    end

    sec_remaining -= frame_time_interval
    ticks += 1

    if sec_remaining < 0 then
        sec_remaining = sec_for_level
        poops_collected = 0
        return false
    end

    return true
end

function drawgamemode()
    local map = get_current_level()
    local mapx = map.celx*8
    local mapy = map.cely*8
    local pooppos = mapx

    spr(SPR_POOP_1, pooppos, mapy)
    print(poops_collected.."/"..poops_to_collect, pooppos+10, mapy+2, 7)

    local timerlen = 7
    local clockpos = mapx+(53-(flr(timerlen/2)))

    spr(SPR_TIMER, clockpos, mapy)
    print(round(sec_remaining, 2), clockpos+10, mapy+2, 7)

    local livespos = mapx+119

    spr(SPR_LIVES, livespos, mapy)
    print(player.lives, livespos-4, mapy+2, 7)
end

function get_current_level()
    return maps[current_level]
end

function get_level_amount()
    return number_of_levels
end

function get_current_level_num()
    return current_level
end

function set_current_level_num(level_num)
    if level_num < 0 or level_num > number_of_levels-1 then
        return false
    end

    current_level = level_num
end

function get_poops_count()
    return poops_collected
end

function get_difficulty()
    if difficulty == EASY_DIFFICULTY then
        return "easy"
    elseif difficulty == NORMAL_DIFFICULTY then
        return "normal"
    elseif difficulty == HARD_DIFFICULTY then
        return "hard"
    end

    return false
end

function get_difficulty_num()
    return difficulty
end

function set_difficulty(dif)
    if dif < 1 or dif > (NUM_DIFFICULTIES+1) then
        return false
    end

    difficulty = dif
end

function toggle_difficulty()
    local new_difficulty = (get_difficulty_num()) % NUM_DIFFICULTIES

    if new_difficulty + 1 == HARD_DIFFICULTY then
        player.lives = 1
    else
        player.lives = 5
    end

    difficulty = new_difficulty + 1
end

function collect_poop()
    if poops_collected <= poops_to_collect then
        sfx(SFX_PICKUP_POOP)
        poops_collected += 1
        return true
    else
        return false
    end
end

function start_next_level()
    if current_level < number_of_levels and player.lives >= 0 then
        current_level += 1

        init_level()

        return true
    else
        return false
    end
end

function init_level()
    level_cleared = false
    poops_to_collect = 0
    poops_collected = 0

    local map = get_current_level()

    camera(
        map.celx*8,
        map.cely*8
    )

    sec_remaining = map.time
    ticks = 60

    for i=map.celx,map.celx+map.w do
        for j=map.cely,map.cely+map.h do
            if mget(i, j) == SPR_POOP_1 or mget(i, j) == SPR_POOP_2 then
                poops_to_collect += 1
            elseif fget(mget(i, j)) == FLAG_PLAYER_STARTR or
                fget(mget(i, j)) == FLAG_PLAYER_STARTL
            then
                player.x = i*8
                player.y = j*8
                player.ready = true
                player.direction =
                    fget(mget(i, j)) == FLAG_PLAYER_STARTR and
                        DIRECTION_RIGHT or
                        DIRECTION_LEFT

                mset(i, j, SPR_EMPTY)
            end
        end
    end

    player.jump_buffer = player.max_jumps
    player.ready = false
    player.ready_to_move = false
    player.ready_to_move_start = time()
    player.dx = 0
    player.dy = 0
    player.is_falling = false
    player.is_jumping = false
    player.jumps_left =  player.max_jumps
    player.current_sprite = SPR_PLAYER_IDLE

    sfx(SFX_GETTING_READY)
end
