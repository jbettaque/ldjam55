require("game.tilemap")
require("game.state")
require("game.conf")

game.editor = {}
local cooldown = 0.1

local currentPreset = "wall"
local lineConnectorStart = nil
local lineConnectorEnd = nil
local showConnections = false

function game.editor.load()
	if game.conf.editor == false then
		return
	end
end

function game.editor.update(dt)
	if cooldown > 0 then
		cooldown = cooldown - dt
		return
	end

	if game.conf.editor == false then
		return
	end

	if love.mouse.isDown(1) and not love.keyboard.isScancodeDown("r") then
		if not (lineConnectorStart ~= nil) then
			local x, y = game.tilemap.screenToWorldPos(love.mouse.getX(), love.mouse.getY())
			game.tilemap.setTileWithPreset(x, y, game.tilemap.getTilePresets()[currentPreset])
		end

		--game.tilemap.interact(x, y, 1)
	end
	if love.mouse.isDown(2) then
		cooldown = 0.1

		local presetKeys = {}
		for k, v in pairs(game.tilemap.getTilePresets()) do
			table.insert(presetKeys, k)
		end
		local index = 1
		for i = 1, #presetKeys do
			if presetKeys[i] == currentPreset then
				index = i
				break
			end
		end
		index = index + 1
		if index > #presetKeys then
			index = 1
		end
		currentPreset = presetKeys[index]
	end

	if love.keyboard.isScancodeDown("n") then
		cooldown = 0.1
		newLevel()
	end

	if love.keyboard.isScancodeDown("c") then
		cooldown = 0.1
		showConnections = not showConnections
	end

	if love.mouse.isDown(3) then
		cooldown = 0.2
		local x, y = game.tilemap.screenToWorldPos(love.mouse.getX(), love.mouse.getY())

		print(game.tilemap.getValue(x, y, "inverted"))
		if game.tilemap.getValue(x, y, "inverted") ~= nil then
			if game.tilemap.getValue(x, y, "inverted") == false then
				game.tilemap.setValue(x, y, "inverted", true)
			else
				game.tilemap.setValue(x, y, "inverted", false)
			end
		end
	end

	if love.keyboard.isScancodeDown("s") and love.keyboard.isScancodeDown("lctrl") then
		cooldown = 2
		local filename = game.tilemap.getCurrentLevelPath()
		game.tilemap.save(filename)
	end

	if love.keyboard.isScancodeDown("right") and love.keyboard.isScancodeDown("lctrl") then
		cooldown = 0.2
		game.loadLevel(game.state.level.current + 1)
	end

	if love.keyboard.isScancodeDown("left") and love.keyboard.isScancodeDown("lctrl") then
		cooldown = 0.2
		game.loadLevel(game.state.level.current - 1)
	end

	if love.keyboard.isScancodeDown("r") and love.mouse.isDown(1) then
		if lineConnectorStart == nil then
			lineConnectorStart = { love.mouse.getX(), love.mouse.getY() }
		else
			lineConnectorEnd = { love.mouse.getX(), love.mouse.getY() }
		end
	else
		if love.keyboard.isScancodeDown("r") and lineConnectorStart ~= nil then
			local x, y = game.tilemap.screenToWorldPos(lineConnectorStart[1], lineConnectorStart[2])
			local endx, endy = game.tilemap.screenToWorldPos(lineConnectorEnd[1], lineConnectorEnd[2])
			local currentNeededRedstone = game.tilemap.getValue(x, y, "needs_redstone")
			if currentNeededRedstone == nil then
				currentNeededRedstone = {}
			end

			-- Check if the connection already exists and remove it

			for i = 1, #currentNeededRedstone do
				if currentNeededRedstone[i].x == endx and currentNeededRedstone[i].y == endy then
					table.remove(currentNeededRedstone, i)
					game.tilemap.setValue(x, y, "needs_redstone", currentNeededRedstone)
					lineConnectorStart = nil
					lineConnectorEnd = nil
					return
				end
			end

			table.insert(currentNeededRedstone, { x = endx, y = endy })
			game.tilemap.setValue(x, y, "needs_redstone", currentNeededRedstone)
			lineConnectorStart = nil
			lineConnectorEnd = nil
		end
	end
end

