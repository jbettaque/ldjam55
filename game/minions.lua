require("game.state")
require("game.conf")
require("game.tilemap")

game.minions = {}

local MINION_SIZE = game.conf.minions.size
local state = game.state.minions
local idleState = 1
local idleUpdateTimer = 1

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

--- handle the movement behavior of a minion
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

--- handle the rotation behavior of a minion
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

--- handle the interaction behavior of a minion
local function interactMinion(minion)
	if minion.canInteract == true then
		local mapX, mapY = game.tilemap.screenToWorldPos(minion.position.x, minion.position.y)
		print(minion.name .. " " .. tostring(minion.id) .. " is interacting with tile " .. mapX .. "x" .. mapY)
		game.tilemap.interact(mapX, mapY, minion)
	end
end

--- handle the unstuck behavior of a potentially stuck minion by unstucking them
local function unstuckMinion(minion)
	local mapX, mapY = game.tilemap.screenToWorldPos(minion.position.x, minion.position.y)

	-- the property inside the tilemap which determines whether the minion can be on a tile
	local mapProp
	if minion.movementType == "walking" then
		mapProp = "walkable"
	elseif minion.movementType == "flying" then
		mapProp = "overFlyable"
	else
		error("unknown minion movement type " .. tostring(minion.movementType))
	end

	-- if the minion is stuck, try to unstuck them
	if game.tilemap.getValue(mapX, mapY, mapProp) == false then
		print(minion.name .. " " .. minion.id .. " is stuck")
		local tileScreenX, tileScreenY = game.tilemap.tilemapToScreen(mapX, mapY)

		-- calculate the distance a minion has already traveled in each potential fix direction
		local fixes = {
			{ "right", minion.position.x - tileScreenX },
			{ "left", tileScreenX - minion.position.x },
			{ "up", tileScreenY - minion.position.y },
			{ "down", minion.position.y - tileScreenY },
		}

		-- iterate over fixes with *most-distance-already-travelled* first and move them further in that direction but only if the tile in that direction can be moved to
		table.sort(fixes, function(a, b)
			return a[2] > b[2]
		end)
		for _, fix in ipairs(fixes) do
			if fix[1] == "right" then
				if game.tilemap.getValue(mapX + 1, mapY, mapProp) == true then
					print("    moving them to the right")
					minion.position.x = minion.position.x + game.conf.minions.unstuckMoveBy
					break
				else
					print("    would like to move them right but moving there is not possible")
				end
			elseif fix[1] == "left" then
				if game.tilemap.getValue(mapX - 1, mapY, mapProp) == true then
					print("    moving them to the left")
					minion.position.x = minion.position.x - game.conf.minions.unstuckMoveBy
					break
				else
					print("    would like to move them left but moving there is not possible")
				end
			elseif fix[1] == "up" then
				if game.tilemap.getValue(mapX, mapY - 1, mapProp) == true then
					print("    moving them up")
					minion.position.y = minion.position.y - game.conf.minions.unstuckMoveBy
					break
				else
					print("    would like to move them up but moving there is not possible")
				end
			elseif fix[1] == "down" then
				if game.tilemap.getValue(mapX, mapY + 1, mapProp) == true then
					print("    moving them down")
					minion.position.y = minion.position.y + game.conf.minions.unstuckMoveBy
					break
				else
					print("    would like to move them down but moving there is not possible")
				end
			end
		end

		-- trigger step-on and step-off events if the minion is now unstuck
		local newMapX, newMapY = game.tilemap.screenToWorldPos(minion.position.x, minion.position.y)
		if newMapX ~= mapX or newMapY ~= mapY then
			triggerMinionStepOff(minion, mapX, mapY)
			triggerMinionStepOn(minion, newMapX, newMapY)
		end
	end
end

