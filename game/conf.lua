game.conf = {
	minions = {
		size = 14,
		unstuckMoveBy = 5,
		presets = {
			homunculus = {
				presetId = "homunculus",
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
				presetId = "zombie",
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
				presetId = "zombie",
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
				presetId = "guard",
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

	level_sequence_old = {
		"game/levels/level1.json", -- for testing
		"game/levels/01_summoning.json",
		"game/levels/02_interaction.json",
		"game/levels/03_different_speeds.json",
		"game/levels/04_yournamehere.json",
		"game/levels/05_you_can_die.json",
		"game/levels/06_sacrifice.json",
		"game/levels/07_you_can_fly.json",
		"game/levels/08_dont_fly_too_high.json",
		"game/levels/09_fae_in_the_middle.json",
		"game/levels/10_race.json",
		"game/levels/11_fly_ahead.json",
		"game/levels/12_locked_in.json",
		"game/levels/13_zombie_prison.json",
		"game/levels/lever_coordination.json",
	},
	level_sequence = {
		{
			filename = "game/levels/level1.json",
			title = "testing stage",
			minions = {
				homunculus = 2,
				zombie = 2,
				fae = 2,
				guard = 2,
			},
		},
		{
			filename = "game/levels/01_summoning.json",
			title = "Summon Me",
			minions = {
				homunculus = 3,
				zombie = 0,
				fae = 0,
				guard = 0,
			},
		},
		{
			filename = "game/levels/02_interaction.json",
			title = "Interaction",
			minions = {
				homunculus = 2,
				zombie = 0,
				fae = 0,
				guard = 0,
			},
		},
		{
			filename = "game/levels/03_different_speeds.json",
			title = "Different Speeds",
			minions = {
				homunculus = 1,
				zombie = 1,
				fae = 0,
				guard = 0,
			},
		},
		{
			filename = "game/levels/04_yournamehere.json",
			title = "Your Name Here",
			minions = {
				homunculus = 1,
				zombie = 1,
				fae = 0,
				guard = 0,
			},
		},
		{
			filename = "game/levels/05_you_can_die.json",
			title = "You Can Die",
			minions = {
				homunculus = 1,
				zombie = 2,
				fae = 0,
				guard = 0,
			},
		},
		{
			filename = "game/levels/06_sacrifice.json",
			title = "Sacrifice",
			minions = {
				homunculus = 1,
				zombie = 0,
				fae = 0,
				guard = 0,
			},
		},
		{
			filename = "game/levels/07_you_can_fly.json",
			title = "You Can Fly",
			minions = {
				homunculus = 1,
				zombie = 0,
				fae = 1,
				guard = 0,
			},
		},
		{
			filename = "game/levels/08_dont_fly_too_high.json",
			title = "Don't Fly Too High",
			minions = {
				homunculus = 1,
				zombie = 1,
				fae = 1,
				guard = 0,
			},
		},
		{
			filename = "game/levels/09_fae_in_the_middle.json",
			title = "Fae in the Middle",
			minions = {
				homunculus = 2,
				zombie = 2,
				fae = 1,
				guard = 0,
			},
		},
		{
			filename = "game/levels/10_race.json",
			title = "Race",
			minions = {
				homunculus = 1,
				zombie = 2,
				fae = 0,
				guard = 0,
			},
		},
		{
			filename = "game/levels/11_fly_ahead.json",
			title = "Fly Ahead",
			minions = {
				homunculus = 1,
				zombie = 0,
				fae = 1,
				guard = 0,
			},
		},
		{
			filename = "game/levels/12_locked_in.json",
			title = "Locked In",
			minions = {
				homunculus = 1,
				zombie = 1,
				fae = 1,
				guard = 0,
			},
		},
		{
			filename = "game/levels/13_zombie_prison.json",
			title = "Zombie Prison",
			minions = {
				homunculus = 1,
				zombie = 3,
				fae = 0,
				guard = 0,
			},
		},
		{
			filename = "game/levels/lever_coordination.json",
			title = "Lever Coordination",
			minions = {
				homunculus = 2,
				zombie = 0,
				fae = 0,
				guard = 0,
			},
		},
	},
	level_minions = {
		{ -- testing stage
			homunculus = 2,
			zombie = 2,
			fae = 2,
			guard = 2,
		},
		{ -- 01_summoning
			homunculus = 3,
			zombie = 0,
			fae = 0,
			guard = 0,
		},
		{ -- 02_interaction
			homunculus = 2,
			zombie = 0,
			fae = 0,
			guard = 0,
		},
		{ -- 03_different_speeds
			homunculus = 1,
			zombie = 1,
			fae = 0,
			guard = 0,
		},
		{ -- 04_yournamehere
			homunculus = 1,
			zombie = 1,
			fae = 0,
			guard = 0,
		},
		{ -- 05_you_can_die
			homunculus = 1,
			zombie = 2,
			fae = 0,
			guard = 0,
		},
		{ -- 06_sacrifice
			homunculus = 1,
			zombie = 0,
			fae = 0,
			guard = 0,
		},
		{ -- 07_you_can_fly
			homunculus = 1,
			zombie = 0,
			fae = 1,
			guard = 0,
		},
		{ -- 08_dont_fly_too_high
			homunculus = 1,
			zombie = 1,
			fae = 1,
			guard = 0,
		},
		{ -- 09_fae_in_the_middle
			homunculus = 2,
			zombie = 2,
			fae = 1,
			guard = 0,
		},
		{ -- 10_race
			homunculus = 1,
			zombie = 2,
			fae = 0,
			guard = 0,
		},
		{ -- 11_fly_ahead
			homunculus = 1,
			zombie = 0,
			fae = 1,
			guard = 0,
		},
		{ -- 12_locked_in
			homunculus = 1,
			zombie = 1,
			fae = 1,
			guard = 0,
		},
		{ -- 13_zombie_prison
			homunculus = 1,
			zombie = 3,
			fae = 0,
			guard = 0,
		},
		{ -- lever coordination
			homunculus = 2,
			zombie = 0,
			fae = 0,
			guard = 0,
		},
		--{ -- zz_quintet
		--	homunculus = 2,
		--	zombie = 3,
		--	fae = 0,
		--	guard = 0,
		--},
	},

	ui = {
		summoning = {
			rowWidth = 430,
			rowHeight = 50,
			titleHeight = 40,
			border = 5,
			menuTitle = "Summon Me",
		},
		intro = {
			containerWidth = 800,
			containerHeight = 500,
			border = 5,
			titleHeight = 50,
			footerHeight = 35,
			textHeight = 20,
		},
		menu = {
			containerHeight = 790,
			rowWidth = 450,
			rowHeight = 40,
			titleHeight = 70,
			border = 5,
		},
		keyboard_control_widget = {
			buttonSize = 78,
			keyTextSize = 30,
			descTextSize = 13,
			gap = { x = 8, y = 5 },
			indent = 18,
			padding = { x = 3, y = 1 },
			fgColor = { 1, 1, 1 },
			fgColorLight = { 0.6, 0.6, 0.6 },
			bgColor = { 0, 0, 1, 0.4 },
		},
	},

	editor = true,
}
