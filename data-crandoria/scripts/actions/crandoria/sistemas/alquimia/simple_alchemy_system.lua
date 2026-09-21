local config = {
	-- Window Config
		mainTitleMsg = "Crafting System", -- Main window title
		mainMsg = "Welcome to the crafting system. Please choose a group to begin.", -- Main window message
	 
		craftTitle = "Crafting System: ", -- Title of the crafting screen after player picks of group
		craftMsg = "Here is a list of all items that can be crafted for the ", -- Message on the crafting screen after player picks of group
	-- End Window Config
	 
	-- Player Notifications Config
		needItems = "You do not have all the required items to make ", -- This is the message the player recieves if he does not have all required items
	 
	-- Crafting Config
		system = {
		[1] = {group = "Buff Potions", -- This is the category can be anything.
				items = {
					[1] = {item = "Kooldown-aid", -- item name (THIS MUST BE EXACT OR IT WILL NOT WORK!)
							itemID = 36723, -- item to be made
							reqItems = { -- items and the amounts in order to craft.
									[1] = {item = 11682, count = 3}, -- Dragonfruit
									[2] = {item = 11459, count = 10}, -- Pineapple
									[3] = {item = 25692, count = 20}, -- Fresh Fruits
									[4] = {item = 29347, count = 5}, -- Violet Glass
								},
							},
	 
					[2] = {item = "Strike Enhancement",
							itemID = 36724,
							reqItems = {
									[1] = {item = 11682, count = 3}, -- Dragonfruit
									[2] = {item = 11459, count = 10}, -- Pineapple
									[3] = {item = 25692, count = 20}, -- Fresh Fruits
									[4] = {item = 29346, count = 5}, -- Green Glass
								},
							},
	 
					[3] = {item = "Stamina Extension",
							itemID = 36725,
							reqItems = {
									[1] = {item = 11682, count = 5}, -- Dragonfruit
									[2] = {item = 11459, count = 15}, -- Pineapple
									[3] = {item = 25692, count = 30}, -- Fresh Fruits
									[4] = {item = 29345, count = 10}, -- blue Glass
							},
						},
	 
					[4] = {item = "Charm Upgrade",
							itemID = 36726,
							reqItems = {
									[1] = {item = 11682, count = 10}, -- Dragonfruit
									[2] = {item = 11459, count = 15}, -- Pineapple
									[3] = {item = 25692, count = 30}, -- Fresh Fruits
									[4] = {item = 29347, count = 10}, -- Violet Glass
							},
						},
	 
					[5] = {item = "Wealth Duplex",
							itemID = 36727,
							reqItems = {
									[1] = {item = 11682, count = 10}, -- Dragonfruit
									[2] = {item = 11459, count = 15}, -- Pineapple
									[3] = {item = 25692, count = 30}, -- Fresh Fruits
									[4] = {item = 29346, count = 10}, -- Green Glass
							},
						},
	 
					[6] = {item = "Bestiary Betterment",
							itemID = 36728,
							reqItems = {
									[1] = {item = 11682, count = 10}, -- Dragonfruit
									[2] = {item = 11459, count = 15}, -- Pineapple
									[3] = {item = 25692, count = 30}, -- Fresh Fruits
									[4] = {item = 29345, count = 10}, -- Blue Glass
							},
						},
					},
				},
	 
		[2] = {group= "Deffensive Potions",
				items = {
					[1] = {item = "Fire Resilience",
							itemID = 36729,
							reqItems = {
									[1] = {item = 11682, count = 2}, -- Dragonfruit
									[2] = {item = 11459, count = 5}, -- Pineapple
									[3] = {item = 8016, count = 20}, -- Pepper
									[4] = {item = 29347, count = 3}, -- Violet Glas
							},
						},
	 
					[2] = {item = "Ice Resilience",
							itemID = 36730,
							reqItems = {
									[1] = {item = 11682, count = 2}, -- Dragonfruit
									[2] = {item = 11459, count = 5}, -- Pineapple
									[3] = {item = 9648, count = 20}, -- Frosty ear
									[4] = {item = 29345, count = 3}, -- Blue Glas
							},
						},
	 
					[3] = {item = "Earth Resilience",
							itemID = 36731,
							reqItems = {
									[1] = {item = 11682, count = 2}, -- Dragonfruit
									[2] = {item = 11459, count = 5}, -- Pineapple
									[3] = {item = 10305, count = 20}, -- Lump of Earth
									[4] = {item = 29346, count = 3}, -- Green Glas
							},
						},
	 
					[4] = {item = "Energy Resilience",
							itemID = 36732,
							reqItems = {
									[1] = {item = 11682, count = 2}, -- Dragonfruit
									[2] = {item = 11459, count = 5}, -- Pineapple
									[3] = {item = 3033, count = 10}, -- Small Amethtyst
									[4] = {item = 29347, count = 3}, -- Violet Glas
							},
						},
	 
					[5] = {item = "Holy Resilience",
							itemID = 36733,
							reqItems = {
									[1] = {item = 11682, count = 2}, -- Dragonfruit
									[2] = {item = 11459, count = 5}, -- Pineapple
									[3] = {item = 5922, count = 5}, -- Holy Orchid
									[4] = {item = 29346, count = 3}, -- Green Glas
							},
						},
					[6] = {item = "Deaeth Resilience",
							itemID = 36734,
							reqItems = {
									[1] = {item = 11682, count = 2}, -- Dragonfruit
									[2] = {item = 11459, count = 5}, -- Pineapple
									[3] = {item = 6499, count = 50}, -- Demonic Essence
									[4] = {item = 29347, count = 3}, -- Violet Glas
							},
						},
					[7] = {item = "Physical Resilience",
							itemID = 36735,
							reqItems = {
									[1] = {item = 11682, count = 2}, -- Dragonfruit
									[2] = {item = 11459, count = 5}, -- Pineapple
									[3] = {item = 11447, count = 20}, -- Battle Stone
									[4] = {item = 29345, count = 3}, -- Blue Glas
							},
						},
					},
				},
	 
			[3] = {group = "Offensive Potions", 
				items = {
					[1] = {item = "Fire Amplification",
							itemID = 36736,
							reqItems = {
									[1] = {item = 11682, count = 3}, -- Dragonfruit
									[2] = {item = 11459, count = 5}, -- Pineapple
									[3] = {item = 8016, count = 20}, -- Pepper
									[4] = {item = 29347, count = 3}, -- Violet Glas
							},
						},
	 
					[2] = {item = "Ice Amplification",
							itemID = 36737,
							reqItems = {
									[1] = {item = 11682, count = 3}, -- Dragonfruit
									[2] = {item = 11459, count = 5}, -- Pineapple
									[3] = {item = 9648, count = 20}, -- Frosty ear
									[4] = {item = 29345, count = 3}, -- Blue Glas
							},
						},
	 
					[3] = {item = "Earth Amplification",
							itemID = 36738,
							reqItems = {
									[1] = {item = 11682, count = 3}, -- Dragonfruit
									[2] = {item = 11459, count = 5}, -- Pineapple
									[3] = {item = 10305, count = 20}, -- Lump of Earth
									[4] = {item = 29346, count = 3}, -- Green Glas
							},
						},
	 
					[4] = {item = "Energy Amplification",
							itemID = 36739,
							reqItems = {
									[1] = {item = 11682, count = 3}, -- Dragonfruit
									[2] = {item = 11459, count = 5}, -- Pineapple
									[3] = {item = 3033, count = 10}, -- Small Amethtyst
									[4] = {item = 29347, count = 3}, -- Violet Glas
							},
						},
	 
					[5] = {item = "Holy Amplification",
							itemID = 36740,
							reqItems = {
									[1] = {item = 11682, count = 3}, -- Dragonfruit
									[2] = {item = 11459, count = 5}, -- Pineapple
									[3] = {item = 5922, count = 5}, -- Holy Orchid
									[4] = {item = 29346, count = 3}, -- Green Glas
							},
						},
					[6] = {item = "Death Amplification",
							itemID = 36741,
							reqItems = {
									[1] = {item = 11682, count = 3}, -- Dragonfruit
									[2] = {item = 11459, count = 5}, -- Pineapple
									[3] = {item = 6499, count = 50}, -- Demonic Essence
									[4] = {item = 29347, count = 3}, -- Violet Glas
							},
						},
					[7] = {item = "Physical Amplification",
							itemID = 36742,
							reqItems = {
									[1] = {item = 11682, count = 3}, -- Dragonfruit
									[2] = {item = 11459, count = 5}, -- Pineapple
									[3] = {item = 11447, count = 20}, -- Battle Stone
									[3] = {item = 29345, count = 3}, -- Blue Glas
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
	
	simpleCraftingSystem:aid(12348)
	simpleCraftingSystem:register()


