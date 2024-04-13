require("game.state")
require("game.conf")
game.summoning = {}

local minionTypes = {}

function game.summoning.load()
	game.state.summoning.isSummoning = false
	game.state.summoning.types = game.conf.minions.presets
	for k, _ in pairs(game.state.summoning.types) do
		table.insert(minionTypes, k)
	end
end

function game.summoning.update(dt) end

function game.summoning.draw()
	if game.state.summoning.isSummoning then
		local rowHeight = game.conf.ui.summoning.rowHeight
		local tableHeight = (rowHeight + 1) * table.getn(minionTypes)
		local tableWidth = game.conf.ui.summoning.rowWidth
		local titleHeight = game.conf.ui.summoning.titleHeight
		local menuBorder = game.conf.ui.summoning.border
		local menuHeight = tableHeight + titleHeight + menuBorder * 2
		local menuWidth = tableWidth + menuBorder * 2

		local x1 = love.graphics.getWidth() / 2 - menuWidth / 2
		local y1 = love.graphics.getHeight() / 2 - menuHeight / 2

		-- Draw Menu Frame
		love.graphics.setColor(1, 1, 1)
		love.graphics.rectangle("fill", x1, y1, menuWidth, menuHeight)
		love.graphics.setColor(0, 0, 0)
		love.graphics.rectangle("fill", x1 + menuBorder, y1 + menuBorder, tableWidth, tableHeight + titleHeight)

		-- Print Title
		local titleFont = titleHeight * 0.8
		local titleMargin = titleHeight * 0.05
		love.graphics.setColor(1, 1, 1)
		love.graphics.setNewFont(titleFont)
		love.graphics.printf(
			game.conf.ui.summoning.menuTitle,
			x1 + menuBorder,
			y1 + menuBorder + titleMargin,
			tableWidth,
			"center"
		)

		--Print Table
		local tableX = x1 + menuBorder
		local tableY = y1 + menuBorder + titleHeight
		love.graphics.setNewFont(rowHeight * 0.6)
		local fontOffset = rowHeight * 0.2
		for i, v in ipairs(minionTypes) do
			local yOffset = (rowHeight + 1) * (i - 1)
			love.graphics.line(tableX, tableY + yOffset, tableX + tableWidth, tableY + yOffset)
			love.graphics.printf(i, tableX, tableY + yOffset + fontOffset, rowHeight, "center")
			love.graphics.printf(
				game.state.summoning.types[v].name,
				tableX + rowHeight,
				tableY + yOffset + fontOffset,
				tableWidth - rowHeight,
				"left"
			)
		end
	end
end

function game.summoning.keypressed(key)
	if key == "q" then
		game.state.summoning.isSummoning = not game.state.summoning.isSummoning
		print("show summoning menu: " .. tostring(game.state.summoning.isSummoning))
	end
	local number = tonumber(key)
	if game.state.summoning.isSummoning and number and number > 0 and number <= table.getn(minionTypes) then
		game.state.summoning.isSummoning = false
		game.summoning.summonAtDefaultLocation(minionTypes[number])
	end
end

function game.summoning.summonAtDefaultLocation(type)
	x, y = game.summoning.getSummonLocation()
	game.summoning.summon(type, x, y)
end

function game.summoning.getSummonLocation()
	return 100, 100
end

function game.summoning.summon(type, x, y)
	print("summoning " .. type .. " minion at " .. x .. "," .. y)
	local preset = game.state.summoning.types[type]
	local minion = {}
	for k, v in pairs(preset) do
		minion[k] = v
	end
	minion.position = {
		x = x,
		y = y,
	}
	minion.angle = 0
	table.insert(game.state.minions, minion)
end
