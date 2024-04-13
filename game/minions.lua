require("game.state")
require("game.conf")
require("game.utils")
require("game.tilemap")

game.minions = {}

local function triggerMinionStepOn(minion, mapX, mapY)
	print("minion " .. minion.name .. " stepped on new tile at " .. mapX .. "x" .. mapY)
end

local function moveMinion(minion, dt)
	local mapX, mapY = game.tilemap.screenToWorldPos(minion.position.x, minion.position.y)

	-- prepare to move the minion
	local newX, newY = minion.position.x, minion.position.y
	if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
		newY = utils.clamp(0, minion.position.y - minion.moveSpeed * dt, 600)
	end
	if love.keyboard.isDown("s") or love.keyboard.isDown("down") then
		newY = utils.clamp(0, minion.position.y + minion.moveSpeed * dt, 600)
	end
	if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
		newX = utils.clamp(0, minion.position.x - minion.moveSpeed * dt, 800)
	end
	if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
		newX = utils.clamp(0, minion.position.x + minion.moveSpeed * dt, 800)
	end

	-- assign new position if it is valid
	local newMapX, newMapY = game.tilemap.screenToWorldPos(newX, newY)
	if game.tilemap.getValue(newMapX, newMapY, "walkable") == true then
		minion.position.x = newX
		minion.position.y = newY

		-- trigger step-on if stepped on a new tile
		if mapX ~= newMapX or mapY ~= newMapY then
			triggerMinionStepOn(minion, newMapX, newMapY)
		end
	end
end

local function interactMinion(minion)
	if minion.canInteract == true then
		local mapX, mapY = game.tilemap.screenToWorldPos(minion.position.x, minion.position.y)
		print("minion " .. minion.name .. " is interacting with tile at " .. mapX .. "x" .. mapY)
	end
end

-- callback when the game loads
function game.minions.load()
	game.state.minions = {}
end

-- callback for game updates
function game.minions.update(dt)
	for _, minion in ipairs(game.state.minions) do
		moveMinion(minion, dt)
	end
end

-- callback for rendering
function game.minions.draw()
	for _, minion in ipairs(game.state.minions) do
		love.graphics.setColor(love.math.colorFromBytes(unpack(minion.color)))
		love.graphics.circle("fill", minion.position.x, minion.position.y, 10)
	end
end

-- callback for key presses
function game.minions.keypressed(key, scancode, isrepeat)
	if key == "space" and not isrepeat then
		for _, minion in ipairs(game.state.minions) do
			interactMinion(minion)
		end
	end
end
