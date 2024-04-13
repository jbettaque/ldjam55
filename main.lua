game = {}
require("game.tilemap")
require("game.state")
require("game.summoning")
require("game.minions")
require("game.editor")

function love.load()
	game.tilemap.load()
	game.summoning.load()
	game.minions.load()
	game.editor.load()

	game.tilemap.nextLevel()
	game.loadLevel(2)
end

function love.update(dt)
	game.tilemap.update(dt)
	game.summoning.update(dt)
	game.minions.update(dt)
	game.editor.update(dt)
end

function love.draw()
	game.tilemap.draw()
	game.minions.draw()
	game.summoning.draw()
	game.editor.draw()
end

function love.keypressed(key, scancode, isrepeat)
	game.summoning.keypressed(key)
	game.minions.keypressed(key, scancode, isrepeat)
end

--- load the level with the given index
function game.loadLevel(id)
	game.summoning.loadLevel(id)
end
