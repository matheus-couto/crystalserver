
local config = {
	[12299] = { flamePosition = Position(4768, 5096, 7), toPosition = Position(4768, 5094, 7) }, -- Mysterious library Magincia
	[12300] = { flamePosition = Position(5328, 4996, 7), toPosition = Position(5321, 4997, 7) }, -- Asura Palace Jagunda Jungle 
	[12301] = { flamePosition = Position(5936, 4725, 7), toPosition = Position(5932, 4721, 7) }, -- Krotkah Black Hydras
	[12302] = { flamePosition = Position(4923, 4585, 3), toPosition = Position(4983, 4680, 13) }, -- Drakens Dungeon
	[12303] = { flamePosition = Position(4665, 5245, 9), toPosition = Position(4663, 5241, 9) }, -- Carnivors Magincia
	[12304] = { flamePosition = Position(5611, 4796, 8), toPosition = Position(5607, 4795, 8) }, -- Asuras e Werelions
	[12305] = { flamePosition = Position(5376, 4617, 9), toPosition = Position(5383, 4620, 9) }, -- Asuras e Behemoths de Anvillux
	[12306] = { flamePosition = Position(4508, 4667, 9), toPosition = Position(4515, 4673, 9) }, -- Glooth Cave
	[12307] = { flamePosition = Position(4658, 4490, 10), toPosition = Position(4653, 4490, 10) }, -- Demons de Astralis
	[12308] = { flamePosition = Position(4852, 5298, 8), toPosition = Position(4854, 5300, 8) }, -- Caverna da Evolução
	[12309] = { flamePosition = Position(5088, 5572, 11), toPosition = Position(5092, 5570, 11) }, -- Cave do Rei Gelado
	[12310] = { flamePosition = Position(5811, 4570, 9), toPosition = Position(5810, 4574, 9) }, -- Cave Nivabi Custom
	[12311] = { flamePosition = Position(5731, 4580, 9), toPosition = Position(5731, 4575, 9) }, -- Cave Nivabi Sphinx
	[12312] = { flamePosition = Position(5927, 5103, 8), toPosition = Position(5926, 5100, 8) }, -- Roshamuul Prison
	[12346] = { flamePosition = Position(5123, 4874, 11), toPosition = Position(5121, 4874, 11) }, -- BOSS ROOM
	[12370] = { flamePosition = Position(4432, 5347, 5), toPosition = Position(4432, 5345, 5) }, -- viridia warlock tower
	[12371] = { flamePosition = Position(4484, 5340, 11), toPosition = Position(4451, 5328, 11) }, -- viridia grim reaper hunt
	[12379] = { flamePosition = Position(4335, 5703, 7), toPosition = Position(4358, 5678, 7) }, -- evento primavera
	[12381] = { flamePosition = Position(4559, 5360, 10), toPosition = Position(4604, 5175, 11) }, -- viridia fauns
	[12384] = { flamePosition = Position(4787, 5373, 13), toPosition = Position(4730, 5349, 14) }, -- viridia mikarah
	[14503] = { flamePosition = Position(4532, 5364, 10), toPosition = Position(4461, 5333, 13) }, -- viridia
	[14504] = { flamePosition = Position(4583, 5797, 7), toPosition = Position(4579, 5797, 7) }, -- evento ferumbras
	[14505] = { flamePosition = Position(4645, 5776, 7), toPosition = Position(4642, 5774, 7) }, -- evento ferumbras hipo
}

local huntCoalBasin = MoveEvent()

