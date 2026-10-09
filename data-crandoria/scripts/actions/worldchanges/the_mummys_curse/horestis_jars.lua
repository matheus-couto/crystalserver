local bossName = "Horestis"
local bossPosition = { x = 5500, y = 4659, z = 13 }
local Poswall1 = { x = 5499, y = 4621, z = 13 }
local Poswall2 = { x = 5500, y = 4621, z = 13 }
local Poswall3 = { x = 5501, y = 4621, z = 13 }
local Poswall4 = { x = 5502, y = 4621, z = 13 }
local failMessages = { "Waaaaaah", "You are too afraid to destroy this object" }

function createWall() --creates walls
	Game.createItem(1603, 1, Poswall1)
	Game.createItem(1603, 1, Poswall2)
	Game.createItem(1603, 1, Poswall3)
	Game.createItem(1603, 1, Poswall4)
end

local horestisJars = Action()

function horestisJars.onUse(cid, item, fromPosition, itemEx, toPosition)
	local exaustedSeconds = 1
	local player = Player(cid)
	local chances = math.random(10)

	if item.actionid == 50006 then
		if item.itemid == 12511 then
			if getPlayerStorageValue(cid, Storage.TheMummysCurse.Time1) <= os.time() then
				if chances == 1 then
					doTransformItem(item.uid, 12506)
					Game.setStorageValue(GlobalStorage.TheMummysCurse, 1)
				else
					player:say(failMessages[math.random(#failMessages)], TALKTYPE_ORANGE_1)
					player:getPosition():sendMagicEffect(CONST_ME_POFF)
					setPlayerStorageValue(cid, Storage.TheMummysCurse.Time1, os.time() + exaustedSeconds * 1800)
				end
			else
				doPlayerSendCancel(cid, "You need wait 30 minutes to use again.")
			end
		end
	elseif item.actionid == 50007 then
		if item.itemid == 12511 then
			if Game.getStorageValue(GlobalStorage.TheMummysCurse) == 1 then
				if getPlayerStorageValue(cid, Storage.TheMummysCurse.Time2) <= os.time() then
					if chances == 1 then
						doTransformItem(item.uid, 12506)
						Game.setStorageValue(GlobalStorage.TheMummysCurse, 2)
					else
						player:say(failMessages[math.random(#failMessages)], TALKTYPE_ORANGE_1)
						player:getPosition():sendMagicEffect(CONST_ME_POFF)
						setPlayerStorageValue(cid, Storage.TheMummysCurse.Time2, os.time() + exaustedSeconds * 1800)
					end
				else
					doPlayerSendCancel(cid, "You need wait 30 minutes to use again.")
				end
			else
				doPlayerSendCancel(cid, "You need to break the first jar.")
			end
		end
	elseif item.actionid == 50008 then
		if item.itemid == 12511 then
			if Game.getStorageValue(GlobalStorage.TheMummysCurse) == 2 then
				if getPlayerStorageValue(cid, Storage.TheMummysCurse.Time3) <= os.time() then
					if chances == 1 then
						doTransformItem(item.uid, 12506)
						Game.setStorageValue(GlobalStorage.TheMummysCurse, 3)
					else
						player:say(failMessages[math.random(#failMessages)], TALKTYPE_ORANGE_1)
						player:getPosition():sendMagicEffect(CONST_ME_POFF)
						setPlayerStorageValue(cid, Storage.TheMummysCurse.Time3, os.time() + exaustedSeconds * 1800)
					end
				else
					doPlayerSendCancel(cid, "You need wait 30 minutes to use again.")
				end
			else
				doPlayerSendCancel(cid, "You need to break the second jar.")
			end
		end
	elseif item.actionid == 50009 then
		if item.itemid == 12511 then
			if Game.getStorageValue(GlobalStorage.TheMummysCurse) == 3 then
				if getPlayerStorageValue(cid, Storage.TheMummysCurse.Time4) <= os.time() then
					if chances == 1 then
						doTransformItem(item.uid, 12506)
						Game.setStorageValue(GlobalStorage.TheMummysCurse, 4)
					else
						player:say(failMessages[math.random(#failMessages)], TALKTYPE_ORANGE_1)
						player:getPosition():sendMagicEffect(CONST_ME_POFF)
						setPlayerStorageValue(cid, Storage.TheMummysCurse.Time4, os.time() + exaustedSeconds * 1800)
					end
				else
					doPlayerSendCancel(cid, "You need wait 30 minutes to use again.")
				end
			else
				doPlayerSendCancel(cid, "You need to break the third jar.")
			end
		end
	elseif item.actionid == 50010 then
		if item.itemid == 12511 then
			if Game.getStorageValue(GlobalStorage.TheMummysCurse) == 4 then
				doTransformItem(item.uid, 12506)
				-- Remover Barreira e Sumonar Boss
				doRemoveItem(getTileItemById({ x = 5499, y = 4621, z = 13 }, 1603).uid, 1)
				doRemoveItem(getTileItemById({ x = 5500, y = 4621, z = 13 }, 1603).uid, 1)
				doRemoveItem(getTileItemById({ x = 5501, y = 4621, z = 13 }, 1603).uid, 1)
				doRemoveItem(getTileItemById({ x = 5502, y = 4621, z = 13 }, 1603).uid, 1)
				doCreatureSay(cid, "The horestis tomb was broken, the boss of the tomb will be reborn in 45 seconds. The barrier will be built from here 2 minutes.", TALKTYPE_ORANGE_1)
				Game.createMonster(bossName, bossPosition)
				addEvent(doSummonCreature, 45 * 1000, "Horestis", { x = 5500, y = 4632, z = 13 })

				addEvent(createWall, 20 * 60)
				addEvent(Game.createItem, 20 * 60 * 1000, 1603, { x = 5499, y = 4621, z = 13 })
				addEvent(Game.createItem, 20 * 60 * 1000, 1603, { x = 5500, y = 4621, z = 13 })
				addEvent(Game.createItem, 20 * 60 * 1000, 1603, { x = 5501, y = 4621, z = 13 })
				addEvent(Game.createItem, 20 * 60 * 1000, 1603, { x = 5502, y = 4621, z = 13 })
			else
				doPlayerSendCancel(cid, "You need to break the fourth jar.")
			end
		end
	end
	return true
end

horestisJars:aid(50006, 50007, 50008, 50009, 50010)
horestisJars:register()
