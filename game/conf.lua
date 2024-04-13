game.conf = {
	minions = {
		presets = {
			homunculus = {
				name = "Homunculus",
				moveSpeed = 120,
				color = { 255, 203, 164 },
				canStepOn = true,
				canInteract = true,
			},
			zombie = {
				name = "Zombie",
				moveSpeed = 80,
				color = { 139, 139, 100 },
				canStepOn = true,
				canInteract = false,
			},
		},
	},

	level = {
		tileSize = 32,
		width = 20,
		height = 15,
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
}
