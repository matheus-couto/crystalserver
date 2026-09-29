

local now = os.date("*t")
local day = now.day
local month = now.month


-- Checar se está entre 21 de junho (21/6) e 21 de setembro (21/9)
local isInRange1 = (month == 6 and day >= 21) or (month == 7) or (month == 8) or (month == 9 and day < 21)

-- Primavera: 21 de setembro até 20 de dezembro
local isInRange2 = (month == 9 and day >= 21) or (month == 10) or (month == 11) or (month == 12 and day < 21)

-- Inverno: 21 de dezembro até 20 de março
local isInRange3 = (month == 12 and day >= 21) or (month == 1) or (month == 2) or (month == 3 and day < 21)

-- Outono: 21 de março até 20 de junho
local isInRange4 = (month == 3 and day >= 21) or (month == 4) or (month == 5) or (month == 6 and day < 21)

----------- NORMAL ----------



local lootTrash = { 3147, 3031, 3031, 3031, 3031, 1781 }
local lootCommon = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031 }
local lootUncommon = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3035, 3035, 3031, 3035, 3035, 3026, 3027, 3028, 3029, 3030, 3032, 3033, 3035, 9057, 3031, 3031, 3031, 3031, 3031 }
local lootSemiRare = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3035, 3035, 3035, 3035, 3035, 16122, 16123, 16124, 3035 }
local lootRare = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3035, 3035, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3035, 16125, 16126, 16127, 3037, 3039, 29345 }
local lootVeryRare = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3035, 3035, 3035, 3031, 3035, 3035, 3035, 3035, 3035, 3035, 3038, 3041, 3035, 3036, 3043, 29345, 29346, 29347, 3035, 3035, 3038, 3041, 3035, 3036, 3043, 3035, 3035, 3035, 3035, 3038, 3041, 3035, 3036, 3043, 29345, 29346, 29347, 3035, 3035, 3038, 3041, 3035, 3036, 3043, 39037 }
local lootSuperRare = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3035, 3035, 3035, 3031, 3035, 3035, 30059, 30060, 30061, 30180, 39037 }
local lootUltraRare = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3035, 3035, 3035, 3035, 3035, 3035, 3035, 3035, 3035, 3035, 3035, 30059, 30060, 30061, 30180, 39037, 4061 }
local lootLuminescent = { 32567 }

local lootTrash2 = { 3147, 3031, 3031, 3031, 3031, 1781 }
local lootCommon2 = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031 }
local lootUncommon2 =  { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3035, 3035, 3031, 3035, 3035, 3026, 3027, 3028, 3029, 3030, 3032, 3033, 3035, 9057, 3031, 3031, 3031, 3031, 3031 }
local lootSemiRare2 = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3035, 3035, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 16122, 16123, 16124, 3035 }
local lootRare2 = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3035, 3035, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3035, 3035, 3035, 3035, 16125, 16126, 16127, 3037, 3039, 29346 }
local lootVeryRare2 = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3035, 3035, 3035, 3031, 3035, 3035, 3035, 3035, 3035, 3035, 3038, 3041, 3035, 3036, 3043, 29345, 29346, 29347, 3035, 3035, 3038, 3041, 3035, 3036, 3043, 3035, 3035, 3035, 3035, 3038, 3041, 3035, 3036, 3043, 29345, 29346, 29347, 3035, 3035, 3038, 3041, 3035, 3036, 3043, 39037 }
local lootSuperRare2 = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3035, 3035, 3035, 3031, 3035, 3035, 30059, 30060, 30061, 30180, 39037 }
local lootUltraRare2 = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3035, 3035, 3035, 3035, 3035, 3035, 3035, 3035, 3035, 3035, 3035, 30059, 30060, 30061, 30180, 39037, 4061 }
local lootLuminescent2 = { 32567 }

local lootTrash3 = { 3147, 3031, 3031, 3031, 3031, 1781 }
local lootCommon3 = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3031, 3031, 3031, 3031, 3031, 3031 }
local lootUncommon3 =  { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3035, 3035, 3031, 3035, 3035, 3026, 3027, 3028, 3029, 3030, 3032, 3033, 3035, 9057, 3031, 3031, 3031, 3031, 3031 }
local lootSemiRare3 = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3035, 3035, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 16122, 16123, 16124, 3035 }
local lootRare3 = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3035, 3035, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3035, 3035, 3035, 3035, 16125, 16126, 16127, 3037, 3039, 29347 }
local lootVeryRare3 = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3035, 3035, 3035, 3031, 3035, 3035, 3035, 3035, 3035, 3035, 3038, 3041, 3035, 3036, 3043, 29345, 29346, 29347, 3035, 3035, 3038, 3041, 3035, 3036, 3043, 3035, 3035, 3035, 3035, 3038, 3041, 3035, 3036, 3043,  29345, 29346, 29347, 3035, 3035, 3038, 3041, 3035, 3036, 3043, 39037 }
local lootSuperRare3 = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3035, 3035, 3035, 3031, 3035, 3035, 30059, 30060, 30061, 30180, 39037 }
local lootUltraRare3 = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3035, 3035, 3035, 3035, 3035, 3035, 3035, 3035, 3035, 3035, 3035, 30059, 30060, 30061, 30180, 39037, 4061 }
local lootLuminescent3 = { 32567 }

local lootTrash4 = { 3147, 3031, 3031, 3031, 3031, 1781 }
local lootCommon4 = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031 }
local lootUncommon4 =  { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3035, 3035, 3031, 3035, 3035, 3026, 3027, 3028, 3029, 3030, 3032, 3033, 3035, 9057, 3031, 3031, 3031, 3031, 3031 }
local lootSemiRare4 = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3035, 3035, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 16122, 16123, 16124, 3035 }
local lootRare4 = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3035, 3035, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3035, 3035, 3035, 3035, 16125, 16126, 16127, 3037, 3039, 29347 }
local lootVeryRare4 = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3035, 3035, 3035, 3031, 3035, 3035, 3035, 3035, 3035, 3035, 3038, 3041, 3035, 3036, 3043, 29345, 29346, 29347, 3035, 3035, 3038, 3041, 3035, 3036, 3043, 3035, 3035, 3035, 3035, 3038, 3041, 3035, 3036, 3043,  29345, 29346, 29347, 3035, 3035, 3038, 3041, 3035, 3036, 3043, 29347, 39037 }
local lootSuperRare4 = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3035, 3035, 3035, 3031, 3035, 3035, 30059, 30060, 30061, 30180, 39037 }
local lootUltraRare4 = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3035, 3035, 3035, 3035, 3035, 3035, 3035, 3035, 3035, 3035, 3035, 30059, 30060, 30061, 30180, 39037, 4061 }
local lootLuminescent4 = { 32567 }



local lootTrash5 = { 3031 }
local lootCommon5 = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3031, 3031, 3031, 3031, 3031, 3031 }
local lootUncommon5 = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3035, 3035, 3031, 3035, 3035, 3026, 3027, 3028, 3029, 3030, 3032, 3033, 3035, 9057 }
local lootSemiRare5 = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3035, 3035, 3035, 3035, 3035, 16122, 16123, 16124, 3035 }
local lootRare5 = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3035, 3035, 3035, 3035, 3035, 3035, 16125, 16126, 16127, 3037, 3039, 3035, 3035, 3035, 3035, 16125, 16126, 16127, 3037, 3039 }
local lootVeryRare5 = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3035, 3035, 3035, 3031, 3035, 3035, 3035, 3035, 3038, 3041, 3035, 3036, 3043, 29345, 29346, 29347, 3035, 3035, 3038, 3041, 3035, 3036, 3043, 29345, 29345, 29345, 39037 }
local lootSuperRare5 = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3035, 3035, 3035, 3031, 3035, 3035, 30059, 30060, 30061, 30180, 39037 }
local lootUltraRare5 = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3035, 3035, 3035, 3035, 3035, 3035, 3035, 3035, 3035, 3035, 3035, 30059, 30060, 30061, 30180, 39037, 4061 }
local lootLuminescent5 = { 32567 }

