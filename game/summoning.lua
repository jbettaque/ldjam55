require("game.state")
require("game.conf")
game.summoning = {}

function game.summoning.load()
	game.state.summoning.isSummoning = false
	game.state.summoning.types = { "default", "special" }
end

function game.summoning.update(dt) end

function game.summoning.draw()
	if game.state.summoning.isSummoning then
		local rowHeight = game.conf.ui.summoning.rowHeight
		local tableHeight = (rowHeight + 1) * table.getn(game.state.summoning.types)
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
		local rows = table.getn(game.state.summoning.types) - 1
		love.graphics.setNewFont(rowHeight * 0.6)
		local fontOffset = rowHeight * 0.2
		for i, v in ipairs(game.state.summoning.types) do
			local yOffset = (rowHeight + 1) * (i - 1)
			love.graphics.line(tableX, tableY + yOffset, tableX + tableWidth, tableY + yOffset)
			love.graphics.printf(i, tableX, tableY + yOffset + fontOffset, rowHeight, "center")
			love.graphics.printf(v, tableX + rowHeight, tableY + yOffset + fontOffset, tableWidth - rowHeight, "left")
		end
	end
end

function game.summoning.keypressed(key)
	if key == "q" then
		game.state.summoning.isSummoning = not game.state.summoning.isSummoning
		print("show summoning menu: " .. tostring(game.state.summoning.isSummoning))
	end
	local number = tonumber(key)
	if
		game.state.summoning.isSummoning
		and number
		and number > 0
		and number <= table.getn(game.state.summoning.types)
	then
		game.state.summoning.isSummoning = false
		game.summoning.summonAtDefaultLocation(game.state.summoning.types[number])
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
	table.insert(game.state.minions, {
		type = type,
		color = game.conf.minions.defaultColor,
		position = {
			x = x,
			y = y,
		},
	})
end
