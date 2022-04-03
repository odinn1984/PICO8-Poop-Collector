function new_player(x, y, accel, max_speed, jump_force)
    
    local player = {
        x = x,
        y = y,
        dx = 0,
        dy = 0,
        w = 8,
        h = 8,
        accel = accel,
        max_speed = max_speed,
        jump_force = jump_force,
        gravity = 0.75,
        friction = 0.7,
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

            self.dy += self.gravity
            self.dx *= self.friction

            if btn(BUTTON_LEFT) then
                self.current_sprite = SPR_PLAYER_IDLE
                self.direction = DIRECTION_LEFT
                self.dx += -self.accel
            elseif btn(BUTTON_RIGHT) then
                self.current_sprite = SPR_PLAYER_IDLE
                self.direction = DIRECTION_RIGHT
                self.dx += self.accel
            end

            if btnp(BUTTON_O) and not self.is_jumping then
                sfx(SFX_JUMP)
                self.dy += -self.jump_force
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
                end
            elseif self.dy < 0 then
                self.is_jumping = true
                self.is_falling = false
                self.current_sprite = SPR_PLAYER_JUMP

                if map_colliding(self, ACT_JUMP) then
                    self.dy = 0
                end
            end

            if abs(self.dx) >= self.max_speed then
                self.dx = self.direction * self.max_speed
            end

            if self.dy >= self.max_speed*2 then
                self.dy = self.max_speed*2
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

            self.x += self.dx
            self.y += self.dy
        end
    }

    return player
end