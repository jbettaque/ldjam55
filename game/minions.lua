require("game.state")
require("game.conf")
require("game.tilemap")

game.minions = {}

local MINION_SIZE = game.conf.minions.size
local state = game.state.minions

--- generate a new minion id that is unique for the current level
local function gen_id()
	state.minion_id_seq = state.minion_id_seq + 1
	return state.minion_id_seq
end

--- trigger other game components when a minion enters a new tile
local function triggerMinionStepOn(minion, mapX, mapY)
	print(minion.name .. " " .. tostring(minion.id) .. " stepped on new tile " .. mapX .. "x" .. mapY)
	game.tilemap.stepOn(mapX, mapY, minion)
end

--- trigger other game components when a minion leaves a tile
local function triggerMinionStepOff(minion, mapX, mapY)
	print(minion.name .. " " .. tostring(minion.id) .. " stepped off old tile " .. mapX .. "x" .. mapY)
	game.tilemap.stepOff(mapX, mapY, minion)
end

local function moveMinion(minion, dt)
	local x, y = minion.position.x, minion.position.y
	local mapX, mapY = game.tilemap.screenToWorldPos(minion.position.x, minion.position.y)
	local hasMoved = false

	--- checks whether the screen position x,y is accessible by the current minion
	local function canMoveTo(x, y)
		local mapX, mapY = game.tilemap.screenToWorldPos(x, y)
		if minion.movementType == "walking" then
			return game.tilemap.getValue(mapX, mapY, "walkable")
		elseif minion.movementType == "flying" then
			print(game.tilemap.getValue(mapX, mapY, "overFlyable"))
			return game.tilemap.getValue(mapX, mapY, "overFlyable")
		else
			error("minion " .. minion.name .. " uses unknown movementType " .. minion.movementType)
		end
	end

	-- handle movement in all four directions
	local isUp = love.keyboard.isScancodeDown("w") or love.keyboard.isScancodeDown("up")
	local isRight = love.keyboard.isScancodeDown("d") or love.keyboard.isScancodeDown("right")
	local isDown = love.keyboard.isScancodeDown("s") or love.keyboard.isScancodeDown("down")
	local isLeft = love.keyboard.isScancodeDown("a") or love.keyboard.isScancodeDown("left")
	if isUp and not isDown and canMoveTo(x, y - minion.moveSpeed * dt) then
		minion.position.y = y - minion.moveSpeed * dt
		hasMoved = true
	end
	if isRight and not isLeft and canMoveTo(x + minion.moveSpeed * dt, y) then
		minion.position.x = x + minion.moveSpeed * dt
		hasMoved = true
	end
	if isDown and not isUp and canMoveTo(x, y + minion.moveSpeed * dt) then
		minion.position.y = y + minion.moveSpeed * dt
		hasMoved = true
	end
	if isLeft and not isRight and canMoveTo(x - minion.moveSpeed * dt, y) then
		minion.position.x = x - minion.moveSpeed * dt
		hasMoved = true
	end

	-- trigger events if stepped on a new tile
	local newMapX, newMapY = game.tilemap.screenToWorldPos(minion.position.x, minion.position.y)
	if (mapX ~= newMapX or mapY ~= newMapY) and minion.canStepOn then
		triggerMinionStepOff(minion, mapX, mapY)
		triggerMinionStepOn(minion, newMapX, newMapY)
	end
end

local function rotateMinion(minion)
	local isUp = love.keyboard.isScancodeDown("w") or love.keyboard.isScancodeDown("up")
	local isRight = love.keyboard.isScancodeDown("d") or love.keyboard.isScancodeDown("right")
	local isDown = love.keyboard.isScancodeDown("s") or love.keyboard.isScancodeDown("down")
	local isLeft = love.keyboard.isScancodeDown("a") or love.keyboard.isScancodeDown("left")

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
		minion.angle = 0
	elseif isRight and isUp and isDown and not isLeft then
		minion.angle = 90
	elseif isDown and isLeft and isRight and not isUp then
		minion.angle = 180
	elseif isLeft and isUp and isDown and not isRight then
		minion.angle = 270
	else
		error(
			"unhandled input combination for minion: "
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

		print(
			minion.name
				.. " "
				.. tostring(minion.id)
				.. " is interacting with tile "
				.. interactX
				.. "x"
				.. interactY
				.. " and "
				.. mapX
				.. "x"
				.. mapY
		)
		game.tilemap.interact(mapX, mapY, minion)
		game.tilemap.interact(interactX, interactY, minion)
	end
end

function game.minions.kill(minion)
	print("killing " .. tostring(minion.name) .. " " .. tostring(minion.id))
	local _, i = game.minions.get(minion.id)
	table.remove(state.activeMinions, i)
	game.summoning.refreshSummon(minion.presetId)
end

--- callback when the game loads
function game.minions.load()
	-- nothing to do; initialization happens on level load
end

--- callback for game updates
function game.minions.update(dt)
	for _, minion in ipairs(state.activeMinions) do
		moveMinion(minion, dt)
		rotateMinion(minion)
	end
end

--- callback for rendering
function game.minions.draw()
	for _, minion in ipairs(state.activeMinions) do
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

		-- carried object
		if minion.carrying == nil then
		elseif minion.carrying == "key" then
			--print("hi")
		else
			error("cannot render carried item " .. tostring(minion.carrying))
		end
	end
end

--- callback for key presses
function game.minions.keypressed(key, scancode, isrepeat)
	if scancode == "space" and not isrepeat then
		for _, minion in ipairs(state.activeMinions) do
			interactMinion(minion)
		end
	end
end

--- summon a minion of the specified type at a given position
---
--- Parameters:
---    presetId: The ID of a minion preset from game.conf.minions.preset
---    x, y: Map coordinates at which the minion should be summoned
function game.minions.summon(presetId, x, y)
	print("summoning " .. presetId .. " at " .. x .. "x" .. y)
	local preset = game.conf.minions.presets[presetId]
	local screenX, screenY = game.tilemap.tilemapToScreen(x, y)

	-- instantiate by copying all properties
	local minion = {}
	for k, v in pairs(preset) do
		minion[k] = v
	end

	-- set runtime properties
	minion.id = gen_id()
	minion.position = {
		x = screenX,
		y = screenY,
	}
	minion.angle = 0
	minion.carrying = "key"

	-- actually spawn by inserting into game state
	table.insert(state.activeMinions, minion)
end

--- get the minion with the given id
---
--- Returns:
---   the minion table
---   the index into the minion state at which that minion is stored
function game.minions.get(id)
	for i, minion in pairs(state.activeMinions) do
		if minion.id == id then
			return minion, i
		end
	end
	error("No minion with id " .. tostring(id) .. " exists")
end

--- callback when the level with the given index is loaded
function game.minions.loadLevel(id)
	state.activeMinions = {}
	state.minion_id_seq = 0
end
