function appr(val, target, amount)
    return val > target 
 	    and max(val-amount, target) 
 	    or min(val+amount, target)
end

function sign(v)
	return v > 0 and 1 or
			v < 0 and -1 or 0
end