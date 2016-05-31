


addhook("second","day")
function day()
	t = t+1
	if ( t%2 == 0 ) then -- Modulo Operator: Gerade Zahlen
		parse("sv_daylighttime "..(t/2))
		
		if (t>=760) then
			t=0
		end
	end
end