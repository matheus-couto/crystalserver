taskConfiguration = {
{name = "Rotworm", color = 40, total = 50, type = "once", storage = 190006, storagecount = 190007, 
rewards = {
{3043, 5},
{"exp", 10000},
	},
},

{name = "Elf", color = 40, total = 100, type = "once", storage = 190064, storagecount = 190065, 
rewards = {
{3043, 3},
{"exp", 21000},
	},
},

{name = "Tarantula", color = 40, total = 100, type = "once", storage = 190066, storagecount = 190067, 
rewards = {
{3043, 3},
{"exp", 60000},
	},
},

{name = "Minotaur", color = 40, total = 500, type = "once", storage = 190000, storagecount = 190001, 
rewards = {
{"exp", 275000},
	},
},

{name = "Dragon", color = 40, total = 500, type = "daily", storage = 190002, storagecount = 190003, 
rewards = {
{3043, 5},
{"exp", 1750000},
	},
},

{name = "Dragon Lord", color = 40, total = 5000, type = "once", storage = 190004, storagecount = 190005, 
rewards = {
{"exp", 5000000},
	},
},

{name = "Amazon", color = 40, total = 200, type = "once", storage = 190008, storagecount = 190009, 
rewards = { 
{3043, 3},
{"exp", 60000},
	},
},

{name = "Valkyrie", color = 40, total = 500, type = "once", storage = 190010, storagecount = 190011, 
rewards = {
{3043, 3},
{"exp", 212500},
	},
},

{name = "Weakened Frazzlemaw", color = 40, total = 1000, type = "once", storage = 190012, storagecount = 190013,
rewards = { 
{"exp", 1000000},
	},
},

{name = "Enfeebled Silencer", color = 40, total = 1000, type = "once", storage = 190014, storagecount = 190015, 
rewards = { 
{"exp", 1200000},
	},
},

{name = "Deepling Guard", color = 40, total = 500, type = "daily", storage = 190016, storagecount = 190017, 
rewards = { 
{"exp", 1250000},
{14142, 1},
	},
},

{name = "Deepling Warrior", color = 40, total = 500, type = "daily", storage = 190018, storagecount = 190019, 
rewards = { 
{"exp", 1150000},
	},
},

{name = "Deepling Scout", color = 40, total = 1000, type = "daily", storage = 190020, storagecount = 190021, 
rewards = { 
{"exp", 800000},
	},
},

{name = "Guzzlemaw", color = 40, total = 5000, type = "once", storage = 190022, storagecount = 190023, 
rewards = { 
{20264, 1},
{"exp", 1125000},
	},
},

{name = "Frazzlemaw", color = 40, total = 5000, type = "once", storage = 190024, storagecount = 190025, 
rewards = { 
{20264, 1},
{"exp", 935000},
	},
},

{name = "Silencer", color = 40, total = 5000, type = "once", storage = 190071, storagecount = 190072, 
rewards = { 
{20264, 1},
{"exp", 1550000},
	},
},

{name = "Medusa", color = 40, total = 10000, type = "once", storage = 190026, storagecount = 190027, 
rewards = { 
{"exp", 20250000},
	},
},

{name = "Demon", color = 40, total = 1000, type = "once", storage = 190028, storagecount = 190029, 
rewards = { 
{9388, 1},
{"exp", 10000000},
	},
},

{name = "Hero", color = 40, total = 1000, type = "once", storage = 190030, storagecount = 190031, 
rewards = { 
{"exp", 1200000},
	},
},

{name = "Brachiodemon", color = 40, total = 1000, type = "once", storage = 190038, storagecount = 190039, 
rewards = { 
{"exp", 15885000},
	},
},

{name = "Goshnar's Megalomania", color = 40, total = 25, type = "once", storage = 190068, storagecount = 190069, 
rewards = { 
{34109, 1},
	},
},

{name = "Juggernaut", color = 40, total = 1000, type = "once", storage = 190044, storagecount = 190045, 
rewards = { 
{"exp", 28000000},
	},
},

{name = "Dawnfire Asura", color = 40, total = 1000, type = "once", storage = 190046, storagecount = 190047, 
rewards = { 
{"exp", 5000000},
	},
},

{name = "Girtablilu Warrior", color = 40, total = 5000, type = "once", storage = 190052, storagecount = 190053, 
rewards = {   
{"exp", 25500000},
	},
},

{name = "Dark Carnisylvan", color = 40, total = 2500, type = "once", storage = 190062, storagecount = 190063, 
rewards = { 
{"exp", 15000000},
	},
},
}

