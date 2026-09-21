-- CRANDORIA EDIT --

local config = {
	firstboss = "snake god essence",
	bossPosition = Position(4944, 4585, 13),

	trap = "plaguethrower",
	trapPositions = {
		Position(4934, 4581, 13),
		Position(4943, 4581, 13),
		Position(4934, 4587, 13),
		Position(33364, 4587, 13)
	},
	startAreaPosition = Position(4936, 4582, 12),
	arenaPosition = Position(4941, 4587, 13)
}

local wrathEmperorMiss11Payback = Action()
function wrathEmperorMiss11Payback.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if Game.getStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.Mission11) == 1 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'The arena is already in use.')
		return true
	end

	Game.setStorageValue(Storage.Quest.U8_6.WrathOfTheEmperor.Mission11, 1)
	addEvent(Game.setStorageValue, 10 * 60000, Storage.WrathoftheEmperor.Mission11, 0)

	local monsters = Game.getSpectators(config.arenaPosition, false, false, 10, 10, 10, 10)
	local spectator
	for i = 1, #monsters do
		spectator = monsters[i]
		if spectator:isMonster() then
			spectator:remove()
		end
	end

	local spectators = Game.getSpectators(config.startAreaPosition, false, true, 0, 5, 0, 5)
	for i = 1, #spectators do
		spectator = spectators[i]
		spectator:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		spectator:teleportTo(config.arenaPosition)
		config.arenaPosition:sendMagicEffect(CONST_ME_TELEPORT)
	end

	for i = 1, #config.trapPositions do
		Game.createMonster(config.trap, config.trapPositions[i])
	end

	Game.createMonster(config.firstboss, config.bossPosition)
	item:transform(item.itemid == 2772 and 2773 or 2772)
	return true
end

wrathEmperorMiss11Payback:uid(3198)
wrathEmperorMiss11Payback:register()