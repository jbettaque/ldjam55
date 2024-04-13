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
				canFly = false,
				canFight = false,
				canFinish = true,
			},
			zombie = {
				name = "Zombie",
				moveSpeed = 80,
				color = { 139, 139, 100 },
				canStepOn = true,
				canInteract = false,
				canFly = false,
				canFight = false,
				canFinish = false,
			},
			fae = {
				name = "Fae",
				moveSpeed = 120,
				color = { 0, 255, 255 },
				canStepOn = false,
				canInteract = true,
				canFly = true,
				canFight = false,
				canFinish = false,
			},
			guard = {
				name = "Guard",
				moveSpeed = 120,
				color = { 203, 205, 205 },
				canStepOn = true,
				canInteract = false,
				canFly = false,
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
		"game/levels/level1.json",
		"game/levels/level2.json",
		"game/levels/level3.json",
		"game/levels/level4.json",
	},

	ui = {
		summoning = {
			rowWidth = 300,
			rowHeight = 50,
			titleHeight = 40,
			border = 5,
			menuTitle = "Summon Me",
		},
	},

	editor = true,
}