squareWaitTime = 5000
taskQuestLog = 65000 -- A storage so you get the quest log
dailyTaskWaitTime = 24 * 60 * 60 

function Player.getCustomActiveTasksName(self)
local player = self
	if not player then
		return false
	end
local tasks = {}
	for i, data in pairs(taskConfiguration) do
		if player:getStorageValue(data.storagecount) ~= -1 then
		tasks[#tasks + 1] = data.name
		end
	end
	return #tasks > 0 and tasks or false
end


function getTaskByStorage(storage)
	for i, data in pairs(taskConfiguration) do
		if data.storage == tonumber(storage) then
			return data
		end
	end
	return false
end

function getTaskByMonsterName(name)
	for i, data in pairs(taskConfiguration) do
		if data.name:lower() == name:lower() then
			return data
		end
	end
	return false
end

function Player.startTask(self, storage)
local player = self
	if not player then
		return false
	end
local data = getTaskByStorage(storage)
	if data == false then
		return false
	end
	if player:getStorageValue(taskQuestLog) == -1 then
		player:setStorageValue(taskQuestLog, 1)
	end
	player:setStorageValue(storage, player:getStorageValue(storage) + 1)
	player:setStorageValue(data.storagecount, 0)
	return true
end

function Player.canStartCustomTask(self, storage)
local player = self
	if not player then
		return false
	end
local data = getTaskByStorage(storage)
	if data == false then
		return false
	end
	if data.type == "daily" then
		return os.time() >= player:getStorageValue(storage)
	elseif data.type == "once" then
		return player:getStorageValue(storage) == -1
	elseif data.type[1] == "repeatable" and data.type[2] ~= -1 then
		return player:getStorageValue(storage) < (data.type[2] - 1)
	else
		return true
	end
end

function Player.endTask(self, storage, prematurely)
local player = self
	if not player then
		return false
	end
local data = getTaskByStorage(storage)
	if data == false then
		return false
end
	if prematurely then
		if data.type == "daily" then
			player:setStorageValue(storage, -1)
		else
			player:setStorageValue(storage, player:getStorageValue(storage) - 1)
	end
	else
		if data.type == "daily" then
			player:setStorageValue(storage, os.time() + dailyTaskWaitTime)
		end
	end
	player:setStorageValue(data.storagecount, -1)
	return true
end

function Player.hasStartedTask(self, storage)
local player = self
	if not player then
		return false
	end
local data = getTaskByStorage(storage)
	if data == false then
		return false
	end
	return player:getStorageValue(data.storagecount) ~= -1
end


function Player.getTaskKills(self, storage)
local player = self
	if not player then
		return false
	end
	return player:getStorageValue(storage)
end

-- function Player.addTaskKill(self, storage, count)
-- local player = self
-- 	if not player then
-- 		return false
-- 	end
-- local data = getTaskByStorage(storage)
-- 	if data == false then
-- 		return false
-- 	end

-- 	local kills = player:getTaskKills(data.storagecount)
-- 	if kills >= data.total then
-- 		return false
-- 	end
-- 	if kills + count >= data.total then
-- 		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[Task System] You finished this task! to take your rewards use !task")
-- 		return player:setStorageValue(data.storagecount, data.total)
-- 	end
-- 	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[Task System] Total creatures defeated: [".. kills + count .. "/".. data.total .."] "..data.name ..".")
-- 	return player:setStorageValue(data.storagecount, kills + count)
-- end

function Player.addTaskKill(self, storage, count)
    local player = self
    if not player then
        return false
    end
    local data = getTaskByStorage(storage)
    if data == false then
        return false
    end

    local kills = player:getTaskKills(data.storagecount)
    if kills >= data.total then
        return false
    end
    if kills + count >= data.total then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[Task System] You finished this task! to take your rewards use !task")
        return player:setStorageValue(data.storagecount, data.total)
    end
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "[Task System] Total creatures defeated: [".. kills + count .. "/".. data.total .."] "..data.name ..".")
    return player:setStorageValue(data.storagecount, kills + count)
end