game.tilemap = {}
game.tiles = {}
require("game.state")
require("game.conf")
require("game.tiles.door")
require("game.tiles.spawn")
require("game.tiles.finish")
require("game.tiles.pit")
require("game.tiles.box")
require("game.tiles.mine")
require("game.tiles.bridge")
require("game.tiles.button")
require("game.tiles.key")
require("game.tiles.spike")
require("game.tiles.pressureplate")
require("game.tiles.lever")
require("game.tiles.keyhole")

local json = require("game.json")

local mapping = {}

tilePresets = {
	wall = { preset = "wall", asset = 1, walkable = false, overFlyable = false },
	ground = { preset = "ground", asset = 2, walkable = true, overFlyable = true },
}
local assets = {
	"assets/tiles/tile_wall.png",
	"assets/tiles/tile_ground.png",
}
local interactFunctions = {}
local stepOnFunctions = {}
local stepOffFunctions = {}
local updateFunctions = {}

local TILE_SIZE = game.conf.level.tileSize
local LEVEL_WIDTH = game.conf.level.width
local LEVEL_HEIGHT = game.conf.level.height
local map = game.state.level.map

function game.tilemap.load()
	game.tiles.door.register()
	game.tiles.finish.register()
	game.tiles.spawn.register()
	game.tiles.pit.register()
	game.tiles.box.register()
	game.tiles.mine.register()
	game.tiles.button.register()
	game.tiles.key.register()
	game.tiles.spike.register()
	game.tiles.pressureplate.register()
	game.tiles.lever.register()
	game.tiles.bridge.register()
	game.tiles.keyhole.register()

	game.tilemap.loadAssets(assets)

	local window_width = TILE_SIZE * LEVEL_WIDTH
	local window_height = TILE_SIZE * LEVEL_HEIGHT

	love.window.setMode(window_width, window_height)

	for y = 1, LEVEL_HEIGHT do
		map[y] = {}
		game.state.level.standingOn[y] = {}
		for x = 1, LEVEL_WIDTH do
			--if x == 1 or x == LEVEL_WIDTH or y == 1 or y == LEVEL_HEIGHT then
			--	game.tilemap.setTileWithPreset(x, y, tilePresets.wall)
			--else
			--	game.tilemap.setTileWithPreset(x, y, tilePresets.ground)
			--end
			--
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
	game.tilemap.loadSave(game.conf.level_sequence[1])
	--game.tilemap.save("save.json")
end

function game.tilemap.update(dt)
	for y = 1, #map do
		for x = 1, #map[y] do
			local tile = map[y][x]
			if updateFunctions[tile.update] then
				updateFunctions[tile.update](x, y, dt)
			end
		end
	end
end

function game.tilemap.draw()
	love.graphics.setColor(255, 255, 255)
	for y = 1, #map do
		for x = 1, #map[y] do
			love.graphics.draw(game.tilemap.getAsset(x, y), (x - 1) * TILE_SIZE, (y - 1) * TILE_SIZE)
		end
	end
end

function game.tilemap.loadAssets(assets)
	for i, asset in ipairs(assets) do
		mapping[i] = love.graphics.newImage(asset)
	end
end

function game.tilemap.getTile(x, y)
	return map[y][x]
end

function game.tilemap.getAsset(x, y)
	return mapping[map[y][x].asset]
end

function game.tilemap.setTile(x, y, tile)
	map[y][x] = tile
end

function game.tilemap.setTileWithPreset(x, y, tilePreset)
	local tile = {}
	for k, v in pairs(tilePreset) do
		tile[k] = v
	end
	map[y][x] = tile
end

function game.tilemap.getValue(x, y, key)
	if not map[y] or not map[y][x] then
		return nil
	end
	return map[y][x][key]
end

function game.tilemap.setValue(x, y, key, value)
	map[y][x][key] = value
end

function game.tilemap.setAsset(x, y, asset)
	map[y][x].asset = asset
end

function game.tilemap.getTileSize()
	return TILE_SIZE
end

function game.tilemap.screenToWorldPos(x, y)
	return math.floor(x / TILE_SIZE) + 1, math.floor(y / TILE_SIZE) + 1
end

function game.tilemap.tilemapToScreen(x, y)
	return (x - 1) * TILE_SIZE + (TILE_SIZE / 2), (y - 1) * TILE_SIZE + (TILE_SIZE / 2)
end

function game.tilemap.interact(x, y, minion)
	local tile = game.tilemap.getTile(x, y)
	if tile.interact then
		interactFunctions[tile.interact](x, y, minion)
	end
end

function game.tilemap.stepOn(x, y, minion)
	game.state.level.standingOn[y][x] = true

	local tile = game.tilemap.getTile(x, y)
	if tile.step_on then
		stepOnFunctions[tile.step_on](x, y, minion)
	end
end

function game.tilemap.stepOff(x, y)
	game.state.level.standingOn[y][x] = false

	local tile = game.tilemap.getTile(x, y)
	if tile.step_off then
		stepOffFunctions[tile.step_off](x, y)
	end
end

function game.tilemap.registerTilePreset(name, preset)
	tilePresets[name] = preset
end

function game.tilemap.registerInteractFunction(name, func)
	interactFunctions[name] = func
end

function game.tilemap.registerStepOnFunction(name, func)
	stepOnFunctions[name] = func
end

function game.tilemap.registerStepOffFunction(name, func)
	stepOffFunctions[name] = func
end

function game.tilemap.registerUpdateFunction(name, func)
	updateFunctions[name] = func
end

function game.tilemap.registerAsset(asset)
	table.insert(assets, asset)
end

function game.tilemap.getAssetCount()
	return #assets
end

function game.tilemap.save(filename)
	local json_data = json.encode(map)
	local file = io.open(filename, "w")
	file:write(json_data)
	file:close()
end

function game.tilemap.loadSave(filename)
	local contents, size = love.filesystem.read(filename)
	if contents then
		map = json.decode(contents)

		for i = 1, #map do
			for j = 1, #map[i] do
				game.state.level.standingOn[i][j] = false

				--
				local preset = tilePresets[map[i][j].preset]
				if preset then
					for k, v in pairs(preset) do
						if map[i][j][k] == nil then
							map[i][j][k] = v
						end
					end
				end
			end
		end
		game.loadLevel(game.state.level.current)
	end
end

function game.tilemap.nextLevel()
	if (game.state.level.current + 1) > #game.conf.level_sequence then
		game.state.level.current = 1
	else
		game.state.level.current = game.state.level.current + 1
	end
	game.tilemap.loadSave(game.conf.level_sequence[game.state.level.current])
end

function game.tilemap.previousLevel()
	if (game.state.level.current - 1) < 1 then
		game.state.level.current = #game.conf.level_sequence
	else
		game.state.level.current = game.state.level.current - 1
	end
	game.tilemap.loadSave(game.conf.level_sequence[game.state.level.current])
end

function game.tilemap.setLevel(level)
	game.state.level.current = level
end

function game.tilemap.getCurrentLevel()
	return game.state.level.current
end

function game.tilemap.getCurrentLevelPath()
	return game.conf.level_sequence[game.state.level.current]
end

function game.tilemap.getTilePresets()
	return tilePresets
end

function game.tilemap.getSpawn()
	for y = 1, #map do
		for x = 1, #map[y] do
			if map[y][x].preset == "spawn" then
				return x, y
			end
		end
	end
	return 100, 100
end

function game.tilemap.resetLevel()
	game.tilemap.loadSave(game.conf.level_sequence[game.state.level.current])
end
