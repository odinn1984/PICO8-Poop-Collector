function create_map_data(level_num, time)
    local extra_time = get_difficulty_num() == NORMAL_DIFFICULTY and 0 or 4
    local map = {
        x=0,
        y=0,
        celx=(16*(level_num%8))%128,
        cely=(16*flr(level_num/8))%128,
        w=16,
        h=16,
        doorcelx=0,
        doorcely=0,
        time=time+extra_time,
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
        create_map_data(0, 10),
        create_map_data(1, 13),
        create_map_data(2, 15),
        create_map_data(3, 12),
        create_map_data(4, 12),
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
        create_map_data(15, 12),
        create_map_data(16, 11),
        create_map_data(17, 5),
        create_map_data(18, 11),
        create_map_data(19, 10),
        create_map_data(20, 8),
        create_map_data(21, 12),
        create_map_data(22, 15),
        create_map_data(23, 7),
        create_map_data(24, 5),
        create_map_data(25, 5),
        create_map_data(26, 8),
        create_map_data(27, 5),
        create_map_data(28, 5),
        create_map_data(29, 5),
        create_map_data(30, 5),
        create_map_data(31, 12)
        
    }
end

function draw_map(mapdata)
    map(
        0, 0, 0, 0, 128, 128
    )
end
