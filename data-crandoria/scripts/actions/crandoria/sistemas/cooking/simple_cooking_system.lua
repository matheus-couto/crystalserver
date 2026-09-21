local config = {
	-- Window Config
		mainTitleMsg = "Sistema de Cooking", -- Main window title
		mainMsg = "Bem vindo ao sistema de Cooking. Selecione o tipo de food que voce deseja criar:", -- Main window message
	 
		craftTitle = "Crafting System: ", -- Title of the crafting screen after player picks of group
		craftMsg = "Aqui esta a lista de todos os ingredientes para fazer ", -- Message on the crafting screen after player picks of group
	-- End Window Config
	
	-- Player Notifications Config
		needItems = "Voce nao tem todos os ingredientes para fazer ", -- This is the message the player recieves if he does not have all required items
	
	-- Crafting Config
		system = {
		[1] = {group = "Food - Skills", -- This is the category can be anything.
				items = {
					[1] = {item = "Carrot Cake", -- item name (THIS MUST BE EXACT OR IT WILL NOT WORK!)
							itemID = 9087, -- item to be made
							reqItems = { -- items and the amounts in order to craft.
									[1] = {item = 25692, count = 10}, -- Fresh Fruits
									[2] = {item = 11682, count = 2}, -- Dragonfruit
									[3] = {item = 32198, count = 2}, -- Leite
									[4] = {item = 36722, count = 3}, -- Firewood
									[5] = {item = 3595, count = 5}, -- Carrots
								},
							},
	 
					[2] = {item = "Carrot Pie",
							itemID = 29409,
							reqItems = {
									[1] = {item = 25692, count = 6}, -- Fresh Fruits
									[2] = {item = 11682, count = 1}, -- Dragonfruit
									[3] = {item = 32198, count = 1}, -- Leite
									[4] = {item = 36722, count = 5}, -- Firewood
									[5] = {item = 3595, count = 5}, -- Carrots
								},
							},
					[3] = {item = "Delicatessen Salad",
							itemID = 29411,
							reqItems = {
									[1] = {item = 25692, count = 3}, -- Fresh Fruits
									[2] = {item = 11459, count = 1}, -- Pineapple
									[3] = {item = 32045, count = 2}, -- Tiny Bass
									[4] = {item = 31982, count = 1}, -- Rare Mushroom
									[5] = {item = 36722, count = 1}, -- Firewood
								},
							},
					[4] = {item = "Demonic Candy Ball",
							itemID = 11587,
							reqItems = {
									[1] = {item = 11459, count = 5}, -- Pineapple
									[2] = {item = 11682, count = 3}, -- Dragonfruits
									[3] = {item = 31982, count = 3}, -- Rare Mushroom
									[4] = {item = 32198, count = 1}, -- Leite
									[5] = {item = 36722, count = 2}, -- Firewood
									[6] = {item = 6499, count = 3}, -- Firewood
							},
						},
	 
					[5] = {item = "Lemon Cupcake",
							itemID = 28486,
							reqItems = {
									[1] = {item = 25692, count = 5}, -- Fresh Fruits
									[2] = {item = 11459, count = 2}, -- Pineapple
									[3] = {item = 32198, count = 3}, -- Leite
									[4] = {item = 36722, count = 3}, -- Firewood
									[5] = {item = 8013, count = 3}, -- Lemon
							},
						},
	 
					[6] = {item = "Northern Fishburger",
							itemID = 9088,
							reqItems = {
									[1] = {item = 11682, count = 3}, -- Dragonfruits
									[2] = {item = 12252, count = 5}, -- Winterberries
									[3] = {item = 32045, count = 20}, -- Tiny Bass
									[4] = {item = 32044, count = 10}, -- Small bass
									[5] = {item = 31982, count = 3}, -- Rare Mushroom
									[6] = {item = 36722, count = 3}, -- Firewood
									[7] = {item = 3600, count = 2}, -- Bread
							},
						},
					[7] = {item = "Roasted Dragon Wings",
							itemID = 9081,
							reqItems = {
									[1] = {item = 11682, count = 3}, -- Dragonfruits
									[2] = {item = 12252, count = 2}, -- Winterberries
									[3] = {item = 31982, count = 3}, -- Rare Mushroom
									[4] = {item = 36722, count = 3}, -- Firewood
									[5] = {item = 3583, count = 5}, -- Dragon Ham
							},
						},
					[8] = {item = "Roasted Wyvern Wings",
							itemID = 29408,
							reqItems = {
									[1] = {item = 11459, count = 2}, -- Pineapple
									[2] = {item = 11682, count = 2}, -- Dragonfruits
									[3] = {item = 12252, count = 1}, -- Winterberries
									[4] = {item = 31982, count = 3}, -- Rare Mushroom
									[5] = {item = 36722, count = 2}, -- Firewood
									[6] = {item = 3583, count = 5}, -- Dragon Ham
							},
						},
					[9] = {item = "Svargrond Salmon Filet",
							itemID = 29413,
							reqItems = {
									[1] = {item = 11459, count = 5}, -- Pineapple
									[2] = {item = 11682, count = 3}, -- Dragonfruits
									[3] = {item = 32045, count = 15}, -- Tiny Bass
									[4] = {item = 32044, count = 8}, -- Small bass
									[5] = {item = 31982, count = 5}, -- Rare Mushroom
									[6] = {item = 36722, count = 3}, -- Firewood
							},
						},
					[10] = {item = "Tropical Fried Terrorbird",
							itemID = 9082,
							reqItems = {
									[1] = {item = 25692, count = 5}, -- Fresh Fruits
									[2] = {item = 11459, count = 3}, -- Pineapple
									[3] = {item = 11682, count = 2}, -- Dragonfruits
									[4] = {item = 31982, count = 2}, -- Rare Mushroom
									[5] = {item = 32198, count = 1}, -- Leite
									[6] = {item = 36722, count = 3}, -- Firewood
									[7] = {item = 10273, count = 3}, -- Terrorbird Beak
							},
						},
					[11] = {item = "Tropical Marinated Tiger",
							itemID = 29410,
							reqItems = {
									[1] = {item = 11459, count = 5}, -- Pineapple
									[2] = {item = 11682, count = 2}, -- Dragonfruits
									[3] = {item = 31982, count = 2}, -- Rare Mushroom
									[4] = {item = 36722, count = 2}, -- Firewood
									[5] = {item = 3583, count = 5}, -- Dragon Ham
							},
						},
					[12] = {item = "Veggie Casserole",
							itemID = 9084,
							reqItems = {
									[1] = {item = 25692, count = 5}, -- Fresh Fruits
									[2] = {item = 11459, count = 2}, -- Pineapple
									[3] = {item = 11682, count = 1}, -- Dragonfruits
									[4] = {item = 31982, count = 1}, -- Rare Mushroom
									[6] = {item = 36722, count = 3}, -- Firewood
									[7] = {item = 3584, count = 2}, -- Pear
							},
						},
					[12] = {item = "Zaoan Sauce",
							itemID = 50334,
							reqItems = {
									[1] = {item = 11459, count = 5}, -- Pineapple
									[2] = {item = 11682, count = 2}, -- Dragonfruits
									[3] = {item = 31982, count = 2}, -- Rare Mushroom
									[4] = {item = 32198, count = 1}, -- Leite
									[5] = {item = 36722, count = 3}, -- Firewood
									[6] = {item = 3583, count = 5}, -- Dragon Ham
							},
						},

					},
				},
	 
		[2] = {group= "Food - Curas, Buffs e Regen",
				items = {
					[1] = {item = "Blessed Steak",
							itemID = 9086,
							reqItems = {
								[1] = {item = 11682, count = 5}, -- Dragonfruits
								[2] = {item = 12252, count = 1}, -- Winterberries
								[3] = {item = 31982, count = 2}, -- Rare Mushroom
								[4] = {item = 36722, count = 3}, -- Firewood
								[5] = {item = 3583, count = 2}, -- Dragon Ham
							},
						},
	 
					[2] = {item = "Blueberry Cupcake",
							itemID = 28484,
							reqItems = {
								[1] = {item = 25692, count = 10}, -- Fresh Fruits
								[2] = {item = 11459, count = 2}, -- Pineapple
								[3] = {item = 12252, count = 2}, -- Winterberries
								[4] = {item = 31982, count = 1}, -- Rare Mushroom
								[6] = {item = 36722, count = 3}, -- Firewood
							},
						},
	 
					[3] = {item = "Carrion Casserole",
							itemID = 29414,
							reqItems = {
								[1] = {item = 25692, count = 3}, -- Fresh Fruits
								[2] = {item = 11459, count = 2}, -- Pineapple
								[3] = {item = 31982, count = 2}, -- Rare Mushroom
								[4] = {item = 36722, count = 1}, -- Firewood
								[5] = {item = 3583, count = 4}, -- Dragon Ham
							},
						},
	 
					[4] = {item = "Chilli con Carniphila",
							itemID = 29412,
							reqItems = {
								[1] = {item = 25692, count = 5}, -- Fresh Fruits
								[2] = {item = 32045, count = 3}, -- Tiny Bass
								[3] = {item = 31982, count = 1}, -- Rare Mushroom
								[4] = {item = 36722, count = 1}, -- Firewood
								[5] = {item = 8016, count = 5}, -- Pepers
							},
						},
	 
					[5] = {item = "Consecrated Beef",
							itemID = 29415,
							reqItems = {
								[1] = {item = 11459, count = 3}, -- Pineapple
								[2] = {item = 11682, count = 2}, -- Dragonfruits
								[3] = {item = 31982, count = 2}, -- Rare Mushroom
								[4] = {item = 36722, count = 1}, -- Firewood
								[5] = {item = 3583, count = 10}, -- Dragon Ham
							},
						},
					[6] = {item = "Filled Jalapeno Peppers",
							itemID = 9085,
							reqItems = {
								[1] = {item = 11459, count = 2}, -- Pineapple
								[2] = {item = 32045, count = 3}, -- Tiny Bass
								[3] = {item = 31982, count = 1}, -- Rare Mushroom
								[4] = {item = 36722, count = 1}, -- Firewood
								[5] = {item = 8016, count = 10}, -- Pepers
							},
						},
					[7] = {item = "Hydra Tongue Salad",
							itemID = 9080,
							reqItems = {
								[1] = {item = 25692, count = 5}, -- Fresh Fruits
								[2] = {item = 11459, count = 2}, -- Pineapple
								[3] = {item = 11682, count = 1}, -- Dragonfruits
								[4] = {item = 31982, count = 1}, -- Rare Mushroom
								[5] = {item = 36722, count = 2}, -- Firewood
								[6] = {item = 7250, count = 2}, -- Hydra Tongue
							},
						},
					[8] = {item = "Pot of Blackjack",
							itemID = 11586,
							reqItems = {
								[1] = {item = 25692, count = 3}, -- Fresh Fruits
								[2] = {item = 11459, count = 2}, -- Pineapple
								[3] = {item = 11682, count = 1}, -- Dragonfruits
								[4] = {item = 32044, count = 2}, -- Small bass
								[5] = {item = 31982, count = 1}, -- Rare Mushroom
								[6] = {item = 36722, count = 2}, -- Firewood
								[7] = {item = 28568, count = 2}, -- Inkwell black
							},
						},
					[9] = {item = "Rotworm Stew",
							itemID = 9079,
							reqItems = {
								[1] = {item = 25692, count = 5}, -- Fresh Fruits
								[2] = {item = 11682, count = 3}, -- Dragonfruits
								[3] = {item = 32045, count = 2}, -- Tiny bass
								[4] = {item = 31982, count = 5}, -- Rare Mushroom
								[5] = {item = 32198, count = 2}, -- Leite
								[6] = {item = 36722, count = 3}, -- Firewood
								[7] = {item = 3582, count = 10}, -- Ham
							},
						},
					[10] = {item = "Strawberry Cupcake",
							itemID = 28485,
							reqItems = {
								[1] = {item = 25692, count = 10}, -- Fresh Fruits
								[2] = {item = 11459, count = 2}, -- Pineapple
								[3] = {item = 12252, count = 1}, -- Winterberries
								[4] = {item = 31982, count = 1}, -- Rare Mushroom
								[5] = {item = 32198, count = 2}, -- Leite
								[6] = {item = 36722, count = 2}, -- Firewood
								[7] = {item = 3591, count = 5}, -- Ham
							},
						},
					[11] = {item = "Sweet Mangonaise Elixir",
							itemID = 11588,
							reqItems = {
								[1] = {item = 12252, count = 3}, -- Winterberries
								[2] = {item = 31982, count = 3}, -- Rare Mushroom
								[3] = {item = 32198, count = 5}, -- Leite
								[4] = {item = 36722, count = 2}, -- Firewood
								[5] = {item = 3606, count = 5}, -- Egg

							},
						},
					},
				},
			},
		}
	
	local simpleCraftingSystem = Action()
	function simpleCraftingSystem.onUse(player, item, fromPosition, itemEx, toPosition, isHotkey)
		if player:getStorageValue(Storage.Quest.Crandoria.SkillsColeta.CultivoLevel) >= 50 then
			player:sendMainCraftWindow(config)
			return true
		else
			player:sendTextMessage(MESSAGE_EVENT_DEFAULT, "Apenas jogadores com skill 50 ou superior em Cultivo podem utilizar o Sistema de Cooking.")
            return true
		end
	end
	
	simpleCraftingSystem:aid(13160)
	simpleCraftingSystem:register()



