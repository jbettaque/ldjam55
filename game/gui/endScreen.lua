game.gui.endScreen = {}

local CONF = game.conf.ui.end_screen

--- callback when a key is pressed on the keyboard
function game.gui.endScreen.keypressed(key, scancode, isrepeat)
	if scancode == "backspace" then
		love.event.push("quit")
	end
end

--- callback for when this gui should be drawn
function game.gui.endScreen.draw()
	local x1 = love.graphics.getWidth() / 2 - CONF.containerWidth / 2
	local y1 = CONF.topMargin

	-- Draw Menu Frame
	love.graphics.setColor(1, 1, 1)
	love.graphics.rectangle(
		"fill",
		x1 - CONF.border,
		y1 - CONF.border,
		CONF.containerWidth + CONF.border * 2,
		CONF.containerHeight + CONF.border * 2
	)
	love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle("fill", x1, y1, CONF.containerWidth, CONF.containerHeight)

	-- Draw Title
	love.graphics.setColor(1, 1, 1)
	love.graphics.setNewFont(CONF.titleHeight * 0.8)
	love.graphics.printf(
		"Congrats! You beat the Game!",
		x1 + CONF.border,
		y1,
		CONF.containerWidth - CONF.border * 2,
		"center"
	)
	love.graphics.line(
		x1,
		y1 + CONF.border + CONF.titleHeight,
		x1 + CONF.containerWidth,
		y1 + CONF.border + CONF.titleHeight
	)

	-- Draw Credits
	love.graphics.setNewFont(CONF.textHeight * 0.8)
	love.graphics.printf({
		-- general text
		{ 1, 1, 1 },
		"We hope you had lots of fun. We at least did while making this game.\n\nCredits go to:\n",
		-- finn
		{ 1, 1, 1 },
		"· ",
		{ 0.36, 0.8, 0.98 },
		"f",
		{ 0.96, 0.66, 0.72 },
		"t",
		{ 1, 1, 1 },
		"se",
		{ 0.96, 0.66, 0.72 },
		"l",
		{ 0.36, 0.8, 0.98 },
		"l",
		{ 0.6, 0.6, 0.6 },
		" (find me at ",
		{ 0, 0.4, 0.6 },
		"https://ftsell.de",
		{ 0.6, 0.6, 0.6 },
		")\n",
		-- jo
		{ 1, 1, 1 },
		"· Jo\n",
		-- ole
		{ 1, 1, 1 },
		"· Ole\n",
		-- philip
		{ 1, 1, 1 },
		"· Philip\n",
		-- vic
		{ 1, 1, 1 },
		"· Vic",
		{ 0.6, 0.6, 0.6 },
		" (find me at ",
		{ 0, 0.4, 0.6 },
		"https://www.vicwrobel.de/",
		{ 0.6, 0.6, 0.6 },
		")\n",
	}, x1 + CONF.border, y1 + 2 * CONF.border + CONF.titleHeight, CONF.containerWidth - 2 * CONF.border, "left")

	-- Draw closing remarks
	love.graphics.line(
		x1,
		y1 + CONF.containerHeight - 2 * CONF.border - CONF.textHeight,
		x1 + CONF.containerWidth,
		y1 + CONF.containerHeight - 2 * CONF.border - CONF.textHeight
	)
	love.graphics.printf(
		{
			{ 1, 1, 1 },
			"Press ",
			{ 0, 1, 0 },
			"<BACKSPACE>",
			{ 1, 1, 1 },
			" to close the game",
		},
		x1 + CONF.border,
		y1 + CONF.containerHeight - CONF.border - CONF.textHeight,
		CONF.containerWidth - 2 * CONF.border,
		"center"
	)
end
