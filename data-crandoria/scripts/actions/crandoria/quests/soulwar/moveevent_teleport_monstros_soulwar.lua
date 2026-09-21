-- local teleportConfig = {
--     teleportId = 12353,
--     teleportPosition = Position(33675, 31500, 11),
--     destinationPosition = Position(33675, 31500, 11),
--     creatureNames = "Infernal Phantom"
-- }

-- local function hasCreatureInArea(fromPosition, toPosition, creatureNames)
--     for x = fromPosition.x, toPosition.x do
--         for y = fromPosition.y, toPosition.y do
--             local pos = Position(x, y, fromPosition.z)
--             local tile = Tile(pos)
--             if tile then
--                 local creature = tile:getTopCreature()
--                 if creature and table.contains(creatureNames, creature:getName()) then
--                     return true
--                 end
--             end
--         end
--     end
--     return false
-- end

-- local teleportMovement = MoveEvent()

-- function teleportMovement.onStepIn(creature, item, position, fromPosition)
--     if hasCreatureInArea(Position(33669, 31495, 11), Position(33678, 31505, 11), teleportConfig.creatureNames) then
--     	creature:teleportTo(teleportConfig.destinationPosition)
--     	return true
--     end
--         creature:sendCancelMessage("You have to wait for the Soul War hoard.")
--         creature:teleportTo(fromPosition)
--     return true
-- end

-- teleportMovement:aid(teleportConfig.teleportId)
-- teleportMovement:register()

local destination = {
	[12353] = Position(33685, 31496, 11), -- ED e RP

}

local teleport = MoveEvent()



