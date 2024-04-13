require("game.state")
require("game.conf")

game.character = {}

function game.character.load()
	game.state.minions[1] = {
		position = {
			x = 400,
			y = 300,
		},
	}
end

function game.character.update(dt)
	if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
		game.state.minions[1].position.y = game.state.minions[1].position.y - game.conf.minions.moveSpeed * dt
	end
	if love.keyboard.isDown("s") or love.keyboard.isDown("down") then
		game.state.minions[1].position.y = game.state.minions[1].position.y + game.conf.minions.moveSpeed * dt
	end
	if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
		game.state.minions[1].position.x = game.state.minions[1].position.x - game.conf.minions.moveSpeed * dt
	end
	if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
		game.state.minions[1].position.x = game.state.minions[1].position.x + game.conf.minions.moveSpeed * dt
	end
end

function game.character.draw()
	love.graphics.setColor(255, 0, 0)
	love.graphics.circle("fill", game.state.minions[1].position.x, game.state.minions[1].position.y, 10)
end
