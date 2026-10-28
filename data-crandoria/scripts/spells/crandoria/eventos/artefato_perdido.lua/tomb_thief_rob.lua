local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local target = creature:getTarget()
	if target then
		if target:isPlayer() then
			local targetPos = target:getPosition()
			local creaturePos = creature:getPosition()
			if targetPos.x - creaturePos.x > 1 or targetPos.x - creaturePos.x < -1 or targetPos.y - creaturePos.y > 1 or targetPos.y - creaturePos.y < -1 then
				return true
			else
				if target:getItemCount(19149) >= 1 then
					target:say('Artefato roubado!', TALKTYPE_MONSTER_SAY)
					targetPos:sendMagicEffect(CONST_ME_SLASH)
					Game.broadcastMessage("Um jogador teve seu artefato roubado por um Tomb Thief!", MESSAGE_EVENT_ADVANCE)
					target:removeItem(19149, 1)
					creaturePos:sendMagicEffect(CONST_ME_POFF)
					creature:remove()
					return true
				else
					target:sendMagicEffect(CONST_ME_HITAREA)
					target:say('Tentando roubar...', TALKTYPE_MONSTER_SAY)
					return true
				end
			end
		end
	end
	return true
end

spell:name("tomb thief rob") -- use esse mesmo nome no "name" da entrada em monster.attacks
spell:words("###779") -- ajuste se seu fork exigir um identificador único diferente
spell:isAggressive(true)
spell:needLearn(true)
spell:blockWalls(true)
spell:register()