local lootTrash6 = { 3031 }
local lootCommon6 = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3031, 3031, 3031, 3031, 3031, 3031 }
local lootUncommon6 =  { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3035, 3035, 3031, 3035, 3035, 3026, 3027, 3028, 3029, 3030, 3032, 3033, 3035, 9057 }
local lootSemiRare6 = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3035, 3035, 3035, 3035, 3035, 16122, 16123, 16124, 3035 }
local lootRare6 = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3035, 3035, 3035, 3035, 3035, 3035, 16125, 16126, 16127, 3037, 3039, 3035, 3035, 3035, 3035, 16125, 16126, 16127, 3037, 3039 }
local lootVeryRare6 = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3035, 3035, 3035, 3031, 3035, 3035, 3035, 3035, 3038, 3041, 3035, 3036, 3043, 29345, 29346, 29347, 3035, 3035, 3038, 3041, 3035, 3036, 3043, 29346, 29346, 29346, 39037 }
local lootSuperRare6 = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3035, 3035, 3035, 3031, 3035, 3035, 30059, 30060, 30061, 30180, 39037}
local lootUltraRare6 = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3035, 3035, 3035, 3035, 3035, 3035, 3035, 3035, 3035, 3035, 3035, 30059, 30060, 30061, 30180, 39037, 4061 }
local lootLuminescent6 = { 32567 }

local lootTrash7 = { 3031 }
local lootCommon7 = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3031, 3031, 3031, 3031, 3031, 3031 }
local lootUncommon7 =  { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3035, 3035, 3031, 3035, 3035, 3026, 3027, 3028, 3029, 3030, 3032, 3033, 3035, 9057 }
local lootSemiRare7 = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3035, 3035, 3035, 3035, 3035, 16122, 16123, 16124, 3035 }
local lootRare7 = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3035, 3035, 3035, 3035, 3035, 3035, 16125, 16126, 16127, 3037, 3039 }
local lootVeryRare7 = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3035, 3035, 3035, 3031, 3035, 3035, 3035, 3035, 3038, 3041, 3035, 3036, 3043, 29345, 29346, 29347, 3035, 3035, 3038, 3041, 3035, 3036, 3043, 29347, 29347, 29347, 39037 }
local lootSuperRare7 = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3035, 3035, 3035, 3031, 3035, 3035, 30059, 30060, 30061, 30180, 39037 }
local lootUltraRare7 = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3035, 3035, 3035, 3035, 3035, 3035, 3035, 3035, 3035, 3035, 3035, 30059, 30060, 30061, 30180, 39037, 4061 }
local lootLuminescent7 = { 32567 }

local lootTrash8 = { 3031 }
local lootCommon8 = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3031, 3031, 3031, 3031, 3031, 3031 }
local lootUncommon8 = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3035, 3035, 3035, 3035, 3035, 3035, 3026, 3027, 3028, 3029, 3030, 3032, 3033, 3035, 9057 }
local lootSemiRare8 = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3035, 3035, 3035, 3035, 3035, 3035, 16122, 16123, 16124, 3035 }
local lootRare8 = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3035, 3035, 3035, 3035, 3035, 3035, 16125, 16126, 16127, 3037, 3039 }
local lootVeryRare8 = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3035, 3035, 3035, 3031, 3035, 3035, 3035, 3035, 3038, 3041, 3035, 3036, 3043, 29345, 29346, 29347, 3035, 3035, 3038, 3041, 3035, 3036, 3043, 29345, 29346, 29347, 39037 }
local lootSuperRare8 = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3035, 3035, 3035, 3031, 3035, 3035, 30059, 30060, 30061, 30180, 39037, 39037, 30059, 30060, 30061, 30180, 39037, 39037, 30059, 30060, 30061, 30180, 39037, 39037, 4061 }
local lootUltraRare8 = { 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3031, 3035, 3035, 3035, 3031, 3031, 3035, 3035, 3035, 3035, 3035, 3035, 3035, 3035, 3035, 3035, 3035, 30059, 30060, 30061, 30180, 39037, 4061 }
local lootLuminescent8 = { 32567 }


local exhaustAttackGroup = Condition(CONDITION_SPELLGROUPCOOLDOWN)
exhaustAttackGroup:setParameter(CONDITION_PARAM_SUBID, 1)
exhaustAttackGroup:setParameter(CONDITION_PARAM_TICKS, 60000)

local exhaustHealGroup = Condition(CONDITION_SPELLGROUPCOOLDOWN)
exhaustHealGroup:setParameter(CONDITION_PARAM_SUBID, 2)
exhaustHealGroup:setParameter(CONDITION_PARAM_TICKS, 60000)

local exhaustSupportGroup = Condition(CONDITION_SPELLGROUPCOOLDOWN)
exhaustSupportGroup:setParameter(CONDITION_PARAM_SUBID, 3)
exhaustSupportGroup:setParameter(CONDITION_PARAM_TICKS, 60000)

local exhaustFourthGroup = Condition(CONDITION_SPELLGROUPCOOLDOWN)
exhaustFourthGroup:setParameter(CONDITION_PARAM_SUBID, 4)
exhaustFourthGroup:setParameter(CONDITION_PARAM_TICKS, 60000)

local exhaustFifthGroup = Condition(CONDITION_SPELLGROUPCOOLDOWN)
exhaustFifthGroup:setParameter(CONDITION_PARAM_SUBID, 5)
exhaustFifthGroup:setParameter(CONDITION_PARAM_TICKS, 60000)

local exhaustSixthGroup = Condition(CONDITION_SPELLGROUPCOOLDOWN)
exhaustSixthGroup:setParameter(CONDITION_PARAM_SUBID, 6)
exhaustSixthGroup:setParameter(CONDITION_PARAM_TICKS, 60000)

local exhaustSeventhGroup = Condition(CONDITION_SPELLGROUPCOOLDOWN)
exhaustSeventhGroup:setParameter(CONDITION_PARAM_SUBID, 6)
exhaustSeventhGroup:setParameter(CONDITION_PARAM_TICKS, 60000)

