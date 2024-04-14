game.conf = {
	minions = {
		size = 14,
		presets = {
			homunculus = {
				name = "Homunculus",
				moveSpeed = 120,
				color = { 255, 203, 164 },
				canStepOn = true,
				canInteract = true,
				movementType = "walking",
				canFight = false,
				canFinish = true,
			},
			zombie = {
				name = "Zombie",
				moveSpeed = 80,
				color = { 139, 139, 100 },
				canStepOn = true,
				canInteract = false,
				movementType = "walking",
				canFight = false,
				canFinish = false,
			},
			fae = {
				name = "Fae",
				moveSpeed = 120,
				color = { 0, 255, 255 },
				canStepOn = false,
				canInteract = true,
				movementType = "flying",
				canFight = false,
				canFinish = false,
			},
			guard = {
				name = "Guard",
				moveSpeed = 120,
				color = { 203, 205, 205 },
				canStepOn = true,
				canInteract = false,
				movementType = "walking",
				canFight = true,
				canFinish = false,
			},
		},
	},

	level = {
		tileSize = 32,
		width = 45,
		height = 30,
	},

	level_sequence = {
		"game/levels/03_different_speeds.json",
		"game/levels/level2.json",
		"game/levels/level3.json",
		"game/levels/level4.json",
	},
	level_minions = {
		{
			homunculus = 1,
			zombie = 1,
			fae = 0,
			guard = 0,
		},
		{
			homunculus = 2,
			zombie = 0,
			fae = 0,
			guard = 0,
		},
		{
			homunculus = 1,
			zombie = 1,
			fae = 0,
			guard = 0,
		},
		{
			homunculus = 1,
			zombie = 1,
			fae = 0,
			guard = 0,
		},
	},

	ui = {
		summoning = {
			rowWidth = 430,
			rowHeight = 50,
			titleHeight = 40,
			border = 5,
			menuTitle = "Summon Me",
		},
	},

	editor = true,
}
