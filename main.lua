game = {}
require("game.character")
require("game.tilemap")

function love.load()
	game.tilemap.load()
	time = 0
end

function love.update(dt)
	time = dt + time
	game.tilemap.update(dt)
end

function love.draw()
	game.character.test()
	game.tilemap.draw()
	love.graphics.print("Hello World " .. time, 400, 250)
end
