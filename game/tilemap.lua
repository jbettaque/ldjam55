game.tilemap = {}
require("game.state")
require("game.conf")

local mapping = {}
local TILE_SIZE = game.conf.level.tileSize
local LEVEL_WIDTH = game.conf.level.width
local LEVEL_HEIGHT = game.conf.level.height
local map = game.state.level.map

function game.tilemap.load()
	mapping[1] = love.graphics.newImage("assets/tiles/tile_wall.png")
	mapping[2] = love.graphics.newImage("assets/tiles/tile_ground.png")

	local window_width = TILE_SIZE * LEVEL_WIDTH
	local window_height = TILE_SIZE * LEVEL_HEIGHT

	love.window.setMode(window_width, window_height)

	for y = 1, LEVEL_HEIGHT do
		map[y] = {}
		for x = 1, LEVEL_WIDTH do
			if x == 1 or x == LEVEL_WIDTH or y == 1 or y == LEVEL_HEIGHT then
				map[y][x] = { asset = 1 }
			else
				map[y][x] = { asset = 2 }
			end
		end
	end
end

function game.tilemap.update(dt)
	if love.mouse.isDown(1) then
		local x, y = game.tilemap.screenToWorldPos(love.mouse.getX(), love.mouse.getY())
		map[y][x].asset = 1
	end
	if love.mouse.isDown(2) then
		local x, y = game.tilemap.screenToWorldPos(love.mouse.getX(), love.mouse.getY())
		map[y][x].asset = 2
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

function game.tilemap.getTile(x, y)
	return mapping[map[y][x]]
end

function game.tilemap.getAsset(x, y)
	return mapping[map[y][x].asset]
end

function game.tilemap.setTile(x, y, tile)
	map[y][x] = tile
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
