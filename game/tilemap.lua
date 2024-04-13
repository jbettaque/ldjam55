game.tilemap = {}

local map = {}
local mapping = {}
local TILE_SIZE = 32
local LEVEL_WIDTH = 32
local LEVEL_HEIGHT = 32

function game.tilemap.load()
	mapping[1] = love.graphics.newImage("assets/tiles/tile_wall.png")
	mapping[2] = love.graphics.newImage("assets/tiles/tile_ground.png")

	window_width = TILE_SIZE * LEVEL_WIDTH
	window_height = TILE_SIZE * LEVEL_HEIGHT

	love.window.setMode(window_width, window_height)

	map = {}
	for y = 1, LEVEL_HEIGHT do
		map[y] = {}
		for x = 1, LEVEL_WIDTH do
			if x == 1 or x == LEVEL_WIDTH or y == 1 or y == LEVEL_HEIGHT then
				map[y][x] = 1
			else
				map[y][x] = 2
			end
		end
	end
end

function game.tilemap.update(dt)
	if love.mouse.isDown(1) then
		local x, y = game.tilemap.screenToWorldPos(love.mouse.getX(), love.mouse.getY())
		map[y][x] = 1
	end
	if love.mouse.isDown(2) then
		local x, y = game.tilemap.screenToWorldPos(love.mouse.getX(), love.mouse.getY())
		map[y][x] = 2
	end
end

function game.tilemap.draw()
	for y = 1, #map do
		for x = 1, #map[y] do
			love.graphics.draw(game.tilemap.getTile(x, y), (x - 1) * TILE_SIZE, (y - 1) * TILE_SIZE)
		end
	end
end

function game.tilemap.getTile(x, y)
	return mapping[map[y][x]]
end

function game.tilemap.setTile(x, y, tile)
	map[y][x] = tile
end

function game.tilemap.getTileSize()
	return TILE_SIZE
end

function game.tilemap.screenToWorldPos(x, y)
	return math.floor(x / TILE_SIZE) + 1, math.floor(y / TILE_SIZE) + 1
end
