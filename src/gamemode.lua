local number_of_levels = 32
local current_level = 0
local poops_to_collect = 0
local poops_collected = 0
local level_cleared = false
local sec_for_level = 0
local sec_remaining = 0
local frame_time_interval = 1/60
local ticks = 0
local maps = {}
local difficulty = NORMAL_DIFFICULTY

function initgamemode()
    maps = get_maps()
    poops_to_collect = 0
    poops_collected = 0
    sec_for_level = 20
    sec_remaining = sec_for_level
end

function updategamemode()
    local map = get_current_level()

    if poops_collected == poops_to_collect and not level_cleared then
        sfx(SFX_DOOR_OPEN)
        mset(map.doorcelx, map.doorcely, SPR_OPEN_DOOR)
        level_cleared = true
    end

    sec_remaining -= frame_time_interval
    ticks += 1

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

    if sec_remaining <= 0 then
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
    print(sec_remaining, clockpos+10, mapy+2, 7)

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
    return difficulty
end

function set_difficulty(dif)
    if dif != EASY_DIFFICULTY and dif != NORMAL_DIFFICULTY then
        return false
    end

    difficulty = dif
end

function toggle_difficulty()
    if difficulty == NORMAL_DIFFICULTY then
        difficulty = EASY_DIFFICULTY
    else
        difficulty = NORMAL_DIFFICULTY
    end
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
    if current_level < number_of_levels then
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

    for i=map.celx,map.celx+map.w do
        for j=map.cely,map.cely+map.h do
            if mget(i, j) == SPR_POOP_1 or mget(i, j) == SPR_POOP_2 then
                poops_to_collect += 1
            elseif fget(mget(i, j)) == FLAG_PLAYER_START then
                mset(i, j, SPR_EMPTY)
                
                player.x = i*8
                player.y = j*8
                player.ready = true
            end
        end
    end

    player.jump_buffer = player.max_jumps

    sfx(SFX_START_LEVEL)
end
