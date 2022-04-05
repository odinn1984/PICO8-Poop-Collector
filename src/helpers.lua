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