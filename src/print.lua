function chprint(text, y, color)
    print(text, 64-#text*2, y, color)
end

function cvprint(text, x, color)
    print(text, x, 61, color)
end

function mprint(text, color)
    print(text, 64-#text*2, 61, color)
end