function game.editor.draw()
	if game.conf.editor == false then
		return
	end

	love.graphics.setColor(255, 255, 255)
	love.graphics.setNewFont(22)
	love.graphics.print("Current preset: " .. currentPreset, 0)
	love.graphics.setNewFont(15)
	love.graphics.print("Available presets:", 10, 40)
	local i = 1
	for k, v in pairs(game.tilemap.getTilePresets()) do
		if k == currentPreset then
			love.graphics.setColor(255, 255, 0)
		else
			love.graphics.setColor(255, 255, 255)
		end
		love.graphics.print(k, 10, 40 + i * 20)
		i = i + 1
	end

	if lineConnectorStart ~= nil then
		love.graphics.setColor(255, 0, 0)
		love.graphics.circle("fill", lineConnectorStart[1], lineConnectorStart[2], 5)
		if lineConnectorEnd ~= nil then
			love.graphics.circle("fill", lineConnectorEnd[1], lineConnectorEnd[2], 5)
			love.graphics.line(lineConnectorStart[1], lineConnectorStart[2], lineConnectorEnd[1], lineConnectorEnd[2])
		end
	end

	game.editor.showConnections()
end

function newLevel()
	local LEVEL_WIDTH = game.conf.level.width
	local LEVEL_HEIGHT = game.conf.level.height

	for y = 1, LEVEL_HEIGHT do
		game.state.level.map[y] = {}
		game.state.level.standingOn[y] = {}
		for x = 1, LEVEL_WIDTH do
			if x == 1 or x == LEVEL_WIDTH or y == 1 or y == LEVEL_HEIGHT then
				game.tilemap.setTileWithPreset(x, y, tilePresets.wall)
			else
				game.tilemap.setTileWithPreset(x, y, tilePresets.ground)
			end

			--if x == 5 and y == math.floor(LEVEL_HEIGHT / 2) then
			--	game.tilemap.setTileWithPreset(x, y, game.tiles.door.doorTilePresets.door_hor)
			--end
			--
			--if x == math.floor(LEVEL_WIDTH / 2) and y == 5 then
			--	game.tilemap.setTileWithPreset(x, y, game.tiles.door.doorTilePresets.door_vert)
			--end
			game.state.level.standingOn[y][x] = false
		end
	end

	game.conf.level_sequence[#game.conf.level_sequence + 1] = "game/levels/level"
		.. #game.conf.level_sequence
		.. ".json"
	game.tilemap.setLevel(#game.conf.level_sequence)
end

function game.editor.wheelmoved(x, y)
	if y < 0 then
		cooldown = 0.1
		local presetKeys = {}
		for k, v in pairs(game.tilemap.getTilePresets()) do
			table.insert(presetKeys, k)
		end
		local index = 1
		for i = 1, #presetKeys do
			if presetKeys[i] == currentPreset then
				index = i
				break
			end
		end
		index = index + 1
		if index > #presetKeys then
			index = 1
		end
		currentPreset = presetKeys[index]
	elseif y > 0 then
		cooldown = 0.1
		local presetKeys = {}
		for k, v in pairs(game.tilemap.getTilePresets()) do
			table.insert(presetKeys, k)
		end
		local index = 1
		for i = 1, #presetKeys do
			if presetKeys[i] == currentPreset then
				index = i
				break
			end
		end
		index = index - 1
		if index < 1 then
			index = #presetKeys
		end
		currentPreset = presetKeys[index]
	end
end

function game.editor.showConnections(dt)
	if not showConnections then
		return
	end
	local LEVEL_WIDTH = game.conf.level.width
	local LEVEL_HEIGHT = game.conf.level.height

	print("Showing connections")
	for y = 1, LEVEL_HEIGHT do
		for x = 1, LEVEL_WIDTH do
			local needsRedstone = game.tilemap.getValue(x, y, "needs_redstone")
			if needsRedstone ~= nil then
				print("Tile at " .. x .. "x" .. y .. " needs redstone")
				for _, v in ipairs(needsRedstone) do
					love.graphics.setColor(255, 0, 0)
					print("  Needs redstone from " .. v.x .. "x" .. v.y .. " to " .. x .. "x" .. y)
					local screenx1, screeny1 = game.tilemap.tilemapToScreen(x, y)
					local screenx2, screeny2 = game.tilemap.tilemapToScreen(v.x, v.y)

					-- Line with direction indicator
					love.graphics.line(screenx1, screeny1, screenx2, screeny2)
					local angle = math.atan2(screeny2 - screeny1, screenx2 - screenx1)
					local arrowLength = 10
					local arrowAngle = math.pi / 6
					love.graphics.line(
						screenx2,
						screeny2,
						screenx2 - arrowLength * math.cos(angle + arrowAngle),
						screeny2 - arrowLength * math.sin(angle + arrowAngle)
					)
					love.graphics.line(
						screenx2,
						screeny2,
						screenx2 - arrowLength * math.cos(angle - arrowAngle),
						screeny2 - arrowLength * math.sin(angle - arrowAngle)
					)
				end
			end
		end
	end
end
