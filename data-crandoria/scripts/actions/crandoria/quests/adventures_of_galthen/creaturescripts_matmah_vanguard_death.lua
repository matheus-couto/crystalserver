local mitmahVanguardDeath = CreatureEvent("mitmahVanguardDeath")

local function hasOutfit(player)
	return player:hasOutfit(1598, 2) or player:hasOutfit(1597, 2)
end

function mitmahVanguardDeath.onDeath(creature, corpse, killer, mostDamage, unjustified, mostDamage_unjustified)
	if not creature then
		return
	end

	local damageMap = creature:getMonster():getDamageMap()
	for key, value in pairs(damageMap) do
		local player = Player(key)
		if player then
			if player:hasOutfit(1598) and player:hasOutfit(1597) then
				if not hasOutfit(player) then
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu o segundo addon do Ancient Aucar Outfits.")
					player:addOutfitAddon(1598, 2)
					player:addOutfitAddon(1597, 2)
					local storageRep = player:getStorageValue(Storage.Quest.Crandoria.Reputation.Points)
					player:setStorageValue(Storage.Quest.Crandoria.Reputation.Points, storageRep + 5)
					player:say('+ Reputacao', TALKTYPE_MONSTER_SAY)
				end
			end
		end
	end
end

mitmahVanguardDeath:register()