function huntCoalBasin.onAddItem(moveitem, tileitem, position)
	local targetCoalBasin = config[tileitem.uid]
	if not targetCoalBasin then
		return true
	end

	if tileitem.uid == 12299 and moveitem.itemid == 22723 and moveitem:getCount() == 30 then
		moveitem:remove()
		position:sendMagicEffect(CONST_ME_HITBYFIRE)

		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
		return true
	elseif tileitem.uid == 12300 and moveitem.itemid == 22723 and moveitem:getCount() == 25 then
		moveitem:remove()
		position:sendMagicEffect(CONST_ME_HITBYFIRE)

		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
		return true
	elseif tileitem.uid == 12301 and moveitem.itemid == 22723 and moveitem:getCount() == 50 then
		moveitem:remove()
		position:sendMagicEffect(CONST_ME_HITBYFIRE)

		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
		return true
	elseif tileitem.uid == 12302 and moveitem.itemid == 22723 and moveitem:getCount() == 10 then
		moveitem:remove()
		position:sendMagicEffect(CONST_ME_HITBYFIRE)

		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
		return true
	elseif tileitem.uid == 12303 and moveitem.itemid == 22723 and moveitem:getCount() == 30 then
		moveitem:remove()
		position:sendMagicEffect(CONST_ME_HITBYFIRE)

		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
		return true
	elseif tileitem.uid == 12304 and moveitem.itemid == 22723 and moveitem:getCount() == 10 then
		moveitem:remove()
		position:sendMagicEffect(CONST_ME_HITBYFIRE)

		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
		return true
	elseif tileitem.uid == 12305 and moveitem.itemid == 22723 and moveitem:getCount() == 30 then
		moveitem:remove()
		position:sendMagicEffect(CONST_ME_HITBYFIRE)

		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
		return true
	elseif tileitem.uid == 12306 and moveitem.itemid == 22723 and moveitem:getCount() == 10 then
		moveitem:remove()
		position:sendMagicEffect(CONST_ME_HITBYFIRE)

		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
		return true
	elseif tileitem.uid == 12307 and moveitem.itemid == 22723 and moveitem:getCount() == 30 then
		moveitem:remove()
		position:sendMagicEffect(CONST_ME_HITBYFIRE)

		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
		return true
	elseif tileitem.uid == 12308 and moveitem.itemid == 22723 and moveitem:getCount() == 25 then
		moveitem:remove()
		position:sendMagicEffect(CONST_ME_HITBYFIRE)

		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
		return true
	elseif tileitem.uid == 12309 and moveitem.itemid == 22723 and moveitem:getCount() == 50 then
		moveitem:remove()
		position:sendMagicEffect(CONST_ME_HITBYFIRE)

		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
		return true
	elseif tileitem.uid == 12310 and moveitem.itemid == 22723 and moveitem:getCount() == 20 then
		moveitem:remove()
		position:sendMagicEffect(CONST_ME_HITBYFIRE)

		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
		return true
	elseif tileitem.uid == 12311 and moveitem.itemid == 22723 and moveitem:getCount() == 20 then
		moveitem:remove()
		position:sendMagicEffect(CONST_ME_HITBYFIRE)

		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
		return true
	elseif tileitem.uid == 12312 and moveitem.itemid == 22723 and moveitem:getCount() == 10 then
		moveitem:remove()
		position:sendMagicEffect(CONST_ME_HITBYFIRE)

		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
		return true
	elseif tileitem.uid == 12346 and moveitem.itemid == 22723 and moveitem:getCount() == 10 then
		moveitem:remove()
		position:sendMagicEffect(CONST_ME_HITBYFIRE)

		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
		return true
	elseif tileitem.uid == 12370 and moveitem.itemid == 3077 and moveitem:getCount() == 1 then
		moveitem:remove()
		position:sendMagicEffect(CONST_ME_HITBYFIRE)

		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
		return true
	elseif tileitem.uid == 12371 and moveitem.itemid == 5954 and moveitem:getCount() == 1 then
		moveitem:remove()
		position:sendMagicEffect(CONST_ME_HITBYFIRE)

		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
		return true
	elseif tileitem.uid == 12381 and moveitem.itemid == 3028 and moveitem:getCount() == 1 then
		moveitem:remove()
		position:sendMagicEffect(CONST_ME_HITBYFIRE)

		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
		return true
	elseif tileitem.uid == 12379 and moveitem.itemid == 9215 and moveitem:getCount() == 1 then
		local player = Tile(targetCoalBasin.flamePosition):getTopCreature()
		moveitem:remove()
		position:sendMagicEffect(CONST_ME_HITBYFIRE)
		player:setStorageValue(Storage.Quest.Crandoria.Eventos.FestivalDePrimavera.Teleport, os.time() + 60 * 60 * 24)

		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
		return true
	elseif tileitem.uid == 12381 and moveitem.itemid == 3028 and moveitem:getCount() == 1 then
		moveitem:remove()
		position:sendMagicEffect(CONST_ME_HITBYFIRE)

		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
		return true
	elseif tileitem.uid == 12384 and moveitem.itemid == 3042 and moveitem:getCount() == 3 then
		moveitem:remove()
		position:sendMagicEffect(CONST_ME_HITBYFIRE)

		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
		return true
	elseif tileitem.uid == 14503 and moveitem.itemid == 5893 and moveitem:getCount() == 1 then
		moveitem:remove()
		position:sendMagicEffect(CONST_ME_HITBYFIRE)

		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
		return true
	elseif tileitem.uid == 14504 and moveitem.itemid == 3300 and moveitem:getCount() == 1 then
		moveitem:remove()
		position:sendMagicEffect(CONST_ME_HITBYFIRE)
		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
		return true
	elseif tileitem.uid == 14505 and moveitem.itemid == 3582 and moveitem:getCount() == 3 then
		moveitem:remove()
		position:sendMagicEffect(CONST_ME_HITBYFIRE)
		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
		return true
	elseif tileitem.uid == 14511 and moveitem.itemid == 51487 and moveitem:getCount() == 3 then -- NORCFERATU CRANDORIA
		moveitem:remove()
		position:sendMagicEffect(CONST_ME_HITBYFIRE)
		Tile(Position(4504, 4243, 7)):relocateTo(Position(4501, 4242, 7))
		Position(4501, 4242, 7):sendMagicEffect(CONST_ME_TELEPORT)
		return true
	else
		return true
	end