function teleport.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local teleport = destination[item.actionid]
		if teleport then
            Game.createMonster("Capricious Phantom", Position(33663, 31467, 11))
            Game.createMonster("Capricious Phantom", Position(33645, 31469, 11))
            Game.createMonster("Infernal Phantom", Position(33640, 31470, 11))
            Game.createMonster("Bony Sea Devil", Position(33644, 31472, 11))
            Game.createMonster("Infernal Phantom", Position(33663, 31472, 11))
            Game.createMonster("Rotten Golem", Position(33640, 31474, 11))
            Game.createMonster("Infernal Phantom", Position(33646, 31474, 11))
            Game.createMonster("Bony Sea Devil", Position(33656, 31474, 11))
            Game.createMonster("Branchy Crawler", Position(33650, 31474, 11))
            Game.createMonster("Branchy Crawler", Position(33643, 31476, 11))
            Game.createMonster("Rotten Golem", Position(33658, 31478, 11))
            Game.createMonster("Capricious Phantom", Position(33643, 31488, 11))
            Game.createMonster("Infernal Phantom", Position(33657, 31488, 11))
            Game.createMonster("Capricious Phantom", Position(33676, 31488, 11))
            Game.createMonster("Infernal Phantom", Position(33630, 31489, 11))
            Game.createMonster("Bony Sea Devil", Position(33629, 31491, 11))
            Game.createMonster("Bony Sea Devil", Position(33656, 31491, 11))
            Game.createMonster("Rotten Golem", Position(33660, 31491, 11))
            Game.createMonster("Capricious Phantom", Position(33643, 31492, 11))
            Game.createMonster("Rotten Golem", Position(33629, 31494, 11))
            Game.createMonster("Rotten Golem", Position(33614, 31495, 11))
            Game.createMonster("Rotten Golem", Position(33650, 31495, 11))
            Game.createMonster("Rotten Golem", Position(33653, 31497, 11))
            Game.createMonster("Branchy Crawler", Position(33651, 31498, 11))
            Game.createMonster("Branchy Crawler", Position(33666, 31498, 11))
            Game.createMonster("Infernal Phantom", Position(33631, 31499, 11))
            Game.createMonster("Rotten Golem", Position(33664, 31502, 11))
            Game.createMonster("Infernal Phantom", Position(33665, 31504, 11))
            Game.createMonster("Bony Sea Devil", Position(33666, 31504, 11))
            Game.createMonster("Bony Sea Devil", Position(33650, 31506, 11))
            Game.createMonster("Infernal Phantom", Position(33659, 31508, 11))
            Game.createMonster("Capricious Phantom", Position(33648, 31509, 11))
            Game.createMonster("Infernal Phantom", Position(33630, 31510, 11))
            Game.createMonster("Rotten Golem", Position(33666, 31511, 11))
            Game.createMonster("Branchy Crawler", Position(33622, 31513, 11))
            Game.createMonster("Infernal Phantom", Position(33677, 31512, 11))
            Game.createMonster("Bony Sea Devil", Position(33676, 31513, 11))
            Game.createMonster("Branchy Crawler", Position(33646, 31514, 11))
            Game.createMonster("Rotten Golem", Position(33622, 31517, 11))
            Game.createMonster("Rotten Golem", Position(33646, 31517, 11))
            Game.createMonster("Infernal Phantom", Position(33659, 31520, 11))
            Game.createMonster("Bony Sea Devil", Position(33646, 31521, 11))
            Game.createMonster("Branchy Crawler", Position(33666, 31523, 11))
            Game.createMonster("Rotten Golem", Position(33664, 31524, 11))
            Game.createMonster("Capricious Phantom", Position(33679, 31524, 11))
            Game.createMonster("Infernal Phantom", Position(33627, 31527, 11))
            Game.createMonster("Infernal Demon", Position(33574, 31474, 11))
            Game.createMonster("Brachiodemon", Position(33572, 31475, 11))
            Game.createMonster("Brachiodemon", Position(33585, 31475, 11))
            Game.createMonster("Mould Phantom", Position(33584, 31476, 11))
            Game.createMonster("Turbulent Elemental", Position(33572, 31477, 11))
            Game.createMonster("Infernal Demon", Position(33583, 31478, 11))
            Game.createMonster("Infernal Demon", Position(33571, 31480, 11))
            Game.createMonster("Brachiodemon", Position(33566, 31483, 11))
            Game.createMonster("Mould Phantom", Position(33571, 31484, 11))
            Game.createMonster("Infernal Demon", Position(33566, 31487, 11))
            Game.createMonster("Infernal Phantom", Position(33614, 31490, 11))
            Game.createMonster("Turbulent Elemental", Position(33584, 31492, 11))
            Game.createMonster("Capricious Phantom", Position(33614, 31492, 11))
            Game.createMonster("Brachiodemon", Position(33586, 31493, 11))
            Game.createMonster("Rotten Golem", Position(33600, 31493, 11))
            Game.createMonster("Bony Sea Devil", Position(33602, 31493, 11))
            Game.createMonster("Infernal Demon", Position(33594, 31495, 11))
            Game.createMonster("Rotten Golem", Position(33608, 31496, 11))
            Game.createMonster("Brachiodemon", Position(33594, 31497, 11))
            Game.createMonster("Mould Phantom", Position(33622, 31497, 11))
            Game.createMonster("Brachiodemon", Position(33627, 31497, 11))
            Game.createMonster("Mould Phantom", Position(33595, 31499, 11))
            Game.createMonster("Turbulent Elemental", Position(33620, 31500, 11))
            Game.createMonster("Infernal Demon", Position(33618, 31501, 11))
            Game.createMonster("Branchy Crawler", Position(33601, 31501, 11))
            Game.createMonster("Infernal Demon", Position(33583, 31503, 11))
            Game.createMonster("Turbulent Elemental", Position(33622, 31504, 11))
            Game.createMonster("Brachiodemon", Position(33567, 31505, 11))
            Game.createMonster("Brachiodemon", Position(33582, 31505, 11))
            Game.createMonster("Infernal Demon", Position(33571, 31507, 11))
            Game.createMonster("Mould Phantom", Position(33576, 31508, 11))
            Game.createMonster("Rotten Golem", Position(33623, 31508, 11))
            Game.createMonster("Rotten Golem", Position(33618, 31509, 11))
            Game.createMonster("Brachiodemon", Position(33583, 31512, 11))
            Game.createMonster("Bony Sea Devil", Position(33602, 31512, 11))
            Game.createMonster("Mould Phantom", Position(33587, 31513, 11))
            Game.createMonster("Capricious Phantom", Position(33605, 31514, 11))
            Game.createMonster("Turbulent Elemental", Position(33587, 31515, 11))
            Game.createMonster("Infernal Demon", Position(33590, 31517, 11))
            Game.createMonster("Infernal Demon", Position(33572, 31518, 11))
            Game.createMonster("Mould Phantom", Position(33604, 31519, 11))
            Game.createMonster("Turbulent Elemental", Position(33605, 31524, 11))
            Game.createMonster("Mould Phantom", Position(33568, 31527, 11))
            Game.createMonster("Infernal Demon", Position(33602, 31528, 11))
            Game.createMonster("Mould Phantom", Position(33569, 31529, 11))
            Game.createMonster("Brachiodemon", Position(33588, 31529, 11))
            Game.createMonster("Mould Phantom", Position(33605, 31529, 11))
            Game.createMonster("Brachiodemon", Position(33616, 31529, 11))
            Game.createMonster("Rotten Golem", Position(33628, 31530, 11))
            Game.createMonster("Infernal Demon", Position(33567, 31532, 11))
            Game.createMonster("Rotten Golem", Position(33626, 31532, 11))
            Game.createMonster("Brachiodemon", Position(33572, 31533, 11))
            Game.createMonster("Turbulent Elemental", Position(33605, 31533, 11))
            Game.createMonster("Mould Phantom", Position(33598, 31534, 11))
            Game.createMonster("Mould Phantom", Position(33610, 31534, 11))
            Game.createMonster("Brachiodemon", Position(33613, 31534, 11))
            Game.createMonster("Brachiodemon", Position(33539, 31503, 11))
            Game.createMonster("Mould Phantom", Position(33542, 31503, 11))
            Game.createMonster("Infernal Demon", Position(33547, 31505, 11))
            Game.createMonster("Brachiodemon", Position(33549, 31506, 11))
            Game.createMonster("Brachiodemon", Position(33534, 31510, 11))
            Game.createMonster("Infernal Demon", Position(33533, 31513, 11))
            Game.createMonster("Brachiodemon", Position(33558, 31517, 11))
            Game.createMonster("Mould Phantom", Position(33532, 31520, 11))
            Game.createMonster("Infernal Demon", Position(33558, 31521, 11))
            Game.createMonster("Brachiodemon", Position(33534, 31524, 11))
            Game.createMonster("Mould Phantom", Position(33553, 31525, 11))
            Game.createMonster("Infernal Demon", Position(33549, 31526, 11))
            Game.createMonster("Mould Phantom", Position(33552, 31529, 11))
            Game.createMonster("Infernal Demon", Position(33558, 31529, 11))
            Game.createMonster("Mould Phantom", Position(33553, 31531, 11))
            Game.createMonster("Brachiodemon", Position(33548, 31532, 11))
            Game.createMonster("Rotten Golem", Position(33640, 31529, 11))
            Game.createMonster("Infernal Phantom", Position(33626, 31531, 11))
            Game.createMonster("Infernal Phantom", Position(33636, 31531, 11))
            Game.createMonster("Infernal Phantom", Position(33660, 31531, 11))
            Game.createMonster("Bony Sea Devil", Position(33660, 31532, 11))
            Game.createMonster("Rotten Golem", Position(33646, 31534, 11))
            Game.createMonster("Bony Sea Devil", Position(33644, 31535, 11))
            Game.createMonster("Capricious Phantom", Position(33640, 31536, 11))
            Game.createMonster("Branchy Crawler", Position(33643, 31538, 11))
            Game.createMonster("Infernal Phantom", Position(33674, 31539, 11))
            Game.createMonster("Capricious Phantom", Position(33642, 31541, 11))
            Game.createMonster("Bony Sea Devil", Position(33666, 31542, 11))
            Game.createMonster("Rotten Golem", Position(33650, 31543, 11))
            Game.createMonster("Rotten Golem", Position(33666, 31543, 11))
            Game.createMonster("Branchy Crawler", Position(33656, 31544, 11))
            Game.createMonster("Infernal Phantom", Position(33651, 31546, 11))
            Game.createMonster("Branchy Crawler", Position(33674, 31546, 11))
            Game.createMonster("Bony Sea Devil", Position(33645, 31551, 11))
            Game.createMonster("Infernal Phantom", Position(33663, 31553, 11))
            Game.createMonster("Bony Sea Devil", Position(33665, 31553, 11))
            Game.createMonster("Capricious Phantom", Position(33669, 31553, 11))
            Game.createMonster("Infernal Phantom", Position(33628, 31554, 11))
            Game.createMonster("Rotten Golem", Position(33665, 31554, 11))
            Game.createMonster("Rotten Golem", Position(33664, 31556, 11))
            Game.createMonster("Branchy Crawler", Position(33652, 31559, 11))
            Game.createMonster("Infernal Phantom", Position(33635, 31560, 11))
            Game.createMonster("Bony Sea Devil", Position(33646, 31561, 11))
            Game.createMonster("Capricious Phantom", Position(33655, 31562, 11))
            Game.createMonster("Bony Sea Devil", Position(33668, 31563, 11))
            Game.createMonster("Mould Phantom", Position(33580, 31535, 11))
            Game.createMonster("Infernal Demon", Position(33584, 31535, 11))
            Game.createMonster("Mould Phantom", Position(33577, 31537, 11))
            Game.createMonster("Brachiodemon", Position(33559, 31543, 11))
            Game.createMonster("Brachiodemon", Position(33587, 31544, 11))
            Game.createMonster("Mould Phantom", Position(33555, 31546, 11))
            Game.createMonster("Infernal Demon", Position(33552, 31548, 11))
            Game.createMonster("Brachiodemon", Position(33568, 31550, 11))
            Game.createMonster("Mould Phantom", Position(33592, 31550, 11))
            Game.createMonster("Infernal Demon", Position(33565, 31551, 11))
            Game.createMonster("Mould Phantom", Position(33562, 31552, 11))
            Game.createMonster("Mould Phantom", Position(33595, 31552, 11))
            Game.createMonster("Brachiodemon", Position(33552, 31553, 11))
            Game.createMonster("Infernal Demon", Position(33595, 31554, 11))
            Game.createMonster("Brachiodemon", Position(33598, 31558, 11))
            Game.createMonster("Turbulent Elemental", Position(33602, 31561, 11))
            Game.createMonster("Capricious Phantom", Position(33614, 31564, 11)) 
        	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            if player:getStorageValue(Storage.Quest.U12_40.SoulWar.BagKillCount) < 1 then
                player:setStorageValue(Storage.Quest.U12_40.SoulWar.BagKillCount, 0)
            end
            player:teleportTo(Position(33685, 31496, 11))
		return true
        end
end

teleport:type("stepin")

for index, value in pairs(destination) do
	teleport:aid(index)
end

teleport:register()
