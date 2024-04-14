game.tiles.key = {}

local asset = "assets/tiles/tile_key.png"

key_step_func = function(x, y, minion)
	print("step on key")
	print(minion)
	minion.carrying = "key"
	game.tilemap.setTileWithPreset(x, y, tilePresets["ground"])
end

function game.tiles.key.register()
	local assetOffset = game.tilemap.getAssetCount()

	game.tilemap.registerAsset(asset)
	print("assetOffset: " .. assetOffset)

	game.tiles.key.tilePreset = {
		preset = "key",
		asset = 1 + assetOffset,
		walkable = true,
		overFlyable = true,
		step_on = "key_step_func",
	}

	game.tilemap.registerTilePreset("key", game.tiles.key.tilePreset)
	game.tilemap.registerStepOnFunction("key_step_func", key_step_func)
end