end

huntCoalBasin:type("additem")
huntCoalBasin:aid(12355)
huntCoalBasin:register()






-- local config = {
-- 	[12299] = { flamePosition = Position(4768, 5096, 7), toPosition = Position(4768, 5094, 7) }, -- Mysterious library Magincia
-- 	[12300] = { flamePosition = Position(5328, 4996, 7), toPosition = Position(5321, 4997, 7) }, -- Asura Palace Jagunda Jungle 
-- 	[12301] = { flamePosition = Position(5936, 4725, 7), toPosition = Position(5932, 4721, 7) }, -- Krotkah Black Hydras
-- 	[12302] = { flamePosition = Position(4923, 4585, 3), toPosition = Position(4983, 4680, 13) }, -- Drakens Dungeon
-- 	[12303] = { flamePosition = Position(4665, 5245, 9), toPosition = Position(4663, 5241, 9) }, -- Carnivors Magincia
-- 	[12304] = { flamePosition = Position(5611, 4796, 8), toPosition = Position(5607, 4795, 8) }, -- Asuras e Werelions
-- 	[12305] = { flamePosition = Position(5376, 4617, 9), toPosition = Position(5383, 4620, 9) }, -- Asuras e Behemoths de Anvillux
-- 	[12306] = { flamePosition = Position(4508, 4667, 9), toPosition = Position(4515, 4673, 9) }, -- Glooth Cave
-- 	[12307] = { flamePosition = Position(4658, 4490, 10), toPosition = Position(4653, 4490, 10) }, -- Demons de Astralis
-- 	[12308] = { flamePosition = Position(4852, 5298, 8), toPosition = Position(4854, 5300, 8) }, -- Caverna da Evolução
-- 	[12309] = { flamePosition = Position(5088, 5572, 11), toPosition = Position(5092, 5570, 11) }, -- Cave do Rei Gelado
-- 	[12310] = { flamePosition = Position(5811, 4570, 9), toPosition = Position(5810, 4574, 9) }, -- Cave Nivabi Custom
-- 	[12311] = { flamePosition = Position(5731, 4580, 9), toPosition = Position(5731, 4575, 9) }, -- Cave Nivabi Sphinx
-- 	[12312] = { flamePosition = Position(5927, 5103, 8), toPosition = Position(5926, 5100, 8) }, -- Roshamuul Prison
-- 	[12346] = { flamePosition = Position(5123, 4874, 11), toPosition = Position(5121, 4874, 11) }, -- BOSS ROOM
-- 	[12370] = { flamePosition = Position(4432, 5347, 5), toPosition = Position(4432, 5345, 5) }, -- viridia warlock tower
-- 	[12371] = { flamePosition = Position(4484, 5340, 11), toPosition = Position(4451, 5328, 11) }, -- viridia grim reaper hunt
-- 	[12379] = { flamePosition = Position(4335, 5703, 7), toPosition = Position(4358, 5678, 7) }, -- evento primavera
-- 	[12381] = { flamePosition = Position(4559, 5360, 10), toPosition = Position(4604, 5175, 11) }, -- viridia fauns
-- 	[12384] = { flamePosition = Position(4787, 5373, 13), toPosition = Position(4730, 5349, 14) }, -- viridia mikarah
-- 	[14503] = { flamePosition = Position(4532, 5364, 10), toPosition = Position(4461, 5333, 13) }, -- viridia
-- 	[14504] = { flamePosition = Position(4583, 5797, 7), toPosition = Position(4579, 5797, 7) }, -- evento ferumbras
-- 	[14505] = { flamePosition = Position(4645, 5776, 7), toPosition = Position(4642, 5774, 7) }, -- evento ferumbras hipo
-- }

