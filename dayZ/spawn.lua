dofile("sys/lua/DayZ-Mod/environment.lua")
dofile("sys/lua/DayZ-Mod/environment.lua")

dayz = {}
dayz.main.array = function(default)
     local array={}
     for i=1, 32 do
          array[i]=default
     end
     return array
end

dayz.main = {}

dayz.main.file = array(32)

dayz.main.x = array(nil)
dayz.main.y = array(nil)
dayz.main.inv = array(dayz.inv.empty())

addhook("join","dayz.main.loadspawn")
dayz.main.loadspawn = function(id)
	x = dayz.main.x[id]
	y = dayz.main.y[id]
	usgn = player(id,"usgn")
	
	if not (usgn > 0) then
		return
	end
	file = io.open("sys/lua/DayZ-Mod/player/"..usgn..".txt","r")
     
	if file~=nil then
		dayz.main.x[id]= file[id]:read("*number")
		dayz.main.y[id]= file[id]:read("*number")
		file:close()
	end
end

addhook("leave","dayz.main.savespawn")
function dayz.main.savespawn(id,reason)
	x = dayz.main.x[id]
	y = dayz.main.y[id]
	usgn = player(id,"usgn")
	
	if (usgn ~= 0) then -- save last save point
		if x~=nil and y~=nil then     
			file=io.open("sys/lua/DayZ-Mod/player/"..usgn..".txt","w+")
			file:write(x.." "..y)
			file:close()
		elseif (player(id,"health") > 0) then -- save last position
			file=io.open("sys/lua/DayZ-Mod/player/"..usgn..".txt","w+")
			file:write(player(id,"tilex").." "..player(id,"tiley"))
			file:close()
		else
			
		end
	end
end

addhook("spawn","setsp")
setsp = function(id)
	x = dayz.main.x[id]
	y = dayz.main.y[id]
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