local function calculateChances(skill)
	local chance = math.random(1000) / 10 -- converting to decimal
	local loot = lootTrash
	if skill <= 39 then
		if chance <= 80 then
			loot = lootTrash
		elseif chance <= 90 then
			loot = lootCommon
		elseif chance <= 98 then
			loot = lootUncommon
		elseif chance <= 99 then
			loot = lootSemiRare
		elseif chance <= 99.95 then
			loot = lootRare
		elseif chance <= 99.99 then
			loot = lootVeryRare
		elseif chance > 99.99 then
			loot =  lootSuperRare
		end

	elseif skill >= 40 and skill <= 60 then
		if chance <= 75 then
			loot = lootTrash
		elseif chance <= 85 then
			loot = lootCommon
		elseif chance <= 95 then
			loot = lootUncommon
		elseif chance <= 98.5 then
			loot = lootSemiRare
		elseif chance <= 99.5 then
			loot = lootRare
		elseif chance <= 99.99 then
			loot = lootVeryRare
		elseif chance > 99.99 then
			loot = lootSuperRare
		end

	elseif skill > 60 and skill <= 80 then
		if chance <= 70 then
			loot = lootTrash
		elseif chance <= 75 then
			loot = lootCommon
		elseif chance <= 95 then
			loot = lootUncommon
		elseif chance <= 98 then
			loot = lootSemiRare
		elseif chance <= 99.3 then
			loot = lootRare
		elseif chance <= 99.99 then
			loot = lootVeryRare
		elseif chance > 99.9 then
			loot = lootSuperRare
		end

	elseif skill > 80 and skill <= 100 then
		if chance <= 60 then
			loot = lootTrash
		elseif chance <= 70 then
			loot = lootCommon
		elseif chance <= 90 then
			loot = lootUncommon
		elseif chance <= 97.5 then
			loot = lootSemiRare
		elseif chance <= 99.2 then
			loot = lootRare
		elseif chance <= 99.99 then
			loot = lootVeryRare
		elseif chance > 99.99 then
			loot = lootSuperRare
		end
	elseif skill > 100 and skill <= 120 then
		if chance <= 40 then
			loot = lootTrash
		elseif chance <= 60 then
			loot = lootCommon
		elseif chance <= 80 then
			loot = lootUncommon
		elseif chance <= 95 then
			loot = lootSemiRare
		elseif chance <= 98 then
			loot = lootRare
		elseif chance <= 99.97 then
			loot = lootVeryRare
		elseif chance > 99.99 then
			loot = lootSuperRare
		end
	elseif skill > 120 and skill <= 130 then
		if chance <= 15 then
			loot = lootTrash
		elseif chance <= 40 then
			loot = lootCommon
		elseif chance <= 60 then
			loot = lootUncommon
		elseif chance <= 95 then
			loot = lootSemiRare
		elseif chance <= 97 then
			loot = lootRare
		elseif chance <= 99.98 then
			loot = lootVeryRare
		elseif chance > 99.98 then
			loot = lootSuperRare
		end
	elseif skill > 130 and skill <= 140 then
		if chance <= 15 then
			loot = lootTrash
		elseif chance <= 40 then
			loot = lootCommon
		elseif chance <= 60 then
			loot = lootUncommon
		elseif chance <= 95 then
			loot = lootSemiRare
		elseif chance <= 97 then
			loot = lootRare
		elseif chance <= 99.98 then
			loot = lootVeryRare
		elseif chance > 99.98 then
			loot = lootSuperRare
		end
	elseif skill > 140 then
		if chance <= 5 then
			loot = lootTrash
		elseif chance <= 30 then
			loot = lootCommon
		elseif chance <= 55 then
			loot = lootUncommon
		elseif chance <= 90 then
			loot = lootSemiRare
		elseif chance <= 95 then
			loot = lootRare
		elseif chance <= 99.5 then
			loot = lootVeryRare
		elseif chance <= 99.95 then
			loot = lootSuperRare
		elseif chance > 99.95 then
			loot = lootUltraRare
		end
	end
	return loot
end

local function calculateChances2(skill)
	local chance = math.random(1000) / 10 -- converting to decimal
	local loot = lootTrash2
	if skill <= 39 then
		if chance <= 80 then
			loot = lootTrash2
		elseif chance <= 90 then
			loot = lootCommon2
		elseif chance <= 98 then
			loot = lootUncommon2
		elseif chance <= 99 then
			loot = lootSemiRare2
		elseif chance <= 99.95 then
			loot = lootRare2
		elseif chance <= 99.99 then
			loot = lootVeryRare2
		elseif chance > 99.99 then
			loot = lootSuperRare2
		end

	elseif skill >= 40 and skill <= 60 then
		if chance <= 75 then
			loot = lootTrash2
		elseif chance <= 85 then
			loot = lootCommon2
		elseif chance <= 95 then
			loot = lootUncommon2
		elseif chance <= 98.5 then
			loot = lootSemiRare2
		elseif chance <= 99.5 then
			loot = lootRare2
		elseif chance <= 99.99 then
			loot = lootVeryRare2
		elseif chance > 99.99 then
			loot = lootSuperRare2
		end

	elseif skill > 60 and skill <= 80 then
		if chance <= 70 then
			loot = lootTrash2
		elseif chance <= 75 then
			loot = lootCommon2
		elseif chance <= 95 then
			loot = lootUncommon2
		elseif chance <= 98 then
			loot = lootSemiRare2
		elseif chance <= 99.3 then
			loot = lootRare2
		elseif chance <= 99.99 then
			loot = lootVeryRare2
		elseif chance > 99.9 then
			loot = lootSuperRare2
		end

	elseif skill > 80 and skill <= 100 then
		if chance <= 60 then
			loot = lootTrash2
		elseif chance <= 70 then
			loot = lootCommon2
		elseif chance <= 90 then
			loot = lootUncommon2
		elseif chance <= 97.5 then
			loot = lootSemiRare2
		elseif chance <= 99.2 then
			loot = lootRare2
		elseif chance <= 99.99 then
			loot = lootVeryRare2
		elseif chance > 99.99 then
			loot = lootSuperRare2
		end
	elseif skill > 100 and skill <= 120 then
		if chance <= 40 then
			loot = lootTrash2
		elseif chance <= 60 then
			loot = lootCommon2
		elseif chance <= 80 then
			loot = lootUncommon2
		elseif chance <= 95 then
			loot = lootSemiRare2
		elseif chance <= 98 then
			loot = lootRare2
		elseif chance <= 99.97 then
			loot = lootVeryRare2
		elseif chance > 99.99 then
			loot = lootSuperRare2
		end
	elseif skill > 120 and skill <= 130 then
		if chance <= 15 then
			loot = lootTrash2
		elseif chance <= 40 then
			loot = lootCommon2
		elseif chance <= 60 then
			loot = lootUncommon2
		elseif chance <= 95 then
			loot = lootSemiRare2
		elseif chance <= 97 then
			loot = lootRare2
		elseif chance <= 99.98 then
			loot = lootVeryRare2
		elseif chance > 99.98 then
			loot = lootSuperRare2
		end
	elseif skill > 130 and skill <= 140 then
		if chance <= 15 then
			loot = lootTrash2
		elseif chance <= 40 then
			loot = lootCommon2
		elseif chance <= 60 then
			loot = lootUncommon2
		elseif chance <= 95 then
			loot = lootSemiRare2
		elseif chance <= 97 then
			loot = lootRare2
		elseif chance <= 99.98 then
			loot = lootVeryRare2
		elseif chance > 99.98 then
			loot = lootSuperRare2
		end
	elseif skill > 140 then
		if chance <= 5 then
			loot = lootTrash2
		elseif chance <= 30 then
			loot = lootCommon2
		elseif chance <= 55 then
			loot = lootUncommon2
		elseif chance <= 90 then
			loot = lootSemiRare2
		elseif chance <= 95 then
			loot = lootRare2
		elseif chance <= 99.5 then
			loot = lootVeryRare2
		elseif chance <= 99.95 then
			loot = lootSuperRare2
		elseif chance > 99.95 then
			loot = lootUltraRare2
		end
	end
	return loot
end

