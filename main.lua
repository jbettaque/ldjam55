game = {}
require("game.state")
require("game.character")

function love.load()
	time = 0
	game.character.load()
end

function love.update(dt)
	time = dt + time
	game.character.update(dt)
end

function love.draw()
	love.graphics.print("Hello World " .. time, 400, 250)
	game.character.draw()
end
