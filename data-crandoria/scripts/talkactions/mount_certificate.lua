local outfits = {
    ["battle badger"] = {153},
    ["black stag"] = {73},
    ["blackpelt"] = {58},
    ["bloodcurl"] = {92},
    ["brass speckled koi"] = {208},
    ["cave tarantula"] = {117},
    ["cinnamon ibex"] = {200},
    ["coral rhea"] = {169},
    ["coralripper"] = {79},
    ["cranium spider"] = {116},
    ["cunning hyaena"] = {172},
    ["dandelion"] = {187},
    ["death crawler"] = {46},
    ["desert king"] = {41},
    ["doombringer"] = {53},
    ["ebony tiger"] = {123},
    ["ember saurian"] = {111},
    ["emerald raven"] = {191},
    ["emerald sphinx"] = {108},
    ["emerald waccoon"] = {70},
    ["emperor deer"] = {74},
    ["ether badger"] = {154},
    ["eventine nandu"] = {170},
    ["feral tiger"] = {124},
    ["festive mammoth"] = {178},
    ["frostbringer"] = {210},
    ["glacier vagaband"] = {64},
    ["gloom widow"] = {118},
    ["gold sphinx"] = {107},
    ["golden dragonfly"] = {59},
    ["gorongra"] = {81},
    ["hailstorm fury"] = {55},
    ["highland yak"] = {63},
    ["holiday mammoth"] = {177},
    ["hyacinth"] = {185},
    ["icebreacher"] = {212},
    ["ink spotted koi"] = {209},
    ["ivory fang"] = {100},
    ["jade lion"] = {48},
    ["jade pincer"] = {49},
    ["jade shrine"] = {196},
    ["jungle saurian"] = {110},
    ["jungle tiger"] = {125},
    ["lagoon saurian"] = {112},
    ["leafscuttler"] = {93},
    ["marsh toad"] = {120},
    ["merry mammoth"] = {176},
    ["mint ibex"] = {199},
    ["mould shell"] = {96},
    ["mouldpincer"] = {91},
    ["mystic raven"] = {192},
    ["night waccoon"] = {69},
    ["nightmarish crocovile"] = {143},
    ["nightstinger"] = {85},
    ["noctungra"] = {82},
    ["obsidian shrine"] = {197},
    ["peony"] = {186},
    ["plumfish"] = {80},
    ["poisonbane"] = {57},
    ["poppy ibex"] = {198},
    ["radiant raven"] = {193},
    ["razorcreep"] = {86},
    ["reed lurker"] = {97},
    ["ringtail raccoon"] = {68},
    ["river crocovile"] = {141},
    ["sanguine frog"] = {121},
    ["savanna ostrich"] = {168},
    ["scruffy hyaena"] = {173},
    ["sea devil"] = {78},
    ["shadow claw"] = {101},
    ["shadow hart"] = {72},
    ["shadow sphinx"] = {109},
    ["siegebreaker"] = {56},
    ["silverneck"] = {83},
    ["slagnare"] = {84},
    ["snow pelt"] = {102},
    ["steel bee"] = {60},
    ["swamp crocovile"] = {142},
    ["swamp snapper"] = {95},
    ["tangerine speckled koi"] = {207},
    ["tombstinger"] = {36},
    ["topaz shrine"] = {195},
    ["toxic toad"] = {122},
    ["tundra rambler"] = {62},
    ["voracious hyaena"] = {171},
    ["winter king"] = {52},
    ["winterstride"] = {211},
    ["woodland prince"] = {54},
    ["zaoan badger"] = {155},
    ["bog tyrant"] = {229},
    ["glacier wyrm"] = {228},
    ["crimson fang"] = {230},
}

local addondoll_id = 22771

local mountCertificate = TalkAction("!mount")

function mountCertificate.onSay(player, words, param)
    if player:getItemCount(addondoll_id) < 1 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce precisa possuir um Mount Certificate!")
        return true
    end

    local outfitName = param:lower():trim()
    if not outfitName or not outfits[outfitName] then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Diga !mount seguido do nome de uma montaria da Dtore de ate 600 TC que voce deseja.")
        return true
    end

    local outfit = outfits[outfitName]

    if player:hasMount(outfit[1], 3) then -- Verifica se já possui ambos os addons
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ja possui essa montaria.")
        return true
    end

    player:removeItem(addondoll_id, 1)
    player:getPosition():sendMagicEffect(CONST_ME_GIFT_WRAPS)
    player:addMount(outfit[1])
    player:sendTextMessage(MESSAGE_INFO_DESCR, string.format('Voce recebeu a montaria %s.', outfitName))
    return true
end

mountCertificate:separator(" ")
mountCertificate:groupType("normal")
mountCertificate:register()

