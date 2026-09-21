-- Minlevel and multiplier are MANDATORY
-- Maxlevel is OPTIONAL, but is considered infinite by default
-- Create a stage with minlevel 1 and no maxlevel to disable stages
------------- TEST SERVER -----------------
experienceStages = {
	{
		minlevel = 1,
		maxlevel = 20,
		multiplier = 25,
	},
	{
		minlevel = 21,
		maxlevel = 100,
		multiplier = 15,
	},
	{
		minlevel = 101,
		maxlevel = 500,
		multiplier = 10,
	},
	{
		minlevel = 501,
		maxlevel = 750,
		multiplier = 5,
	},
	{
		minlevel = 751,
		multiplier = 3,
	},
}

skillsStages = {
	{
		minlevel = 10,
		maxlevel = 110,
		multiplier = 100,
	},
	{
		minlevel = 106,
		multiplier = 5,
	},
}

magicLevelStages = {
	{
		minlevel = 0,
		maxlevel = 100,
		multiplier = 100,
	},
	{
		minlevel = 101,
		multiplier = 5,
	},
}


------------- OFICIAL -----------------
-- experienceStages = {
-- 	{
-- 		minlevel = 1,
-- 		maxlevel = 20,
-- 		multiplier = 10,
-- 	},
-- 	{
-- 		minlevel = 21,
-- 		maxlevel = 100,
-- 		multiplier = 8,
-- 	},
-- 	{
-- 		minlevel = 101,
-- 		maxlevel = 250,
-- 		multiplier = 6,
-- 	},
-- 	{
-- 		minlevel = 251,
-- 		maxlevel = 500,
-- 		multiplier = 4,
-- 	},
-- 	{
-- 		minlevel = 501,
-- 		maxlevel = 750,
-- 		multiplier = 2,
-- 	},
-- 	{
-- 		minlevel = 751,
-- 		multiplier = 1,
-- 	},
-- }

-- skillsStages = {
-- 	{
-- 		minlevel = 10,
-- 		maxlevel = 50,
-- 		multiplier = 45,
-- 	},
-- 	{
-- 		minlevel = 51,
-- 		maxlevel = 70,
-- 		multiplier = 20,
-- 	},
-- 	{
-- 		minlevel = 71,
-- 		maxlevel = 90,
-- 		multiplier = 10,
-- 	},
-- 	{
-- 		minlevel = 91,
-- 		maxlevel = 100,
-- 		multiplier = 5,
-- 	},
-- 	{
-- 		minlevel = 101,
-- 		maxlevel = 105,
-- 		multiplier = 2,
-- 	},
-- 	{
-- 		minlevel = 106,
-- 		multiplier = 1,
-- 	},
-- }

-- magicLevelStages = {
-- 	{
-- 		minlevel = 0,
-- 		maxlevel = 50,
-- 		multiplier = 30,
-- 	},
-- 	{
-- 		minlevel = 51,
-- 		maxlevel = 70,
-- 		multiplier = 10,
-- 	},
-- 	{
-- 		minlevel = 71,
-- 		maxlevel = 90,
-- 		multiplier = 5,
-- 	},
-- 	{
-- 		minlevel = 91,
-- 		maxlevel = 100,
-- 		multiplier = 2,
-- 	},
-- 	{
-- 		minlevel = 101,
-- 		multiplier = 1,
-- 	},
-- }
