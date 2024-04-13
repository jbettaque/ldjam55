game = {}
require("game.state")
require("game.minions")
require("game.tilemap")

function love.load()
	game.tilemap.load()
	time = 0
	game.minions.load()
end

function love.update(dt)
	time = dt + time
	game.tilemap.update(dt)
	game.minions.update(dt)
end

function love.draw()
	game.tilemap.draw()
	love.graphics.print("Hello World " .. time, 400, 250)
	game.minions.draw()
end
