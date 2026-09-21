local lilyBeaver = Action()

function lilyBeaver.onUse(player, item, fromPosition, target, toPosition, isHotkey)


	if target:isMonster() and target:getOutfit().lookType == 1536 then
		if player:hasMount(201) then
			player:sendCancelMessage("Voce ja possui essa montaria.")
			return false
		else
			local chance = math.random(1, 10)
			if chance >= 7 then
				item:remove()
				target:getPosition():sendMagicEffect(CONST_ME_POFF)
				target:remove()
				player:addMount(201)
				player:say('Voce domou a montaria Giant Beaver e agora podera obter essa conquista com o Almirante Haldor!', TALKTYPE_MONSTER_SAY)
				player:setStorageValue(Storage.Quest.Crandoria.Viridia.Conquistas.Montaria, 1)
				return true
			elseif chance >= 3 and chance < 7 then
				item:remove()
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
				player:say('Voce falhou e o item se desfez.', TALKTYPE_MONSTER_SAY)
				return true
			else
				target:getPosition():sendMagicEffect(CONST_ME_POFF)
				target:remove()
				player:say('Voce espantou a criatura e ela fugiu.', TALKTYPE_MONSTER_SAY)
				return true
			end
		end
	else
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		player:sendCancelMessage("Voce nao pode usar este item aqui.")
		return true
	end

end

lilyBeaver:id(39548)
lilyBeaver:register()