require("game.state")
require("game.conf")
require("game.utils")

game.minions = {}

local MOVE_SPEED = game.conf.minions.moveSpeed

function game.minions.load()
	game.state.minions[1] = {
		position = {
			x = 400,
			y = 300,
		},
	}
end

function game.minions.update(dt)
	if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
		game.state.minions[1].position.y = utils.clamp(0, game.state.minions[1].position.y - MOVE_SPEED * dt, 600)
	end
	if love.keyboard.isDown("s") or love.keyboard.isDown("down") then
		game.state.minions[1].position.y = utils.clamp(0, game.state.minions[1].position.y + MOVE_SPEED * dt, 600)
	end
	if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
		game.state.minions[1].position.x = utils.clamp(0, game.state.minions[1].position.x - MOVE_SPEED * dt, 800)
	end
	if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
		game.state.minions[1].position.x = utils.clamp(0, game.state.minions[1].position.x + MOVE_SPEED * dt, 800)
	end
end

function game.minions.draw()
	love.graphics.setColor(255, 0, 0)
	love.graphics.circle("fill", game.state.minions[1].position.x, game.state.minions[1].position.y, 10)
end
