game.tilemap = game.tilemap or require("game.tilemap")
game.tiles.door = {}

door_func = function(x, y, button)
	if button == 1 then
		if game.tilemap.getValue(x, y, "needs_redstone") then
			local redstoneNeeded = game.tilemap.getValue(x, y, "needs_redstone")

			for i = 1, #redstoneNeeded do
				local redstoneX = redstoneNeeded[i].x
				local redstoneY = redstoneNeeded[i].y

				if not game.tilemap.getValue(redstoneX, redstoneY, "redstone") then
					return
				end
			end
		end

		local assetOpen = game.tilemap.getValue(x, y, "assetOpen")
		local assetClosed = game.tilemap.getValue(x, y, "assetClosed")

		local asset = game.tilemap.getAsset(x, y)

		if asset == assetOpen then
			game.tilemap.setAsset(x, y, assetClosed)
			game.tilemap.setValue(x, y, "walkable", false)
			game.tilemap.setValue(x, y, "overFlyable", false)
		else
			game.tilemap.setAsset(x, y, assetOpen)
			game.tilemap.setValue(x, y, "walkable", true)
			game.tilemap.setValue(x, y, "overFlyable", true)
		end
	end
end

door_update_func = function(x, y, dt)
	local shouldBeOpen = true
	if game.tilemap.getValue(x, y, "needs_redstone") then
		local redstoneNeeded = game.tilemap.getValue(x, y, "needs_redstone")

		for i = 1, #redstoneNeeded do
			local redstoneX = redstoneNeeded[i].x
			local redstoneY = redstoneNeeded[i].y

			if not game.tilemap.getValue(redstoneX, redstoneY, "redstone") then
				shouldBeOpen = false
			end
		end
	end

	local assetOpen = game.tilemap.getValue(x, y, "assetOpen")
	local assetClosed = game.tilemap.getValue(x, y, "assetClosed")

	local asset = game.tilemap.getAsset(x, y)

	if shouldBeOpen then
		game.tilemap.setAsset(x, y, assetOpen)
		game.tilemap.setValue(x, y, "walkable", true)
		game.tilemap.setValue(x, y, "overFlyable", true)
	else
		game.tilemap.setAsset(x, y, assetClosed)
		game.tilemap.setValue(x, y, "walkable", false)
		game.tilemap.setValue(x, y, "overFlyable", false)
	end
end

door_step = function(x, y)
	print("step on door")
end

local doorAssets = {
	"assets/tiles/door_hor_closed.png",
	"assets/tiles/door_hor_open.png",
	"assets/tiles/door_ver_closed.png",
	"assets/tiles/door_ver_open.png",
}

function game.tiles.door.register()
	local assetOffset = game.tilemap.getAssetCount()

	game.tiles.door.doorTilePresets = {
		door_hor = {
			preset = "door_hor",
			asset = 1 + assetOffset,
			assetOpen = 2 + assetOffset,
			assetClosed = 1 + assetOffset,
			walkable = false,
			overFlyable = false,
			interact = "door_func",
			step_on = "door_step",
			update = "door_update_func",
		},
		door_vert = {
			preset = "door_vert",
			asset = 3 + assetOffset,
			assetOpen = 4 + assetOffset,
			assetClosed = 3 + assetOffset,
			walkable = false,
			overFlyable = false,
			interact = "door_func",
			step_on = "door_step",
			update = "door_update_func",
		},
	}

	for i = 1, #doorAssets do
		game.tilemap.registerAsset(doorAssets[i])
	end

	game.tilemap.registerStepOnFunction("door_step", door_step)
	game.tilemap.registerTilePreset("door_hor", game.tiles.door.doorTilePresets.door_hor)
	game.tilemap.registerTilePreset("door_vert", game.tiles.door.doorTilePresets.door_vert)
	game.tilemap.registerInteractFunction("door_func", door_func)
	game.tilemap.registerUpdateFunction("door_update_func", door_update_func)
end
