

local linksEffect = GlobalEvent("LinksEffect")

local position = Position(5000, 5000, 5)
local positionLinks = Position(4996, 4998, 5)
local positionRegras = Position(4996, 5000, 5)
local positionVideos = Position(4996, 5002, 5)


function linksEffect.onThink(interval)
    -- Obtém os jogadores na posição
    local players = Game.getSpectators(position, false, true, 9, 9, 9, 9)
    
    -- Verifica se há jogadores na posição
    if #players > 0 then
        for _, player in ipairs(players) do
            if Game.getStorageValue(GlobalStorage.Crandoria.Effects.LinksTemple) < os.time() then
                player:say("LINKS", TALKTYPE_MONSTER_SAY, false, nil, positionLinks)
                player:say("REGRAS", TALKTYPE_MONSTER_SAY, false, nil, positionRegras)
                player:say("STAFF", TALKTYPE_MONSTER_SAY, false, nil, positionVideos)
                Game.setStorageValue(GlobalStorage.Crandoria.Effects.LinksTemple, os.time() + 3)
                positionLinks:sendMagicEffect(CONST_ME_MAGIC_BLUE)
                positionRegras:sendMagicEffect(CONST_ME_MAGIC_BLUE)
                return true
            else
                return true
            end
        end
    end

    return true
end

linksEffect:interval(4000)
linksEffect:register()


local linksEffectRewards = GlobalEvent("linksEffectRewards")

local positionCenter = Position(4999, 4999, 7)
local positionCenterUp = Position(4999, 4999, 6)
local positionTrainers = Position(4997, 5003, 6)
local positionCitizen = Position(5003, 5003, 6)
local positionTps = Position(5004, 5000, 6)
local positionRewardChest = Position(4997, 4998, 7)
local positionRewardChestVip = Position(5001, 4998, 7)
local positionRewardTotem = Position(5001, 5002, 7)

local effectList = {
    CONST_ME_STORM,
    CONST_ME_HOLYDAMAGE,
    CONST_ME_BLOCKHIT,
    CONST_ME_FIREATTACK,
    CONST_ME_SMALLCLOUDS,
    CONST_ME_ENERGYAREA,
    CONST_ME_ICEAREA,
    CONST_ME_ICEATTACK,
    CONST_ME_SMALLPLANTS,
    CONST_ME_PURPLEENERGY,
    CONST_ME_HOLYAREA,
    CONST_ME_PLANTATTACK,
    CONST_ME_HITAREA,
    CONST_ME_THUNDER
}

local function getRandomEffect()
    return effectList[math.random(#effectList)]
end

function linksEffectRewards.onThink(interval)
    -- Obtem os jogadores na posicao
    local players = Game.getSpectators(positionCenter, false, true, 7, 7, 7, 7)
    local players2 = Game.getSpectators(positionCenterUp, false, true, 7, 7, 7, 7)
    
    -- Verifica se ha jogadores na posicao
    if #players > 0 or #players2 > 0 then
        if Game.getStorageValue(GlobalStorage.Crandoria.Effects.LinksTemple) < os.time() then
            if #players > 0 then
                -- Mensagens e efeitos para os jogadores na posição `positionCenter`
                players[1]:say("PLAYERS FREE", TALKTYPE_MONSTER_SAY, false, nil, positionRewardChest)
                players[1]:say("PLAYERS VIP", TALKTYPE_MONSTER_SAY, false, nil, positionRewardChestVip)
                players[1]:say("CLIENT 13", TALKTYPE_MONSTER_SAY, false, nil, positionRewardTotem)
                positionRewardChest:sendMagicEffect(CONST_ME_MAGIC_BLUE)
                positionRewardChestVip:sendMagicEffect(CONST_ME_MAGIC_RED)
            end
            if #players2 > 0 then
                -- Mensagens e efeitos para os jogadores na posição `positionCenterUp`
                players2[1]:say("TRAINERS", TALKTYPE_MONSTER_SAY, false, nil, positionTrainers)
                players2[1]:say("CITIZEN", TALKTYPE_MONSTER_SAY, false, nil, positionCitizen)
                players2[1]:say("TP ROOM", TALKTYPE_MONSTER_SAY, false, nil, positionTps)
                local randomEffect = getRandomEffect()
                positionTrainers:sendMagicEffect(randomEffect)
            end
            Game.setStorageValue(GlobalStorage.Crandoria.Effects.LinksTemple, os.time() + 3)
        end
    end

    return true
end

linksEffectRewards:interval(2000)
linksEffectRewards:register()