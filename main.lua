game = {}
require("game.tilemap")
require("game.state")
require("game.summoning")
require("game.minions")
require("game.editor")
require("game.intro")

function love.load()
	game.intro.load()
	game.summoning.load()
	game.tilemap.load()
	game.minions.load()
	game.editor.load()
end

function love.update(dt)
	-- always active modules
	game.intro.update(dt)

	-- conditionally active modules
	if game.state.isActive then
		game.tilemap.update(dt)
		game.summoning.update(dt)
		game.minions.update(dt)
		game.editor.update(dt)
	end
end

function love.draw()
	game.tilemap.draw()
	game.minions.draw()
	game.summoning.draw()
	game.editor.draw()
	game.intro.draw()
end

function love.keypressed(key, scancode, isrepeat)
	-- always active modules
	game.intro.keypressed(key, scancode, isrepeat)

	-- conditionally active modules
	if game.state.isActive then
		game.summoning.keypressed(key, scancode, isrepeat)
		game.minions.keypressed(key, scancode, isrepeat)
	end
end

function love.mousepressed(x, y, button, istouch, presses)
	game.intro.mousepressed(x, y, button, istouch, presses)
end

--- load the level with the given index
function game.loadLevel(id)
	game.minions.loadLevel(id)
	game.summoning.loadLevel(id)
	game.intro.loadLevel(id)
end
