local transmutationClasses = {

    Cobra = {
        ["cobra crossbow"] = 30393,
        ["cobra boots"] = 30394,
        ["cobra club"] = 30395,
        ["cobra axe"] = 30396,
        ["cobra hood"] = 30397,
        ["cobra sword"] = 30398,
        ["cobra wand"] = 30399,
        ["cobra rod"] = 30400
    },


    Lion = {
        ["lion longbow"] = 34150,
        ["lion rod"] = 34151,
        ["lion wand"] = 34152,
        ["lion spellbook"] = 34153,
        ["lion shield"] = 34154,
        ["lion longsword"] = 34155,
        ["lion spangenhelm"] = 34156,
        ["lion plate"] = 34157,
        ["lion axe"] = 34253,
        ["lion hammer"] = 34254,
        ["lion claws"] = 50162,
    },


    Falcon = {
        ["falcon circlet"] = 28714,
        ["falcon coif"] = 28715,
        ["falcon rod"] = 28716,
        ["falcon wand"] = 28717,
        ["falcon bow"] = 28718,
        ["falcon plate"] = 28719,
        ["falcon greaves"] = 28720,
        ["falcon escutcheon"] = 28722,
        ["falcon longsword"] = 28723,
        ["falcon mace"] = 28725,
        ["falcon sai"] = 50161,
        ["falcon circlet"] = 52783,
    },

    Stag = {
        ["stag helmet"] = 52348,
        ["stag robe"] = 52349,
        ["stag plate"] = 52350,
        ["stag legs"] = 52351,
        ["stag shinguards"] = 52352,
        ["stag boots"] = 52353,
        ["stag footwraps"] = 52354,
        ["stag spellbook"] = 52355,
        ["stag scrolls"] = 52356,
        ["refined stag shield"] = 52649,
    },

    Eldritch = {
        ["eldritch shield"] = 36656,
        ["eldritch claymore"] = 36657,
        ["eldritch warmace"] = 36659,
        ["eldritch greataxe"] = 36661,
        ["eldritch cuirass"] = 36663,
        ["eldritch bow"] = 36664,
        ["eldritch breeches"] = 36667,
        ["eldritch wand"] = 36668,
        ["eldritch cowl"] = 36670,
        ["eldritch hood"] = 36671,
        ["eldritch folio"] = 36672,
        ["eldritch tome"] = 36673,
        ["eldritch rod"] = 36674,
        ["eldritch crescent moon spade"] = 50169,
        ["eldritch monk boots"] = 50266,
    },

    Inferniarch = {
        ["inferniarch bow"] = 49520,
        ["inferniarch arbalest"] = 49522,
        ["inferniarch battleaxe"] = 49523,
        ["inferniarch greataxe"] = 49524,
        ["inferniarch flail"] = 49525,
        ["inferniarch warhammer"] = 49526,
        ["inferniarch blade"] = 49527,
        ["inferniarch wand"] = 49528,
        ["inferniarch rod"] = 49529,
        ["inferniarch slayer"] = 49530,
        ["inferniarch claws"] = 50250,
    },

    Amber = {
        ["amber slayer"] = 47368,
        ["amber greataxe"] = 47369,
        ["amber bludgeon"] = 47370,
        ["amber bow"] = 47371,
        ["amber wand"] = 47372,
        ["amber rod"] = 47373,
        ["amber sabre"] = 47374,
        ["amber axe"] = 47375,
        ["amber cudgel"] = 47376,
        ["amber crossbow"] = 47377,
        ["amber kusarigama"] = 50239,

    },

    Norcferatu = {
        ["norcferatu skullguard"] = 51260,
        ["norcferatu bonehood"] = 51261,
        ["norcferatu tuskplate"] = 51262,
        ["norcferatu bloodhide"] = 51263,
        ["norcferatu bonecloak"] = 51264,
        ["norcferatu thornwraps"] = 51265,
        ["norcferatu bloodstrider"] = 51266,
        ["norcferatu fleshguards"] = 51267,
        ["norcferatu goretrampers"] = 51268,
        ["norcferatu fangstompers"] = 51269,
    },

    Soul = {
        ["soulcutter"] = 34082,
        ["soulshredder"] = 34083,
        ["soulbiter"] = 34084,
        ["souleater"] = 34085,
        ["soulcrusher"] = 34086,
        ["soulmaimer"] = 34087,
        ["soulbleeder"] = 34088,
        ["soulpiercer"] = 34089,
        ["soultainter"] = 34090,
        ["soulhexer"] = 34091,
        ["soulshanks"] = 34092,
        ["soulstrider"] = 34093,
        ["soulshell"] = 34094,
        ["soulmantle"] = 34095,
        ["soulshroud"] = 34096,
        ["soulbastion"] = 34099,
        ["soulkamas"] = 50159,
        ["soulsoles"] = 50240,
        ["soulgarb"] = 50254,
    },

    Primal = {
        ["alicorn headguard"] = 39149,
        ["arboreal crown"] = 39153,
        ["arboreal tome"] = 39154,
        ["arcanomancer regalia"] = 39151,
        ["arcanomancer folio"] = 39152,
        ["ethereal coned hat"] = 50188,
        ["spiritthorn armor"] = 39147,
        ["spiritthorn helmet"] = 39148,
    },

    Sanguine = {
        ["sanguine blade"] = 43864,
        ["sanguine cudgel"] = 43866,
        ["sanguine hatchet"] = 43868,
        ["sanguine razor"] = 43870,
        ["sanguine bludgeon"] = 43872,
        ["sanguine battleaxe"] = 43874,
        ["sanguine legs"] = 43876,
        ["sanguine bow"] = 43877,
        ["sanguine crossbow"] = 43879,
        ["sanguine greaves"] = 43881,
        ["sanguine coil"] = 43882,
        ["sanguine boots"] = 43884,
        ["sanguine rod"] = 43885,
        ["sanguine galoshes"] = 43887,
        ["sanguine trousers"] = 50146,
        ["sanguine claws"] = 50157,
    },

}



