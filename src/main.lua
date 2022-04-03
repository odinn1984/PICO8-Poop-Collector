local game_state = STATE_MAIN_MENU
local debug = false

function _init()
    player = new_player(0, 0, 0.5, 2, 7)
    maps = get_maps()

    initgamemode()
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
    chprint("press x to start", 55, 8)

    spr(SPR_LEFT, 35, 62)
    chprint("level "..(get_current_level_num()+1), 63, 8)
    spr(SPR_RIGHT, 85, 62)

    chprint("--------------------------------", 83, 9)
    print("controls", 2, 88, 9)
    spr(SPR_C, 6, 94)
    print("jump", 16, 96, 15)
    spr(SPR_LEFT, 6, 102)
    print("move left", 16, 104, 15)
    spr(SPR_RIGHT, 6, 110)
    print("move right", 16, 112, 15)
    spr(SPR_X, 6, 118)
    print("reset level", 16, 120, 15)
    chprint("--------------------------------", 125, 9)
end

function draw_gameloop()
    cls()

    draw_map(get_current_level())
    player:draw()
    drawgamemode()

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
end

function draw_gameover()
    cls()
    chprint("--------------------------------", 51, 4)
    spr(SPR_POOP_1, 12, 59)
    mprint("you have been flushed", 4)
    spr(SPR_POOP_2, 108, 59)
    chprint("--------------------------------", 71, 4)
end

function update_menu()
    if btnp(BUTTON_X) then
        start_next_level()
        game_state = STATE_GAME_LOOP
    elseif btnp(BUTTON_LEFT) then
        set_current_level_num(get_current_level_num()-1)
    elseif btnp(BUTTON_RIGHT) then
        set_current_level_num(get_current_level_num()+1)
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
        init_level()
        player.lives -= 1

        if player.lives < 0 then
            sfx(SFX_GAME_OVER)
            game_state = STATE_GAME_OVER
        end
    end

    player:update()

    if pickup_colliding(player) then
        collect_poop()
    end

    if open_door_colliding(player) then
        if not start_next_level() then
            sfx(SFX_WIN)
            game_state = STATE_GAME_WIN
        else
            sfx(SFX_LEVEL_EXIT)
        end
    end
end

function update_pause()
    if btnp(BUTTON_X) then
        game_state = STATE_GAME_LOOP
    elseif btnp(BUTTON_O) then
        game_state = STATE_GAME_LOOP
        reload(0x1000, 0x1000, 0x2000)
        init_level()
        player.lives -= 1
    end
end

function update_gamewin()
    camera(0, 0)
end

function update_gameover()
    camera(0, 0)
end