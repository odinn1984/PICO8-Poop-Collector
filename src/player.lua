function new_player()
    local player = {
        x = 0,
        y = 0,
        prevy = 0,
        dx = 0,
        dy = 0,
        w = 8,
        h = 8,
        accel = 0.6,
        deccel = 0.15,
        max_gravity = 0.41,
        max_speed = 1.5,
        max_fall_speed = 4.25,
        max_jump_speed = 4.25,
        jumps_left = 1,
        max_jumps = 1,
        direction = DIRECTION_RIGHT,
        is_falling = false,
        is_jumping = false,
        ready = false,
        current_sprite = SPR_PLAYER_IDLE,
        lives = 5,

        draw = function(self)
            spr(
                self.current_sprite, 
                self.x, 
                self.y, 
                self.w/8, 
                self.h/8, 
                self.direction != DIRECTION_RIGHT
            )
        end,

        update = function(self)
            if not self.ready then
                return
            end

            if self.is_falling or self.is_jumping then
                self.accel = 0.4
            end

            local gravity = self.max_gravity

            if abs(self.dy) <= 1.0 then
                gravity *= 0.6
            end

            local moving_direction = DIRECTION_NONE

            if btn(BUTTON_LEFT) and not map_colliding(self, ACT_MOVE_LEFT) then
                if not self.is_falling and not self.is_jumping then 
                    self.current_sprite = SPR_PLAYER_IDLE
                end 

                self.direction = DIRECTION_LEFT
                moving_direction = DIRECTION_LEFT
            elseif btn(BUTTON_RIGHT) and not map_colliding(self, ACT_MOVE_RIGHT) then
                if not self.is_falling and not self.is_jumping then 
                    self.current_sprite = SPR_PLAYER_IDLE
                end 

                self.direction = DIRECTION_RIGHT
                moving_direction = DIRECTION_RIGHT
            end

            if btnp(BUTTON_O) and self.jumps_left > 0 and not map_colliding(self, ACT_JUMP) then
                sfx(SFX_JUMP)
                self.dy = -self.max_jump_speed
                self.jumps_left -= 1
            end

            if self.dy > 0 then
                self.is_falling = true
                self.current_sprite = SPR_PLAYER_FALL

                if map_colliding(self, ACT_FALL) then
                    self.current_sprite = SPR_PLAYER_IDLE
                    self.is_falling = false
                    self.is_jumping = false
                    self.dy = 0
                    self.y -= ((self.y+self.h+1)%8)-1
                    self.jumps_left = self.max_jumps
                end
            elseif self.dy < 0 then
                self.is_jumping = true
                self.is_falling = false
                self.current_sprite = SPR_PLAYER_JUMP

                if map_colliding(self, ACT_JUMP) then
                    if abs(self.dx) > 0 then
                        self.y = self.prevy
                    else
                        self.dy = 0
                    end
                end
            end

            if abs(self.dx) > self.max_speed then
                self.dx = appr(
                    self.dx,
                    sign(self.dx) * self.max_speed,
                    self.deccel
                )
            else
                self.dx = appr(
                    self.dx,
                    moving_direction * self.max_speed,
                    self.accel
                )
            end

            if self.dx > 0 then
                if map_colliding(self, ACT_MOVE_RIGHT) then
                    self.dx = 0
                end
            elseif self.dx < 0 then
                if map_colliding(self, ACT_MOVE_LEFT) then
                    self.dx = 0
                end
            end

            if not map_colliding(self, ACT_FALL) then
                self.dy = appr(
                    self.dy, 
                    self.max_fall_speed,
                    gravity
                )
            end

            self.prevy = self.y
            self.x += self.dx
            self.y += self.dy
        end
    }

    return player
end