game.gui = {}

require("game.utils")
require("game.state")
require("game.gui.menu")
require("game.gui.intro")
require("game.gui.endScreen")

--- callback when the game starts
function game.gui.load()
	-- nothing to do; all relevant initialization happens in loadLevel()
end

--- callback when the game loads the level with the given index
function game.gui.loadLevel(id)
	game.state.isActive = false
	if id == #game.conf.level_sequence then
		game.state.gui = "endScreen"
	else
		game.state.gui = "intro"
	end
end

--- callback when the game loop updates
function game.gui.update(dt)
	-- nothing to do; interaction is done via key events
end

--- callback when a key is pressed on the keyboard
function game.gui.keypressed(key, scancode, isrepeat)
	if game.state.gui == "intro" then
		game.gui.intro.keypressed(key, scancode, isrepeat)
	elseif game.state.gui == "menu" then
		game.gui.menu.keypressed(key, scancode, isrepeat)
	elseif game.state.gui == "closed" then
		if scancode == "escape" then
			game.state.gui = "menu"
		end
	elseif game.state.gui == "endScreen" then
		game.gui.endScreen.keypressed(key, scancode, isrepeat)
	else
		error("unknown gui state " .. tostring(game.state.gui))
	end
end

--- callback to draw on the screen
function game.gui.draw()
	if game.state.gui == "intro" then
		game.gui.intro.draw()
	elseif game.state.gui == "menu" then
		game.gui.menu.draw()
	elseif game.state.gui == "endScreen" then
		game.gui.endScreen.draw()
	end
end

--- close the currently active gui window
function game.gui.close()
	game.state.gui = "closed"
	game.state.isActive = true
end
