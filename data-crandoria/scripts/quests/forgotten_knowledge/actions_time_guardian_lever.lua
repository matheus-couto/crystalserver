local config = {
	bossName = "The Time Guardian",
	timeToFightAgain = 20, -- In hour
	timeToDefeat = 15, -- In minutes
	playerPositions = {
		{ pos = Position(4986, 4807, 15), teleport = Position(4953, 4818, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(4986, 4808, 15), teleport = Position(4953, 4818, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(4986, 4809, 15), teleport = Position(4953, 4818, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(4986, 4810, 15), teleport = Position(4953, 4818, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(4986, 4811, 15), teleport = Position(4953, 4818, 15), effect = CONST_ME_TELEPORT }
	},
	bosses = {
		{bossPosition = Position(4953, 4809, 15), bossName = 'The Time Guardian'},
		{bossPosition = Position(4951, 4810, 14), bossName = 'The Freezing Time Guardian'},
		{bossPosition = Position(4956, 4810, 14), bossName = 'The Blazing Time Guardian'},
	},
	specPos = {
		from = Position(4939, 4798, 15),
		to = Position(4968, 4822, 15)
	},
	exit = Position(4986, 4815, 15),
	storage = Storage.Quest.U11_02.ForgottenKnowledge.TimeGuardianTimer
}

local forgottenKnowledgeGuardianLever = Action()
function forgottenKnowledgeGuardianLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if config.playerPositions[1].pos ~= player:getPosition() then
		return false
	end

	local spec = Spectators()
	spec:setOnlyPlayer(false)
	spec:setRemoveDestination(config.exit)
	spec:setCheckPosition(config.specPos)
	spec:setMultiFloor(true)
	spec:check()

	if spec:getPlayers() > 0 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "There's someone fighting with " .. config.bossName .. ".")
		return true
	end

	local lever = Lever()
	lever:setPositions(config.playerPositions)
	lever:setCondition(function(creature)
		if not creature or not creature:isPlayer() then
			return true
		end

		if creature:getStorageValue(config.storage) > os.time() then
			local info = lever:getInfoPositions()
			for _, v in pairs(info) do
				local newPlayer = v.creature
				if newPlayer then
					newPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You or a member in your team have to wait " .. config.timeToFightAgain .. " hours to face " .. config.bossName .. " again!")
					if newPlayer:getStorageValue(config.storage) > os.time() then
						newPlayer:getPosition():sendMagicEffect(CONST_ME_POFF)
					end
				end
			end
			return false
		end
		return true
	end)

	lever:checkPositions()

	local info = lever:getInfoPositions()
	local ipCount = {}

	for _, v in pairs(info) do
		local playerCheck = v.creature
		if playerCheck and playerCheck:isPlayer() then
			local ip = Game.convertIpToString(playerCheck:getIp())
			ipCount[ip] = (ipCount[ip] or 0) + 1
			if ipCount[ip] > 2 then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "No maximo 2 personagens do mesmo jogador sao permitidos.")
				for _, affected in pairs(info) do
					if affected.creature then
						affected.creature:getPosition():sendMagicEffect(CONST_ME_POFF)
					end
				end
				return true
			end
		end
	end

	if lever:checkConditions() then
		spec:removeMonsters()
		for b = 1, #config.bosses do
			local monster = Game.createMonster(config.bosses[b].bossName, config.bosses[b].bossPosition, true, true)
			if not monster then
				return true
			end
		end
		lever:teleportPlayers()
		lever:setStorageAllPlayers(config.storage, os.time() + config.timeToFightAgain * 3600)
		addEvent(function()
			local old_players = lever:getInfoPositions()
			spec:clearCreaturesCache()
			spec:setOnlyPlayer(true)
			spec:check()
			local player_remove = {}
			for i, v in pairs(spec:getCreatureDetect()) do
				for _, v_old in pairs(old_players) do
					if v_old.creature == nil or v_old.creature:isMonster() then
						break
					end
					if v:getName() == v_old.creature:getName() then
						table.insert(player_remove, v_old.creature)
						break
					end
				end
			end
			spec:removePlayers(player_remove)
		end, config.timeToDefeat * 60 * 1000)
	end
end

forgottenKnowledgeGuardianLever:position(Position(4986, 4806, 15))
forgottenKnowledgeGuardianLever:register()
