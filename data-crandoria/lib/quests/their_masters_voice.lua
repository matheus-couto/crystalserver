-- CRANDORIA EDIT --

local config = {
	quest_duration = 60, -- quanto tempo até a missão ser revertida, em minutos
	slime_exhaust = 5, -- intervalo até poder remover outra lesma, em segundos
	slimes_needed = 25, -- lesmas necessárias para matar o mago louco e completar a missão
	max_slimes = 100, -- máximo de lesmas necessárias para começar as ondas
	max_waves = 25 -- máximo de ondas, a última será o mago louco
}

local mage_positions = {
	{x = 4807, y = 5232, z = 10},
	{x = 4816, y = 5272, z = 10}
}

local servant_positions = {
	{x = 4808, y = 5225, z = 10},
	{x = 4808, y = 5254, z = 10},
	{x = 4813, y = 5226, z = 10},
	{x = 4813, y = 5239, z = 10},
	{x = 4813, y = 5262, z = 10},
	{x = 4793, y = 5239, z = 10},
	{x = 4805, y = 5239, z = 10},
	{x = 4820, y = 5239, z = 10},
	{x = 4839, y = 5240, z = 10},
	{x = 4833, y = 5287, z = 10},
	{x = 4840, y = 5287, z = 10},
	{x = 4850, y = 5287, z = 10},
	{x = 4858, y = 5287, z = 10},
	{x = 4842, y = 5247, z = 10},
	{x = 4849, y = 5246, z = 10},
	{x = 4852, y = 5227, z = 10},
	{x = 4852, y = 5258, z = 10},
	{x = 4840, y = 5239, z = 10},
	{x = 4842, y = 5254, z = 10},
	{x = 4806, y = 5239, z = 10},
	{x = 4814, y = 5252, z = 10},
	{x = 4808, y = 5237, z = 10},
	{x = 4833, y = 5258, z = 10},
	{x = 4834, y = 5259, z = 10},
	{x = 4846, y = 5258, z = 10}
}

local slime_ids = {12059, 12060, 12061, 12062, 12063}

local servants = {
	{10, "diamond servant"},
	{40, "golden servant"},
	{100, "iron servant"}
}

slime_exhaust = slime_exhaust or {}
slimes_removed = slimes_removed or {}
current_servants = current_servants or {}
current_mage = current_mage or 0
current_wave = current_wave or 0
valid_participants = valid_participants or {}

function startServantWave()

    if Game.getStorageValue(GlobalStorage.Crandoria.MadMage) == 1 then
        return -- Impede que outra onda seja iniciada
    end

	current_wave = current_wave + 1
	if current_wave == config.max_waves then
		local mage = Game.createMonster("Mad Mage", mage_positions[math.random(#mage_positions)], true, true)
		if mage then
			Game.setStorageValue(GlobalStorage.Crandoria.MadMage, 1)
			mage:registerEvent("Mage_Death")
		end
		return
	end

	current_servants = {}
	for pos_key = 1, #servant_positions do
		local random = math.random(100)
		for servant_key = 1, #servants do
			if random <= servants[servant_key][1] then
				local servant = Game.createMonster(servants[servant_key][2], servant_positions[pos_key], true, true)
				if servant then
					current_servants[#current_servants + 1] = servant.uid
					servant:registerEvent("Servant_Death")
					break
				end
			end
		end
	end
end

function revertQuest()
	for i = 1, #current_servants do
		local servant = Creature(current_servants[i])
		if servant then
			servant:remove()
		end
	end
	current_servants = {}

	local mage = Creature(current_mage)
	if mage then
		mage:remove()
	end
	current_mage = 0

	for i = 1, #slimes_removed do
		local ground = Tile(slimes_removed[i].pos):getGround()
		if ground then
			ground:transform(slimes_removed[i].id)
		end
	end
	slimes_removed = {}
	current_wave = 0
end

function Gobbler_onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not target or not isInArray(slime_ids, target.itemid) then
		return false
	end

	local time = os.time()
	if slime_exhaust[player.uid] and slime_exhaust[player.uid] >= os.time() then
		player:sendCancelMessage(RETURNVALUE_YOUAREEXHAUSTED)
		fromPosition:sendMagicEffect(CONST_ME_POFF)
		return true
	end

	slime_exhaust[player.uid] = time + config.slime_exhaust
	player:say("The slime gobbler gobbles large chunks of the slime fungus with great satisfaction.", TALKTYPE_MONSTER_SAY)
	player:addExperience(20, true, true)
	slimes_removed[#slimes_removed + 1] = {cid = player.uid, id = target.itemid, pos = toPosition}
	target:transform(12065)

	if not isInArray(valid_participants, player.uid) then
		local slime_count = 0
		for i = 1, #slimes_removed do
			if slimes_removed[i].cid == player.uid then
				slime_count = slime_count + 1
				if slime_count == 25 then
					player:say("You gobbled enough slime to get a good grip on this dungeon's slippery floor.", TALKTYPE_MONSTER_SAY)
					valid_participants[#valid_participants + 1] = player.uid
					break
				end
			end
		end
	end

	if #slimes_removed == 1 then
		addEvent(revertQuest, config.quest_duration * 60 * 1000)
	elseif #slimes_removed >= config.max_slimes then
		player:say("COME! My servants! RISE!", TALKTYPE_MONSTER_SAY)
		startServantWave()
	end
	return true
end

function Servant_onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified)
	for i = 1, #current_servants do
		if current_servants[i] == creature.uid then
			table.remove(current_servants, i)
			break
		end
	end

	if #current_servants < 1 then
		startServantWave()
	end
	return true
end

function Mage_onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified)
	if killer and isInArray(valid_participants, killer.uid) then
		-- adicione conquistas se necessário
	end
	revertQuest()
	return true
end