local function calculateChances3(skill)
	local chance = math.random(1000) / 10 -- converting to decimal
	local loot = lootTrash3
	if skill <= 39 then
		if chance <= 80 then
			loot = lootTrash3
		elseif chance <= 90 then
			loot = lootCommon3
		elseif chance <= 98 then
			loot = lootUncommon3
		elseif chance <= 99 then
			loot = lootSemiRare3
		elseif chance <= 99.95 then
			loot = lootRare3
		elseif chance <= 99.99 then
			loot = lootVeryRare3
		elseif chance > 99.99 then
			loot = lootSuperRare3
		end

	elseif skill >= 40 and skill <= 60 then
		if chance <= 75 then
			loot = lootTrash3
		elseif chance <= 85 then
			loot = lootCommon3
		elseif chance <= 95 then
			loot = lootUncommon3
		elseif chance <= 98.5 then
			loot = lootSemiRare3
		elseif chance <= 99.5 then
			loot = lootRare3
		elseif chance <= 99.99 then
			loot = lootVeryRare3
		elseif chance > 99.99 then
			loot = lootSuperRare3
		end

	elseif skill > 60 and skill <= 80 then
		if chance <= 70 then
			loot = lootTrash3
		elseif chance <= 75 then
			loot = lootCommon3
		elseif chance <= 95 then
			loot = lootUncommon3
		elseif chance <= 98 then
			loot = lootSemiRare3
		elseif chance <= 99.3 then
			loot = lootRare3
		elseif chance <= 99.99 then
			loot = lootVeryRare3
		elseif chance > 99.9 then
			loot = lootSuperRare3
		end

	elseif skill > 80 and skill <= 100 then
		if chance <= 60 then
			loot = lootTrash3
		elseif chance <= 70 then
			loot = lootCommon3
		elseif chance <= 90 then
			loot = lootUncommon3
		elseif chance <= 97.5 then
			loot = lootSemiRare3
		elseif chance <= 99.2 then
			loot = lootRare3
		elseif chance <= 99.99 then
			loot = lootVeryRare3
		elseif chance > 99.99 then
			loot = lootSuperRare3
		end
	elseif skill > 100 and skill <= 120 then
		if chance <= 40 then
			loot = lootTrash3
		elseif chance <= 60 then
			loot = lootCommon3
		elseif chance <= 80 then
			loot = lootUncommon3
		elseif chance <= 95 then
			loot = lootSemiRare3
		elseif chance <= 98 then
			loot = lootRare3
		elseif chance <= 99.97 then
			loot = lootVeryRare3
		elseif chance > 99.99 then
			loot = lootSuperRare3
		end
	elseif skill > 120 and skill <= 130 then
		if chance <= 15 then
			loot = lootTrash3
		elseif chance <= 40 then
			loot = lootCommon3
		elseif chance <= 60 then
			loot = lootUncommon3
		elseif chance <= 95 then
			loot = lootSemiRare3
		elseif chance <= 97 then
			loot = lootRare3
		elseif chance <= 99.98 then
			loot = lootVeryRare3
		elseif chance > 99.98 then
			loot = lootSuperRare3
		end
	elseif skill > 130 and skill <= 140 then
		if chance <= 15 then
			loot = lootTrash3
		elseif chance <= 40 then
			loot = lootCommon3
		elseif chance <= 60 then
			loot = lootUncommon3
		elseif chance <= 95 then
			loot = lootSemiRare3
		elseif chance <= 97 then
			loot = lootRare3
		elseif chance <= 99.98 then
			loot = lootVeryRare3
		elseif chance > 99.98 then
			loot = lootSuperRare3
		end
	elseif skill > 140 then
		if chance <= 5 then
			loot = lootTrash3
		elseif chance <= 30 then
			loot = lootCommon3
		elseif chance <= 55 then
			loot = lootUncommon3
		elseif chance <= 90 then
			loot = lootSemiRare3
		elseif chance <= 95 then
			loot = lootRare3
		elseif chance <= 99.5 then
			loot = lootVeryRare3
		elseif chance <= 99.95 then
			loot = lootSuperRare3
		elseif chance > 99.95 then
			loot = lootUltraRare3
		end
	end
	return loot
end

local function calculateChances4(skill)
	local chance = math.random(1000) / 10 -- converting to decimal
	local loot = lootTrash4
	if skill <= 39 then
		if chance <= 80 then
			loot = lootTrash4
		elseif chance <= 90 then
			loot = lootCommon4
		elseif chance <= 98 then
			loot = lootUncommon4
		elseif chance <= 99 then
			loot = lootSemiRare4
		elseif chance <= 99.95 then
			loot = lootRare4
		elseif chance <= 99.99 then
			loot = lootVeryRare4
		elseif chance > 99.99 then
			loot = lootSuperRare4
		end

	elseif skill >= 40 and skill <= 60 then
		if chance <= 75 then
			loot = lootTrash4
		elseif chance <= 85 then
			loot = lootCommon4
		elseif chance <= 95 then
			loot = lootUncommon4
		elseif chance <= 98.5 then
			loot = lootSemiRare4
		elseif chance <= 99.5 then
			loot = lootRare4
		elseif chance <= 99.99 then
			loot = lootVeryRare4
		elseif chance > 99.99 then
			loot = lootSuperRare4
		end

	elseif skill > 60 and skill <= 80 then
		if chance <= 70 then
			loot = lootTrash4
		elseif chance <= 75 then
			loot = lootCommon4
		elseif chance <= 95 then
			loot = lootUncommon4
		elseif chance <= 98 then
			loot = lootSemiRare4
		elseif chance <= 99.3 then
			loot = lootRare4
		elseif chance <= 99.99 then
			loot = lootVeryRare4
		elseif chance > 99.9 then
			loot = lootSuperRare4
		end

	elseif skill > 80 and skill <= 100 then
		if chance <= 60 then
			loot = lootTrash4
		elseif chance <= 70 then
			loot = lootCommon4
		elseif chance <= 90 then
			loot = lootUncommon4
		elseif chance <= 97.5 then
			loot = lootSemiRare4
		elseif chance <= 99.2 then
			loot = lootRare4
		elseif chance <= 99.99 then
			loot = lootVeryRare4
		elseif chance > 99.99 then
			loot = lootSuperRare4
		end
	elseif skill > 100 and skill <= 120 then
		if chance <= 40 then
			loot = lootTrash4
		elseif chance <= 60 then
			loot = lootCommon4
		elseif chance <= 80 then
			loot = lootUncommon4
		elseif chance <= 95 then
			loot = lootSemiRare4
		elseif chance <= 98 then
			loot = lootRare4
		elseif chance <= 99.97 then
			loot = lootVeryRare4
		elseif chance > 99.99 then
			loot = lootSuperRare4
		end
	elseif skill > 120 and skill <= 140 then
		if chance <= 15 then
			loot = lootTrash4
		elseif chance <= 40 then
			loot = lootCommon4
		elseif chance <= 60 then
			loot = lootUncommon4
		elseif chance <= 95 then
			loot = lootSemiRare4
		elseif chance <= 97 then
			loot = lootRare4
		elseif chance <= 99.9 then
			loot = lootVeryRare4
		elseif chance > 99.9 then
			loot = lootSuperRare4
		end
	elseif skill > 140 then
		if chance <= 5 then
			loot = lootTrash4
		elseif chance <= 30 then
			loot = lootCommon4
		elseif chance <= 55 then
			loot = lootUncommon4
		elseif chance <= 80 then
			loot = lootSemiRare4
		elseif chance <= 90 then
			loot = lootRare4
		elseif chance <= 95 then
			loot = lootVeryRare4
		elseif chance <= 99.5 then
			loot = lootSuperRare4
		elseif chance > 99.5 then
			loot = lootUltraRare4
		end
	end
	return loot
end

------------------------------------------------ VIP CHANCES ---------------------------------

