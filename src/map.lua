function create_map_data(level_num, time)
    local get_difficulty_extra_time = function(difficulty)
       if difficulty == EASY_DIFFICULTY then
           return 4
       elseif difficulty == NORMAL_DIFFICULTY then
            return 0
       elseif difficulty == HARD_DIFFICULTY then
            return -2
       end
    end

    local extra_time = get_difficulty_extra_time(get_difficulty_num())
    local new_time = (
        time <= 5 and
        get_difficulty_num() == HARD_DIFFICULTY and
            time or max(5, time+extra_time)
    )
    local map = {
        x=0,
        y=0,
        celx=(16*(level_num%8))%128,
        cely=(16*flr(level_num/8))%128,
        w=16,
        h=16,
        doorcelx=0,
        doorcely=0,
        time=new_time,
    }

    for i=map.celx,map.celx+map.w do
        for j=map.cely,map.cely+map.h do
            if fget(mget(i, j)) == FLAG_DOOR then
                map.doorcelx = i
                map.doorcely = j
            end
        end
    end

    return map
end

function get_maps()
    return {
        create_map_data(0, 8),
        create_map_data(1, 12),
        create_map_data(2, 12),
        create_map_data(3, 11),
        create_map_data(4, 11),
        create_map_data(5, 10),
        create_map_data(6, 12),
        create_map_data(7, 10),
        create_map_data(8, 9),
        create_map_data(9, 10),
        create_map_data(10, 10),
        create_map_data(11, 11),
        create_map_data(12, 9),
        create_map_data(13, 8),
        create_map_data(14, 8),
        create_map_data(15, 11),
        create_map_data(16, 11),
        create_map_data(17, 5),
        create_map_data(18, 10),
        create_map_data(19, 8),
        create_map_data(20, 7),
        create_map_data(21, 11),
        create_map_data(22, 11),
        create_map_data(23, 6),
        create_map_data(24, 3),
        create_map_data(25, 4),
        create_map_data(26, 7),
        create_map_data(27, 3),
        create_map_data(28, 3),
        create_map_data(29, 3),
        create_map_data(30, 3),
        create_map_data(31, 10)
    }
end

function draw_map(mapdata)
    map(
        0, 0, 0, 0, 128, 128
    )
end
