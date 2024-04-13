require("game.state")
require("game.conf")
require("game.utils")
require("game.tilemap")

game.minions = {}

local MOVE_SPEED = game.conf.minions.moveSpeed

function game.minions.load()
	game.state.minions = {
		{ position = { x = 100, y = 200 }, color = { 255, 0, 0 } },
		--{ position = { x = 200, y = 200 }, color = { 0, 255, 0 } },
		--{ position = { x = 300, y = 400 }, color = { 0, 0, 255 } },
	}
end

function game.minions.update(dt)
	for _, minion in ipairs(game.state.minions) do
		-- prepare to move the minion
		local newX, newY = minion.position.x, minion.position.y
		if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
			newY = utils.clamp(0, minion.position.y - MOVE_SPEED * dt, 600)
		end
		if love.keyboard.isDown("s") or love.keyboard.isDown("down") then
			newY = utils.clamp(0, minion.position.y + MOVE_SPEED * dt, 600)
		end
		if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
			newX = utils.clamp(0, minion.position.x - MOVE_SPEED * dt, 800)
		end
		if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
			newX = utils.clamp(0, minion.position.x + MOVE_SPEED * dt, 800)
		end

		-- check if the new position is valid
		local mapX, mapY = game.tilemap.screenToWorldPos(newX, newY)
		if game.tilemap.getValue(mapX, mapY, "walkable") == true then
			minion.position.x = newX
			minion.position.y = newY
		end
	end
end

function game.minions.draw()
	for i, minion in ipairs(game.state.minions) do
		love.graphics.setColor(love.math.colorFromBytes(unpack(minion.color)))
		love.graphics.circle("fill", minion.position.x, minion.position.y, 10)
	end
end
