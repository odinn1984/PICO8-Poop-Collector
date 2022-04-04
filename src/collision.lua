function pickup_colliding(obj)
    local x = obj.x+2
    local y = obj.y+2
    local w = obj.w-2
    local h = obj.h-2
    local colliding = false

    if fget(mget(x/8, y/8)) == FLAG_PICKUP_POOP then
        mset(x/8, y/8, SPR_EMPTY)
        colliding = true
    elseif fget(mget(x/8, (y+h)/8)) == FLAG_PICKUP_POOP then
        mset(x/8, (y+h)/8, SPR_EMPTY)
        colliding = true
    elseif fget(mget((x+w)/8, y/8)) == FLAG_PICKUP_POOP then
        mset((x+w)/8, y/8, SPR_EMPTY)
        colliding = true
    elseif fget(mget((x+w)/8, (y+h)/8)) == FLAG_PICKUP_POOP then
        mset((x+w)/8, (y+h)/8, SPR_EMPTY)
        colliding = true
    end

    return colliding
end

function open_door_colliding(obj)
    local x = obj.x+2
    local y = obj.y+2
    local w = obj.w-2
    local h = obj.h-2

    return fget(mget(x/8, y/8)) == FLAG_EXIT or
        fget(mget(x/8, (y+h)/8)) == FLAG_EXIT or
        fget(mget((x+w)/8, y/8)) == FLAG_EXIT or 
        fget(mget((x+w)/8, (y+h)/8)) == FLAG_EXIT
end

function map_colliding(obj, action)
    hitbox = {}

    if action == ACT_MOVE_LEFT then
        hitbox = {
            {
                x = obj.x+1,
                y = obj.y+2
            },
            {
                x = obj.x-1,
                y = obj.y+obj.h-2
            }
        }
    elseif action == ACT_MOVE_RIGHT then
        hitbox = {
            {
                x = obj.x+obj.w-2,
                y = obj.y+2
            },
            {
                x = obj.x+obj.w-1,
                y = obj.y+obj.h-2
            }
        }
    elseif action == ACT_FALL then
        hitbox = {
            {
                x = obj.x+2,
                y = obj.y+obj.h
            },
            {
                x = obj.x+obj.w-3,
                y = obj.y+obj.h+1
            }
        }
    elseif action == ACT_JUMP then
        hitbox = {
            {
                x = obj.x+2,
                y = obj.y
            },
            {
                x = obj.x+obj.w-3,
                y = obj.y-1
            }
        }
    end

    if fget(mget(hitbox[1].x/8, hitbox[1].y/8)) == FLAG_COLLIDE or
        fget(mget(hitbox[1].x/8, hitbox[2].y/8)) == FLAG_COLLIDE or
        fget(mget(hitbox[2].x/8, hitbox[1].y/8)) == FLAG_COLLIDE or
        fget(mget(hitbox[2].x/8, hitbox[2].y/8)) == FLAG_COLLIDE
    then
        return true
    end

    return false
end