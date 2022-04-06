app_id = "2a78625b-634a-4f28-ae7a-86d3f1f1712f"

local game_state = STATE_MAIN_MENU
local debug = false
local start_from_level = get_current_level_num()
local start_from_difficulty = get_difficulty_num()

local DGET_START_LEVEL_IDX = 0
local DGET_START_DIFFICULTY_IDX = 1

function _init()
    cartdata(app_id)

    start_from_level = dget(DGET_START_LEVEL_IDX) or 0
    start_from_difficulty = 
        dget(DGET_START_DIFFICULTY_IDX) == 0 and 
            NORMAL_DIFFICULTY or 
            dget(DGET_START_DIFFICULTY_IDX)

    set_current_level_num(start_from_level)
    set_difficulty(start_from_difficulty)

    player = new_player()
    music(MSC_MAIN_MENU)
end

function _draw()
    if game_state == STATE_MAIN_MENU then
        draw_menu()
    elseif game_state == STATE_GAME_LOOP then
        draw_gameloop()
    elseif game_state == STATE_GAME_PAUSE then
        draw_pause()
    elseif game_state == STATE_GAME_WIN then
        draw_gamewin()
    elseif game_state == STATE_GAME_OVER then
        draw_gameover()
    end
end

function _update60()
    if game_state == STATE_MAIN_MENU then
        update_menu()
    elseif game_state == STATE_GAME_LOOP then
        update_gameloop()
    elseif game_state == STATE_GAME_PAUSE then
        update_pause()
    elseif game_state == STATE_GAME_WIN then
        update_gamewin()
    elseif game_state == STATE_GAME_OVER then
        update_gameover()
    end
end

function draw_menu()
    cls()
    chprint("--------------------------------", 10, 4)
    spr(SPR_POOP_1, 25, 14)
    chprint("poop collector", 16, 4)
    spr(SPR_POOP_2, 95, 14)
    chprint("--------------------------------", 22, 4)

    chprint("press c to start", 40, 8)

    spr(SPR_LEFT, 35, 53)
    chprint("level "..(get_current_level_num()+1), 54, 14)
    spr(SPR_RIGHT, 85, 53)

    spr(SPR_X, 35, 62)
    chprint(get_difficulty(), 63, 14)

    chprint("--------------------------------", 83, 9)
    print("controls", 2, 88, 9)
    spr(SPR_C, 6, 94)
    print("/", 14, 96, 15)
    spr(SPR_UP, 17, 94)
    print("jump", 28, 96, 15)
    spr(SPR_LEFT, 6, 102)
    print("move left", 28, 104, 15)
    spr(SPR_RIGHT, 6, 110)
    print("move right", 28, 112, 15)
    spr(SPR_X, 6, 118)
    print("reset level", 28, 120, 15)
    chprint("--------------------------------", 125, 9)
end

function draw_gameloop()
    cls()

    draw_map(get_current_level())
    player:draw()
    drawgamemode()

    if player.ready_to_move then
        draw_dialog("move to start")
    end

    if hitbox != nil and #hitbox > 0 and debug then
        rectfill(
            hitbox[1].x,
            hitbox[1].y,
            hitbox[2].x,
            hitbox[2].y,
            7
        )
    end
end

function draw_pause()
    draw_confirm_dialog("reset level?")
end

function draw_gamewin()
    cls()
    chprint("--------------------------------", 51, 4)
    spr(SPR_POOP_1, 15, 59)
    mprint("poop power achieved", 4)
    spr(SPR_POOP_2, 105, 59)
    chprint("--------------------------------", 71, 4)

    chprint("[c]restart [x]main menu", 120, 8)
end

function draw_gameover()
    cls()
    chprint("--------------------------------", 51, 4)
    spr(SPR_POOP_1, 12, 59)
    mprint("you have been flushed", 4)
    spr(SPR_POOP_2, 108, 59)
    chprint("--------------------------------", 71, 4)

    chprint("[c]restart [x]main menu", 120, 8)
end

function update_menu()
    local current_level_num = get_current_level_num()

    if btnp(BUTTON_O) then
        music(MSC_MAIN_NONE, 500)
        sfx(SFX_START_GAME)
        wait(50)

        maps = get_maps()
        initgamemode()
        start_next_level()
        game_state = STATE_GAME_LOOP
    elseif btnp(BUTTON_LEFT) then
        sfx(SFX_MAIN_MENU_BUTTON)
        start_from_level = (current_level_num-1)%get_level_amount()
        set_current_level_num(start_from_level)
        dset(DGET_START_LEVEL_IDX, start_from_level)
    elseif btnp(BUTTON_RIGHT) then
        sfx(SFX_MAIN_MENU_BUTTON)
        start_from_level = (current_level_num+1)%get_level_amount()
        set_current_level_num(start_from_level)
        dset(DGET_START_LEVEL_IDX, start_from_level)
    elseif btnp(BUTTON_X) then
        sfx(SFX_MAIN_MENU_BUTTON)
        toggle_difficulty()
        start_from_difficulty = get_difficulty_num()
        dset(DGET_START_DIFFICULTY_IDX, start_from_difficulty)
    end
end

function update_gameloop()
    if btnp(BUTTON_X) then
        game_state = STATE_GAME_PAUSE
    end

    if game_state != STATE_GAME_LOOP then
        return
    end

    if not updategamemode() then
        reload(0x1000, 0x1000, 0x2000)

        kill_player()

        if player.lives >= 0 then
            init_level()
        end
    end

    player:update()

    if (abs(player.dx) > 0 or abs(player.dy) > 0) and pickup_colliding(player) then
        collect_poop()
    end

    if open_door_colliding(player) then
        if not start_next_level() then
            music(MSC_GAME_WIN)
            game_state = STATE_GAME_WIN
        end
    end
end

function update_pause()
    if btnp(BUTTON_X) then
        game_state = STATE_GAME_LOOP
    elseif btnp(BUTTON_O) then
        game_state = STATE_GAME_LOOP
        reload(0x1000, 0x1000, 0x2000)

        if get_difficulty_num() == NORMAL_DIFFICULTY then
            kill_player()
        end

        if player.lives >= 0 then
            init_level()
        end
    end
end

function update_gamewin()
    camera(0, 0)
    handle_endgame_input()
end

function update_gameover()
    camera(0, 0)
    handle_endgame_input()
end

function handle_endgame_input()
    if btnp(BUTTON_X) then
        game_state = STATE_MAIN_MENU

        music(MSC_MAIN_NONE, 500)
        restart_game()
        music(MSC_MAIN_MENU)
    elseif btnp(BUTTON_O) then
        game_state = STATE_GAME_LOOP

        music(MSC_MAIN_NONE, 500)
        restart_game()
        start_next_level()
    end
end

function restart_game()
    player = new_player()
    start_from_level = dget(DGET_START_LEVEL_IDX) or 0
    start_from_difficulty = dget(DGET_START_DIFFICULTY_IDX) or NORMAL_DIFFICULTY

    sfx(SFX_START_GAME)
    wait(50)

    set_difficulty(start_from_difficulty)
    set_current_level_num(start_from_level)
    initgamemode()
end

function kill_player()
    player.lives -= 1

    if player.lives < 0 then
        music(MSC_GAME_OVER)
        game_state = STATE_GAME_OVER
    end

    sfx(SFX_DIE)
    wait(100)
end

function wait(t)
    for i = 1,t do flip() end
end
