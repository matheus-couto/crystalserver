-- crandoria edit --

local scissorsfun = Action()
function scissorsfun.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if not player then
        return true
    end

    if not target or not target:isNpc() then
        return true
    end

    local storage = player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.Scissors)
    local timer = player:getStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.RouboTimer)
    local timeNow = os.time()

    if target:getName() == "Lord Holtten" then
        if storage >= 2 then
            if timer <= timeNow then
                local chance = math.random(1, 3)
                if chance == 1 then
                    local coins = math.random(5, 15)
                    player:addTransferableCoins(coins)
                    player:say('click!', TALKTYPE_MONSTER_SAY)
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce roubou algumas Tibia Coins de Lord Holtten, fazendo-o fugir assustado.")
                else
                    player:say('miss', TALKTYPE_MONSTER_SAY)
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce tentou roubar do Lord Holtten, mas ele percebeu e fugiu rapidamente.")
                end
                player:setStorageValue(Storage.Quest.Crandoria.IntoTheShaodws.RouboTimer, timeNow + 7 * 24 * 60 * 60)
                toPosition:sendMagicEffect(CONST_ME_POFF)
                target:remove()
                return true
            else
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce so pode tentar roubar uma vez a cada 7 dias.")
                return true
            end
        else
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao sabe como usar este item.")
            return true
        end
    else
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Nao ha nada a ser roubado aqui.")
        return true
    end
	return true
end

scissorsfun:id(31327)
scissorsfun:register()

