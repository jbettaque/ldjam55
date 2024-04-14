game = {}

require("game.tilemap")
require("game.state")
require("game.summoning")
require("game.minions")
require("game.editor")
require("game.audio")
require("game.gui.index")

function love.load()
	game.summoning.load()
	game.tilemap.load()
	game.minions.load()
	game.editor.load()
	game.audio.load()
	game.gui.load()
	game.loadLevel(1)
end

function love.update(dt)
	-- always active modules
	game.audio.update(dt)
	game.gui.update(dt)

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
	game.gui.draw()
end

function love.keypressed(key, scancode, isrepeat)
	-- always active modules
	game.gui.keypressed(key, scancode, isrepeat)

	-- conditionally active modules
	if game.state.isActive then
		game.summoning.keypressed(key, scancode, isrepeat)
		game.minions.keypressed(key, scancode, isrepeat)
	end
end

function love.wheelmoved(x, y)
	game.editor.wheelmoved(x, y)
end

--- load the level with the given index
function game.loadLevel(id)
	if id > #game.conf.level_sequence then
		error("level id too high")
	end

	game.state.level.current = id
	game.minions.loadLevel(id)
	game.summoning.loadLevel(id)
	game.gui.loadLevel(id)
	game.tilemap.loadLevel(id)
end
