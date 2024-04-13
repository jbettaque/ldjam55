utils = {}

function utils.clamp(min, value, max)
	if value < min then
		return min
	elseif value > max then
		return max
	else
		return value
	end
end
