game.gui.menu = {}

require("game.gui.control_widget")

---  callback when a key is pressed on the keyboard
function game.gui.menu.keypressed(key, scancode, isrepeat)
	if scancode == "h" then
		game.state.gui = "intro"
	elseif scancode == "r" then
		game.loadLevel(game.state.level.current)
		game.gui.close()
	elseif scancode == "escape" then
		game.gui.close()
	elseif scancode == "backspace" then
		love.event.push("quit")
	end
end

function game.gui.menu.draw()
	local containerHeight = game.conf.ui.menu.containerHeight
	local rowHeight = game.conf.ui.menu.rowHeight
	local rowWidth = game.conf.ui.menu.rowWidth
	local border = game.conf.ui.menu.border

	local x1 = love.graphics.getWidth() / 2 - rowWidth / 2
	local y1 = love.graphics.getHeight() / 2 - containerHeight / 2

	-- Draw Menu Frame
	local menuWidth = rowWidth
	love.graphics.setColor(1, 1, 1)
	love.graphics.rectangle("fill", x1, y1, rowWidth, containerHeight)
	love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle("fill", x1 + border, y1 + border, menuWidth - border * 2, containerHeight - border * 2)

	-- Draw Title
	local titleHeight = game.conf.ui.menu.titleHeight
	local titleFont = titleHeight * 0.8
	love.graphics.setColor(1, 1, 1)
	love.graphics.setNewFont(titleFont)
	love.graphics.printf("Pause", x1 + border, y1 + border, rowWidth, "center")
	love.graphics.line(x1, y1 + border * 2 + titleHeight, x1 + rowWidth, y1 + border * 2 + titleHeight)

	-- helpers for drawing rows
	local xRow = x1 + border * 2
	local yRowBase = y1 + border * 4 + titleHeight
	local rowMult = rowHeight + border * 2
	local textWidth = rowWidth - border * 4

	-- Draw Level Info Section
	local itemFont = rowHeight * 0.8
	love.graphics.setNewFont(itemFont)
	love.graphics.printf("Level " .. tostring(game.state.level.current), xRow, yRowBase, textWidth, "center")
	love.graphics.printf("I like to Move It Move It", xRow, yRowBase + 1 * rowMult, textWidth, "center")
	love.graphics.line(x1, yRowBase + 2 * rowMult, x1 + rowWidth, yRowBase + 2 * rowMult)

	-- Draw actual menu section
	yRowBase = yRowBase + 2 * rowMult + 2 * border
	love.graphics.printf({
		{ 0.2, 1, 0.2 },
		"<H>",
		{ 1, 1, 1 },
		" to repeat the intro",
	}, xRow, yRowBase, textWidth, "left")
	love.graphics.printf({
		{ 0.2, 1, 0.2 },
		"<R>",
		{ 1, 1, 1 },
		" to restart the level",
	}, xRow, yRowBase + 1 * rowMult, textWidth, "left")
	love.graphics.printf({
		{ 0.2, 1, 0.2 },
		"<ESC>",
		{ 1, 1, 1 },
		" to unpause",
	}, xRow, yRowBase + 2 * rowMult, textWidth, "left")
	love.graphics.printf({
		{ 0.2, 1, 0.2 },
		"<BACKSPACE>",
		{ 1, 1, 1 },
		" to quit",
	}, xRow, yRowBase + 3 * rowMult, textWidth, "left")
	love.graphics.line(x1, yRowBase + 4 * rowMult + titleHeight, x1 + rowWidth, yRowBase + 4 * rowMult + titleHeight)

	-- Draw Control widget section
	yRowBase = yRowBase + 4 * rowMult + 2 * border + titleHeight
	love.graphics.printf("Keyboard Controls", xRow, yRowBase, textWidth, "center")
	game.gui.widgets.keyboardControl(xRow + 30, yRowBase + 1 * rowMult)
end
