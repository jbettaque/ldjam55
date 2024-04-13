game = {}
require("game.state")
require("game.character")
require("game.tilemap")

function love.load()
	game.tilemap.load()
	time = 0
	game.character.load()
end

function love.update(dt)
	time = dt + time
	game.tilemap.update(dt)
	game.character.update(dt)
end

function love.draw()
	game.tilemap.draw()
	love.graphics.print("Hello World " .. time, 400, 250)
	game.character.draw()
end