local function calculateChances5(skill)
	local chance = math.random(1000) / 10 -- converting to decimal
	local loot = lootTrash5
	if skill <= 39 then
		if chance <= 80 then
			loot = lootTrash5
		elseif chance <= 90 then
			loot = lootCommon5
		elseif chance <= 98 then
			loot = lootUncommon5
		elseif chance <= 99 then
			loot = lootSemiRare5
		elseif chance <= 99.95 then
			loot = lootRare5
		elseif chance <= 99.99 then
			loot = lootVeryRare5
		elseif chance > 99.99 then
			loot =  lootSuperRare5
		end

	elseif skill >= 40 and skill <= 60 then
		if chance <= 75 then
			loot = lootTrash5
		elseif chance <= 85 then
			loot = lootCommon5
		elseif chance <= 95 then
			loot = lootUncommon5
		elseif chance <= 98.5 then
			loot = lootSemiRare5
		elseif chance <= 99.5 then
			loot = lootRare5
		elseif chance <= 99.99 then
			loot = lootVeryRare5
		elseif chance > 99.99 then
			loot = lootSuperRare5
		end

	elseif skill > 60 and skill <= 80 then
		if chance <= 70 then
			loot = lootTrash5
		elseif chance <= 75 then
			loot = lootCommon5
		elseif chance <= 95 then
			loot = lootUncommon5
		elseif chance <= 98 then
			loot = lootSemiRare5
		elseif chance <= 99.3 then
			loot = lootRare5
		elseif chance <= 99.99 then
			loot = lootVeryRare5
		elseif chance > 99.9 then
			loot = lootSuperRare5
		end

	elseif skill > 80 and skill <= 100 then
		if chance <= 60 then
			loot = lootTrash5
		elseif chance <= 70 then
			loot = lootCommon5
		elseif chance <= 90 then
			loot = lootUncommon5
		elseif chance <= 97.5 then
			loot = lootSemiRare5
		elseif chance <= 99.2 then
			loot = lootRare5
		elseif chance <= 99.99 then
			loot = lootVeryRare5
		elseif chance > 99.99 then
			loot = lootSuperRare5
		end
	elseif skill > 100 and skill <= 120 then
		if chance <= 40 then
			loot = lootTrash5
		elseif chance <= 60 then
			loot = lootCommon5
		elseif chance <= 80 then
			loot = lootUncommon5
		elseif chance <= 95 then
			loot = lootSemiRare5
		elseif chance <= 98 then
			loot = lootRare5
		elseif chance <= 99.97 then
			loot = lootVeryRare5
		elseif chance > 99.99 then
			loot = lootSuperRare5
		end
	elseif skill > 120 and skill <= 130 then
		if chance <= 15 then
			loot = lootTrash5
		elseif chance <= 40 then
			loot = lootCommon5
		elseif chance <= 60 then
			loot = lootUncommon5
		elseif chance <= 95 then
			loot = lootSemiRare5
		elseif chance <= 97 then
			loot = lootRare5
		elseif chance <= 99.98 then
			loot = lootVeryRare5
		elseif chance > 99.98 then
			loot = lootSuperRare5
		end
	elseif skill > 130 and skill <= 140 then
		if chance <= 15 then
			loot = lootTrash5
		elseif chance <= 40 then
			loot = lootCommon5
		elseif chance <= 60 then
			loot = lootUncommon5
		elseif chance <= 95 then
			loot = lootSemiRare5
		elseif chance <= 97 then
			loot = lootRare5
		elseif chance <= 99.98 then
			loot = lootVeryRare5
		elseif chance > 99.98 then
			loot = lootSuperRare5
		end
	elseif skill > 140 then
		if chance <= 5 then
			loot = lootTrash5
		elseif chance <= 30 then
			loot = lootCommon5
		elseif chance <= 55 then
			loot = lootUncommon5
		elseif chance <= 90 then
			loot = lootSemiRare5
		elseif chance <= 95 then
			loot = lootRare5
		elseif chance <= 99.5 then
			loot = lootVeryRare5
		elseif chance <= 99.95 then
			loot = lootSuperRare5
		elseif chance > 99.95 then
			loot = lootUltraRare5
		end
	end
	return loot
end

local function calculateChances6(skill)
	local chance = math.random(1000) / 10 -- converting to decimal
	local loot = lootTrash6
	if skill <= 39 then
		if chance <= 80 then
			loot = lootTrash6
		elseif chance <= 90 then
			loot = lootCommon6
		elseif chance <= 98 then
			loot = lootUncommon6
		elseif chance <= 99 then
			loot = lootSemiRare6
		elseif chance <= 99.95 then
			loot = lootRare6
		elseif chance <= 99.99 then
			loot = lootVeryRare6
		elseif chance > 99.99 then
			loot = lootSuperRare6
		end

	elseif skill >= 40 and skill <= 60 then
		if chance <= 75 then
			loot = lootTrash6
		elseif chance <= 85 then
			loot = lootCommon6
		elseif chance <= 95 then
			loot = lootUncommon6
		elseif chance <= 98.5 then
			loot = lootSemiRare6
		elseif chance <= 99.5 then
			loot = lootRare6
		elseif chance <= 99.99 then
			loot = lootVeryRare6
		elseif chance > 99.99 then
			loot = lootSuperRare6
		end

	elseif skill > 60 and skill <= 80 then
		if chance <= 70 then
			loot = lootTrash6
		elseif chance <= 75 then
			loot = lootCommon6
		elseif chance <= 95 then
			loot = lootUncommon6
		elseif chance <= 98 then
			loot = lootSemiRare6
		elseif chance <= 99.3 then
			loot = lootRare6
		elseif chance <= 99.99 then
			loot = lootVeryRare6
		elseif chance > 99.9 then
			loot = lootSuperRare6
		end

	elseif skill > 80 and skill <= 100 then
		if chance <= 60 then
			loot = lootTrash6
		elseif chance <= 70 then
			loot = lootCommon6
		elseif chance <= 90 then
			loot = lootUncommon6
		elseif chance <= 97.5 then
			loot = lootSemiRare6
		elseif chance <= 99.2 then
			loot = lootRare6
		elseif chance <= 99.99 then
			loot = lootVeryRare6
		elseif chance > 99.99 then
			loot = lootSuperRare6
		end
	elseif skill > 100 and skill <= 120 then
		if chance <= 40 then
			loot = lootTrash6
		elseif chance <= 60 then
			loot = lootCommon6
		elseif chance <= 80 then
			loot = lootUncommon6
		elseif chance <= 95 then
			loot = lootSemiRare6
		elseif chance <= 98 then
			loot = lootRare6
		elseif chance <= 99.97 then
			loot = lootVeryRare6
		elseif chance > 99.99 then
			loot = lootSuperRare6
		end
	elseif skill > 120 and skill <= 130 then
		if chance <= 15 then
			loot = lootTrash6
		elseif chance <= 40 then
			loot = lootCommon6
		elseif chance <= 60 then
			loot = lootUncommon6
		elseif chance <= 95 then
			loot = lootSemiRare6
		elseif chance <= 97 then
			loot = lootRare6
		elseif chance <= 99.98 then
			loot = lootVeryRare6
		elseif chance > 99.98 then
			loot = lootSuperRare6
		end
	elseif skill > 130 and skill <= 140 then
		if chance <= 15 then
			loot = lootTrash6
		elseif chance <= 40 then
			loot = lootCommon6
		elseif chance <= 60 then
			loot = lootUncommon6
		elseif chance <= 95 then
			loot = lootSemiRare6
		elseif chance <= 97 then
			loot = lootRare6
		elseif chance <= 99.98 then
			loot = lootVeryRare6
		elseif chance > 99.98 then
			loot = lootSuperRare6
		end
	elseif skill > 140 then
		if chance <= 5 then
			loot = lootTrash6
		elseif chance <= 30 then
			loot = lootCommon6
		elseif chance <= 55 then
			loot = lootUncommon6
		elseif chance <= 90 then
			loot = lootSemiRare6
		elseif chance <= 95 then
			loot = lootRare6
		elseif chance <= 99.5 then
			loot = lootVeryRare6
		elseif chance <= 99.95 then
			loot = lootSuperRare6
		elseif chance > 99.95 then
			loot = lootUltraRare6
		end
	end
	return loot
end

