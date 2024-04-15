game.conf = {
	minions = {
		size = 14,
		unstuckMoveBy = 5,
		idleTime = 1,
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
				assets = {
					"assets/minions/homunculus.png",
					"assets/minions/homunculus_01.png",
				},
				deathSounds = {
					"assets/sfx/Garry_Tot_1.mp3",
					"assets/sfx/Garry_tot_2.mp3",
					"assets/sfx/Garry_tot_3.mp3",
					"assets/sfx/Garry_tot_4.mp3",
				},
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
				assets = {
					"assets/minions/zombie.png",
					"assets/minions/zombie_01.png",
				},
				deathSounds = {
					"assets/sfx/Zombie_tot_1.mp3",
					"assets/sfx/Zombie_tot_2.mp3",
					"assets/sfx/Zombie_tot_3.mp3",
				},
			},
			fae = {
				presetId = "fae",
				name = "Fae",
				moveSpeed = 120,
				color = { 0, 255, 255 },
				canStepOn = false,
				canInteract = true,
				movementType = "flying",
				canFight = false,
				canFinish = false,
				assets = {
					"assets/minions/fae.png",
					"assets/minions/fae_01.png",
				},
				deathSounds = {},
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
				assets = {
					"assets/minions/fae.png",
					"assets/minions/fae_01.png",
				},
				deathSounds = {},
			},
		},
	},

	level = {
		tileSize = 32,
		width = 35,
		height = 20,
		--width = 45,
		--height = 30,
	},

	level_sequence = {
		--{
		--	filename = "game/levels/level1.json",
		--	title = "testing stage",
		--	minions = {
		--		homunculus = 2,
		--		zombie = 2,
		--		fae = 2,
		--		guard = 2,
		--	},
		--},
		{
			filename = "game/levels/01_summoning.json",
			title = "Welcome to the Game",
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
			filename = "game/levels/04_zombies_are_stupid.json",
			title = "Zombies Are Stupid",
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
		{
			filename = "game/levels/mines.json",
			title = "Mines",
			minions = {
				homunculus = 2,
				zombie = 0,
				fae = 0,
				guard = 0,
			},
		},
		{
			filename = "game/levels/killing_undead.json",
			title = "Killing Undead",
			minions = {
				homunculus = 1,
				zombie = 1,
				fae = 0,
				guard = 0,
			},
		},
		{
			filename = "game/levels/locked_in_again.json",
			title = "Locked In (Again?)",
			minions = {
				homunculus = 1,
				zombie = 1,
				fae = 1,
				guard = 0,
			},
		},
		{
			filename = "game/levels/99_end.json",
			title = "The End",
			minions = {
				homunculus = 0,
				zombie = 0,
				fae = 0,
				guard = 0,
			},
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
		intro = {
			containerWidth = 800,
			containerHeight = 500,
			border = 5,
			titleHeight = 50,
			footerHeight = 35,
			textHeight = 20,
		},
		menu = {
			containerHeight = 850,
			rowWidth = 550,
			rowHeight = 40,
			titleHeight = 70,
			border = 5,
		},
		end_screen = {
			containerHeight = 450,
			containerWidth = 1100,
			titleHeight = 70,
			textHeight = 35,
			border = 5,
			topMargin = 45,
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