-- local config = {
-- 	[30426] = {
-- 		itemId = 30426,
-- 		msg = "You are cutting some veldt flowers.",
-- 		storage = Storage.Kilmaresh.Eighth.Yonan,
-- 		getValue = 2,
-- 		addItemId = 31325,
-- 	}, -- Veldt Flower
-- 	[30422] = {
-- 		itemId = 30422,
-- 		msg = "You are cutting some snake maw.",
-- 		storage = Storage.Kilmaresh.Eighth.Shimun,
-- 		getValue = 2,
-- 		addItemId = 31336,
-- 	}, -- Sanke Maw
-- 	[30427] = {
-- 		itemId = 30427,
-- 		msg = "You are cutting some desert rose blossoms.",
-- 		storage = Storage.Kilmaresh.Eighth.Tefrit,
-- 		getValue = 2,
-- 		addItemId = 31330,
-- 	}, -- Rose Blossoms
-- 	[12747] = {
-- 		itemId = 12747,
-- 		msg = "You are gathering some spiderweb cloud shreds. But you become entangled.",
-- 		storage = Storage.Kilmaresh.Eighth.Tefrit,
-- 		getValue = 2,
-- 		addItemId = 31339,
-- 	}, -- Spider Cloud Shreds
-- 	[12748] = {
-- 		itemId = 12748,
-- 		msg = "You are gathering some spiderweb cloud shreds. But you become entangled.",
-- 		storage = Storage.Kilmaresh.Eighth.Tefrit,
-- 		getValue = 2,
-- 		addItemId = 31339,
-- 	}, -- Spider Cloud Shreds
-- 	[12749] = {
-- 		itemId = 12749,
-- 		msg = "You are gathering some spiderweb cloud shreds. But you become entangled.",
-- 		storage = Storage.Kilmaresh.Eighth.Tefrit,
-- 		getValue = 2,
-- 		addItemId = 31339,
-- 	}, -- Spider Cloud Shreds
-- 	[12750] = {
-- 		itemId = 12750,
-- 		msg = "You are gathering some spiderweb cloud shreds. But you become entangled.",
-- 		storage = Storage.Kilmaresh.Eighth.Tefrit,
-- 		getValue = 2,
-- 		addItemId = 31339,
-- 	}, -- Spider Cloud Shreds
-- 	[12751] = {
-- 		itemId = 12751,
-- 		msg = "You are gathering some spiderweb cloud shreds. But you become entangled.",
-- 		storage = Storage.Kilmaresh.Eighth.Tefrit,
-- 		getValue = 2,
-- 		addItemId = 31339,
-- 	}, -- Spider Cloud Shreds
-- 	[12752] = {
-- 		itemId = 12752,
-- 		msg = "You are gathering some spiderweb cloud shreds. But you become entangled.",
-- 		storage = Storage.Kilmaresh.Eighth.Tefrit,
-- 		getValue = 2,
-- 		addItemId = 31339,
-- 	}, -- Spider Cloud Shreds
-- 	[12753] = {
-- 		itemId = 12753,
-- 		msg = "You are gathering some spiderweb cloud shreds. But you become entangled.",
-- 		storage = Storage.Kilmaresh.Eighth.Tefrit,
-- 		getValue = 2,
-- 		addItemId = 31339,
-- 	}, -- Spider Cloud Shreds
-- 	[12754] = {
-- 		itemId = 12754,
-- 		msg = "You are gathering some spiderweb cloud shreds. But you become entangled.",
-- 		storage = Storage.Kilmaresh.Eighth.Tefrit,
-- 		getValue = 2,
-- 		addItemId = 31339,
-- 	}, -- Spider Cloud Shreds
-- 	[12755] = {
-- 		itemId = 12755,
-- 		msg = "You are gathering some spiderweb cloud shreds. But you become entangled.",
-- 		storage = Storage.Kilmaresh.Eighth.Tefrit,
-- 		getValue = 2,
-- 		addItemId = 31339,
-- 	}, -- Spider Cloud Shreds
-- 	[12756] = {
-- 		itemId = 12756,
-- 		msg = "You are gathering some spiderweb cloud shreds. But you become entangled.",
-- 		storage = Storage.Kilmaresh.Eighth.Tefrit,
-- 		getValue = 2,
-- 		addItemId = 31339,
-- 	}, -- Spider Cloud Shreds
-- 	[12757] = {
-- 		itemId = 12757,
-- 		msg = "You are gathering some spiderweb cloud shreds. But you become entangled.",
-- 		storage = Storage.Kilmaresh.Eighth.Tefrit,
-- 		getValue = 2,
-- 		addItemId = 31339,
-- 	}, -- Spider Cloud Shreds
-- 	[12758] = {
-- 		itemId = 12758,
-- 		msg = "You are gathering some spiderweb cloud shreds. But you become entangled.",
-- 		storage = Storage.Kilmaresh.Eighth.Tefrit,
-- 		getValue = 2,
-- 		addItemId = 31339,
-- 	}, -- Spider Cloud Shreds
-- 	[12759] = {
-- 		itemId = 12759,
-- 		msg = "You are gathering some spiderweb cloud shreds. But you become entangled.",
-- 		storage = Storage.Kilmaresh.Eighth.Tefrit,
-- 		getValue = 2,
-- 		addItemId = 31339,
-- 	}, -- Spider Cloud Shreds
-- 	[12760] = {
-- 		itemId = 12760,
-- 		msg = "You are gathering some spiderweb cloud shreds. But you become entangled.",
-- 		storage = Storage.Kilmaresh.Eighth.Tefrit,
-- 		getValue = 2,
-- 		addItemId = 31339,
-- 	}, -- Spider Cloud Shreds
-- 	[12761] = {
-- 		itemId = 12761,
-- 		msg = "You are gathering some spiderweb cloud shreds. But you become entangled.",
-- 		storage = Storage.Kilmaresh.Eighth.Tefrit,
-- 		getValue = 2,
-- 		addItemId = 31339,
-- 	}, -- Spider Cloud Shreds
-- 	[12762] = {
-- 		itemId = 12762,
-- 		msg = "You are gathering some spiderweb cloud shreds. But you become entangled.",
-- 		storage = Storage.Kilmaresh.Eighth.Tefrit,
-- 		getValue = 2,
-- 		addItemId = 31339,
-- 	}, -- Spider Cloud Shreds
-- 	[12763] = {
-- 		itemId = 12763,
-- 		msg = "You are gathering some spiderweb cloud shreds. But you become entangled.",
-- 		storage = Storage.Kilmaresh.Eighth.Tefrit,
-- 		getValue = 2,
-- 		addItemId = 31339,
-- 	}, -- Spider Cloud Shreds
-- 	[12764] = {
-- 		itemId = 12764,
-- 		msg = "You are gathering some spiderweb cloud shreds. But you become entangled.",
-- 		storage = Storage.Kilmaresh.Eighth.Tefrit,
-- 		getValue = 2,
-- 		addItemId = 31339,
-- 	}, -- Spider Cloud Shreds
-- 	[12765] = {
-- 		itemId = 12765,
-- 		msg = "You are gathering some spiderweb cloud shreds. But you become entangled.",
-- 		storage = Storage.Kilmaresh.Eighth.Tefrit,
-- 		getValue = 2,
-- 		addItemId = 31339,
-- 	}, -- Spider Cloud Shreds
-- 	[12766] = {
-- 		itemId = 12766,
-- 		msg = "You are gathering some spiderweb cloud shreds. But you become entangled.",
-- 		storage = Storage.Kilmaresh.Eighth.Tefrit,
-- 		getValue = 2,
-- 		addItemId = 31339,
-- 	}, -- Spider Cloud Shreds
-- 	[12767] = {
-- 		itemId = 12767,
-- 		msg = "You are gathering some spiderweb cloud shreds. But you become entangled.",
-- 		storage = Storage.Kilmaresh.Eighth.Tefrit,
-- 		getValue = 2,
-- 		addItemId = 31339,
-- 	}, -- Spider Cloud Shreds
-- 	[12768] = {
-- 		itemId = 12768,
-- 		msg = "You are gathering some spiderweb cloud shreds. But you become entangled.",
-- 		storage = Storage.Kilmaresh.Eighth.Tefrit,
-- 		getValue = 2,
-- 		addItemId = 31339,
-- 	}, -- Spider Cloud Shreds
-- 	[12769] = {
-- 		itemId = 12769,
-- 		msg = "You are gathering some spiderweb cloud shreds. But you become entangled.",
-- 		storage = Storage.Kilmaresh.Eighth.Tefrit,
-- 		getValue = 2,
-- 		addItemId = 31339,
-- 	}, -- Spider Cloud Shreds
-- 	[12770] = {
-- 		itemId = 12770,
-- 		msg = "You are gathering some spiderweb cloud shreds. But you become entangled.",
-- 		storage = Storage.Kilmaresh.Eighth.Tefrit,
-- 		getValue = 2,
-- 		addItemId = 31339,
-- 	}, -- Spider Cloud Shreds
-- 	[12771] = {
-- 		itemId = 12771,
-- 		msg = "You are gathering some spiderweb cloud shreds. But you become entangled.",
-- 		storage = Storage.Kilmaresh.Eighth.Tefrit,
-- 		getValue = 2,
-- 		addItemId = 31339,
-- 	}, -- Spider Cloud Shreds
-- 	[12772] = {
-- 		itemId = 12772,
-- 		msg = "You are gathering some spiderweb cloud shreds. But you become entangled.",
-- 		storage = Storage.Kilmaresh.Eighth.Tefrit,
-- 		getValue = 2,
-- 		addItemId = 31339,
-- 	}, -- Spider Cloud Shreds
-- 	[12773] = {
-- 		itemId = 12773,
-- 		msg = "You are gathering some spiderweb cloud shreds. But you become entangled.",
-- 		storage = Storage.Kilmaresh.Eighth.Tefrit,
-- 		getValue = 2,
-- 		addItemId = 31339,
-- 	}, -- Spider Cloud Shreds
-- 	[12774] = {
-- 		itemId = 12774,
-- 		msg = "You are gathering some spiderweb cloud shreds. But you become entangled.",
-- 		storage = Storage.Kilmaresh.Eighth.Tefrit,
-- 		getValue = 2,
-- 		addItemId = 31339,
-- 	}, -- Spider Cloud Shreds
-- 	[12775] = {
-- 		itemId = 12775,
-- 		msg = "You are gathering some spiderweb cloud shreds. But you become entangled.",
-- 		storage = Storage.Kilmaresh.Eighth.Tefrit,
-- 		getValue = 2,
-- 		addItemId = 31339,
-- 	}, -- Spider Cloud Shreds
-- 	[12776] = {
-- 		itemId = 12776,
-- 		msg = "You are gathering some spiderweb cloud shreds. But you become entangled.",
-- 		storage = Storage.Kilmaresh.Eighth.Tefrit,
-- 		getValue = 2,
-- 		addItemId = 31339,
-- 	}, -- Spider Cloud Shreds
-- 	[12777] = {
-- 		itemId = 12777,
-- 		msg = "You are gathering some spiderweb cloud shreds. But you become entangled.",
-- 		storage = Storage.Kilmaresh.Eighth.Tefrit,
-- 		getValue = 2,
-- 		addItemId = 31339,
-- 	}, -- Spider Cloud Shreds
-- 	[12778] = {
-- 		itemId = 12778,
-- 		msg = "You are gathering some spiderweb cloud shreds. But you become entangled.",
-- 		storage = Storage.Kilmaresh.Eighth.Tefrit,
-- 		getValue = 2,
-- 		addItemId = 31339,
-- 	}, -- Spider Cloud Shreds
-- 	[12779] = {
-- 		itemId = 12779,
-- 		msg = "You are gathering some spiderweb cloud shreds. But you become entangled.",
-- 		storage = Storage.Kilmaresh.Eighth.Tefrit,
-- 		getValue = 2,
-- 		addItemId = 31339,
-- 	}, -- Spider Cloud Shreds
-- 	[12780] = {
-- 		itemId = 12780,
-- 		msg = "You are gathering some spiderweb cloud shreds. But you become entangled.",
-- 		storage = Storage.Kilmaresh.Eighth.Tefrit,
-- 		getValue = 2,
-- 		addItemId = 31339,
-- 	}, -- Spider Cloud Shreds
-- 	[12781] = {
-- 		itemId = 12781,
-- 		msg = "You are gathering some spiderweb cloud shreds. But you become entangled.",
-- 		storage = Storage.Kilmaresh.Eighth.Tefrit,
-- 		getValue = 2,
-- 		addItemId = 31339,
-- 	}, -- Spider Cloud Shreds
-- }

-- local scissorsfun = Action()
-- function scissorsfun.onUse(player, item, fromPosition, target, toPosition, isHotkey)
-- 	local key = config[target.itemid]
-- 	if key then
-- 		if player:getStorageValue(key.storage) == key.getValue then
-- 			if table.contains({ key.itemId }, target.itemid) then
-- 				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, key.msg)
-- 				player:addItem(key.addItemId, 1)
-- 			end
-- 		else
-- 			player:sendTextMessage(MESSAGE_FAILURE, "Sorry, not possible.")
-- 		end
-- 	end
-- 	return true
-- end

-- scissorsfun:id(31327)
-- scissorsfun:register()
