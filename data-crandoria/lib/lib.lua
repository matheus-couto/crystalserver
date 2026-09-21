-- Core API functions implemented in Lua
dofile(DATA_DIRECTORY .. "/lib/core/load.lua")

-- Others library
dofile(DATA_DIRECTORY .. "/lib/others/load.lua")

-- Quests library
dofile(DATA_DIRECTORY .. "/lib/quests/quest.lua")

-- Task system: define taskConfiguration e taskQuestLog. Sem este dofile o
-- task_globalevent.lua e o !task quebravam com taskConfiguration nil.
dofile(DATA_DIRECTORY .. "/lib/task_lib.lua")

-- Tables library
dofile(DATA_DIRECTORY .. "/lib/tables/load.lua")
