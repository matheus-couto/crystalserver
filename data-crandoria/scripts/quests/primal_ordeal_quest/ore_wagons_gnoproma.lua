local carts = {
    {clickPos = {x = 5670, y = 4860, z = 15}, destination = Position(5763, 4789, 15)},
    {clickPos = {x = 5764, y = 4788, z = 15}, destination = Position(5669, 4860, 15)},
    {clickPos = {x = 5673, y = 4859, z = 15}, destination = Position(5891, 4856, 15)},
    {clickPos = {x = 5892, y = 4856, z = 15}, destination = Position(5672, 4859, 15)},
    {clickPos = {x = 5676, y = 4860, z = 15}, destination = Position(5690, 4810, 15)},
    {clickPos = {x = 5689, y = 4810, z = 15}, destination = Position(5675, 4860, 15)},
    {clickPos = {x = 5698, y = 4816, z = 15}, destination = Position(4717, 4857, 15)},
    {clickPos = {x = 5718, y = 4857, z = 15}, destination = Position(5697, 4816, 15)},
    {clickPos = {x = 5724, y = 4862, z = 15}, destination = Position(5787, 4924, 15)},
    {clickPos = {x = 5788, y = 4924, z = 15}, destination = Position(5723, 4862, 15)},

}

local gnompronaCarts = Action()
function gnompronaCarts.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    for i = 1, #carts do
        if item:getPosition() == Position(carts[i].clickPos) then
            player:teleportTo(carts[i].destination)
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            return true
        end
    end
end

for j = 1, #carts do
    gnompronaCarts:position(carts[j].clickPos)
end
gnompronaCarts:register()
