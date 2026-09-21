
local elevatorBounacAction = Action()
function elevatorBounacAction.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getPosition() ~= Position(5189, 4459, 7) then
		Position(5189, 4459, 7):sendMagicEffect(CONST_ME_POFF)
	else
		player:teleportTo(Position(5192, 4460, 3))
		Position(5192, 4460, 3):sendMagicEffect(CONST_ME_POFF)
	end
	return true
end
elevatorBounacAction:aid(59604)
elevatorBounacAction:register()

local elevatorBounacMoveEvent = MoveEvent()
function elevatorBounacMoveEvent.onStepIn(creature, item, position, fromPosition)
	if creature:isPlayer() then
		creature:teleportTo(Position(5189, 4460, 7))
		Position(5189, 4460, 7):sendMagicEffect(CONST_ME_POFF)
	end
	return true
end
elevatorBounacMoveEvent:aid(59605)
elevatorBounacMoveEvent:register()