local function calculateChances7(skill)
	local chance = math.random(1000) / 10 -- converting to decimal
	local loot = lootTrash7
	if skill <= 39 then
		if chance <= 80 then
			loot = lootTrash7
		elseif chance <= 90 then
			loot = lootCommon7
		elseif chance <= 98 then
			loot = lootUncommon7
		elseif chance <= 99 then
			loot = lootSemiRare7
		elseif chance <= 99.95 then
			loot = lootRare7
		elseif chance <= 99.99 then
			loot = lootVeryRare7
		elseif chance > 99.99 then
			loot = lootSuperRare7
		end

	elseif skill >= 40 and skill <= 60 then
		if chance <= 75 then
			loot = lootTrash7
		elseif chance <= 85 then
			loot = lootCommon7
		elseif chance <= 95 then
			loot = lootUncommon7
		elseif chance <= 98.5 then
			loot = lootSemiRare7
		elseif chance <= 99.5 then
			loot = lootRare7
		elseif chance <= 99.99 then
			loot = lootVeryRare7
		elseif chance > 99.99 then
			loot = lootSuperRare7
		end

	elseif skill > 60 and skill <= 80 then
		if chance <= 70 then
			loot = lootTrash7
		elseif chance <= 75 then
			loot = lootCommon7
		elseif chance <= 95 then
			loot = lootUncommon7
		elseif chance <= 98 then
			loot = lootSemiRare7
		elseif chance <= 99.3 then
			loot = lootRare7
		elseif chance <= 99.99 then
			loot = lootVeryRare7
		elseif chance > 99.9 then
			loot = lootSuperRare7
		end

	elseif skill > 80 and skill <= 100 then
		if chance <= 60 then
			loot = lootTrash7
		elseif chance <= 70 then
			loot = lootCommon7
		elseif chance <= 90 then
			loot = lootUncommon7
		elseif chance <= 97.5 then
			loot = lootSemiRare7
		elseif chance <= 99.2 then
			loot = lootRare7
		elseif chance <= 99.99 then
			loot = lootVeryRare7
		elseif chance > 99.99 then
			loot = lootSuperRare7
		end
	elseif skill > 100 and skill <= 120 then
		if chance <= 40 then
			loot = lootTrash7
		elseif chance <= 60 then
			loot = lootCommon7
		elseif chance <= 80 then
			loot = lootUncommon7
		elseif chance <= 95 then
			loot = lootSemiRare7
		elseif chance <= 98 then
			loot = lootRare7
		elseif chance <= 99.97 then
			loot = lootVeryRare7
		elseif chance > 99.99 then
			loot = lootSuperRare7
		end
	elseif skill > 120 and skill <= 130 then
		if chance <= 15 then
			loot = lootTrash7
		elseif chance <= 40 then
			loot = lootCommon7
		elseif chance <= 60 then
			loot = lootUncommon7
		elseif chance <= 95 then
			loot = lootSemiRare7
		elseif chance <= 97 then
			loot = lootRare7
		elseif chance <= 99.98 then
			loot = lootVeryRare7
		elseif chance > 99.98 then
			loot = lootSuperRare7
		end
	elseif skill > 130 and skill <= 140 then
		if chance <= 15 then
			loot = lootTrash7
		elseif chance <= 40 then
			loot = lootCommon7
		elseif chance <= 60 then
			loot = lootUncommon7
		elseif chance <= 95 then
			loot = lootSemiRare7
		elseif chance <= 97 then
			loot = lootRare7
		elseif chance <= 99.98 then
			loot = lootVeryRare7
		elseif chance > 99.98 then
			loot = lootSuperRare7
		end
	elseif skill > 140 then
		if chance <= 5 then
			loot = lootTrash7
		elseif chance <= 30 then
			loot = lootCommon7
		elseif chance <= 55 then
			loot = lootUncommon7
		elseif chance <= 90 then
			loot = lootSemiRare7
		elseif chance <= 95 then
			loot = lootRare7
		elseif chance <= 99.5 then
			loot = lootVeryRare7
		elseif chance <= 99.95 then
			loot = lootSuperRare7
		elseif chance > 99.95 then
			loot = lootUltraRare7
		end
	end
	return loot
end

local function calculateChances8(skill)
	local chance = math.random(1000) / 10 -- converting to decimal
	local loot = lootTrash8
	if skill <= 39 then
		if chance <= 80 then
			loot = lootTrash8
		elseif chance <= 90 then
			loot = lootCommon8
		elseif chance <= 98 then
			loot = lootUncommon8
		elseif chance <= 99 then
			loot = lootSemiRare8
		elseif chance <= 99.95 then
			loot = lootRare8
		elseif chance <= 99.99 then
			loot = lootVeryRare8
		elseif chance > 99.99 then
			loot = lootSuperRare8
		end

	elseif skill >= 40 and skill <= 60 then
		if chance <= 75 then
			loot = lootTrash8
		elseif chance <= 85 then
			loot = lootCommon8
		elseif chance <= 95 then
			loot = lootUncommon8
		elseif chance <= 98.5 then
			loot = lootSemiRare8
		elseif chance <= 99.5 then
			loot = lootRare8
		elseif chance <= 99.99 then
			loot = lootVeryRare8
		elseif chance > 99.99 then
			loot = lootSuperRare8
		end

	elseif skill > 60 and skill <= 80 then
		if chance <= 70 then
			loot = lootTrash8
		elseif chance <= 75 then
			loot = lootCommon8
		elseif chance <= 95 then
			loot = lootUncommon8
		elseif chance <= 98 then
			loot = lootSemiRare8
		elseif chance <= 99.3 then
			loot = lootRare8
		elseif chance <= 99.99 then
			loot = lootVeryRare8
		elseif chance > 99.9 then
			loot = lootSuperRare8
		end

	elseif skill > 80 and skill <= 100 then
		if chance <= 60 then
			loot = lootTrash8
		elseif chance <= 70 then
			loot = lootCommon8
		elseif chance <= 90 then
			loot = lootUncommon8
		elseif chance <= 97.5 then
			loot = lootSemiRare8
		elseif chance <= 99.2 then
			loot = lootRare8
		elseif chance <= 99.99 then
			loot = lootVeryRare8
		elseif chance > 99.99 then
			loot = lootSuperRare8
		end
	elseif skill > 100 and skill <= 120 then
		if chance <= 40 then
			loot = lootTrash8
		elseif chance <= 60 then
			loot = lootCommon8
		elseif chance <= 80 then
			loot = lootUncommon8
		elseif chance <= 95 then
			loot = lootSemiRare8
		elseif chance <= 98 then
			loot = lootRare8
		elseif chance <= 99.97 then
			loot = lootVeryRare8
		elseif chance > 99.99 then
			loot = lootSuperRare8
		end
	elseif skill > 120 and skill <= 130 then
		if chance <= 15 then
			loot = lootTrash8
		elseif chance <= 40 then
			loot = lootCommon8
		elseif chance <= 60 then
			loot = lootUncommon8
		elseif chance <= 95 then
			loot = lootSemiRare8
		elseif chance <= 97 then
			loot = lootRare8
		elseif chance <= 99.9 then
			loot = lootVeryRare8
		elseif chance > 99.9 then
			loot = lootSuperRare8
		end
	elseif skill > 140 then
		if chance <= 5 then
			loot = lootTrash8
		elseif chance <= 30 then
			loot = lootCommon8
		elseif chance <= 55 then
			loot = lootUncommon8
		elseif chance <= 80 then
			loot = lootSemiRare8
		elseif chance <= 90 then
			loot = lootRare8
		elseif chance <= 95 then
			loot = lootVeryRare8
		elseif chance <= 99.5 then
			loot = lootSuperRare8
		elseif chance > 99.5 then
			loot = lootUltraRare8
		end
	end
	return loot
end
--------------------------------------------------- VIP CHANCES ----------------------------------


local MiningCrystalsTable = {
    [15319] = true,
    [14941] = true,
    [14961] = true,
	[19311] = true,
}

local miningEvent = {}
local MINING_STORAGE = Storage.Quest.Crandoria.ForgeSystem.AutoMiningTimer

local function leaveMining(playerId)
    if miningEvent[playerId] then
        stopEvent(miningEvent[playerId].event)
        miningEvent[playerId] = nil
    end

    local player = Player(playerId)
    if player then
        player:setStorageValue(MINING_STORAGE, 0)  -- Desativa o estado de mineração
    end
    return
end