function game.minions.kill(minion)
	print("killing " .. tostring(minion.name) .. " " .. tostring(minion.id))
	local _, i = game.minions.get(minion.id)
	table.remove(state.activeMinions, i)
	game.summoning.refreshSummon(minion.presetId)

	local randomDeathSoundIndex = math.random(1, #minion.deathSounds)
	game.minions.audio[minion.deathSounds[randomDeathSoundIndex]]:play()
end

--- callback when the game loads
function game.minions.load()
	-- nothing to do; initialization happens on level load

	-- load assets
	game.minions.assets = {}

	-- load audio
	game.minions.audio = {}

	for _, preset in pairs(game.conf.minions.presets) do
		for _, assetPath in pairs(preset.assets) do
			if not game.minions.assets[assetPath] then
				game.minions.assets[assetPath] = love.graphics.newImage(assetPath)
			end
		end

		for _, audioPath in pairs(preset.deathSounds) do
			if not game.minions.audio[audioPath] then
				game.minions.audio[audioPath] = love.audio.newSource(audioPath, "static")
				game.minions.audio[audioPath]:setVolume(game.conf.volume.voices)
			end
		end
	end
end

--- callback for game updates
function game.minions.update(dt)
	local currentLvl = game.state.level.current
	for _, minion in ipairs(state.activeMinions) do
		moveMinion(minion, dt)
		-- check if minion finished level during movement, if so aboard update as all minions will be cleared
		if currentLvl ~= game.state.level.current then
			return
		end
		rotateMinion(minion)
		unstuckMinion(minion)
	end

	-- update the idle state of minions
	idleUpdateTimer = idleUpdateTimer - dt

	if idleUpdateTimer <= 0 then
		idleUpdateTimer = game.conf.minions.idleTime
		if idleState == 1 then
			idleState = 2
		else
			idleState = 1
		end
	end
end

--- callback for rendering
function game.minions.draw()
	for _, minion in ipairs(state.activeMinions) do
		local asset = game.minions.assets[minion.assets[idleState]]

		--using sprite
		love.graphics.draw(
			asset,
			minion.position.x,
			minion.position.y - game.conf.level.tileSize / 2.5,
			math.rad(0),
			2,
			2,
			asset:getWidth() / 2,
			asset:getHeight() / 2
		)

		---- body
		--love.graphics.setColor(love.math.colorFromBytes(unpack(minion.color)))
		--love.graphics.circle("fill", minion.position.x, minion.position.y, MINION_SIZE)
		--
		---- eye white
		--local eyesSize = MINION_SIZE / 4
		--local eyesDistance = MINION_SIZE / 2
		--love.graphics.setColor(1, 1, 1)
		--love.graphics.circle(
		--	"fill",
		--	minion.position.x + math.cos(math.rad(minion.angle - 90 - 35)) * eyesDistance,
		--	minion.position.y + math.sin(math.rad(minion.angle - 90 - 35)) * eyesDistance,
		--	eyesSize
		--)
		--love.graphics.circle(
		--	"fill",
		--	minion.position.x + math.cos(math.rad(minion.angle - 90 + 35)) * eyesDistance,
		--	minion.position.y + math.sin(math.rad(minion.angle - 90 + 35)) * eyesDistance,
		--	eyesSize
		--)
		---- eye outline
		--love.graphics.setColor(0, 0, 0)
		--love.graphics.circle(
		--	"line",
		--	minion.position.x + math.cos(math.rad(minion.angle - 90 - 35)) * eyesDistance,
		--	minion.position.y + math.sin(math.rad(minion.angle - 90 - 35)) * eyesDistance,
		--	eyesSize
		--)
		--love.graphics.circle(
		--	"line",
		--	minion.position.x + math.cos(math.rad(minion.angle - 90 + 35)) * eyesDistance,
		--	minion.position.y + math.sin(math.rad(minion.angle - 90 + 35)) * eyesDistance,
		--	eyesSize
		--)
		---- pupils
		--love.graphics.setColor(0, 0, 0)
		--love.graphics.circle(
		--	"fill",
		--	minion.position.x + math.cos(math.rad(minion.angle - 90 - 35)) * eyesDistance,
		--	minion.position.y + math.sin(math.rad(minion.angle - 90 - 35)) * eyesDistance,
		--	eyesSize / 3
		--)
		--love.graphics.circle(
		--	"fill",
		--	minion.position.x + math.cos(math.rad(minion.angle - 90 + 35)) * eyesDistance,
		--	minion.position.y + math.sin(math.rad(minion.angle - 90 + 35)) * eyesDistance,
		--	eyesSize / 3
		--)

		-- carried object
		if minion.carrying == nil then
		elseif minion.carrying == "key" then
			error("rendering a minion carrying a key is not yet implemented")
		else
			error("cannot render carried item " .. tostring(minion.carrying))
		end
	end
end

--- callback for key presses
function game.minions.keypressed(key, scancode, isrepeat)
	if scancode == "e" and not isrepeat then
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
	minion.carrying = nil

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
