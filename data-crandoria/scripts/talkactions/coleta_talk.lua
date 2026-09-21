local skillsColeta = TalkAction("!coleta")

function skillsColeta.onSay(player, words, param)

    local farming = math.max(player:getStorageValue(Storage.Quest.Crandoria.SkillsColeta.CultivoLevel), 0)
    local ranching = math.max(player:getStorageValue(Storage.Quest.Crandoria.SkillsColeta.OrdenhaLevel), 0)
    local lumberjack = math.max(player:getStorageValue(Storage.Quest.Crandoria.SkillsColeta.LumberjackLevel), 0)
    local mining = math.max(player:getStorageValue(Storage.Quest.Crandoria.SkillsColeta.MiningLevel), 0)
    local fishing = player:getEffectiveSkillLevel(SKILL_FISHING)

    local msg = string.format(
        "== Skills de Coleta ==\n\n" ..
        "Farming: %d\n" ..
        "Fishing: %d\n" ..
        "Lumberjack: %d\n" ..
        "Mining: %d\n" ..
        "Ranching: %d",
        farming,
        fishing,
        lumberjack,
        mining,
        ranching
    )

    player:popupFYI(msg)
    return true
end

skillsColeta:groupType("normal")
skillsColeta:register()