local function miningCycle(playerId, crystalPosition, pickaxeId, startPosition, hitCount)
    local player = Player(playerId)
    if not player then
        return leaveMining(playerId)
    end

	local level = player:getLevel()
	local magicLevel = player:getBaseMagicLevel()

	local RandomCrystals = {
		15319,  -- ID de cristal aleatório 1
		14941,  -- ID de cristal aleatório 2
		14961,  -- ID de cristal aleatório 3
	}

	if player:getVipDays() > 0 then
		RandomCrystals = {
			15319,  -- ID de cristal aleatório 1
			14941,  -- ID de cristal aleatório 2
			14961,  -- ID de cristal aleatório 3
			19311,
		}
	end

	local function transformCrystal(item)
		local randomIndex = math.random(1, #RandomCrystals)
		local newCrystalId = RandomCrystals[randomIndex]

		-- Transforma o cristal antigo no novo cristal
		item:transform(newCrystalId)
		item:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)  -- Efeito visual da transformação
	end

	local skillMining = player:getStorageValue(Storage.Quest.Crandoria.SkillsColeta.MiningCount)
	local skillMiningLevel = player:getStorageValue(Storage.Quest.Crandoria.SkillsColeta.MiningLevel)
	local skillMiningNext = player:getStorageValue(Storage.Quest.Crandoria.SkillsColeta.MiningNextLevel)

    if player:getPosition() ~= startPosition then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce se moveu da posicao, a mineracao parou.")
        return leaveMining(playerId)
    end

    if player:getStorageValue(MINING_STORAGE) ~= 1 then
        return leaveMining(playerId)
    end

    -- Verifica se há um cristal válido na posição
    local crystalItem = Tile(crystalPosition):getItemById(15319) or
                        Tile(crystalPosition):getItemById(14941) or
                        Tile(crystalPosition):getItemById(14961)

	if player:getVipDays() > 0 then
		crystalItem = Tile(crystalPosition):getItemById(15319) or
                        Tile(crystalPosition):getItemById(14941) or
                        Tile(crystalPosition):getItemById(14961) or
						Tile(crystalPosition):getItemById(19311)
	end

    if not crystalItem then
        player:sendTextMessage(MESSAGE_FAILURE, "A mineracao parou porque o cristal foi removido.")
        leaveMining(playerId)
        return false
    end

	if player:getItemCount(32711) < 1 then
        player:sendTextMessage(MESSAGE_FAILURE, "Voce nao possui uma picareta de cristal.")
        leaveMining(playerId)
        return false
    end

    local tile = Tile(player:getPosition())
    if tile and not (tile:getItemById(10145) or tile:getItemById(10146)) then
        player:sendTextMessage(MESSAGE_FAILURE, "Voce nao esta em uma area de mineracao.")
        leaveMining(playerId)
        return false
    end

    if player:getIp() == 0 then
        player:save()
        addEvent(function()
            player:remove()
        end, 3000)
        return false
    end

	local stamina = player:getStamina()
	if stamina < 480 then
		player:sendTextMessage(MESSAGE_FAILURE, "Voce esta muito cansado para continuar minerando.")
        leaveMining(playerId)
        return false
    end

	if player:getStorageValue(Storage.Quest.Crandoria.ForgeSystem.AutoMining) < os.time() and player:getVipDays() < 0.1 then
        leaveMining(playerId)
		player:teleportTo(Position(4729, 4572, 7))
		player:sendTextMessage(MESSAGE_FAILURE, "Seu tempo nas minas se esgotou.")
        return false
    end

	if player:getFreeBackpackSlots() < 1 then
		leaveMining(playerId)
		player:sendTextMessage(MESSAGE_FAILURE, "Voce nao possui espaco para armazenar mais itens.")
        return false
    end

	-- COM STORAGE --
    -- Lógica de mineração, adicionar recompensas etc.
    -- crystalPosition:sendMagicEffect(CONST_ME_HITAREA)
	-- local storagesorte = player:getStorageValue(Storage.Quest.Crandoria.ArvoreDeForca.LuckLevel)

	-- if skillMiningLevel < 1 then
	-- 	skillMiningLevel = 0
	-- end

	-- if skillMining < 1 then
	-- 	skillMining = 1
	-- end

	-- -- local skill = player:getEffectiveSkillLevel(SKILL_FIST) + (storagesorte / 2) + (skillMiningLevel * 0.1)
	-- local skill = (level / 15) + (skillMiningLevel * 0.8) + storagesorte

	-- COM CACHE --
	local arvore = getArvoreDeForcaValues(player)
	local storagesorte = arvore.luck

	if storagesorte < 1 then
		storagesorte = 0
	end

	if skillMiningLevel < 1 then
		skillMiningLevel = 0
	end

	if skillMining < 1 then
		skillMining = 1
	end

    local setBonus = 0
    local helmet = player:getSlotItem(CONST_SLOT_HEAD)
    local shirt = player:getSlotItem(CONST_SLOT_ARMOR)
    local legs = player:getSlotItem(CONST_SLOT_LEGS)
    local boots = player:getSlotItem(CONST_SLOT_FEET)

    if helmet then
        if helmet.itemid == 11700 then
            setBonus = setBonus + 1
        elseif helmet.itemid == 3226 then
            setBonus = setBonus + 2
        end
    end

    if shirt then
        if shirt.itemid == 32099 then
            setBonus = setBonus + 2
        elseif shirt.itemid == 32585 then
            setBonus = setBonus + 3
        end
    end

    if legs then
        if legs.itemid == 32097 then
            setBonus = setBonus + 2
        elseif legs.itemid == 24402 then
            setBonus = setBonus + 3
        end
    end

    if boots then
        if boots.itemid == 9017 then
            setBonus = setBonus + 1
        elseif boots.itemid == 32098 then
            setBonus = setBonus + 2
        end
    end

	local skill = (level / 15) + (skillMiningLevel * 0.8) + storagesorte + (setBonus / 2)


	if isInRange1 then
		skill = skill + 5
	elseif isInRange3 then
		skill = skill - 10
	end

	local lootTable = calculateChances(skill)
	local lootTable2 = calculateChances2(skill)
	local lootTable3 = calculateChances3(skill)
	local lootTable4 = calculateChances4(skill)
	local lootTable5 = calculateChances5(skill)
	local lootTable6 = calculateChances6(skill)
	local lootTable7 = calculateChances7(skill)
	local lootTable8 = calculateChances8(skill)

	local chanceSorte = math.random(1, 10000)
		if storagesorte == 1 then
			chanceSorte = math.random(1000, 10000)
		elseif storagesorte == 2 then
			chanceSorte = math.random(1500, 10000)
		elseif storagesorte == 3 then
			chanceSorte = math.random(2000, 10000)
		elseif storagesorte == 4 then
			chanceSorte = math.random(2500, 10000)
		elseif storagesorte == 5 then
			chanceSorte = math.random(3000, 10000)
		end

	-- local chance = math.random(1 + (storagesorte * 3) + skill + (level / 20) + (magicLevel / 10), 250)
	local chance = math.random(1 + (storagesorte * 3) + player:getEffectiveSkillLevel(SKILL_FIST) + (level / 100) + (magicLevel / 10), 250)
	local chanceStamina = math.random(1, 300)
	local chance2 = math.random(1, 3000)
		if chance > 195 then
			-- local staminaCost = math.max(0, math.ceil((1000 - level) / 100))
			local staminaCost = math.max(0, math.ceil((1000 - level) / 100))
			crystalPosition:sendMagicEffect(CONST_ME_HITAREA)
			player:say("CLINK!", TALKTYPE_MONSTER_SAY, false, nil, crystalPosition)
			player:getPosition():sendSingleSoundEffect(SOUND_EFFECT_TYPE_SPELL_PROTECTOR)
			local crystalId = crystalItem:getId()
			local specialPickCount = player:getItemCount(4049)

			local countItem = player:getStorageValue(Storage.Quest.Crandoria.SociedadeDeAstralis.BuffColeta) > os.time() and 2 or 1

			if crystalId == 15319 then
				player:addItem(lootTable[math.random(#lootTable)], countItem)
				player:setDirection(EAST)
			elseif crystalId == 14941 then
				player:addItem(lootTable2[math.random(#lootTable2)], countItem)
				player:setDirection(NORTH)
			elseif crystalId == 14961 then
				player:addItem(lootTable3[math.random(#lootTable3)], countItem)
				player:setDirection(SOUTH)
			elseif crystalId == 19311 then
				player:addItem(lootTable4[math.random(#lootTable4)], countItem)
			end

			local function getItemInContainers(container, itemId)
				for i = 0, container:getSize() - 1 do
					local item = container:getItem(i)

					if item:getId() == itemId then
						return item
					end

					if item:isContainer() then
						local found = getItemInContainers(item, itemId)
						if found then
							return found
						end
					end
				end
				return nil
			end

			player:addCondition(exhaustHealGroup)
			player:addCondition(exhaustSupportGroup)
			player:addCondition(exhaustAttackGroup)
			player:addCondition(exhaustFourthGroup)
			player:addCondition(exhaustFifthGroup)
			player:addCondition(exhaustSixthGroup)
			player:addCondition(exhaustSeventhGroup)

			local chanceExtra = math.random(1, 150000)
			if skillMiningLevel > 4 and skillMiningLevel < 10 then
				if chanceExtra > 130000 then
					player:addItem(3031, 1)
				end
			elseif skillMiningLevel >= 10 and skillMiningLevel < 25 then
				if chanceExtra >= 149500 then
					player:addItem(3035, 1)
				end
			elseif skillMiningLevel >= 25 and skillMiningLevel < 75 then
				if chanceExtra >= 149500 then
					player:addItem(3028, 1)
				end
			elseif skillMiningLevel >= 75 then
				if chanceExtra == 150000 then
					player:addItem(4061, 1)
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce encontrou um raro Eldritch Fragment! (Bonus de Skill)")
				end
			end

			-- INICIALIZAÇÃO COMPLETA
			if skillMining <= 1 then
				player:setStorageValue(Storage.Quest.Crandoria.SkillsColeta.MiningCount, 1)
				player:setStorageValue(Storage.Quest.Crandoria.SkillsColeta.MiningLevel, 1)
				player:setStorageValue(Storage.Quest.Crandoria.SkillsColeta.MiningNextLevel, 300)

			end

			if skillMiningLevel < 100 then
				-- A cada mining
				if skillMining + 1 == skillMiningNext then
					-- Evoluiu a skill
					local newLevel = skillMiningLevel + 1
					local newNext = skillMiningNext + (500 * newLevel)

					player:setStorageValue(Storage.Quest.Crandoria.SkillsColeta.MiningLevel, newLevel)
					player:setStorageValue(Storage.Quest.Crandoria.SkillsColeta.MiningNextLevel, newNext)
					player:setStorageValue(Storage.Quest.Crandoria.SkillsColeta.MiningCount, skillMining + 1)

					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce evoluiu sua Skill de Mining!")
				else
					-- Apenas ganha 1 ponto
					player:setStorageValue(Storage.Quest.Crandoria.SkillsColeta.MiningCount, skillMining + 1)
					player:say("+ Mining", TALKTYPE_MONSTER_SAY)
				end
			end

			if player:getStorageValue(Storage.Quest.Crandoria.WarlocksConspiracy.Progresso) >= 12 then
				if chance2 == 3000 then
					player:addItem(32567, 1)
				end
			end
			hitCount = hitCount + 1
		else
			player:addCondition(exhaustHealGroup)
			player:addCondition(exhaustSupportGroup)
			player:addCondition(exhaustAttackGroup)
			player:addCondition(exhaustFourthGroup)
			player:addCondition(exhaustFifthGroup)
			player:addCondition(exhaustSixthGroup)
			player:addCondition(exhaustSeventhGroup)
			crystalPosition:sendMagicEffect(CONST_ME_POFF)
			player:say("miss", TALKTYPE_MONSTER_SAY, false, nil, crystalPosition)
			player:getPosition():sendSingleSoundEffect(SOUND_EFFECT_TYPE_MONSTER_MELEE_ATK_RIP)
		end

    -- hitCount = hitCount + 1

    if hitCount >= 10 then
        transformCrystal(crystalItem)  -- Passa o cristalItem válido para transformação
        hitCount = 0  -- Reinicia o contador de batidas
    end

    local vocation = player:getVocation()
    miningEvent[playerId].event = addEvent(miningCycle, 3500, playerId, crystalPosition, pickaxeId, startPosition, hitCount)
    return true
end

local miningAction = Action()

local function isCrystal(id)
    return MiningCrystalsTable[id] ~= nil
end

function miningAction.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if not target then
        return
    end

    local playerId = player:getId()
    local targetId = target:getId()

	if target.itemid == 1791 and target:getPosition() == Position(5818, 5560, 7) then
		if player:getStorageValue(Storage.Quest.Crandoria.QuestKromrek.Progresso) >= 6 then
			if player:getStorageValue(Storage.Quest.Crandoria.QuestKromrek.Progresso) == 6 then
				if player:getItemCount(399) >= 1 then
					player:removeItem(399, 1)
					player:setStorageValue(Storage.Quest.Crandoria.QuestKromrek.Progresso, 7)
				else
					return true
				end
			end
			player:teleportTo(Position(5898, 5566, 8))
			return true
		end
	end

    if target.itemid == 39037 then
        if player:getItemCount(39037) < 1 then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "O item deve estar em seu inventario.")
            return true
        else
            player:removeItem(39037, 1)
            fromPosition:sendMagicEffect(CONST_ME_HITAREA)
            local chanceCobalt = math.random(1, 25)
            if chanceCobalt == 25 then
                local storageTC = player:getStorageValue(Storage.Quest.Crandoria.SkillsColeta.ContagemTC)
                local limiteTC = Game.getStorageValue(GlobalStorage.Crandoria.TibiaCoinsColeta.LimiteDiario)
                if limiteTC < 0 then
                    limiteTC = 0
                end
                local valorTC = 25 - limiteTC
                if valorTC >= 1 then
                    player:addTransferableCoins(1)
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu 1 Tibia Coin.")
                    setGlobalStorage(GlobalStorage.Crandoria.TibiaCoinsColeta.CoinsTotal, getGlobalStorage(GlobalStorage.Crandoria.TibiaCoinsColeta.CoinsTotal) + 1)
                    player:setStorageValue(Storage.Quest.Crandoria.SkillsColeta.ContagemTC,storageTC  + 1)
                    Game.setStorageValue(GlobalStorage.Crandoria.TibiaCoinsColeta.LimiteDiario, limiteTC + 1)
                else
                    player:addItem(3043, 1)
                    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce abriu um Cobalt Ridge e encontrou 1 Crystal Coin.")
                    return true
                end
            elseif chanceCobalt > 20 and chanceCobalt < 25 then
                player:addItem(3043, 1)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce abriu um Cobalt Ridge e encontrou 1 Crystal Coin.")
                return true
            elseif chanceCobalt > 15 and chanceCobalt <= 20 then
                local platinum = math.random(5, 25)
                player:addItem(3035, platinum)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce abriu um Cobalt Ridge e encontrou alguns platinum coins.")
                return true
            elseif chanceCobalt > 10 and chanceCobalt <= 15 then
                player:addItem(3041, 1)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce abriu um Cobalt Ridge e encontrou 1 Blue Gem.")
                return true
            elseif chanceCobalt > 5 and chanceCobalt <= 10 then
                player:addItem(3037, 1)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce abriu um Cobalt Ridge e encontrou 1 Yellow Gem.")
                return true
            elseif chanceCobalt > 1 and chanceCobalt <= 5 then
                player:addItem(3036, 1)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce abriu um Cobalt Ridge e encontrou 1 Violet Gem.")
                return true
            else
                player:addItem(4061, 1)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce abriu um Cobalt Ridge e encontrou 1 Eldritch Fragment!")
                return true
            end
        end
	end

    if target:isItem() and isCrystal(targetId) then
        if miningEvent[playerId] then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You are already mining.")
            leaveMining(playerId)
            return true
        end

        if player:getIp() == 0 then
            player:remove()
            return false
        end

        miningEvent[playerId] = miningEvent[playerId] or {}

        if not miningEvent[playerId].event then
            local startPosition = player:getPosition()
            miningEvent[playerId].event = addEvent(miningCycle, 0, playerId, target:getPosition(), item.itemid, startPosition, 0)  -- Inicializa o contador de batidas
            player:setStorageValue(MINING_STORAGE, 1)  -- Ativa o estado de mineração
        end

        return true
    end
    return false
end

miningAction:id(32711)  -- ID da picareta
miningAction:register()
