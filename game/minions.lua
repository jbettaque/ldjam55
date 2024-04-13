require("game.state")
require("game.conf")
require("game.utils")

game.minions = {}

local MOVE_SPEED = game.conf.minions.moveSpeed

function game.minions.load()
	game.state.minions = {
		{ position = { x = 100, y = 200 }, color = { 255, 0, 0 } },
		{ position = { x = 200, y = 200 }, color = { 0, 255, 0 } },
		{ position = { x = 300, y = 400 }, color = { 0, 0, 255 } },
	}
end

function game.minions.update(dt)
	for i, minion in ipairs(game.state.minions) do
		if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
			minion.position.y = utils.clamp(0, minion.position.y - MOVE_SPEED * dt, 600)
		end
		if love.keyboard.isDown("s") or love.keyboard.isDown("down") then
			minion.position.y = utils.clamp(0, minion.position.y + MOVE_SPEED * dt, 600)
		end
		if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
			minion.position.x = utils.clamp(0, minion.position.x - MOVE_SPEED * dt, 800)
		end
		if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
			minion.position.x = utils.clamp(0, minion.position.x + MOVE_SPEED * dt, 800)
		end
	end
end

function game.minions.draw()
	for i, minion in ipairs(game.state.minions) do
		love.graphics.setColor(love.math.colorFromBytes(unpack(minion.color)))
		love.graphics.circle("fill", minion.position.x, minion.position.y, 10)
	end
end
