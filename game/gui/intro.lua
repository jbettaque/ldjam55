require("game.state")

game.gui.intro = {}

--- draw the menu container and return the inner dimensions available for furhter text
---
--- Returns:
---   x coordinate of the inner content area
---   y coordinate of the inner content area
---   width of the inner content area
---   height of the inner content area
local function drawContainer()
	local levelName = game.conf.level_sequence[game.state.level.current].title
	local containerWidth = game.conf.ui.intro.containerWidth
	local containerHeight = game.conf.ui.intro.containerHeight
	local border = game.conf.ui.intro.border

	local x1 = love.graphics.getWidth() / 2 - containerWidth / 2
	local y1 = love.graphics.getHeight() / 2 - containerHeight / 2

	-- Draw Frame
	love.graphics.setColor(1, 1, 1)
	love.graphics.rectangle("fill", x1 - border, y1 - border, containerWidth + 2 * border, containerHeight + 2 * border)
	love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle("fill", x1, y1, containerWidth, containerHeight)

	-- Print Title
	local titleHeight = game.conf.ui.intro.titleHeight
	love.graphics.setColor(1, 1, 1)
	love.graphics.setNewFont(titleHeight * 0.8)
	love.graphics.printf(levelName, x1 + border, y1 + border, containerWidth, "center")
	love.graphics.line(x1, y1 + border + titleHeight + border, x1 + containerWidth, y1 + border + titleHeight + border)

	--- Print closing remark
	local footerHeight = game.conf.ui.intro.footerHeight
	love.graphics.setNewFont(footerHeight * 0.8)
	love.graphics.line(
		x1,
		y1 + containerHeight - border - footerHeight - border,
		x1 + containerWidth,
		y1 + containerHeight - border - footerHeight - border
	)
	love.graphics.printf({
		{ 1, 1, 1 },
		"Press ",
		{ 0.1, 0.9, 0.1 },
		"<ENTER>",
		{ 1, 1, 1 },
		" to close!",
	}, x1 + border, y1 + containerHeight - border - footerHeight, containerWidth, "center")

	-- prepare inner content area and return dimensions
	local textHeight = game.conf.ui.intro.textHeight
	love.graphics.setNewFont(textHeight * 0.9)
	return x1 + border,
		y1 + border * 3 + titleHeight,
		containerWidth - border * 2,
		containerHeight - border * 6 - titleHeight - footerHeight
end

--- calculate whether the given screen coordinates are inside the containers footer
local function isInFooter(x, y)
	local containerWidth = game.conf.ui.intro.containerWidth
	local containerHeight = game.conf.ui.intro.containerHeight
	local border = game.conf.ui.intro.border
	local footerHeight = game.conf.ui.intro.footerHeight

	local containerX = love.graphics.getWidth() / 2 - containerWidth / 2
	local containerY = love.graphics.getHeight() / 2 - containerHeight / 2

	return x >= containerX
		and x <= containerX + containerWidth
		and y >= containerY + containerHeight - footerHeight - border * 2
		and y <= containerY + containerHeight
end

local function drawLevelSummoning()
	x, y, width, height = drawContainer()
	love.graphics.printf("Hello World.", x, y, width, "left") -- TODO write intro and explain controls
	game.gui.widgets.keyboardControl(x + 20, y + 50)
end

local function drawLevelInteractions()
	x, y, width, height = drawContainer()
	love.graphics.printf(
		"Your minions can interact with various objects in your chambers. In this room they need to operate a switch and a pressure plate.",
		x,
		y,
		width,
		"left"
	)
end

local function drawLevelDifferentSpeeds()
	x, y, width, height = drawContainer()
	love.graphics.printf(
		"Naturally you don't only have homunculi at your command. Summon a zombie to clear the next room. As you know zombies are slower than your other minions and they are also dumber and can't interact with object. However, they are ideal as ballast for pressure plates. But remember that only homunculi can use the exit.",
		x,
		y,
		width,
		"left"
	)
end

local function drawLevelYouCanDie()
	x, y, width, height = drawContainer()
	love.graphics.printf(
		"As you are well aware your minions can die, from running brainlessly into spikes for example. But don't be alarmed deceased minions can be re-summoned immediately.",
		x,
		y,
		width,
		"left"
	)
end

local function drawLevelYouCanFly()
	x, y, width, height = drawContainer()
	love.graphics.printf(
		"The next room contains pits and spikes which cannot be avoided. I suggest you summon a fae, which can elegantly glide above them. But just as Zombies they cannot use the exit.",
		x,
		y,
		width,
		"left"
	)
end

local function drawLevelDontFlyTooHigh()
	x, y, width, height = drawContainer()
	love.graphics.printf(
		"Fae might be able to fly above dangers and obstacles. But as you certainly know, this also prevents them from pressing down pressure plates.",
		x,
		y,
		width,
		"left"
	)
end

--- callback when a key is pressed on the keyboard
function game.gui.intro.keypressed(key, scancode, isrepeat)
	if scancode == "return" then
		game.gui.close()
	end
end

--- callback to draw on the screen
function game.gui.intro.draw()
	local lvl = game.state.level.current
	if lvl == 2 then
		drawLevelSummoning()
	elseif lvl == 3 then
		drawLevelInteractions()
	elseif lvl == 4 then
		drawLevelDifferentSpeeds()
	elseif lvl == 6 then
		drawLevelYouCanDie()
	elseif lvl == 8 then
		drawLevelYouCanFly()
	elseif lvl == 9 then
		drawLevelDontFlyTooHigh()
	else
		game.gui.close()
	end
end
