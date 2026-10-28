-- Minlevel and multiplier are MANDATORY
-- Maxlevel is OPTIONAL, but is considered infinite by default
-- Create a stage with minlevel 1 and no maxlevel to disable stages
------------- TEST SERVER -----------------
experienceStages = {
	{
		minlevel = 1,
		maxlevel = 19,
		multiplier = 10,
	},
	{
		minlevel = 20,
		maxlevel = 49,
		multiplier = 5,
	},
	{
		minlevel = 50,
		maxlevel = 149,
		multiplier = 4,
	},
	{
		minlevel = 150,
		maxlevel = 299,
		multiplier = 3,
	},
	{
		minlevel = 300,
		maxlevel = 599,
		multiplier = 2,
	},
	{
		minlevel = 600,
		multiplier = 1,
	},
}

skillsStages = {
	{
		minlevel = 10,
		maxlevel = 50,
		multiplier = 45,
	},
	{
		minlevel = 51,
		maxlevel = 70,
		multiplier = 30,
	},
	{
		minlevel = 71,
		maxlevel = 90,
		multiplier = 15,
	},
	{
		minlevel = 91,
		maxlevel = 100,
		multiplier = 5,
	},
	{
		minlevel = 101,
		maxlevel = 105,
		multiplier = 2,
	},
	{
		minlevel = 106,
		multiplier = 1,
	},
}

magicLevelStages = {
	{
		minlevel = 0,
		maxlevel = 50,
		multiplier = 30,
	},
	{
		minlevel = 51,
		maxlevel = 70,
		multiplier = 15,
	},
	{
		minlevel = 71,
		maxlevel = 90,
		multiplier = 5,
	},
	{
		minlevel = 91,
		maxlevel = 100,
		multiplier = 2,
	},
	{
		minlevel = 101,
		multiplier = 1,
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
