require("game.state")

game.intro = {}
local state = game.state.intro

--- draw the menu container and return the inner dimensions available for furhter text
---
--- Parameters:
---   title: The title to draw on the top of the menu
--- Returns:
---   x coordinate of the inner content area
---   y coordinate of the inner content area
---   width of the inner content area
---   height of the inner content area
local function drawContainer(title)
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
	love.graphics.printf("Welcome to the Game", x1 + border, y1 + border, containerWidth, "center")
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
		" to close or click on ",
		{ 0.1, 0.9, 0.1 },
		"me",
		{ 1, 1, 1 },
		"!",
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

local function drawLevel1()
	x, y, width, height = drawContainer("Welcome to the game")
	love.graphics.printf("Hello World", x, y, width, "left")
end

--- callback when the game starts
function game.intro.load()
	-- nothing to initialize; all relevant stuff happens in loadLevel()
end

--- callback when the game loads the level with the given index
function game.intro.loadLevel(id)
	game.state.isActive = false
	state.isOpen = true
end

--- callback when the game loop updates
function game.intro.update(dt)
	-- nothing to do; dismissing the dialog is done via key events
end

--- callback when a key is pressed on the keyboard
function game.intro.keypressed(key, scancode, isrepeat)
	if state.isOpen and scancode == "return" then
		game.intro.close()
	end
end

--- callback when a mouse button is pressed
function game.intro.mousepressed(x, y, button, istouch, presses)
	if state.isOpen and button == 1 and isInFooter(x, y) then
		game.intro.close()
	end
end

--- callback to draw on the screen
function game.intro.draw()
	if state.isOpen then
		if game.state.level.current == 1 then
			drawLevel1()
		else
			game.intro.close()
		end
	end
end

--- close the intro if it is currently open and activate the main game
function game.intro.close()
	state.isOpen = false
	game.state.isActive = true
end
