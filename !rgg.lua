--Больше скриптов от автора можно найти на сайте: http://www.rubbishman.ru/samp
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
		type0 = "[-] Ничего",
	},
	slot1 =
	{
		type1 = "[-] Ничего",
	},
	slot2 =
	{
		type2 = "[-] Ничего",
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
		type5 = "[-] Ничего",
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
		type9 = "[-] Ничего",
		kolvo43 = 0,
	},
	slot11 =
	{
		type11 = "[-] Ничего",
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
		sampAddChatMessage((thisScript().name..' v'..thisScript().version..' by rubbishman (он же James_Bond, он же Phil_Coulson) запущен. Написан под Samp-Rp.'),
		0x348cb2)
		sampAddChatMessage(('Подробнее - /rgg. Выдать себе - /rg. Выдать игроку - /rg id. Отключить это сообщение - /rggnot.'), 0x348cb2)
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
			renderFontDrawText(font, "rubbihman's givegun\nСтатус: "..tostring(Enable).."\nПауза (/rgp): "..tostring(pause).."\nВыдаю: "..tostring(currentid).."\nLast: "..tostring(string).."\nСкрипт выдал: "..#given.."\nИгроков в стриме: "..onstart.." ("..count..") было, "..(sampGetPlayerCount(true) - 1).." сейчас\nПредметов в наборе: "..tostring(summcount), resX / 50, resY / 2.5, 0xFF00FF00)
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
		summ = summ.."Слот 0: "..settings.slot0.type0.."\n"
		summcount = summcount + 1
	end
	if slot1 ~= nil then
		summ = summ.."Слот 1: "..settings.slot1.type1.."\n"
		summcount = summcount + 1
	end
	if slot2 ~= nil and slot2 == "22" and tonumber(settings.slot2.kolvo22) ~= 0 then
		summ = summ.."Слот 2: "..settings.slot2.type2..". Патрон: "..settings.slot2.kolvo22..".\n"
		summcount = summcount + 1
	end
	if slot2 ~= nil and slot2 == "24" and tonumber(settings.slot2.kolvo24) ~= 0 then
		summ = summ.."Слот 2: "..settings.slot2.type2..". Патрон: "..settings.slot2.kolvo24..".\n"
		summcount = summcount + 1
	end
	if slot3 ~= nil and tonumber(settings.slot3.kolvo25) ~= 0 then
		summ = summ.."Слот 3: "..settings.slot3.type3..". Патрон: "..settings.slot3.kolvo25..".\n"
		summcount = summcount + 1
	end
	if slot4 ~= nil and tonumber(settings.slot4.kolvo29) ~= 0 then
		summ = summ.."Слот 4: "..settings.slot4.type4..". Патрон: "..settings.slot4.kolvo29..".\n"
		summcount = summcount + 1
	end
	if slot5 ~= nil and slot5 == "30" and tonumber(settings.slot5.kolvo30) ~= 0 then
		summ = summ.."Слот 5: "..settings.slot5.type5..". Патрон: "..settings.slot5.kolvo30..".\n"
		summcount = summcount + 1
	end
	if slot5 ~= nil and slot5 == "31" and tonumber(settings.slot5.kolvo31) ~= 0 then
		summ = summ.."Слот 5: "..settings.slot5.type5..". Патрон: "..settings.slot5.kolvo31..".\n"
		summcount = summcount + 1
	end
	if slot6 ~= nil and tonumber(settings.slot6.kolvo33) ~= 0 then
		summ = summ.."Слот 8: "..settings.slot6.type6..". Патрон: "..settings.slot6.kolvo33..".\n"
		summcount = summcount + 1
	end
	if slot9 ~= nil and tonumber(settings.slot9.kolvo43) ~= 0 then
		summ = summ.."Слот 9: "..settings.slot9.type9..". Патрон: "..settings.slot9.kolvo43..".\n"
		summcount = summcount + 1
	end
	if slot11 ~= nil then
		summ = summ.."Слот 11: "..settings.slot11.type11..".\n"
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
			sampAddChatMessage("{FF5F5F}"..thisScript().name.."{ffffff} выдал оружие "..sampGetPlayerNickname(id1), color)
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
		sampAddChatMessage("{FF5F5F}"..thisScript().name.."{ffffff} выдал вам оружие", color)
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
		sampShowDialog(5125, '{348cb2}RGG v'..thisScript().version..' by rubbishman', "{ffcc00}Установленный набор:{ffffff}\n"..summ.."{ffcc00}Количество игроков в зоне стрима:{ffffff}\n"..(sampGetPlayerCount(true) - 1).." человек.\n{ffcc00}Количество игроков, которым будет выдано:{ffffff}\n"..count.." человек.\n{ffcc00}Минимальный лвл для выдачи:{ffffff}\n"..settings.options.lvl.." лвл.\n{ffcc00}Максимальная дистанция выдачи:{ffffff}\n"..settings.options.distance.." м.\n{ffcc00}Установленная задержка:{ffffff}\n"..settings.options.delay.." мс.\n{ffcc00}Выдача приблизительно займет:{ffffff}\n"..activehourlimiter.." ч. "..activeminutelimiter.." м. "..activeseclimiter.. " с.", "Запустить", "Отмена")
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
			sampAddChatMessage("{FF5F5F}"..thisScript().name.."{ffffff} выдал оружие "..#given.." игрокам.", color)
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
		sampAddChatMessage("Ошибка: набор пуст.", color)
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
	submenus_show(mod_submenus_sa, '{348cb2}RGG v'..thisScript().version..' by rubbishman (James_Bond, Phil_Coulson)', 'Выбрать', 'Закрыть', 'Назад')
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
			title = 'Запустить флудер',
			onclick = function()
				lua_thread.create(flooder)
			end
		},
		{
			title = "Настройки скрипта",
			submenu = {
				{
					title = 'Вкл/выкл уведомление при запуске',
					onclick = function()
						cmdScriptInform()
						menu()
					end
				},
				{
					title = 'Вкл/выкл рендер при флуде',
					onclick = function()
						cmdScriptRender()
						menu()
					end
				},
				{
					title = 'Вкл/выкл testmode (пишет в чат, а не отправляет)',
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
					title = 'Изменить задержку',
					onclick = function()
						cmdScriptDelay()
						menu()
					end
				},
				{
					title = 'Изменить минимальный lvl',
					onclick = function()
						cmdScriptlvl()
						menu()
					end
				},
				{
					title = 'Изменить дистанцию',
					onclick = function()
						cmdScriptdistance()
						menu()
					end
				},
				{
					title = ' ',
				},
				-- ffi - стандартная библиотека LuaJIT, которая позволяет из Lua кода вызывать внешние C-функции и использовать структуры данных C. По умолчанию она не загружается. Если вы боитесь, что стандартные библиотеки могут угонять админки, вырежьте по линии, чтобы не повредить скрипту в коде. Я использую её, чтобы открывать в браузере необходимые ссылки. Код директив не мой и я понятия не имею как он работает. Я мог сделать автообновление, но вариант с ffi исключает вероятность стиллера, так как вы сами кидаете в свою папку скаченный скрипт, код которого ВСЕГДА открыт.
				--   CUT HERE
				{
					title = 'Связь с автором (баги, просьбы сюда)',
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
					title = 'Открыть ссылку на видеообзор',
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
					title = 'Скачать актуальную версию скрипта',
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
					title = 'Открыть сайт автора',
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
				sampAddChatMessage("Здесь спрятана благодарность FYP'y за функцию submenus_show, использованную в скрипте.", color)
			end
		},
		{
			title = '{348cb2}Огнестрельное {AAAAAA}(сбросить)',
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
			title = '{AAAAAA}Слот 2',
		},
		{
			title = '[22] Useless Pistol - '..settings.slot2.kolvo22,
			onclick = function()
				settings.slot2.type2 = "[22] Useless Pistol"
				settings.slot2.kolvo24 = 0
				sampShowDialog(9899, "Патроны для [22] Useless Pistol:", string.format("Текущее количество: "..settings.slot2.kolvo22.."\nВведите 0, чтобы удалить оружие из набора.\nВведите 1-999, установить кол-во патрон."), "Выбрать", "Закрыть", 1)
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
				sampShowDialog(9899, "Патроны для [24] Desert Eagle:", string.format("Текущее количество: "..settings.slot2.kolvo24.."\nВведите 0, чтобы удалить оружие из набора.\nВведите 1-999, установить кол-во патрон."), "Выбрать", "Закрыть", 1)
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
			title = '{AAAAAA}Слот 3',
		},
		{
			title = '[25] Shotgun - '..settings.slot3.kolvo25,
			onclick = function()
				sampShowDialog(9899, "Патроны для [25] Shotgun:", string.format("Текущее количество: "..settings.slot3.kolvo25.."\nВведите 0, чтобы удалить оружие из набора.\nВведите 1-999, установить кол-во патрон."), "Выбрать", "Закрыть", 1)
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
			title = '{AAAAAA}Слот 4',
		},
		{
			title = '[29] MP5 - '..settings.slot4.kolvo29,
			onclick = function()
				sampShowDialog(9899, "Патроны для [29] MP5:", string.format("Текущее количество: "..settings.slot4.kolvo29.."\nВведите 0, чтобы удалить оружие из набора.\nВведите 1-999, установить кол-во патрон."), "Выбрать", "Закрыть", 1)
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
			title = '{AAAAAA}Слот 5',
		},
		{
			title = '[30] AK-47 - '..settings.slot5.kolvo30,
			onclick = function()
				settings.slot5.type5 = "[30] AK-47"
				settings.slot5.kolvo31 = 0
				sampShowDialog(9899, "Патроны для [30] AK-47:", string.format("Текущее количество: "..settings.slot5.kolvo30.."\nВведите 0, чтобы удалить оружие из набора.\nВведите 1-999, установить кол-во патрон."), "Выбрать", "Закрыть", 1)
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
				sampShowDialog(9899, "Патроны для [31] M4:", string.format("Текущее количество: "..settings.slot5.kolvo31.."\nВведите 0, чтобы удалить оружие из набора.\nВведите 1-999, установить кол-во патрон."), "Выбрать", "Закрыть", 1)
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
			title = '{AAAAAA}Слот 6',
		},
		{
			title = '[33] Rifle - '..settings.slot6.kolvo33,
			onclick = function()
				sampShowDialog(9899, "Патроны для [33] Rifle:", string.format("Текущее количество: "..settings.slot6.kolvo33.."\nВведите 0, чтобы удалить оружие из набора.\nВведите 1-999, установить кол-во патрон."), "Выбрать", "Закрыть", 1)
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
			title = '{348cb2}Разное {AAAAAA}(сбросить)',
			onclick = function()
				settings.slot0.type0 = "[-] Ничего"
				settings.slot1.type1 = "[-] Ничего"
				settings.slot9.type9 = "[-] Ничего" settings.slot9.kolvo43 = 0
				settings.slot11.type11 = "[-] Ничего"
				inicfg.save(settings, 'rgg.ini')
				menuupdate()
				menu()
			end
		},
		{
			title = string.format("%s", settings.slot0.type0),
			submenu = {
				{
					title = '[-] Ничего',
					onclick = function()
						settings.slot0.type0 = "[-] Ничего"
						inicfg.save(settings, 'rgg.ini')
						menuupdate()
						menu()
					end
				},
				{
					title = '[0] Кулак',
					onclick = function()
						settings.slot0.type0 = "[0] Кулак"
						inicfg.save(settings, 'rgg.ini')
						menuupdate()
						menu()
					end
				},
				{
					title = '[1] Кастет',
					onclick = function()
						settings.slot0.type0 = "[1] Кастет"
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
					title = '[-] Ничего',
					onclick = function()
						settings.slot1.type1 = "[-] Ничего"
						inicfg.save(settings, 'rgg.ini')
						menuupdate()
						menu()
					end
				},
				{
					title = '[2] Клюшка для гольфа',
					onclick = function()
						settings.slot1.type1 = "[2] Клюшка для гольфа"
						inicfg.save(settings, 'rgg.ini')
						menuupdate()
						menu()
					end
				},
				{
					title = '[3] Полицейская дубинка',
					onclick = function()
						settings.slot1.type1 = "[3] Полицейская дубинка"
						inicfg.save(settings, 'rgg.ini')
						menuupdate()
						menu()
					end
				},
				{
					title = '[5] Бейсбольная бита',
					onclick = function()
						settings.slot1.type1 = "[5] Бейсбольная бита"
						inicfg.save(settings, 'rgg.ini')
						menuupdate()
						menu()
					end
				},
				{
					title = '[6] Лопата',
					onclick = function()
						settings.slot1.type1 = "[6] Лопата"
						inicfg.save(settings, 'rgg.ini')
						menuupdate()
						menu()
					end
				},
				{
					title = '[7] Кий',
					onclick = function()
						settings.slot1.type1 = "[7] Кий"
						inicfg.save(settings, 'rgg.ini')
						menuupdate()
						menu()
					end
				},
				{
					title = '[8] Катана',
					onclick = function()
						settings.slot1.type1 = "[8] Катана"
						inicfg.save(settings, 'rgg.ini')
						menuupdate()
						menu()
					end
				},
				{
					title = '[10] Двухсторонний дилдо',
					onclick = function()
						settings.slot1.type1 = "[10] Двухсторонний дилдо"
						inicfg.save(settings, 'rgg.ini')
						menuupdate()
						menu()
					end
				},
				{
					title = '[11] Дилдо',
					onclick = function()
						settings.slot1.type1 = "[11] Дилдо"
						inicfg.save(settings, 'rgg.ini')
						menuupdate()
						menu()
					end
				},
				{
					title = '[12] Вибратор',
					onclick = function()
						settings.slot1.type1 = "[12] Вибратор"
						inicfg.save(settings, 'rgg.ini')
						menuupdate()
						menu()
					end
				},
				{
					title = '[13] Серебрянный вибратор',
					onclick = function()
						settings.slot1.type1 = "[13] Серебрянный вибратор"
						inicfg.save(settings, 'rgg.ini')
						menuupdate()
						menu()
					end
				},
				{
					title = '[14] Букет цветов',
					onclick = function()
						settings.slot1.type1 = "[14] Букет цветов"
						inicfg.save(settings, 'rgg.ini')
						menuupdate()
						menu()
					end
				},
				{
					title = '[15] Трость',
					onclick = function()
						settings.slot1.type1 = "[15] Трость"
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
				sampShowDialog(9899, "Патроны для [43] Фотоаппарат:", string.format("Текущее количество: "..settings.slot9.kolvo43.."\nВведите 0, чтобы удалить оружие из набора.\nВведите 1-999, установить кол-во патрон."), "Выбрать", "Закрыть", 1)
				while sampIsDialogActive(9899) do wait(100) end
				local resultMain, buttonMain, typ = sampHasDialogRespond(9899)
				if buttonMain == 1 then
					if tonumber(sampGetCurrentDialogEditboxText(9899)) ~= nil and tonumber(sampGetCurrentDialogEditboxText(9899)) > 0 and tonumber(sampGetCurrentDialogEditboxText(9899)) < 1000 then
						settings.slot9.kolvo43 = sampGetCurrentDialogEditboxText(9899)
						settings.slot9.type9 = "[43] Фотоаппарат - "..settings.slot9.kolvo43
						inicfg.save(settings, 'rgg.ini')
						menuupdate()
						menu()
					end
					if tonumber(sampGetCurrentDialogEditboxText(9899)) == 0 then
						settings.slot9.type9 = "[-] Ничего" settings.slot9.kolvo43 = sampGetCurrentDialogEditboxText(9899)
						inicfg.save(settings, 'rgg.ini')
						menuupdate()
						menu()
					end
				else
					settings.slot9.type9 = "[-] Ничего"
					inicfg.save(settings, 'rgg.ini')
					menuupdate()
					menu()
				end
			end
		},
		{
			title = string.format("%s  >>", settings.slot11.type11),
			onclick = function()
				if settings.slot11.type11 == "[-] Ничего" then settings.slot11.type11 = "[46] Парашют" else settings.slot11.type11 = "[-] Ничего" end
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
		settings.options.startmessage = 0 sampAddChatMessage(('Уведомление активации RGG при запуске игры отключено'), color)
	else
		settings.options.startmessage = 1 sampAddChatMessage(('Уведомление активации RGG при запуске игры включено'), color)
	end
	inicfg.save(settings, 'rgg.ini')
end
function cmdScriptRender()
	if settings.options.render == 1 then
		settings.options.render = 0 sampAddChatMessage(('Рендер RGG отключен'), color)
	else
		settings.options.render = 1 sampAddChatMessage(('Рендер RGG включен'), color)
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
	sampShowDialog(989, "Установка задержки выдачи", string.format("Введите задержку в миллисекундах.\nТекущая задержка: "..settings.options.delay.." ms."), "Выбрать", "Закрыть", 1)
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
	sampShowDialog(989, "Установка минимального лвл", string.format("Введите минимальный лвл.\nТекущая лвл: "..settings.options.lvl.."."), "Выбрать", "Закрыть", 1)
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
	sampShowDialog(989, "Установка дистанции", string.format("Введите максимальную дистанцию.\nЕсли игрок в зоне прорисовки, но дальше вас на X метров, то он игнорируется.\nТекущая дистанция: "..settings.options.distance.."."), "Выбрать", "Закрыть", 1)
	while sampIsDialogActive() do wait(100) end
	local resultMain, buttonMain, typ = sampHasDialogRespond(989)
	if buttonMain == 1 then
		if tonumber(sampGetCurrentDialogEditboxText(989)) ~= nil and tonumber(sampGetCurrentDialogEditboxText(989)) > 0 and tonumber(sampGetCurrentDialogEditboxText(989)) < 10000 then
			settings.options.distance = tonumber(sampGetCurrentDialogEditboxText(989))
			inicfg.save(settings, 'rgg.ini')
		end
	end
end