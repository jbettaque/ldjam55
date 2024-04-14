game.gui.widgets = {}

local CONFIG = game.conf.ui.keyboard_control_widget

local function drawButton(x, y, fgColor, bgColor, key, desc)
	love.graphics.setColor(bgColor)
	love.graphics.rectangle("fill", x, y, CONFIG.buttonSize, CONFIG.buttonSize)
	love.graphics.setColor(fgColor)
	love.graphics.rectangle("line", x, y, CONFIG.buttonSize, CONFIG.buttonSize)
	love.graphics.setNewFont(CONFIG.keyTextSize)
	love.graphics.printf(
		key,
		x + CONFIG.padding.x,
		y + CONFIG.padding.y,
		CONFIG.buttonSize - CONFIG.padding.x * 2,
		"right"
	)
	love.graphics.setNewFont(CONFIG.descTextSize)
	love.graphics.printf(
		desc,
		x + CONFIG.padding.x,
		y + CONFIG.padding.y + CONFIG.keyTextSize,
		CONFIG.buttonSize - CONFIG.padding.x * 2,
		"left"
	)
end

function game.gui.widgets.keyboardControl(x, y)
	-- 1 2 3 4
	drawButton(
		x + 0 * (CONFIG.buttonSize + CONFIG.gap.x),
		y,
		CONFIG.fgColor,
		CONFIG.bgColor,
		"1",
		"Summon 1st menu entry"
	)
	drawButton(
		x + 1 * (CONFIG.buttonSize + CONFIG.gap.x),
		y,
		CONFIG.fgColor,
		CONFIG.bgColor,
		"2",
		"Summon 2nd menu entry"
	)
	drawButton(
		x + 2 * (CONFIG.buttonSize + CONFIG.gap.x),
		y,
		CONFIG.fgColor,
		CONFIG.bgColor,
		"3",
		"Summon 3rd menu entry"
	)
	drawButton(
		x + 3 * (CONFIG.buttonSize + CONFIG.gap.x),
		y,
		CONFIG.fgColor,
		CONFIG.bgColor,
		"4",
		"Summon 4th menu entry"
	)

	-- Q W E
	drawButton(
		x + 0 * (CONFIG.buttonSize + CONFIG.gap.x) + 1 * CONFIG.indent,
		y + 1 * (CONFIG.buttonSize + CONFIG.gap.y),
		CONFIG.fgColor,
		CONFIG.bgColor,
		"Q",
		"Open Summon Menu"
	)
	drawButton(
		x + 1 * (CONFIG.buttonSize + CONFIG.gap.x) + 1 * CONFIG.indent,
		y + 1 * (CONFIG.buttonSize + CONFIG.gap.y),
		CONFIG.fgColor,
		CONFIG.bgColor,
		"W",
		"Walk up"
	)
	drawButton(
		x + 2 * (CONFIG.buttonSize + CONFIG.gap.x) + 1 * CONFIG.indent,
		y + 1 * (CONFIG.buttonSize + CONFIG.gap.y),
		CONFIG.fgColor,
		CONFIG.bgColor,
		"E",
		"Interact"
	)

	-- A S D
	drawButton(
		x + 0 * (CONFIG.buttonSize + CONFIG.gap.x) + 2 * CONFIG.indent,
		y + 2 * (CONFIG.buttonSize + CONFIG.gap.y),
		CONFIG.fgColor,
		CONFIG.bgColor,
		"A",
		"Walk left"
	)
	drawButton(
		x + 1 * (CONFIG.buttonSize + CONFIG.gap.x) + 2 * CONFIG.indent,
		y + 2 * (CONFIG.buttonSize + CONFIG.gap.y),
		CONFIG.fgColor,
		CONFIG.bgColor,
		"S",
		"Walk down"
	)
	drawButton(
		x + 2 * (CONFIG.buttonSize + CONFIG.gap.x) + 2 * CONFIG.indent,
		y + 2 * (CONFIG.buttonSize + CONFIG.gap.y),
		CONFIG.fgColor,
		CONFIG.bgColor,
		"D",
		"Walk right"
	)
end
