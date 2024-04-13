game = {}
require("game.state")
require("game.summoning")
require("game.minions")
require("game.tilemap")

function love.load()
	game.tilemap.load()
	game.summoning.load()
	game.minions.load()
end

function love.update(dt)
	game.tilemap.update(dt)
	game.summoning.update(dt)
	game.minions.update(dt)
end

function love.draw()
	game.tilemap.draw()
	game.minions.draw()
	game.summoning.draw()
end

function love.keypressed(key)
	game.summoning.keypressed(key)
end
