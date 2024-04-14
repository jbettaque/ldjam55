require("game.state")
require("game.conf")
require("game.utils")

game.tilemap = game.tilemap or require("game.tilemap")
game.summoning = {}

--- callback when the game loads
function game.summoning.load()
	-- initialize empty state where nothing can be summoned
	game.state.summoning = {
		isSummoning = false,
		types = {},
	}
end

--- callback to update game state
function game.summoning.update(dt) end

--- callback to draw the current game state
function game.summoning.draw()
	if game.state.summoning.isSummoning then
		local rowHeight = game.conf.ui.summoning.rowHeight
		local tableHeight = (rowHeight + 1) * #game.state.summoning.types
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

		-- Print Minion Table
		local tableX = x1 + menuBorder
		local tableY = y1 + menuBorder + titleHeight
		love.graphics.setNewFont(rowHeight * 0.6)
		local fontOffset = rowHeight * 0.2
		local keyNumberWidth = rowHeight
		local availableWidth = 80
		for i, v in ipairs(game.state.summoning.types) do
			local minionState = game.state.summoning.types[i]
			local minionType = game.conf.minions.presets[minionState.id]
			local yOffset = (rowHeight + 1) * (i - 1)
			local textColor = { 1, 1, 1 }
			if minionState.summoned == minionState.totalAvailable then
				textColor = { 0.5, 0.5, 0.5 }
			end
			love.graphics.line(tableX, tableY + yOffset, tableX + tableWidth, tableY + yOffset)
			love.graphics.printf({ textColor, i }, tableX, tableY + yOffset + fontOffset, keyNumberWidth, "center")
			love.graphics.printf(
				{ textColor, minionType.name },
				tableX + keyNumberWidth,
				tableY + yOffset + fontOffset,
				tableWidth - keyNumberWidth - availableWidth,
				"left"
			)
			love.graphics.printf(
				{ textColor, tostring(minionState.totalAvailable - minionState.summoned) .. " left" },
				tableX + tableWidth - availableWidth - fontOffset,
				tableY + yOffset + fontOffset,
				availableWidth,
				"right"
			)
		end
	end
end

--- callback when a key is pressed
function game.summoning.keypressed(key, scancode, isrepeat)
	if scancode == "q" then
		game.state.summoning.isSummoning = not game.state.summoning.isSummoning
		print("show summoning menu: " .. tostring(game.state.summoning.isSummoning))
	end

	local number = tonumber(key)
	if game.state.summoning.isSummoning and number and number > 0 and number <= #game.state.summoning.types then
		-- check if there are still enough summons left and do the summoning
		local minionState = game.state.summoning.types[number]
		if minionState.summoned < minionState.totalAvailable then
			game.state.summoning.isSummoning = false
			minionState.summoned = minionState.summoned + 1
			game.minions.summon(minionState.id, game.summoning.getSummonLocation())
		end
	end
end

--- callback when the level with the given index is loaded
function game.summoning.loadLevel(id)
	-- reset state
	game.state.summoning.isSummoning = false
	game.state.summoning.types = {}

	-- rebuild state to store summonable minion types
	print("loading summoning options for level " .. tostring(id))
	for minionId, amount in pairs(game.conf.level_minions[id]) do
		if amount > 0 then
			print("    " .. amount .. " " .. minionId .. " available to summon")
			table.insert(game.state.summoning.types, {
				id = minionId,
				summoned = 0,
				totalAvailable = amount,
			})
		end
	end
end

--- get the default summoning location for the current level
function game.summoning.getSummonLocation()
	print(game.tilemap.getSpawn())
	return game.tilemap.tilemapToScreen(game.tilemap.getSpawn())
end