-- local huntCoalBasin = MoveEvent()

-- function huntCoalBasin.onAddItem(moveitem, tileitem, position)
-- 	local targetCoalBasin = config[tileitem.uid]
-- 	if not targetCoalBasin then
-- 		return true
-- 	end

-- 	if tileitem.uid == 12299 and moveitem.itemid == 22721 and moveitem:getCount() == 3 then
-- 		moveitem:remove()
-- 		position:sendMagicEffect(CONST_ME_HITBYFIRE)

-- 		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
-- 		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
-- 		return true
-- 	elseif tileitem.uid == 12300 and moveitem.itemid == 22721 and moveitem:getCount() == 1 then
-- 		moveitem:remove()
-- 		position:sendMagicEffect(CONST_ME_HITBYFIRE)

-- 		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
-- 		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
-- 		return true
-- 	elseif tileitem.uid == 12301 and moveitem.itemid == 22721 and moveitem:getCount() == 5 then
-- 		moveitem:remove()
-- 		position:sendMagicEffect(CONST_ME_HITBYFIRE)

-- 		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
-- 		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
-- 		return true
-- 	elseif tileitem.uid == 12302 and moveitem.itemid == 22721 then
-- 		moveitem:remove()
-- 		position:sendMagicEffect(CONST_ME_HITBYFIRE)

-- 		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
-- 		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
-- 		return true
-- 	elseif tileitem.uid == 12303 and moveitem.itemid == 22721 and moveitem:getCount() == 3 then
-- 		moveitem:remove()
-- 		position:sendMagicEffect(CONST_ME_HITBYFIRE)

-- 		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
-- 		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
-- 		return true
-- 	elseif tileitem.uid == 12304 and moveitem.itemid == 22721 then
-- 		moveitem:remove()
-- 		position:sendMagicEffect(CONST_ME_HITBYFIRE)

-- 		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
-- 		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
-- 		return true
-- 	elseif tileitem.uid == 12305 and moveitem.itemid == 22721 and moveitem:getCount() == 3 then
-- 		moveitem:remove()
-- 		position:sendMagicEffect(CONST_ME_HITBYFIRE)

-- 		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
-- 		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
-- 		return true
-- 	elseif tileitem.uid == 12306 and moveitem.itemid == 22721 then
-- 		moveitem:remove()
-- 		position:sendMagicEffect(CONST_ME_HITBYFIRE)

-- 		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
-- 		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
-- 		return true
-- 	elseif tileitem.uid == 12307 and moveitem.itemid == 22721 and moveitem:getCount() == 3 then
-- 		moveitem:remove()
-- 		position:sendMagicEffect(CONST_ME_HITBYFIRE)

-- 		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
-- 		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
-- 		return true
-- 	elseif tileitem.uid == 12308 and moveitem.itemid == 22721 and moveitem:getCount() == 1 then
-- 		moveitem:remove()
-- 		position:sendMagicEffect(CONST_ME_HITBYFIRE)

-- 		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
-- 		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
-- 		return true
-- 	elseif tileitem.uid == 12309 and moveitem.itemid == 22721 and moveitem:getCount() == 5 then
-- 		moveitem:remove()
-- 		position:sendMagicEffect(CONST_ME_HITBYFIRE)

