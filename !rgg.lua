--������ �������� �� ������ ����� ����� �� �����: http://www.rubbishman.ru/samp
--------------------------------------------------------------------------------
-------------------------------------META---------------------------------------
--------------------------------------------------------------------------------
script_name("/RGG")
script_version("1.3")
script_author("rubbishman")
script_description("/rgg")
--------------------------------------VAR---------------------------------------
color = -1
Enable = false
pause = false
given = {}
--------------------------------------------------------------------------------
--------------------------------------INI---------------------------------------
--------------------------------------------------------------------------------
local inicfg = require 'inicfg'
local settings = inicfg.load({
	options =
	{
		startmessage = 1,
		delay = 1400,
		testmode = 0,
		distance = 999,
		lvl = 2,
		render = 1,
	},
	slot0 =
	{
		type0 = "[-] ������",
	},
	slot1 =
	{
		type1 = "[-] ������",
	},
	slot2 =
	{
		type2 = "[-] ������",
		kolvo22 = 0,
		kolvo24 = 0,
	},
	slot3 =
	{
		type3 = "[25] Shotgun",
		kolvo25 = 0,
	},
	slot4 =
	{
		type4 = "[29] MP5",
		kolvo29 = 0,
	},
	slot5 =
	{
		type5 = "[-] ������",
		kolvo30 = 0,
		kolvo31 = 0,
	},
	slot6 =
	{
		type6 = "[33] Rifle",
		kolvo33 = 0,
	},
	slot9 =
	{
		type9 = "[-] ������",
		kolvo43 = 0,
	},
	slot11 =
	{
		type11 = "[-] ������",
	},
}, 'rgg.ini')
inicfg.save(settings, 'rgg.ini')
--------------------------------------------------------------------------------
--------------------------------------MAIN--------------------------------------
--------------------------------------------------------------------------------
function main()
	while not isSampAvailable() do wait(10) end
	wait(1000)
	if settings.options.startmessage == 1 then
		sampAddChatMessage((thisScript().name..' v'..thisScript().version..' by rubbishman (�� �� James_Bond, �� �� Phil_Coulson) �������. ������� ��� Samp-Rp.'),
		0x348cb2)
		sampAddChatMessage(('��������� - /rgg. ������ ���� - /rg. ������ ������ - /rg id. ��������� ��� ��������� - /rggnot.'), 0x348cb2)
	end
	sampRegisterChatCommand("rgg", scriptmenu)
	sampRegisterChatCommand("rg", rgg)
	sampRegisterChatCommand("rgp", rggpause)
	sampRegisterChatCommand("rggnot", cmdScriptInform)
	menuupdate()
	nabor()
	resX, resY = getScreenResolution()
	font = renderCreateFont("Arial", 8, 5)
	lua_thread.create(render)
	while true do
		wait(0)
		if menutrigger ~= nil then menu() menutrigger = nil end
	end
