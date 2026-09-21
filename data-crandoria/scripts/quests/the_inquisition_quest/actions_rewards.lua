-- CRANDORIA EDIT --

local rewards = {
	[1300] = 8062,
	[1301] = 8090,
	[1302] = 8053,
	[1303] = 8060,
	[1304] = 8023,
	[1305] = 8096,
	[1306] = 8100,
	[1307] = 8102,
	[1308] = 8026,
	[1311] = 50261,
}

local inquisitionRewards = Action()
function inquisitionRewards.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Reward) < 1 then
		player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Reward, 1)
		player:setStorageValue(Storage.Quest.Crandoria.DemonSlayer.InquisitionPass, 1) -- DEMON SLAYER
		player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Questline, 25)
		player:setStorageValue(Storage.Quest.U8_2.TheInquisitionQuest.Mission07, 5) -- The Inquisition Questlog- "Mission 7: The Shadow Nexus"
		player:addItem(rewards[item.uid], 1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found " .. ItemType(rewards[item.uid]):getName() .. ".")
		player:addAchievement('Master of the Nexus')
		player:addOutfitAddon(288, 2)
		player:addOutfitAddon(288, 1)
		player:addOutfitAddon(289, 1)
		player:addOutfitAddon(289, 2)
		local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
        player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 10)
        player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The chest is empty.")
	end
	return true
end

for uniqueId, info in pairs(rewards) do
	inquisitionRewards:uid(uniqueId)
end

inquisitionRewards:register()
