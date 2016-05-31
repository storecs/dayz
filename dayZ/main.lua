dayz = {}

dofile("sys/lua/DayZ-Mod/environment.lua")
dofile("sys/lua/DayZ-Mod/inventory.lua")

dayz.array = function(default)
     local array={}
     for i=1, 32 do
          array[i]=default
     end
     return array
end

dayz.spawn = {}

dayz.spawn.x = array(nil)
dayz.spawn.y = array(nil)
dayz.spawn.inv = array(dayz.inv.empty())


dayz.spawn.loadspawn = function(id)
	x = dayz.spawn.x[id]
	y = dayz.spawn.y[id]
	usgn = player(id,"usgn")
	
	if not (usgn > 0) then
		return
	end
	file = io.open("sys/lua/DayZ-Mod/player/"..usgn..".txt","r")
     
	if file~=nil then
		dayz.spawn.x[id]= file[id]:read("*number")
		dayz.spawn.y[id]= file[id]:read("*number")
		file:close()
	end
end
addhook("join","dayz.spawn.loadspawn")

addhook("leave","dayz.addhook("join","dayz.spawn.loadspawn").savespawn")
function dayz.addhook("join","dayz.spawn.loadspawn").savespawn(id,reason)
	x = dayz.spawn.x[id]
	y = dayz.spawn.y[id]
	usgn = player(id,"usgn")
	
	if (usgn ~= 0) then -- save last save point
		file=io.open("sys/lua/DayZ-Mod/player/"..tostring(usgn)..".txt","w+")
		if x~=nil and y~=nil then     
			file:write(x)
			file:write(y)
		elseif (player(id,"health") > 0) then -- save last position
			file:write(player(id,"tilex"))
		else
			file:write(player(id,"tiley"))
			dayz.spawn.x[id] = nil
			dayz.spawn.y[id] = nil
		end
		file:close()
	end
end

addhook("spawn","setsp")
setsp = function(id)
	x = dayz.spawn.x[id]
	y = dayz.spawn.y[id]
	usgn = player(id,"usgn")
	
	if x~=nil and y~=nil then
		parse("setpos "..id.." "..x[.." "..y)
	end
end


addhook("die","newspawn")
function newspawn(id)
     x[id]=nil
     y[id]=nil
end