end
--------------------------------------------------------------------------------
-------------------------------------RENDER-------------------------------------
--------------------------------------------------------------------------------
function render()
	while true do
		wait(0)
		while Enable == true and settings.options.render == 1 do
			wait(0)
			renderFontDrawText(font, "rubbihman's givegun\n������: "..tostring(Enable).."\n����� (/rgp): "..tostring(pause).."\n�����: "..tostring(currentid).."\nLast: "..tostring(string).."\n������ �����: "..#given.."\n������� � ������: "..onstart.." ("..count..") ����, "..(sampGetPlayerCount(true) - 1).." ������\n��������� � ������: "..tostring(summcount), resX / 50, resY / 2.5, 0xFF00FF00)
		end
	end
end
--------------------------------------------------------------------------------
----------------------------------ini to string---------------------------------
--------------------------------------------------------------------------------
function nabor()
	wait(200)
	slot0 = string.match(settings.slot0.type0, "(%d+)")
	slot1 = string.match(settings.slot1.type1, "(%d+)")
	slot2 = string.match(settings.slot2.type2, "(%d+)")
	slot3 = string.match(settings.slot3.type3, "(%d+)")
	slot4 = string.match(settings.slot4.type4, "(%d+)")
	slot5 = string.match(settings.slot5.type5, "(%d+)")
	slot6 = string.match(settings.slot6.type6, "(%d+)")
	slot9 = string.match(settings.slot9.type9, "(%d+)")
	slot11 = string.match(settings.slot11.type11, "(%d+)")
	summ = ""
	summcount = 0
	if slot0 ~= nil then
		summ = summ.."���� 0: "..settings.slot0.type0.."\n"
		summcount = summcount + 1
	end
	if slot1 ~= nil then
		summ = summ.."���� 1: "..settings.slot1.type1.."\n"
		summcount = summcount + 1
	end
	if slot2 ~= nil and slot2 == "22" and tonumber(settings.slot2.kolvo22) ~= 0 then
		summ = summ.."���� 2: "..settings.slot2.type2..". ������: "..settings.slot2.kolvo22..".\n"
		summcount = summcount + 1
	end
	if slot2 ~= nil and slot2 == "24" and tonumber(settings.slot2.kolvo24) ~= 0 then
		summ = summ.."���� 2: "..settings.slot2.type2..". ������: "..settings.slot2.kolvo24..".\n"
		summcount = summcount + 1
	end
	if slot3 ~= nil and tonumber(settings.slot3.kolvo25) ~= 0 then
		summ = summ.."���� 3: "..settings.slot3.type3..". ������: "..settings.slot3.kolvo25..".\n"
		summcount = summcount + 1
	end
	if slot4 ~= nil and tonumber(settings.slot4.kolvo29) ~= 0 then
		summ = summ.."���� 4: "..settings.slot4.type4..". ������: "..settings.slot4.kolvo29..".\n"
		summcount = summcount + 1
	end
	if slot5 ~= nil and slot5 == "30" and tonumber(settings.slot5.kolvo30) ~= 0 then
		summ = summ.."���� 5: "..settings.slot5.type5..". ������: "..settings.slot5.kolvo30..".\n"
		summcount = summcount + 1
	end
	if slot5 ~= nil and slot5 == "31" and tonumber(settings.slot5.kolvo31) ~= 0 then
		summ = summ.."���� 5: "..settings.slot5.type5..". ������: "..settings.slot5.kolvo31..".\n"
		summcount = summcount + 1
	end
	if slot6 ~= nil and tonumber(settings.slot6.kolvo33) ~= 0 then
		summ = summ.."���� 8: "..settings.slot6.type6..". ������: "..settings.slot6.kolvo33..".\n"
		summcount = summcount + 1
	end
	if slot9 ~= nil and tonumber(settings.slot9.kolvo43) ~= 0 then
		summ = summ.."���� 9: "..settings.slot9.type9..". ������: "..settings.slot9.kolvo43..".\n"
		summcount = summcount + 1
	end
	if slot11 ~= nil then
		summ = summ.."���� 11: "..settings.slot11.type11..".\n"
		summcount = summcount + 1
	end
end
--------------------------------------------------------------------------------
---------------------------------------/RG--------------------------------------
--------------------------------------------------------------------------------
function rgg(id)
	local id = tonumber(id)
	lua_thread.create(rg, id)
end
function rg(paramid)
	nabor()
	local id1 = tonumber(paramid)
	if id1 ~= nil and id1 >= 0 and id1 <= 1000 then
		if sampIsPlayerConnected(id1) then
			addOneOffSound(0.0, 0.0, 0.0, 1138)
			if slot0 ~= nil then
				givegun(id1, slot0, nil)
			end
			if slot1 ~= nil then
				givegun(id1, slot1, nil)
			end
			if slot2 ~= nil and slot2 == "22" and tonumber(settings.slot2.kolvo22) ~= 0 then
				givegun(id1, slot2, settings.slot2.kolvo22)
			end
			if slot2 ~= nil and slot2 == "24" and tonumber(settings.slot2.kolvo24) ~= 0 then
				givegun(id1, slot2, settings.slot2.kolvo24)
			end
			if slot3 ~= nil and tonumber(settings.slot3.kolvo25) ~= 0 then
				givegun(id1, slot3, settings.slot3.kolvo25)
			end
			if slot4 ~= nil and tonumber(settings.slot4.kolvo29) ~= 0 then
				givegun(id1, slot4, settings.slot4.kolvo29)
			end
			if slot5 ~= nil and slot5 == "30" and tonumber(settings.slot5.kolvo30) ~= 0 then
				givegun(id1, slot5, settings.slot5.kolvo30)
			end
			if slot5 ~= nil and slot5 == "31" and tonumber(settings.slot5.kolvo31) ~= 0 then
				givegun(id1, slot5, settings.slot5.kolvo31)
			end
			if slot6 ~= nil and tonumber(settings.slot6.kolvo33) ~= 0 then
				givegun(id1, slot6, settings.slot6.kolvo33)
			end
			if slot9 ~= nil and tonumber(settings.slot9.kolvo43) ~= 0 then
				givegun(id1, slot9, settings.slot9.kolvo43)
			end
			if slot11 ~= nil then
				givegun(id1, slot11, nil)
			end
			sampAddChatMessage("{FF5F5F}"..thisScript().name.."{ffffff} ����� ������ "..sampGetPlayerNickname(id1), color)
			addOneOffSound(0.0, 0.0, 0.0, 1139)
		end
	else
		asodkas, licenseid = sampGetPlayerIdByCharHandle(PLAYER_PED)
		addOneOffSound(0.0, 0.0, 0.0, 1138)
		if slot0 ~= nil then
			givegun(licenseid, slot0, nil)
		end
		if slot1 ~= nil then
			givegun(licenseid, slot1, nil)
		end
		if slot2 ~= nil and slot2 == "22" and tonumber(settings.slot2.kolvo22) ~= 0 then
			givegun(licenseid, slot2, settings.slot2.kolvo22)
		end
		if slot2 ~= nil and slot2 == "24" and tonumber(settings.slot2.kolvo24) ~= 0 then
			givegun(licenseid, slot2, settings.slot2.kolvo24)
		end
		if slot3 ~= nil and tonumber(settings.slot3.kolvo25) ~= 0 then
			givegun(licenseid, slot3, settings.slot3.kolvo25)
		end
		if slot4 ~= nil and tonumber(settings.slot4.kolvo29) ~= 0 then
			givegun(licenseid, slot4, settings.slot4.kolvo29)
		end
		if slot5 ~= nil and slot5 == "30" and tonumber(settings.slot5.kolvo30) ~= 0 then
			givegun(licenseid, slot5, settings.slot5.kolvo30)
		end
		if slot5 ~= nil and slot5 == "31" and tonumber(settings.slot5.kolvo31) ~= 0 then
			givegun(licenseid, slot5, settings.slot5.kolvo31)
		end
		if slot6 ~= nil and tonumber(settings.slot6.kolvo33) ~= 0 then
			givegun(licenseid, slot6, settings.slot6.kolvo33)
		end
		if slot9 ~= nil and tonumber(settings.slot9.kolvo43) ~= 0 then
			givegun(licenseid, slot9, settings.slot9.kolvo43)
		end
		if slot11 ~= nil then
			givegun(licenseid, slot11, nil)
		end
		sampAddChatMessage("{FF5F5F}"..thisScript().name.."{ffffff} ����� ��� ������", color)
		addOneOffSound(0.0, 0.0, 0.0, 1139)
	end
end
--------------------------------------------------------------------------------
--------------------------------------/RGG--------------------------------------
--------------------------------------------------------------------------------
function flooder()
	nabor()
	count = 0
	for id = 0, 1000 do
		if sampIsPlayerConnected(id) and sampGetCharHandleBySampPlayerId(id) and sampGetPlayerScore(id) >= settings.options.lvl then
			local dfsdfsd, cped = sampGetCharHandleBySampPlayerId(id)
			local cX, cY, cZ = getCharCoordinates(cped)
			local mX, mY, mZ = getCharCoordinates(PLAYER_PED)
			if getDistanceBetweenCoords3d(cX, cY, cZ, mX, mY, mZ) <= settings.options.distance then
				count = count + 1
			end
		end
	end
	wait(1000)
	timecount = settings.options.delay * count * summcount / 1000
	countdown = timecount
	if timecount > 3600 then
		activehourlimiter = math.floor(timecount / 3600)
		timecount = timecount % 3600
		activeminutelimiter = math.floor(timecount / 60)
		activeseclimiter = math.ceil(limiter % 60)
	elseif timecount >= 0 then
		activehourlimiter = 0
		activeminutelimiter = math.floor(timecount / 60)
		activeseclimiter = math.ceil(timecount % 60)
	end
	if summcount > 0 then
		sampShowDialog(5125, '{348cb2}RGG v'..thisScript().version..' by rubbishman', "{ffcc00}������������� �����:{ffffff}\n"..summ.."{ffcc00}���������� ������� � ���� ������:{ffffff}\n"..(sampGetPlayerCount(true) - 1).." �������.\n{ffcc00}���������� �������, ������� ����� ������:{ffffff}\n"..count.." �������.\n{ffcc00}����������� ��� ��� ������:{ffffff}\n"..settings.options.lvl.." ���.\n{ffcc00}������������ ��������� ������:{ffffff}\n"..settings.options.distance.." �.\n{ffcc00}������������� ��������:{ffffff}\n"..settings.options.delay.." ��.\n{ffcc00}������ �������������� ������:{ffffff}\n"..activehourlimiter.." �. "..activeminutelimiter.." �. "..activeseclimiter.. " �.", "���������", "������")
		onstart = (sampGetPlayerCount(true) - 1)
		while sampIsDialogActive(5125) do wait(100) end
		local resultMain, buttonMain, typ = sampHasDialogRespond(5125)
		if buttonMain == 1 then
			Enable = true
			for id = 0, 1000 do
				while pause == true do wait(100) end
				if Enable == true and sampIsPlayerConnected(id) and sampGetCharHandleBySampPlayerId(id) and sampGetPlayerScore(id) >= settings.options.lvl then
					local dfsdfsd, cped = sampGetCharHandleBySampPlayerId(id)
					local cX, cY, cZ = getCharCoordinates(cped)
					local mX, mY, mZ = getCharCoordinates(PLAYER_PED)
					if getDistanceBetweenCoords3d(cX, cY, cZ, mX, mY, mZ) <= settings.options.distance then
						if slot0 ~= nil then
							givegun(id, slot0, nil)
						end
						if slot1 ~= nil then
							givegun(id, slot1, nil)
						end
						if slot2 ~= nil and slot2 == "22" and tonumber(settings.slot2.kolvo22) ~= 0 then
							givegun(id, slot2, settings.slot2.kolvo22)
						end
						if slot2 ~= nil and slot2 == "24" and tonumber(settings.slot2.kolvo24) ~= 0 then
							givegun(id, slot2, settings.slot2.kolvo24)
						end
						if slot3 ~= nil and tonumber(settings.slot3.kolvo25) ~= 0 then
							givegun(id, slot3, settings.slot3.kolvo25)
						end
						if slot4 ~= nil and tonumber(settings.slot4.kolvo29) ~= 0 then
							givegun(id, slot4, settings.slot4.kolvo29)
						end
						if slot5 ~= nil and slot5 == "30" and tonumber(settings.slot5.kolvo30) ~= 0 then
							givegun(id, slot5, settings.slot5.kolvo30)
						end
						if slot5 ~= nil and slot5 == "31" and tonumber(settings.slot5.kolvo31) ~= 0 then
							givegun(id, slot5, settings.slot5.kolvo31)
						end
						if slot6 ~= nil and tonumber(settings.slot6.kolvo33) ~= 0 then
							givegun(id, slot6, settings.slot6.kolvo33)
						end
						if slot9 ~= nil and tonumber(settings.slot9.kolvo43) ~= 0 then
							givegun(id, slot9, settings.slot9.kolvo43)
						end
						if slot11 ~= nil then
							givegun(id, slot11, nil)
						end
						for i = 1, 10000 do
							if given[i] == nil then given[i] = sampGetPlayerNickname(id) break end
						end
					end
				end
			end
			for id = 0, 1000 do
				while pause == true do wait(100) end
				if Enable == true and sampIsPlayerConnected(id) and sampGetCharHandleBySampPlayerId(id) and sampGetPlayerScore(id) >= settings.options.lvl then
					local dfsdfsd, cped = sampGetCharHandleBySampPlayerId(id)
					local cX, cY, cZ = getCharCoordinates(cped)
					local mX, mY, mZ = getCharCoordinates(PLAYER_PED)
					if getDistanceBetweenCoords3d(cX, cY, cZ, mX, mY, mZ) <= settings.options.distance then
						go = true
						for i = 0, #given do
							if sampGetPlayerNickname(id) == given[i] then
								go = false
								break
							end
						end
						if go == true then
							if slot0 ~= nil then
								givegun(id, slot0, nil)
							end
							if slot1 ~= nil then
								givegun(id, slot1, nil)
							end
							if slot2 ~= nil and slot2 == "22" and tonumber(settings.slot2.kolvo22) ~= 0 then
								givegun(id, slot2, settings.slot2.kolvo22)
							end
							if slot2 ~= nil and slot2 == "24" and tonumber(settings.slot2.kolvo24) ~= 0 then
								givegun(id, slot2, settings.slot2.kolvo24)
							end
							if slot3 ~= nil and tonumber(settings.slot3.kolvo25) ~= 0 then
								givegun(id, slot3, settings.slot3.kolvo25)
							end
							if slot4 ~= nil and tonumber(settings.slot4.kolvo29) ~= 0 then
								givegun(id, slot4, settings.slot4.kolvo29)
							end
							if slot5 ~= nil and slot5 == "30" and tonumber(settings.slot5.kolvo30) ~= 0 then
								givegun(id, slot5, settings.slot5.kolvo30)
							end
							if slot5 ~= nil and slot5 == "31" and tonumber(settings.slot5.kolvo31) ~= 0 then
								givegun(id, slot5, settings.slot5.kolvo31)
							end
							if slot6 ~= nil and tonumber(settings.slot6.kolvo33) ~= 0 then
								givegun(id, slot6, settings.slot6.kolvo33)
							end
							if slot9 ~= nil and tonumber(settings.slot9.kolvo43) ~= 0 then
								givegun(id, slot9, settings.slot9.kolvo43)
							end
							if slot11 ~= nil then
								givegun(id, slot11, nil)
							end
							for i = 1, 10000 do
								if given[i] == nil then given[i] = sampGetPlayerNickname(id) break end
							end
						end
					end
				end
			end
			sampAddChatMessage("{FF5F5F}"..thisScript().name.."{ffffff} ����� ������ "..#given.." �������.", color)
			addOneOffSound(0.0, 0.0, 0.0, 1139)
			countdown = 0
			wait(2000)
			Enable = false
			for i = 1, #given do
				given[i] = nil
			end
			Enable = false
		end
		Enable = false
	else
		sampAddChatMessage("������: ����� ����.", color)
	end
end
--------------------------------------------------------------------------------
-----------------------------------FLOODER--------------------------------------
--------------------------------------------------------------------------------
function givegun(id, type, ammo)
		while pause == true do wait(100) end
	local name = sampGetPlayerNickname(id)
	currentid = sampGetPlayerNickname(id).. " ["..id.."]"
	if ammo == nil then ammo = 1 end
	if settings.options.testmode == 1 then
		sampAddChatMessage("/givegun "..id.." "..type.." "..ammo, color)
	else
		sampSendChat("/givegun "..id.." "..type.." "..ammo)
	end
	string = "/givegun "..id.." "..type.." "..ammo
	wait(settings.options.delay)
end
--------------------------------------------------------------------------------
-----------------------------------MAIN MENU------------------------------------
--------------------------------------------------------------------------------
-- submenus_show made by FYP
function submenus_show(menu, caption, select_button, close_button, back_button)
	select_button, close_button, back_button = select_button or 'Select', close_button or 'Close', back_button or 'Back'
	prev_menus = {}
	function display(menu, id, caption)
		local string_list = {}
		for i, v in ipairs(menu) do
			table.insert(string_list, type(v.submenu) == 'table' and v.title .. '  >>' or v.title)
		end
		sampShowDialog(id, caption, table.concat(string_list, '\n'), select_button, (#prev_menus > 0) and back_button or close_button, 4)
		repeat
			wait(0)
			result, button, list = sampHasDialogRespond(id)
			if result then
				if button == 1 and list ~= -1 then
					local item = menu[list + 1]
					if type(item.submenu) == 'table' then -- submenu
						table.insert(prev_menus, {menu = menu, caption = caption})
						if type(item.onclick) == 'function' then
							item.onclick(menu, list + 1, item.submenu)
						end
						return display(item.submenu, id + 1, item.submenu.title and item.submenu.title or item.title)
					elseif type(item.onclick) == 'function' then
						local result = item.onclick(menu, list + 1)
						if not result then return result end
						return display(menu, id, caption)
					end
				else -- if button == 0
					if #prev_menus > 0 then
						local prev_menu = prev_menus[#prev_menus]
						prev_menus[#prev_menus] = nil
						return display(prev_menu.menu, id - 1, prev_menu.caption)
					end
					return false
				end
			end
		until result
	end
	return display(menu, 31337, caption or menu.title)
end
--/rgg menu
function menu()
	submenus_show(mod_submenus_sa, '{348cb2}RGG v'..thisScript().version..' by rubbishman (James_Bond, Phil_Coulson)', '�������', '�������', '�����')
end
--toggle menu
function scriptmenu()
	if Enable == true then Enable = false else
		menutrigger = 1
	end
end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
function menuupdate()
	mod_submenus_sa = {
		{
			title = '��������� ������',
			onclick = function()
				lua_thread.create(flooder)
			end
		},
		{
			title = "��������� �������",
			submenu = {
				{
					title = '���/���� ����������� ��� �������',
					onclick = function()
						cmdScriptInform()
						menu()
					end
				},
				{
					title = '���/���� ������ ��� �����',
					onclick = function()
						cmdScriptRender()
						menu()
					end
				},
				{
					title = '���/���� testmode (����� � ���, � �� ����������)',
					onclick = function()
						if settings.options.testmode == 1 then
							settings.options.testmode = 0 sampAddChatMessage(('TestMode off'), color)
						else
							settings.options.testmode = 1 sampAddChatMessage(('TestMode on'), color)
						end
						menu()
					end
				},
				{
					title = ' ',
				},
				{
					title = '�������� ��������',
					onclick = function()
						cmdScriptDelay()
						menu()
					end
				},
				{
					title = '�������� ����������� lvl',
					onclick = function()
						cmdScriptlvl()
						menu()
					end
				},
				{
					title = '�������� ���������',
					onclick = function()
						cmdScriptdistance()
						menu()
					end
				},
				{
					title = ' ',
				},
				-- ffi - ����������� ���������� LuaJIT, ������� ��������� �� Lua ���� �������� ������� C-������� � ������������ ��������� ������ C. �� ��������� ��� �� �����������. ���� �� �������, ��� ����������� ���������� ����� ������� �������, �������� �� �����, ����� �� ��������� ������� � ����. � ��������� �, ����� ��������� � �������� ����������� ������. ��� �������� �� ��� � � ������� �� ���� ��� �� ��������. � ��� ������� ��������������, �� ������� � ffi ��������� ����������� ��������, ��� ��� �� ���� ������� � ���� ����� ��������� ������, ��� �������� ������ ������.
				--   CUT HERE
				{
					title = '����� � ������� (����, ������� ����)',
					onclick = function()
						local ffi = require 'ffi'
						ffi.cdef [[
														void* __stdcall ShellExecuteA(void* hwnd, const char* op, const char* file, const char* params, const char* dir, int show_cmd);
														uint32_t __stdcall CoInitializeEx(void*, uint32_t);
													]]
						local shell32 = ffi.load 'Shell32'
						local ole32 = ffi.load 'Ole32'
						ole32.CoInitializeEx(nil, 2 + 4)
						print(shell32.ShellExecuteA(nil, 'open', 'http://rubbishman.ru/sampcontact', nil, nil, 1))
					end
				},
				{
					title = '������� ������ �� ����������',
					onclick = function()
						local ffi = require 'ffi'
						ffi.cdef [[
														void* __stdcall ShellExecuteA(void* hwnd, const char* op, const char* file, const char* params, const char* dir, int show_cmd);
														uint32_t __stdcall CoInitializeEx(void*, uint32_t);
													]]
						local shell32 = ffi.load 'Shell32'
						local ole32 = ffi.load 'Ole32'
						ole32.CoInitializeEx(nil, 2 + 4)
						print(shell32.ShellExecuteA(nil, 'open', 'http://rubbishman.ru/samprggobzor', nil, nil, 1))
					end
				},
				{
					title = '������� ���������� ������ �������',
					onclick = function()
						local ffi = require 'ffi'
						ffi.cdef [[
														void* __stdcall ShellExecuteA(void* hwnd, const char* op, const char* file, const char* params, const char* dir, int show_cmd);
														uint32_t __stdcall CoInitializeEx(void*, uint32_t);
													]]
						local shell32 = ffi.load 'Shell32'
						local ole32 = ffi.load 'Ole32'
						ole32.CoInitializeEx(nil, 2 + 4)
						print(shell32.ShellExecuteA(nil, 'open', 'http://rubbishman.ru/samprgg', nil, nil, 1))
					end
				},
				{
					title = '������� ���� ������',
					onclick = function()
						local ffi = require 'ffi'
						ffi.cdef [[
														void* __stdcall ShellExecuteA(void* hwnd, const char* op, const char* file, const char* params, const char* dir, int show_cmd);
														uint32_t __stdcall CoInitializeEx(void*, uint32_t);
													]]
						local shell32 = ffi.load 'Shell32'
						local ole32 = ffi.load 'Ole32'
						ole32.CoInitializeEx(nil, 2 + 4)
						print(shell32.ShellExecuteA(nil, 'open', 'http://rubbishman.ru/samp', nil, nil, 1))
					end
				},
				--   CUT HERE
			}
		},
		{
			title = ' ',
			onclick = function()
				sampAddChatMessage("����� �������� ������������� FYP'y �� ������� submenus_show, �������������� � �������.", color)
			end
		},
		{
			title = '{348cb2}������������� {AAAAAA}(��������)',
			onclick = function()
				settings.slot2.kolvo22 = 0
				settings.slot2.kolvo24 = 0
				settings.slot3.kolvo25 = 0
				settings.slot4.kolvo29 = 0
				settings.slot5.kolvo31 = 0
				settings.slot5.kolvo30 = 0
				settings.slot6.kolvo33 = 0
				inicfg.save(settings, 'rgg.ini')
				menuupdate()
				menu()
			end
		},
		{
			title = '{AAAAAA}���� 2',
		},
		{
			title = '[22] Useless Pistol - '..settings.slot2.kolvo22,
			onclick = function()
				settings.slot2.type2 = "[22] Useless Pistol"
				settings.slot2.kolvo24 = 0
				sampShowDialog(9899, "������� ��� [22] Useless Pistol:", string.format("������� ����������: "..settings.slot2.kolvo22.."\n������� 0, ����� ������� ������ �� ������.\n������� 1-999, ���������� ���-�� ������."), "�������", "�������", 1)
				while sampIsDialogActive(9899) do wait(100) end
				local resultMain, buttonMain, typ = sampHasDialogRespond(9899)
				if buttonMain == 1 then
					if tonumber(sampGetCurrentDialogEditboxText(9899)) ~= nil and tonumber(sampGetCurrentDialogEditboxText(9899)) > - 1 and tonumber(sampGetCurrentDialogEditboxText(9899)) < 1000 then
						settings.slot2.kolvo22 = sampGetCurrentDialogEditboxText(9899)
						inicfg.save(settings, 'rgg.ini')
						menuupdate()
						menu()
					end
				else
					menuupdate()
					menu()
				end
			end
		},
		{
			title = '[24] Desert Eagle - '..settings.slot2.kolvo24,
			onclick = function()
				settings.slot2.type2 = "[24] Desert Eagle"
				settings.slot2.kolvo22 = 0
				sampShowDialog(9899, "������� ��� [24] Desert Eagle:", string.format("������� ����������: "..settings.slot2.kolvo24.."\n������� 0, ����� ������� ������ �� ������.\n������� 1-999, ���������� ���-�� ������."), "�������", "�������", 1)
				while sampIsDialogActive(9899) do wait(100) end
				local resultMain, buttonMain, typ = sampHasDialogRespond(9899)
				if buttonMain == 1 then
					if tonumber(sampGetCurrentDialogEditboxText(9899)) ~= nil and tonumber(sampGetCurrentDialogEditboxText(9899)) > - 1 and tonumber(sampGetCurrentDialogEditboxText(9899)) < 1000 then
						settings.slot2.kolvo24 = sampGetCurrentDialogEditboxText(9899)
						inicfg.save(settings, 'rgg.ini')
						menuupdate()
						menu()
					end
				else
					menuupdate()
					menu()
				end
			end
		},
		{
			title = '{AAAAAA}���� 3',
		},
		{
			title = '[25] Shotgun - '..settings.slot3.kolvo25,
			onclick = function()
				sampShowDialog(9899, "������� ��� [25] Shotgun:", string.format("������� ����������: "..settings.slot3.kolvo25.."\n������� 0, ����� ������� ������ �� ������.\n������� 1-999, ���������� ���-�� ������."), "�������", "�������", 1)
				while sampIsDialogActive(9899) do wait(100) end
				local resultMain, buttonMain, typ = sampHasDialogRespond(9899)
				if buttonMain == 1 then
					if tonumber(sampGetCurrentDialogEditboxText(9899)) ~= nil and tonumber(sampGetCurrentDialogEditboxText(9899)) > - 1 and tonumber(sampGetCurrentDialogEditboxText(9899)) < 1000 then
						settings.slot3.kolvo25 = sampGetCurrentDialogEditboxText(9899)
						inicfg.save(settings, 'rgg.ini')
						menuupdate()
						menu()
					end
				else
					menuupdate()
					menu()
				end
			end
		},
		{
			title = '{AAAAAA}���� 4',
		},
		{
			title = '[29] MP5 - '..settings.slot4.kolvo29,
			onclick = function()
				sampShowDialog(9899, "������� ��� [29] MP5:", string.format("������� ����������: "..settings.slot4.kolvo29.."\n������� 0, ����� ������� ������ �� ������.\n������� 1-999, ���������� ���-�� ������."), "�������", "�������", 1)
				while sampIsDialogActive(9899) do wait(100) end
				local resultMain, buttonMain, typ = sampHasDialogRespond(9899)
				if buttonMain == 1 then
					if tonumber(sampGetCurrentDialogEditboxText(9899)) ~= nil and tonumber(sampGetCurrentDialogEditboxText(9899)) > - 1 and tonumber(sampGetCurrentDialogEditboxText(9899)) < 1000 then
						settings.slot4.kolvo29 = sampGetCurrentDialogEditboxText(9899)
						inicfg.save(settings, 'rgg.ini')
						menuupdate()
						menu()
					end
				else
					menuupdate()
					menu()
				end
			end
		},

		{
			title = '{AAAAAA}���� 5',
		},
		{
			title = '[30] AK-47 - '..settings.slot5.kolvo30,
			onclick = function()
				settings.slot5.type5 = "[30] AK-47"
				settings.slot5.kolvo31 = 0
				sampShowDialog(9899, "������� ��� [30] AK-47:", string.format("������� ����������: "..settings.slot5.kolvo30.."\n������� 0, ����� ������� ������ �� ������.\n������� 1-999, ���������� ���-�� ������."), "�������", "�������", 1)
				while sampIsDialogActive(9899) do wait(100) end
				local resultMain, buttonMain, typ = sampHasDialogRespond(9899)
				if buttonMain == 1 then
					if tonumber(sampGetCurrentDialogEditboxText(9899)) ~= nil and tonumber(sampGetCurrentDialogEditboxText(9899)) > - 1 and tonumber(sampGetCurrentDialogEditboxText(9899)) < 1000 then
						settings.slot5.kolvo30 = sampGetCurrentDialogEditboxText(9899)
						inicfg.save(settings, 'rgg.ini')
						menuupdate()
						menu()
					end
				else
					menuupdate()
					menu()
				end
			end
		},
		{
			title = '[31] M4 - '..settings.slot5.kolvo31,
			onclick = function()
				settings.slot5.type5 = "[31] M4"
				settings.slot5.kolvo30 = 0
				sampShowDialog(9899, "������� ��� [31] M4:", string.format("������� ����������: "..settings.slot5.kolvo31.."\n������� 0, ����� ������� ������ �� ������.\n������� 1-999, ���������� ���-�� ������."), "�������", "�������", 1)
				while sampIsDialogActive(9899) do wait(100) end
				local resultMain, buttonMain, typ = sampHasDialogRespond(9899)
				if buttonMain == 1 then
					if tonumber(sampGetCurrentDialogEditboxText(9899)) ~= nil and tonumber(sampGetCurrentDialogEditboxText(9899)) > - 1 and tonumber(sampGetCurrentDialogEditboxText(9899)) < 1000 then
						settings.slot5.kolvo31 = sampGetCurrentDialogEditboxText(9899)
						inicfg.save(settings, 'rgg.ini')
						menuupdate()
						menu()
					end
				else
					menuupdate()
					menu()

				end
			end
		},
		{
			title = '{AAAAAA}���� 6',
		},
		{
			title = '[33] Rifle - '..settings.slot6.kolvo33,
			onclick = function()
				sampShowDialog(9899, "������� ��� [33] Rifle:", string.format("������� ����������: "..settings.slot6.kolvo33.."\n������� 0, ����� ������� ������ �� ������.\n������� 1-999, ���������� ���-�� ������."), "�������", "�������", 1)
				while sampIsDialogActive(9899) do wait(100) end
				local resultMain, buttonMain, typ = sampHasDialogRespond(9899)
				if buttonMain == 1 then
					if tonumber(sampGetCurrentDialogEditboxText(9899)) ~= nil and tonumber(sampGetCurrentDialogEditboxText(9899)) > - 1 and tonumber(sampGetCurrentDialogEditboxText(9899)) < 1000 then
						settings.slot6.kolvo33 = sampGetCurrentDialogEditboxText(9899)
						inicfg.save(settings, 'rgg.ini')
						menuupdate()
						menu()
					end
				else
					menuupdate()
					menu()
				end
			end
		},
		{
			title = '{348cb2}������ {AAAAAA}(��������)',
			onclick = function()
				settings.slot0.type0 = "[-] ������"
				settings.slot1.type1 = "[-] ������"
				settings.slot9.type9 = "[-] ������" settings.slot9.kolvo43 = 0
				settings.slot11.type11 = "[-] ������"
				inicfg.save(settings, 'rgg.ini')
				menuupdate()
				menu()
			end
		},
		{
			title = string.format("%s", settings.slot0.type0),
			submenu = {
				{
					title = '[-] ������',
					onclick = function()
						settings.slot0.type0 = "[-] ������"
						inicfg.save(settings, 'rgg.ini')
						menuupdate()
						menu()
					end
				},
				{
					title = '[0] �����',
					onclick = function()
						settings.slot0.type0 = "[0] �����"
						inicfg.save(settings, 'rgg.ini')
						menuupdate()
						menu()
					end
				},
				{
					title = '[1] ������',
					onclick = function()
						settings.slot0.type0 = "[1] ������"
						inicfg.save(settings, 'rgg.ini')
						menuupdate()
						menu()
					end
				},
			}
		},
		{
			title = string.format("%s", settings.slot1.type1),
			submenu = {
				{
					title = '[-] ������',
					onclick = function()
						settings.slot1.type1 = "[-] ������"
						inicfg.save(settings, 'rgg.ini')
						menuupdate()
						menu()
					end
				},
				{
					title = '[2] ������ ��� ������',
					onclick = function()
						settings.slot1.type1 = "[2] ������ ��� ������"
						inicfg.save(settings, 'rgg.ini')
						menuupdate()
						menu()
					end
				},
				{
					title = '[3] ����������� �������',
					onclick = function()
						settings.slot1.type1 = "[3] ����������� �������"
						inicfg.save(settings, 'rgg.ini')
						menuupdate()
						menu()
					end
				},
				{
					title = '[5] ����������� ����',
					onclick = function()
						settings.slot1.type1 = "[5] ����������� ����"
						inicfg.save(settings, 'rgg.ini')
						menuupdate()
						menu()
					end
				},
				{
					title = '[6] ������',
					onclick = function()
						settings.slot1.type1 = "[6] ������"
						inicfg.save(settings, 'rgg.ini')
						menuupdate()
						menu()
					end
				},
				{
					title = '[7] ���',
					onclick = function()
						settings.slot1.type1 = "[7] ���"
						inicfg.save(settings, 'rgg.ini')
						menuupdate()
						menu()
					end
				},
				{
					title = '[8] ������',
					onclick = function()
						settings.slot1.type1 = "[8] ������"
						inicfg.save(settings, 'rgg.ini')
						menuupdate()
						menu()
					end
				},
				{
					title = '[10] ������������� �����',
					onclick = function()
						settings.slot1.type1 = "[10] ������������� �����"
						inicfg.save(settings, 'rgg.ini')
						menuupdate()
						menu()
					end
				},
				{
					title = '[11] �����',
					onclick = function()
						settings.slot1.type1 = "[11] �����"
						inicfg.save(settings, 'rgg.ini')
						menuupdate()
						menu()
					end
				},
				{
					title = '[12] ��������',
					onclick = function()
						settings.slot1.type1 = "[12] ��������"
						inicfg.save(settings, 'rgg.ini')
						menuupdate()
						menu()
					end
				},
				{
					title = '[13] ����������� ��������',
					onclick = function()
						settings.slot1.type1 = "[13] ����������� ��������"
						inicfg.save(settings, 'rgg.ini')
						menuupdate()
						menu()
					end
				},
				{
					title = '[14] ����� ������',
					onclick = function()
						settings.slot1.type1 = "[14] ����� ������"
						inicfg.save(settings, 'rgg.ini')
						menuupdate()
						menu()
					end
				},
				{
					title = '[15] ������',
					onclick = function()
						settings.slot1.type1 = "[15] ������"
						inicfg.save(settings, 'rgg.ini')
						menuupdate()
						menu()
					end
				},
			}
		},
		{
			title = string.format("%s", settings.slot9.type9),
			onclick = function()
				sampShowDialog(9899, "������� ��� [43] �����������:", string.format("������� ����������: "..settings.slot9.kolvo43.."\n������� 0, ����� ������� ������ �� ������.\n������� 1-999, ���������� ���-�� ������."), "�������", "�������", 1)
				while sampIsDialogActive(9899) do wait(100) end
				local resultMain, buttonMain, typ = sampHasDialogRespond(9899)
				if buttonMain == 1 then
					if tonumber(sampGetCurrentDialogEditboxText(9899)) ~= nil and tonumber(sampGetCurrentDialogEditboxText(9899)) > 0 and tonumber(sampGetCurrentDialogEditboxText(9899)) < 1000 then
						settings.slot9.kolvo43 = sampGetCurrentDialogEditboxText(9899)
						settings.slot9.type9 = "[43] ����������� - "..settings.slot9.kolvo43
						inicfg.save(settings, 'rgg.ini')
						menuupdate()
						menu()
					end
					if tonumber(sampGetCurrentDialogEditboxText(9899)) == 0 then
						settings.slot9.type9 = "[-] ������" settings.slot9.kolvo43 = sampGetCurrentDialogEditboxText(9899)
						inicfg.save(settings, 'rgg.ini')
						menuupdate()
						menu()
					end
				else
					settings.slot9.type9 = "[-] ������"
					inicfg.save(settings, 'rgg.ini')
					menuupdate()
					menu()
				end
			end
		},
		{
			title = string.format("%s  >>", settings.slot11.type11),
			onclick = function()
				if settings.slot11.type11 == "[-] ������" then settings.slot11.type11 = "[46] �������" else settings.slot11.type11 = "[-] ������" end
				inicfg.save(settings, 'rgg.ini')
				menuupdate()
				menu()
			end
		},
	}
end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-----------------------------------SETTINGS-------------------------------------
--------------------------------------------------------------------------------
function cmdScriptInform()
	if settings.options.startmessage == 1 then
		settings.options.startmessage = 0 sampAddChatMessage(('����������� ��������� RGG ��� ������� ���� ���������'), color)
	else
		settings.options.startmessage = 1 sampAddChatMessage(('����������� ��������� RGG ��� ������� ���� ��������'), color)
	end
	inicfg.save(settings, 'rgg.ini')
end
function cmdScriptRender()
	if settings.options.render == 1 then
		settings.options.render = 0 sampAddChatMessage(('������ RGG ��������'), color)
	else
		settings.options.render = 1 sampAddChatMessage(('������ RGG �������'), color)
	end
	inicfg.save(settings, 'rgg.ini')
end

function rggpause()
	if pause == true then
		pause = false
	else
		pause = true
	end
end


function cmdScriptDelay()
	sampShowDialog(989, "��������� �������� ������", string.format("������� �������� � �������������.\n������� ��������: "..settings.options.delay.." ms."), "�������", "�������", 1)
	while sampIsDialogActive() do wait(100) end
	local resultMain, buttonMain, typ = sampHasDialogRespond(989)
	if buttonMain == 1 then
		if tonumber(sampGetCurrentDialogEditboxText(989)) ~= nil and tonumber(sampGetCurrentDialogEditboxText(989)) > 0 then
			settings.options.delay = tonumber(sampGetCurrentDialogEditboxText(989))
			inicfg.save(settings, 'rgg.ini')
		end
	end
end
function cmdScriptlvl()
	sampShowDialog(989, "��������� ������������ ���", string.format("������� ����������� ���.\n������� ���: "..settings.options.lvl.."."), "�������", "�������", 1)
	while sampIsDialogActive() do wait(100) end
	local resultMain, buttonMain, typ = sampHasDialogRespond(989)
	if buttonMain == 1 then
		if tonumber(sampGetCurrentDialogEditboxText(989)) ~= nil and tonumber(sampGetCurrentDialogEditboxText(989)) > 0 and tonumber(sampGetCurrentDialogEditboxText(989)) < 100 then
			settings.options.lvl = tonumber(sampGetCurrentDialogEditboxText(989))
			inicfg.save(settings, 'rgg.ini')
		end
	end
end



function cmdScriptdistance()
	sampShowDialog(989, "��������� ���������", string.format("������� ������������ ���������.\n���� ����� � ���� ����������, �� ������ ��� �� X ������, �� �� ������������.\n������� ���������: "..settings.options.distance.."."), "�������", "�������", 1)
	while sampIsDialogActive() do wait(100) end
	local resultMain, buttonMain, typ = sampHasDialogRespond(989)
	if buttonMain == 1 then
		if tonumber(sampGetCurrentDialogEditboxText(989)) ~= nil and tonumber(sampGetCurrentDialogEditboxText(989)) > 0 and tonumber(sampGetCurrentDialogEditboxText(989)) < 10000 then
			settings.options.distance = tonumber(sampGetCurrentDialogEditboxText(989))
			inicfg.save(settings, 'rgg.ini')
		end
	end
end