-- 		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
-- 		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
-- 		return true
-- 	elseif tileitem.uid == 12310 and moveitem.itemid == 22721 and moveitem:getCount() == 2 then
-- 		moveitem:remove()
-- 		position:sendMagicEffect(CONST_ME_HITBYFIRE)

-- 		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
-- 		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
-- 		return true
-- 	elseif tileitem.uid == 12311 and moveitem.itemid == 22721 and moveitem:getCount() == 2 then
-- 		moveitem:remove()
-- 		position:sendMagicEffect(CONST_ME_HITBYFIRE)

-- 		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
-- 		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
-- 		return true
-- 	elseif tileitem.uid == 12312 and moveitem.itemid == 22721 and moveitem:getCount() == 1 then
-- 		moveitem:remove()
-- 		position:sendMagicEffect(CONST_ME_HITBYFIRE)

-- 		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
-- 		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
-- 		return true
-- 	elseif tileitem.uid == 12346 and moveitem.itemid == 22721 and moveitem:getCount() == 1 then
-- 		moveitem:remove()
-- 		position:sendMagicEffect(CONST_ME_HITBYFIRE)

-- 		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
-- 		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
-- 		return true
-- 	elseif tileitem.uid == 12370 and moveitem.itemid == 3077 and moveitem:getCount() == 1 then
-- 		moveitem:remove()
-- 		position:sendMagicEffect(CONST_ME_HITBYFIRE)

-- 		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
-- 		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
-- 		return true
-- 	elseif tileitem.uid == 12371 and moveitem.itemid == 5954 and moveitem:getCount() == 1 then
-- 		moveitem:remove()
-- 		position:sendMagicEffect(CONST_ME_HITBYFIRE)

-- 		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
-- 		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
-- 		return true
-- 	elseif tileitem.uid == 12381 and moveitem.itemid == 3028 and moveitem:getCount() == 1 then
-- 		moveitem:remove()
-- 		position:sendMagicEffect(CONST_ME_HITBYFIRE)

-- 		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
-- 		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
-- 		return true
-- 	elseif tileitem.uid == 12379 and moveitem.itemid == 9215 and moveitem:getCount() == 1 then
-- 		local player = Tile(targetCoalBasin.flamePosition):getTopCreature()
-- 		moveitem:remove()
-- 		position:sendMagicEffect(CONST_ME_HITBYFIRE)
-- 		player:setStorageValue(Storage.Quest.Crandoria.Eventos.FestivalDePrimavera.Teleport, os.time() + 60 * 60 * 24)

-- 		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
-- 		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
-- 		return true
-- 	elseif tileitem.uid == 12381 and moveitem.itemid == 3028 and moveitem:getCount() == 1 then
-- 		moveitem:remove()
-- 		position:sendMagicEffect(CONST_ME_HITBYFIRE)

-- 		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
-- 		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
-- 		return true
-- 	elseif tileitem.uid == 12384 and moveitem.itemid == 3042 and moveitem:getCount() == 3 then
-- 		moveitem:remove()
-- 		position:sendMagicEffect(CONST_ME_HITBYFIRE)

-- 		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
-- 		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
-- 		return true
-- 	elseif tileitem.uid == 14503 and moveitem.itemid == 5893 and moveitem:getCount() == 1 then
-- 		moveitem:remove()
-- 		position:sendMagicEffect(CONST_ME_HITBYFIRE)

-- 		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
-- 		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
-- 		return true
-- 	elseif tileitem.uid == 14504 and moveitem.itemid == 3300 and moveitem:getCount() == 1 then
-- 		moveitem:remove()
-- 		position:sendMagicEffect(CONST_ME_HITBYFIRE)
-- 		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
-- 		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
-- 		return true
-- 	elseif tileitem.uid == 14505 and moveitem.itemid == 3582 and moveitem:getCount() == 3 then
-- 		moveitem:remove()
-- 		position:sendMagicEffect(CONST_ME_HITBYFIRE)
-- 		Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
-- 		targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
-- 		return true
-- 	else
-- 		return true
-- 	end

-- end

-- huntCoalBasin:type("additem")
-- huntCoalBasin:aid(12355)
-- huntCoalBasin:register()


