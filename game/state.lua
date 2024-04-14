game.state = {
	--- whether most game systems are currently active
	isActive = false,

	intro = {},
	minions = {},
	summoning = {},
	gui = nil,
	level = {
		current = 1,
		map = {},
		standingOn = {},
	},
}
