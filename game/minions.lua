require("game.state")
require("game.conf")
require("game.utils")
require("game.tilemap")

game.minions = {}

local MINION_SIZE = game.conf.minions.size

local function triggerMinionStepOn(minion, mapX, mapY)
	print("minion " .. minion.name .. " stepped on new tile " .. mapX .. "x" .. mapY)
	game.tilemap.stepOn(mapX, mapY)
end

local function triggerMinionStepOff(minion, mapX, mapY)
	print("minion " .. minion.name .. " stepped off old tile " .. mapX .. "x" .. mapY)
	game.tilemap.stepOff(mapX, mapY)
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

		-- trigger events if stepped on a new tile
		if mapX ~= newMapX or mapY ~= newMapY then
			triggerMinionStepOff(minion, mapX, mapY)
			triggerMinionStepOn(minion, newMapX, newMapY)
		end
	end
end

local function rotateMinion(minion)
	local isUp = love.keyboard.isDown("w") or love.keyboard.isDown("up")
	local isRight = love.keyboard.isDown("d") or love.keyboard.isDown("right")
	local isDown = love.keyboard.isDown("s") or love.keyboard.isDown("down")
	local isLeft = love.keyboard.isDown("a") or love.keyboard.isDown("left")

	-- combinations that are supposed to do nothing
	if not isUp and not isRight and not isDown and not isLeft then
	-- combinations that dont make any sense
	elseif isUp and isDown and not isRight and not isLeft then
	elseif isLeft and isRight and not isUp and not isDown then
	elseif isUp and isDown and isRight and isLeft then
	-- single button combinations
	elseif isUp and not isDown and not isRight and not isLeft then
		minion.angle = 0
	elseif isRight and not isUp and not isDown and not isLeft then
		minion.angle = 90
	elseif isDown and not isUp and not isRight and not isLeft then
		minion.angle = 180
	elseif isLeft and not isUp and not isRight and not isDown then
		minion.angle = 270
	-- diagonals
	elseif isUp and isRight and not isDown and not isLeft then
		minion.angle = 45
	elseif isRight and isDown and not isUp and not isLeft then
		minion.angle = 90 + 45
	elseif isDown and isLeft and not isUp and not isRight then
		minion.angle = 180 + 45
	elseif isLeft and isUp and not isRight and not isDown then
		minion.angle = 270 + 45
	-- combinations that only partially make sense
	elseif isUp and isLeft and isRight and not isDown then
		monion.angle = 0
	elseif isRight and isUp and isDown and not isLeft then
		minion.angle = 90
	elseif isDown and isLeft and isRight and not isUp then
		minion.angle = 180
	elseif isLeft and isUp and isDown and not isRight then
		minion.angle = 270
	else
		error(
			"unhandled input combination for monion: "
				.. tostring(isUp)
				.. " "
				.. tostring(isRight)
				.. " "
				.. tostring(isDown)
				.. " "
				.. tostring(isLeft)
		)
	end
end

local function interactMinion(minion)
	if minion.canInteract == true then
		local mapX, mapY = game.tilemap.screenToWorldPos(minion.position.x, minion.position.y)

		-- figure out which tile to interact with based on the direction the minion is facing
		local interactX, interactY = mapX, mapY
		if minion.angle == 0 then
			interactY = mapY - 1
		elseif minion.angle == 45 then
			interactY = mapY - 1
			interactX = mapX + 1
		elseif minion.angle == 90 then
			interactX = mapX + 1
		elseif minion.angle == 90 + 45 then
			interactX = mapX + 1
			interactY = mapY + 1
		elseif minion.angle == 180 then
			interactY = mapY + 1
		elseif minion.angle == 180 + 45 then
			interactY = mapY + 1
			interactX = mapX - 1
		elseif minion.angle == 270 then
			interactX = mapX - 1
		elseif minion.angle == 270 + 45 then
			interactX = mapX - 1
			interactY = mapY - 1
		else
			error("unhandled minion angle " .. tostring(minion.angle))
		end

		print("minion " .. minion.name .. " is interacting with tile at " .. interactX .. "x" .. interactY)
		game.tilemap.interact(interactX, interactY, 1)
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
		rotateMinion(minion)
	end
end

-- callback for rendering
function game.minions.draw()
	for _, minion in ipairs(game.state.minions) do
		-- body
		love.graphics.setColor(love.math.colorFromBytes(unpack(minion.color)))
		love.graphics.circle("fill", minion.position.x, minion.position.y, MINION_SIZE)

		-- eye white
		local eyesSize = MINION_SIZE / 4
		local eyesDistance = MINION_SIZE / 2
		love.graphics.setColor(1, 1, 1)
		love.graphics.circle(
			"fill",
			minion.position.x + math.cos(math.rad(minion.angle - 90 - 35)) * eyesDistance,
			minion.position.y + math.sin(math.rad(minion.angle - 90 - 35)) * eyesDistance,
			eyesSize
		)
		love.graphics.circle(
			"fill",
			minion.position.x + math.cos(math.rad(minion.angle - 90 + 35)) * eyesDistance,
			minion.position.y + math.sin(math.rad(minion.angle - 90 + 35)) * eyesDistance,
			eyesSize
		)
		-- eye outline
		love.graphics.setColor(0, 0, 0)
		love.graphics.circle(
			"line",
			minion.position.x + math.cos(math.rad(minion.angle - 90 - 35)) * eyesDistance,
			minion.position.y + math.sin(math.rad(minion.angle - 90 - 35)) * eyesDistance,
			eyesSize
		)
		love.graphics.circle(
			"line",
			minion.position.x + math.cos(math.rad(minion.angle - 90 + 35)) * eyesDistance,
			minion.position.y + math.sin(math.rad(minion.angle - 90 + 35)) * eyesDistance,
			eyesSize
		)
		-- pupils
		love.graphics.setColor(0, 0, 0)
		love.graphics.circle(
			"fill",
			minion.position.x + math.cos(math.rad(minion.angle - 90 - 35)) * eyesDistance,
			minion.position.y + math.sin(math.rad(minion.angle - 90 - 35)) * eyesDistance,
			eyesSize / 3
		)
		love.graphics.circle(
			"fill",
			minion.position.x + math.cos(math.rad(minion.angle - 90 + 35)) * eyesDistance,
			minion.position.y + math.sin(math.rad(minion.angle - 90 + 35)) * eyesDistance,
			eyesSize / 3
		)
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