local function findItemClass(itemName)

    itemName = itemName:lower()

    for className, items in pairs(transmutationClasses) do

        if items[itemName] then
            return className, items[itemName]
        end

    end

    return nil, nil
end

local transmutation = TalkAction("!transmutar")

function transmutation.onSay(player, words, param)


    local split = param:split(",")


    if #split ~= 2 then

        player:sendTextMessage(
            MESSAGE_EVENT_ADVANCE,
            "Use: !transmutar nome do item, nome do item desejado."
        )

        return false
    end



    local oldItemName = split[1]:trim():lower()
    local newItemName = split[2]:trim():lower()



    local oldClass, oldItemId = findItemClass(oldItemName)
    local newClass, newItemId = findItemClass(newItemName)



    if not oldItemId or not newItemId then

        player:sendTextMessage(
            MESSAGE_EVENT_ADVANCE,
            "Um dos itens informados nao existe para transmutacao."
        )

        return false
    end



    if oldClass ~= newClass then

        player:sendTextMessage(
            MESSAGE_EVENT_ADVANCE,
            "Os itens precisam pertencer a mesma classe."
        )

        return false
    end



    if player:getItemCount(oldItemId) < 3 then

        player:sendTextMessage(
            MESSAGE_EVENT_ADVANCE,
            "Voce precisa possuir 3 unidades do item para transmutar."
        )

        return false
    end



    player:removeItem(oldItemId,3)

    player:addItem(newItemId,1)



    player:sendTextMessage(
        MESSAGE_EVENT_ADVANCE,
        "Voce transmutou 3x "..oldItemName.." em 1x "..newItemName.."."
    )


    return true
end

transmutation:separator(" ")
transmutation:groupType("normal")
transmutation:register()