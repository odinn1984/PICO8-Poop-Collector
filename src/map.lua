function create_map_data(level_num, time)
    local map = {
        x=0,
        y=0,
        celx=(16*(level_num%8))%128,
        cely=(16*flr(level_num/8))%128,
        w=16,
        h=16,
        doorcelx=0,
        doorcely=0,
        time=time,
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
        create_map_data(1, 15),
        create_map_data(2, 20),
        create_map_data(3, 20),
        create_map_data(4, 12),
        create_map_data(5, 12),
        create_map_data(6, 15),
        create_map_data(7, 10),
        create_map_data(8, 15),
        create_map_data(9, 15),
        create_map_data(10, 15),
        create_map_data(11, 15),
        create_map_data(12, 15),
        create_map_data(13, 15),
        create_map_data(14, 15),
        create_map_data(15, 15),
        create_map_data(16, 10),
        create_map_data(17, 15),
        create_map_data(18, 15),
        create_map_data(19, 10),
        create_map_data(20, 10),
        create_map_data(21, 15),
        create_map_data(22, 15),
        create_map_data(23, 10),
        create_map_data(24, 5),
        create_map_data(25, 10),
        create_map_data(26, 10),
        create_map_data(27, 5),
        create_map_data(28, 5),
        create_map_data(29, 5),
        create_map_data(30, 5),
        create_map_data(31, 15)
        
    }
end

function draw_map(mapdata)
    map(
        0, 0, 0, 0, 128, 128
    )
end
