local bonusAddons = TalkAction("!bonus")

function bonusAddons.onSay(player, words, param)
	local outfits = {}

	if player:getSex() == PLAYERSEX_FEMALE then
		outfits = {
			136, 137, 138, 139, 140, 141, 142,
			147, 148, 149, 150, 155, 156, 157,
			158, 252, 269, 270, 279, 288, 324,
			329, 336, 366, 431, 433, 464, 466,
			471, 513, 514, 542, 575, 578, 618,
			620, 632, 635, 636, 664, 666, 683,
			694, 696, 698, 724, 732, 745, 749,
			759, 845, 852, 874, 885, 900, 909,
			929, 956, 958, 963, 965, 967, 969,
			971, 973, 975, 1020, 1024, 1043, 1050,
			1057, 1070, 1095, 1103, 1128, 1147, 1162,
			1174, 1187, 1203, 1205, 1207, 1211, 1244,
			1246, 1252, 1271, 1280, 1283, 1293,
			1323, 1332, 1339, 1372, 1383, 1385, 1387,
			1416, 1437, 1445, 1450, 1456, 1461, 1490,
			1501, 1569, 1576, 1582, 1598, 1613, 1619,
			1663, 1676, 1681, 1875, 1777, 1746, 1726, 
			1714, 1838, 1846, 1832, 1723, 1808, 1861, 
			1775, 
		}
	else
		outfits = {
			128, 129, 130, 131, 132, 133, 134,
			143, 144, 145, 146, 151, 152, 153,
			154, 251, 268, 273, 278, 289, 325,
			328, 335, 367, 430, 432, 463, 465,
			472, 512, 516, 541, 574, 577, 610,
			619, 633, 634, 637, 665, 667, 684,
			695, 697, 699, 725, 733, 746, 750,
			760, 846, 853, 873, 884, 899, 908,
			931, 955, 957, 962, 964, 966, 968,
			970, 972, 974, 1021, 1023, 1042, 1051,
			1056, 1069, 1094, 1102, 1127, 1146, 1161,
			1173, 1186, 1202, 1204, 1206, 1210, 1243,
			1245, 1251, 1270, 1279, 1282, 1292,
			1322, 1331, 1338, 1371, 1382, 1384, 1386,
			1415, 1436, 1444, 1449, 1455, 1460, 1489,
			1500, 1568, 1575, 1581, 1597, 1612, 1618,
			1662, 1675, 1680, 1874, 1776, 1745, 1725, 
			1713, 1837, 1845, 1831, 1722, 1809, 1860, 
			1774, 
		}
	end

	local mounts = {
		1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
		11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
		21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
		31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
		41, 42, 43, 44, 45, 46, 47, 48, 49, 50,
		51, 52, 53, 54, 55, 56, 57, 58, 59, 60,
		61, 62, 63, 64, 65, 66, 67, 68, 69, 70,
		71, 72, 73, 74, 75, 76, 77, 78, 79, 80,
		81, 82, 83, 84, 85, 86, 87, 88, 89, 90,
		91, 92, 93, 94, 95, 96, 97, 98, 99, 100,
		101, 102, 103, 104, 105, 106, 107, 108, 109, 110,
		111, 112, 113, 114, 115, 116, 117, 118, 119, 120,
		121, 122, 123, 124, 125, 126, 127, 128, 129, 130,
		131, 132, 133, 134, 135, 136, 137, 138, 139, 140,
		141, 142, 143, 144, 145, 146, 147, 148, 149, 150,
		151, 152, 153, 154, 155, 156, 157, 158, 159, 160,
		161, 162, 163, 164, 165, 166, 167, 168, 169, 170,
		171, 172, 173, 174, 175, 176, 177, 178, 179, 180,
		181, 182, 183, 184, 185, 186, 187, 188, 189, 190,
		191, 192, 193, 194, 195, 196, 197, 198, 199, 200,
		201, 202, 203, 204, 205, 206, 207, 208, 209, 210,
		211, 212, 213, 214, 215, 216, 217, 218, 219, 220,
		221, 222, 223, 224, 225, 226, 227, 228, 229, 230,
		231, 232, 233, 234, 235, 236, 237, 238, 239, 240,
		241, 242, 243, 244, 245, 246, 247, 248, 249, 250
	}

    local count = 0
    for _, outfitId in ipairs(outfits) do
        if player:hasOutfit(outfitId) and player:hasOutfit(outfitId, 1) and player:hasOutfit(outfitId, 2) then
            count = count + 1
        end
    end
    if count > 100 then
        count = 100
    end

    -- Conta montarias
    local countMount = 0
    for _, mountId in ipairs(mounts) do
        if player:hasMount(mountId) then
            countMount = countMount + 1
        end
    end
    if countMount > 50 then
        countMount = 50
    end

    -- -- Cálculo dos bônus de montarias (0.5% a cada 10 montarias completas)
    -- local mountBonusBlocks = math.floor(countMount / 10) -- Blocos de 10
    -- local mountBonusPercent = mountBonusBlocks * 0.5 -- 0.5% por bloco

    -- Atualiza storages
    player:setStorageValue(Storage.Quest.Crandoria.AddonsBonus.BonusExp, count)
    player:setStorageValue(Storage.Quest.Crandoria.AddonsBonus.BonusLoot, count)
    player:setStorageValue(Storage.Quest.Crandoria.AddonsBonus.BonusSkills, count)

    player:setStorageValue(Storage.Quest.Crandoria.MountBonus.BonusExp, countMount)
    player:setStorageValue(Storage.Quest.Crandoria.MountBonus.BonusLoot, countMount)
    player:setStorageValue(Storage.Quest.Crandoria.MountBonus.BonusSkills, countMount)

    -- Cálculo dos bônus de addons (outfits)
    local expBonus = count * 0.2
    local lootBonus = count * 0.05
    local skillsBonus = count * 0.1

	local expBonusMount = countMount * 0.1
    local lootBonusMount = countMount * 0.1
    local skillsBonusMount = countMount * 0.1

    -- Monta a mensagem incluindo montarias e seus bônus
    local msg = string.format(
        "Voce possui %d outfits completos.\n\n" ..
        "Exp Bonus: %.1f%%\nLoot Bonus: %.1f%%\nSkills Bonus: %.1f%%\n\n" ..
        "Voce possui %d montarias.\n\n" ..
        "Exp Bonus: %.1f%%\nLoot Bonus: %.1f%%\nSkills Bonus: %.1f%%",
        count, expBonus, lootBonus, skillsBonus,
        countMount,
        expBonusMount, lootBonusMount, skillsBonusMount
    )

	-- Mostra janela ao jogador
	player:popupFYI(msg)

	return true
end

bonusAddons:groupType("normal")
bonusAddons:register()