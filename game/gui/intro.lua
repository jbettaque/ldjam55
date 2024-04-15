require("game.state")
require("game.tilemap")

game.gui.intro = {}

local WHITE = { 1, 1, 1 }
local GREEN = { 0.1, 0.9, 0.1 }

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
		WHITE,
		"Press ",
		GREEN,
		"<ENTER>",
		WHITE,
		" to close!",
	}, x1 + border, y1 + containerHeight - border - footerHeight, containerWidth, "center")

	-- prepare inner content area and return dimensions
	setupContentFont()
	return x1 + border,
		y1 + border * 3 + titleHeight,
		containerWidth - border * 2,
		containerHeight - border * 6 - titleHeight - footerHeight
end

function setupContentFont()
	local textHeight = game.conf.ui.intro.textHeight
	love.graphics.setNewFont(textHeight * 0.9)
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

local function drawLevelWelcomeToTheGame()
	x, y, width, height = drawContainer()
	love.graphics.printf(
		"Greetings Master!\nI set up all of your chambers just as you demanded. I drew the     pentagrams so you can summon your minions. I also instructed all of them to move at the same time, just as you wanted. Finally, I set up a     goal in each chamber you can chase your minions towards.",
		x,
		y,
		width,
		"left"
	)
	love.graphics.draw(game.tilemap.getAssetById(7), x + 300, y + 63, 0, 0.65, 0.65, 0, 0) -- finish
	love.graphics.draw(game.tilemap.getAssetById(8), x + width - 224, y + 22, 0, 0.65, 0.65, 0, 0) -- start
	game.gui.widgets.keyboardControl(x + 20, y + 120)
	setupContentFont()
	love.graphics.printf({
		WHITE,
		"Use ",
		GREEN,
		"<Q>",
		WHITE,
		" followed by ",
		GREEN,
		"<number>",
		WHITE,
		" to summon a minion.\nUse ",
		GREEN,
		"<WASD>",
		WHITE,
		" to command your minions.\nUse ",
		GREEN,
		"<ESC>",
		WHITE,
		" to pause and open the menu where you can:\n  - Show this text again\n  - Restart the level\n  - Mute the sound\n  - Quit",
	}, x + 400, y + 150, width / 2, "left")
end

local function drawLevelInteractions()
	x, y, width, height = drawContainer()
	love.graphics.printf({
		WHITE,
		"I set up various objects for your minions to interact with. In this room they need to operate a      switch and a     pressure plate.\nOnly one homunculus needs to reach the goal.\n\nUse ",
		GREEN,
		"<E>",
		WHITE,
		" to interact with switches.",
	}, x, y, width, "left")
	love.graphics.draw(game.tilemap.getAssetById(17), x + 240, y + 22, 0, 0.65, 0.65, 0, 0) -- pressure plate
	love.graphics.draw(game.tilemap.getAssetById(19), x + 95, y + 22, 0, 0.65, 0.65, 0, 0) -- switch
end

local function drawLevelDifferentSpeeds()
	x, y, width, height = drawContainer()
	love.graphics.printf(
		"Naturally you don't only have homunculi at your command. Summon a zombie to clear the next room. As you know zombies are slower than your other minions and they are also dumber and can't interact with object. However, they are ideal as ballast for     pressure plates. But remember that only homunculi can use the exit.",
		x,
		y,
		width,
		"left"
	)
	love.graphics.draw(game.tilemap.getAssetById(17), x + width - 50, y + 42, 0, 0.65, 0.65, 0, 0) -- pressure plate
end

local function drawLevelZombiesAreStupid()
	x, y, width, height = drawContainer()
	love.graphics.printf(
		"While Zombies are pretty easy to summon and deal with, they are also just plain dumb…\nThey can't do anything useful besides standing in the way and on top of things.",
		x,
		y,
		width,
		"left"
	)
end

local function drawLevelYouCanDie()
	x, y, width, height = drawContainer()
	love.graphics.printf(
		"As you are well aware your minions can die, from running brainlessly into     spikes for example. But don't be alarmed deceased minions can be re-summoned immediately.",
		x,
		y,
		width,
		"left"
	)
	love.graphics.draw(game.tilemap.getAssetById(15), x + width - 126, y + 1, 0, 0.65, 0.65, 0, 0) -- spikes
end

local function drawLevelYouCanFly()
	x, y, width, height = drawContainer()
	love.graphics.printf(
		"The next room contains     pits and     spikes which cannot be avoided. I suggest you summon a fae, which can elegantly glide above them. But just as Zombies they cannot use the exit.",
		x,
		y,
		width,
		"left"
	)
	love.graphics.draw(game.tilemap.getAssetById(15), x + 319, y + 1, 0, 0.65, 0.65, 0, 0) -- spikes
	love.graphics.draw(game.tilemap.getAssetById(9), x + 219, y + 1, 0, 0.65, 0.65, 0, 0) -- pits
end

local function drawLevelDontFlyTooHigh()
	x, y, width, height = drawContainer()
	love.graphics.printf(
		"Faes might be able to fly above dangers and obstacles. But as you certainly know, this also prevents them from pressing     down pressure plates.",
		x,
		y,
		width,
		"left"
	)
	love.graphics.draw(game.tilemap.getAssetById(17), x + 306, y + 22, 0, 0.65, 0.65, 0, 0) -- pressure plate
end

local function drawLevelMines()
	x, y, width, height = drawContainer()
	love.graphics.printf(
		"Watch Out Master!\nThere is still one of the     mines, you placed after - The Incident™ -\nCommand one of your minions to step onto it to clear it up.",
		x,
		y,
		width,
		"left"
	)
	love.graphics.draw(game.tilemap.getAssetById(11), x + 210, y + 22, 0, 0.65, 0.65, 0, 0) -- mine
end

local function drawLevelLockedUpAgain()
	x, y, width, height = drawContainer()
	love.graphics.printf({
		WHITE,
		"We reached the last of your chambers. Good luck with it.\n\nAnd remember you can always reset the room in the ",
		GREEN,
		"<ESC>",
		WHITE,
		" menu.",
	}, x, y, width, "left")
end

--- callback when a key is pressed on the keyboard
function game.gui.intro.keypressed(key, scancode, isrepeat)
	if scancode == "return" then
		game.gui.close()
	end
end

--- callback to draw on the screen
function game.gui.intro.draw()
	local lvlName = game.conf.level_sequence[game.state.level.current].title

	if lvlName == "Welcome to the Game" then
		drawLevelWelcomeToTheGame()
	elseif lvlName == "Interaction" then
		drawLevelInteractions()
	elseif lvlName == "Different Speeds" then
		drawLevelDifferentSpeeds()
	elseif lvlName == "Zombies Are Stupid" then
		drawLevelZombiesAreStupid()
	elseif lvlName == "You Can Die" then
		drawLevelYouCanDie()
	elseif lvlName == "You Can Fly" then
		drawLevelYouCanFly()
	elseif lvlName == "Don't Fly Too High" then
		drawLevelDontFlyTooHigh()
	elseif lvlName == "Mines" then
		drawLevelMines()
	elseif lvlName == "Locked In (Again?)" then
		drawLevelLockedUpAgain()
	else
		game.gui.close()
	end
end
