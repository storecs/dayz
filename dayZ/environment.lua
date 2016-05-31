
dayz.env = {}
dayz.env.t = 270.0

dayz.env.night = function()
	dayz.env.t += 1
	
	if (dayz.env.t >= 760) then
		dayz.env.t = 0
	end
	
	if (dayz.env.t % 2 == 0) then -- Modulo Operator: Gerade Zahlen
		parse("sv_daylighttime "..(dayz.env.t / 2))
	end
end

addhook("second","dayz.env.night")
