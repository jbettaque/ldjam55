require("game.tilemap")
require("game.state")
require("game.conf")

game.editor = {}
local cooldown = 0.1

local currentPreset = "wall"

function game.editor.load()
	if game.conf.editor == false then
		return
	end
end

function game.editor.update(dt)
	if game.conf.editor == false then
		return
	end

	if love.mouse.isDown(1) then
		local x, y = game.tilemap.screenToWorldPos(love.mouse.getX(), love.mouse.getY())
		game.tilemap.setTileWithPreset(x, y, game.tilemap.getTilePresets()[currentPreset])
		--game.tilemap.interact(x, y, 1)
	end
	if love.mouse.isDown(2) then
		if cooldown > 0 then
			cooldown = cooldown - dt
			return
		end
		cooldown = 0.1

		local presetKeys = {}
		for k, v in pairs(game.tilemap.getTilePresets()) do
			table.insert(presetKeys, k)
			print(k)
		end
		print("presetKeys: " .. #presetKeys)
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
		newLevel()
	end

	if love.keyboard.isScancodeDown("s") then
		game.tilemap.save("save.json")
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
		love.graphics.print(k, 10, 40 + i * 20)
		i = i + 1
	end
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
end
