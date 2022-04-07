function draw_confirm_dialog(text)
    local map = get_current_level()
    local centx = 64+(map.celx*8)
    local centy = 61+(map.cely*8)
    local color = 0
    local textcolor = 15
    local framecolor = 7
    local buttoncolor = 1
    local conftext = "[c]yes [x]no"
    local textlen = max(#conftext, #text)
    local tcentx = centx-textlen*2
    local tcentx2 = centx+textlen*2
    local tcenty = centy
    local margin = 10
    local bottommargin = 12

    rectfill(
        tcentx-margin,
        tcenty-margin,
        tcentx2+margin,
        tcenty+bottommargin,
        color
    )

    rectfill(
        tcentx-margin,
        tcenty+margin+1,
        tcentx2+margin,
        tcenty+margin-5,
        buttoncolor
    )

    rect(
        tcentx-margin,
        tcenty-margin,
        tcentx2+margin,
        tcenty+bottommargin,
        framecolor
    )

    print(text, tcentx, centy-5, textcolor)
    print(conftext, tcentx, centy+6, textcolor)
end

function draw_dialog(text)
    local map = get_current_level()
    local centx = 64+(map.celx*8)
    local centy = 61+(map.cely*8)
    local color = 0
    local textcolor = 15
    local framecolor = 7
    local tcentx = centx-#text*2
    local tcentx2 = centx+#text*2
    local tcenty = centy
    local margin = 10

    rectfill(
        tcentx-margin,
        tcenty-margin,
        tcentx2+margin,
        tcenty+margin-5,
        color
    )

    rect(
        tcentx-margin,
        tcenty-margin,
        tcentx2+margin,
        tcenty+margin-5,
        framecolor
    )

    print(text, tcentx, centy-5, textcolor)
end
