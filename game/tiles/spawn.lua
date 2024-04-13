game.tiles.spawn = {}

local asset = "assets/tiles/tile_spawn.png"

function game.tiles.spawn.register()
	local assetOffset = game.tilemap.getAssetCount()

	game.tilemap.registerAsset(asset)
	print("assetOffset: " .. assetOffset)

	game.tiles.spawn.tilePreset = {
		asset = 1 + assetOffset,
		walkable = true,
		overFlyable = true,
	}

	game.tilemap.registerTilePreset("spawn", game.tiles.spawn.tilePreset)
end
