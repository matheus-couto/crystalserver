local config = {
-- Window Config
	mainTitleMsg = "Crafting System", -- Main window title
	mainMsg = "Welcome to the crafting system. Please choose a group to begin.", -- Main window message
 
	craftTitle = "Crafting System: ", -- Title of the crafting screen after player picks of vocation
	craftMsg = "Here is a list of all items that can be crafted for the ", -- Message on the crafting screen after player picks of vocation
-- End Window Config
 
-- Player Notifications Config
	needItems = "You do not have all the required items to make ", -- This is the message the player recieves if he does not have all required items
 
-- Crafting Config
	system = {
	[1] = {group = "Eldrich Weapons", -- This is the category can be anything.
			items = {
				[1] = {item = "Eldritch Claymore", -- item name (THIS MUST BE EXACT OR IT WILL NOT WORK!)
					itemID = 36657, -- item to be made
					reqItems = { -- items and the amounts in order to craft.
							[1] = {item = 21383, count = 5}, -- Eldritch Stone
							[2] = {item = 39037, count = 50}, -- Cobalt Ridge
							[3] = {item = 29345, count = 250}, -- Blue Glass Plate
						},
					},
				[2] = {item = "Eldritch Greataxe", -- item name (THIS MUST BE EXACT OR IT WILL NOT WORK!)
					itemID = 36661, -- item to be made
					reqItems = { -- items and the amounts in order to craft.
							[1] = {item = 21383, count = 5}, -- Eldritch Stone
							[2] = {item = 39037, count = 50}, -- Cobalt Ridge
							[3] = {item = 29345, count = 500}, -- Blue Glass Plate
						},
					},
				[3] = {item = "Eldritch Warmace", -- item name (THIS MUST BE EXACT OR IT WILL NOT WORK!)
					itemID = 36659, -- item to be made
					reqItems = { -- items and the amounts in order to craft.
							[1] = {item = 21383, count = 5}, -- Eldritch Stone
							[2] = {item = 39037, count = 50}, -- Cobalt Ridge
							[3] = {item = 29345, count = 500}, -- Blue Glass Plate
						},
					},
				[4] = {item = "Eldritch Bow", -- item name (THIS MUST BE EXACT OR IT WILL NOT WORK!)
					itemID = 36664, -- item to be made
					reqItems = { -- items and the amounts in order to craft.
							[1] = {item = 21383, count = 5}, -- Eldritch Stone
							[2] = {item = 39037, count = 50}, -- Cobalt Ridge
							[3] = {item = 29346, count = 500}, -- Green Glass Plate
						},
					},
				[5] = {item = "Eldritch Wand", -- item name (THIS MUST BE EXACT OR IT WILL NOT WORK!)
					itemID = 36668, -- item to be made
					reqItems = { -- items and the amounts in order to craft.
							[1] = {item = 21383, count = 5}, -- Eldritch Stone
							[2] = {item = 39037, count = 50}, -- Cobalt Ridge
							[3] = {item = 29347, count = 500}, -- Violet Glass Plate
						},
					},
				[6] = {item = "Eldritch Rod", -- item name (THIS MUST BE EXACT OR IT WILL NOT WORK!)
					itemID = 36674, -- item to be made
					reqItems = { -- items and the amounts in order to craft.
							[1] = {item = 21383, count = 5}, -- Eldritch Stone
							[2] = {item = 39037, count = 50}, -- Cobalt Ridge
							[3] = {item = 29347, count = 500}, -- Violet Glass Plate
						},
					},
				[7] = {item = "Eldritch Crescent Moon Spade", -- item name (THIS MUST BE EXACT OR IT WILL NOT WORK!)
					itemID = 50169, -- item to be made
					reqItems = { -- items and the amounts in order to craft.
							[1] = {item = 21383, count = 5}, -- Eldritch Stone
							[2] = {item = 39037, count = 50}, -- Cobalt Ridge
							[3] = {item = 29346, count = 500}, -- Green Glass Plate
						},
					},
				},
			},
	[2] = {group = "Sanguine Weapons", -- This is the category can be anything.
			items = {
				[1] = {item = "Sanguine Blade", -- item name (THIS MUST BE EXACT OR IT WILL NOT WORK!)
					itemID = 43864, -- item to be made
					reqItems = { -- items and the amounts in order to craft.
							[1] = {item = 43855, count = 4}, -- Darklight heart
							[2] = {item = 43854, count = 4}, -- Tainted Heart
							[3] = {item = 29345, count = 500}, -- Blue Glass Plate
							[4] = {item = 39037, count = 250}, -- Cobalt Ridge
							[5] = {item = 39039, count = 1}, -- transmutation gem
						},
					},
				[2] = {item = "Sanguine Cudgel", -- item name (THIS MUST BE EXACT OR IT WILL NOT WORK!)
					itemID = 43866, -- item to be made
					reqItems = { -- items and the amounts in order to craft.
							[1] = {item = 43855, count = 4}, -- Darklight heart
							[2] = {item = 43854, count = 4}, -- Tainted Heart
							[3] = {item = 29345, count = 500}, -- Blue Glass Plate
							[4] = {item = 39037, count = 250}, -- Cobalt Ridge
							[5] = {item = 39039, count = 1}, -- transmutation gem
						},
					},
				[3] = {item = "Sanguine Hatchet", -- item name (THIS MUST BE EXACT OR IT WILL NOT WORK!)
					itemID = 43868, -- item to be made
					reqItems = { -- items and the amounts in order to craft.
							[1] = {item = 43855, count = 4}, -- Darklight heart
							[2] = {item = 43854, count = 4}, -- Tainted Heart
							[3] = {item = 29345, count = 500}, -- Blue Glass Plate
							[4] = {item = 39037, count = 250}, -- Cobalt Ridge
							[5] = {item = 39039, count = 1}, -- transmutation gem
						},
					},
				[4] = {item = "Sanguine Razor", -- item name (THIS MUST BE EXACT OR IT WILL NOT WORK!)
					itemID = 43870, -- item to be made
					reqItems = { -- items and the amounts in order to craft.
							[1] = {item = 43855, count = 4}, -- Darklight heart
							[2] = {item = 43854, count = 4}, -- Tainted Heart
							[3] = {item = 29345, count = 500}, -- Blue Glass Plate
							[4] = {item = 39037, count = 250}, -- Cobalt Ridge
							[5] = {item = 39039, count = 1}, -- transmutation gem
						},
					},
				[5] = {item = "Sanguine Bludgeon", -- item name (THIS MUST BE EXACT OR IT WILL NOT WORK!)
					itemID = 43872, -- item to be made
					reqItems = { -- items and the amounts in order to craft.
							[1] = {item = 43855, count = 4}, -- Darklight heart
							[2] = {item = 43854, count = 4}, -- Tainted Heart
							[3] = {item = 29345, count = 500}, -- Blue Glass Plate
							[4] = {item = 39037, count = 250}, -- Cobalt Ridge
							[5] = {item = 39039, count = 1}, -- transmutation gem
						},
					},
				[6] = {item = "Sanguine Battleaxe", -- item name (THIS MUST BE EXACT OR IT WILL NOT WORK!)
					itemID = 43874, -- item to be made
					reqItems = { -- items and the amounts in order to craft.
							[1] = {item = 43855, count = 4}, -- Darklight heart
							[2] = {item = 43854, count = 4}, -- Tainted Heart
							[3] = {item = 29345, count = 500}, -- Blue Glass Plate
							[4] = {item = 39037, count = 250}, -- Cobalt Ridge
							[5] = {item = 39039, count = 1}, -- transmutation gem
						},
					},
				[7] = {item = "Sanguine Coil", -- item name (THIS MUST BE EXACT OR IT WILL NOT WORK!)
					itemID = 43882, -- item to be made
					reqItems = { -- items and the amounts in order to craft.
							[1] = {item = 43855, count = 4}, -- Darklight heart
							[2] = {item = 43854, count = 4}, -- Tainted Heart
							[3] = {item = 29347, count = 500}, -- Violet Glass Plate
							[4] = {item = 39037, count = 250}, -- Cobalt Ridge
							[5] = {item = 39039, count = 1}, -- transmutation gem
						},
					},
				[8] = {item = "Sanguine Rod", -- item name (THIS MUST BE EXACT OR IT WILL NOT WORK!)
					itemID = 43886, -- item to be made
					reqItems = { -- items and the amounts in order to craft.
							[1] = {item = 43855, count = 4}, -- Darklight heart
							[2] = {item = 43854, count = 4}, -- Tainted Heart
							[3] = {item = 29347, count = 500}, -- Violet Glass Plate
							[4] = {item = 39037, count = 250}, -- Cobalt Ridge
							[5] = {item = 39039, count = 1}, -- transmutation gem
						},
					},
				[9] = {item = "Sanguine Bow", -- item name (THIS MUST BE EXACT OR IT WILL NOT WORK!)
					itemID = 43877, -- item to be made
					reqItems = { -- items and the amounts in order to craft.
							[1] = {item = 43855, count = 4}, -- Darklight heart
							[2] = {item = 43854, count = 4}, -- Tainted Heart
							[3] = {item = 29346, count = 500}, -- Green Glass Plate
							[4] = {item = 39037, count = 250}, -- Cobalt Ridge
							[5] = {item = 39039, count = 1}, -- transmutation gem
						},
					},
				[10] = {item = "Sanguine Crossbow", -- item name (THIS MUST BE EXACT OR IT WILL NOT WORK!)
					itemID = 43879, -- item to be made
					reqItems = { -- items and the amounts in order to craft.
							[1] = {item = 43855, count = 4}, -- Darklight heart
							[2] = {item = 43854, count = 4}, -- Tainted Heart
							[3] = {item = 29346, count = 500}, -- Green Glass Plate
							[4] = {item = 39037, count = 250}, -- Cobalt Ridge
							[5] = {item = 39039, count = 1}, -- transmutation gem
						},
					},
				[11] = {item = "Sanguine Claws", -- item name (THIS MUST BE EXACT OR IT WILL NOT WORK!)
					itemID = 50157, -- item to be made
					reqItems = { -- items and the amounts in order to craft.
							[1] = {item = 43855, count = 4}, -- Darklight heart
							[2] = {item = 43854, count = 4}, -- Tainted Heart
							[3] = {item = 29346, count = 500}, -- Green Glass Plate
							[4] = {item = 39037, count = 250}, -- Cobalt Ridge
							[5] = {item = 39039, count = 1}, -- transmutation gem
						},
					},
				},
			},	
	[3] = {group = "Gilded Eldritch Weapons", -- This is the category can be anything.
			items = {
				[1] = {item = "Gilded Eldritch Claymore", -- item name (THIS MUST BE EXACT OR IT WILL NOT WORK!)
						itemID = 36658, -- item to be made
						reqItems = { -- items and the amounts in order to craft.
								[1] = {item = 36657, count = 2}, -- Weapon
								[2] = {item = 4061, count = 10}, -- Eldritch Fragment
								[3] = {item = 39037, count = 250}, -- Cobalt Ridge
								[4] = {item = 29345, count = 500}, -- Blue Glass Plate
								[5] = {item = 39039, count = 1}, -- transmutation gem
							},
						},
 
				[2] = {item = "Gilded Eldritch Greataxe",
						itemID = 36662,
						reqItems = {
								[1] = {item = 36661, count = 2}, -- Weapon
								[2] = {item = 4061, count = 10}, -- Eldritch Fragment
								[3] = {item = 39037, count = 250}, -- Cobalt Ridge
								[4] = {item = 29345, count = 500}, -- Blue Glass Plate
								[5] = {item = 39039, count = 1}, -- transmutation gem
							},
						},
 
				[3] = {item = "Gilded Eldritch Warmace",
						itemID = 36660,
						reqItems = {
								[1] = {item = 36659, count = 2}, -- Weapon
								[2] = {item = 4061, count = 10}, -- Eldritch Fragment
								[3] = {item = 39037, count = 250}, -- Cobalt Ridge
								[4] = {item = 29345, count = 500}, -- Blue Glass Plate
								[5] = {item = 39039, count = 1}, -- transmutation gem
						},
					},
 
				[4] = {item = "Gilded Eldritch Bow",
						itemID = 36665,
						reqItems = {
								[1] = {item = 36664, count = 2}, -- Weapon
								[2] = {item = 4061, count = 10}, -- Eldritch Fragment
								[3] = {item = 39037, count = 250}, -- Cobalt Ridge
								[4] = {item = 29346, count = 500}, -- Green Glass Plate
								[5] = {item = 39039, count = 1}, -- transmutation gem
						},
					},
 
				[5] = {item = "Gilded Eldritch Wand",
						itemID = 36669,
						reqItems = {
								[1] = {item = 36668, count = 2}, -- Weapon
								[2] = {item = 4061, count = 10}, -- Eldritch Fragment
								[3] = {item = 39037, count = 250}, -- Cobalt Ridge
								[4] = {item = 29347, count = 500}, -- Violet Glass Plate
								[5] = {item = 39039, count = 1}, -- transmutation gem
						},
					},
 
				[6] = {item = "Gilded Eldritch Rod",
						itemID = 36675,
						reqItems = {
								[1] = {item = 36674, count = 2}, -- Weapon
								[2] = {item = 4061, count = 10}, -- Eldritch Fragment
								[3] = {item = 39037, count = 250}, -- Cobalt Ridge
								[4] = {item = 29347, count = 500}, -- Violet Glass Plate
								[5] = {item = 39039, count = 1}, -- transmutation gem
						},
					},
				[7] = {item = "Gilded Eldritch Crescent Moon Spade",
						itemID = 50170,
						reqItems = {
								[1] = {item = 50169, count = 2}, -- Weapon
								[2] = {item = 4061, count = 10}, -- Eldritch Fragment
								[3] = {item = 39037, count = 250}, -- Cobalt Ridge
								[4] = {item = 29346, count = 500}, -- Green Glass Plate
								[5] = {item = 39039, count = 1}, -- transmutation gem
						},
					},
				},
			},
	[4] = {group = "Grand Sanguine Weapons", -- This is the category can be anything.
	items = {
				[1] = {item = "Grand Sanguine Battleaxe",
						itemID = 43875,
						reqItems = {
								[1] = {item = 43874, count = 2}, -- Weapon
								[2] = {item = 43855, count = 5}, -- Darklight heart
								[3] = {item = 43854, count = 5}, -- Tainted Heart
								[4] = {item = 39037, count = 500}, -- Cobalt Ridge
								[5] = {item = 39039, count = 5}, -- transmutation gem
						},
					},
		
				[2] = {item = "Grand Sanguine Blade",
						itemID = 43865,
						reqItems = {
								[1] = {item = 43864, count = 2}, -- Weapon
								[2] = {item = 43855, count = 5}, -- Darklight heart
								[3] = {item = 43854, count = 5}, -- Tainted Heart
								[4] = {item = 39037, count = 500}, -- Cobalt Ridge
								[5] = {item = 39039, count = 5}, -- transmutation gem
						},
					},

				[3] = {item = "Grand Sanguine Bludgeon",
						itemID = 43873,
						reqItems = {
								[1] = {item = 43872, count = 2}, -- Weapon
								[2] = {item = 43855, count = 5}, -- Darklight heart
								[3] = {item = 43854, count = 5}, -- Tainted Heart
								[4] = {item = 39037, count = 500}, -- Cobalt Ridge
								[5] = {item = 39039, count = 5}, -- transmutation gem
						},
					},
				[4] = {item = "Grand Sanguine Bow",
						itemID = 43878,
						reqItems = {
								[1] = {item = 43877, count = 2}, -- Weapon
								[2] = {item = 43855, count = 5}, -- Darklight heart
								[3] = {item = 43854, count = 5}, -- Tainted Heart
								[4] = {item = 39037, count = 500}, -- Cobalt Ridge
								[5] = {item = 39039, count = 5}, -- transmutation gem
						},
					},
				[5] = {item = "Grand Sanguine Coil",
						itemID = 43883,
						reqItems = {
								[1] = {item = 43882, count = 2}, -- Weapon
								[2] = {item = 43855, count = 5}, -- Darklight heart
								[3] = {item = 43854, count = 5}, -- Tainted Heart
								[4] = {item = 39037, count = 500}, -- Cobalt Ridge
								[5] = {item = 39039, count = 5}, -- transmutation gem
						},
					},
				[6] = {item = "Grand Sanguine Crossbow",
						itemID = 43880,
						reqItems = {
								[1] = {item = 43879, count = 2}, -- Weapon
								[2] = {item = 43855, count = 5}, -- Darklight heart
								[3] = {item = 43854, count = 5}, -- Tainted Heart
								[4] = {item = 39037, count = 500}, -- Cobalt Ridge
								[5] = {item = 39039, count = 5}, -- transmutation gem
						},
					},
				[7] = {item = "Grand Sanguine Cudgel",
						itemID = 43867,
						reqItems = {
								[1] = {item = 43866, count = 2}, -- Weapon
								[2] = {item = 43855, count = 5}, -- Darklight heart
								[3] = {item = 43854, count = 5}, -- Tainted Heart
								[4] = {item = 39037, count = 500}, -- Cobalt Ridge
								[5] = {item = 39039, count = 5}, -- transmutation gem
						},
					},
		

		
				[8] = {item = "Grand Sanguine Hatchet",
						itemID = 43869,
						reqItems = {
								[1] = {item = 43868, count = 2}, -- Weapon
								[2] = {item = 43855, count = 5}, -- Darklight heart
								[3] = {item = 43854, count = 5}, -- Tainted Heart
								[4] = {item = 39037, count = 500}, -- Cobalt Ridge
								[5] = {item = 39039, count = 5}, -- transmutation gem
						},
					},
				[9] = {item = "Grand Sanguine Razor", -- item name (THIS MUST BE EXACT OR IT WILL NOT WORK!)
						itemID = 43871, -- item to be made
						reqItems = { -- items and the amounts in order to craft.
								[1] = {item = 43870, count = 2}, -- Weapon
								[2] = {item = 43855, count = 5}, -- Darklight heart
								[3] = {item = 43854, count = 5}, -- Tainted Heart
								[4] = {item = 39037, count = 500}, -- Cobalt Ridge
								[5] = {item = 39039, count = 5}, -- transmutation gem
						},
					},
				[10] = {item = "Grand Sanguine Rod",
						itemID = 43886,
						reqItems = {
								[1] = {item = 43885, count = 2}, -- Weapon
								[2] = {item = 43855, count = 5}, -- Darklight heart
								[3] = {item = 43854, count = 5}, -- Tainted Heart
								[4] = {item = 39037, count = 500}, -- Cobalt Ridge
								[5] = {item = 39039, count = 5}, -- transmutation gem
						},
					},
				[11] = {item = "Grand Sanguine Claws",
						itemID = 50158,
						reqItems = {
								[1] = {item = 50157, count = 2}, -- Weapon
								[2] = {item = 43855, count = 5}, -- Darklight heart
								[3] = {item = 43854, count = 5}, -- Tainted Heart
								[4] = {item = 39037, count = 500}, -- Cobalt Ridge
								[5] = {item = 39039, count = 5}, -- transmutation gem
						},
					},

				},
			},

	[6] = {group = "Worket Set",
	items = {
				[1] = {item = "Improved Worker Helmet",
					itemID = 3226,
					reqItems = {
							[1] = {item = 11700, count = 1}, -- worker helm
							[2] = {item = 4061, count = 3}, -- eldritch fragment
							[3] = {item = 5887, count = 20}, -- piece of royal steel
							[4] = {item = 39037, count = 200}, -- cobalt ridge
							[5] = {item = 14112, count = 1}, -- bar of gold
					},
				},
				[2] = {item = "Improved Worker Shirt",
					itemID = 32585,
					reqItems = {
							[1] = {item = 32099, count = 1}, -- worker shirt
							[2] = {item = 4061, count = 5}, -- eldritch fragment
							[3] = {item = 5909, count = 100}, -- white poc
							[4] = {item = 5922, count = 200}, -- holy orchid
							[5] = {item = 39037, count = 100}, -- cobalt ridge
							[6] = {item = 14112, count = 1}, -- bar of gold
					},
				},
				[3] = {item = "Improved Worker Legs",
				itemID = 24402,
				reqItems = {
						[1] = {item = 32097, count = 1}, -- worker legs
						[2] = {item = 4061, count = 5}, -- eldritch fragment
						[3] = {item = 5911, count = 200}, -- red poc
						[4] = {item = 5948, count = 200}, -- red dragon leather
						[5] = {item = 39037, count = 100}, -- cobalt ridge
						[6] = {item = 14112, count = 1}, -- bar of gold
					},
				},
				[4] = {item = "Improved Worker Shoes",
				itemID = 32098,
				reqItems = {
						[1] = {item = 9017, count = 1}, -- worker shoes
						[2] = {item = 4061, count = 3}, -- eldritch fragment
						[3] = {item = 5878, count = 200}, -- minotaur leather
						[4] = {item = 5876, count = 200}, -- lizard leather
						[5] = {item = 39037, count = 100}, -- cobalt ridge
						[6] = {item = 14112, count = 1}, -- bar of gold
					},
				},

			},
		},


			
		},
	}
 
local simpleCraftingSystem = Action()
function simpleCraftingSystem.onUse(player, item, fromPosition, itemEx, toPosition, isHotkey)
    player:sendMainCraftWindow(config)
    return true
end

simpleCraftingSystem:aid(12347)
simpleCraftingSystem:register()