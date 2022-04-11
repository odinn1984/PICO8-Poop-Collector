function appr(val, target, amount)
    return val > target
 	    and max(val-amount, target)
 	    or min(val+amount, target)
end

function sign(v)
	return v > 0 and 1 or
			v < 0 and -1 or 0
end

function round(num, decimal_places)
    local mult = 10^(decimal_places or 0)
    return flr(num * mult + 0.5) / mult
end

function fade_out()
	local dpal = {0,1,1,2,1,13,6,4,4,9,3,13,1,13,14}

	for i=0,40 do
		for j=1,15 do
			local col = j

			for k=1,((i+(j%5))/2) do
				col = dpal[col]
			end

			pal(j, col, 1)
		end

		flip()
	end
end
