game.tiles.key = {}

local asset = "assets/tiles/tile_key.png"

function game.tiles.key.register()
	local assetOffset = game.tilemap.getAssetCount()

	game.tilemap.registerAsset(asset)
	print("assetOffset: " .. assetOffset)

	game.tiles.key.tilePreset = {
		preset = "key",
		asset = 1 + assetOffset,
		walkable = true,
		overFlyable = true,
	}

	game.tilemap.registerTilePreset("key", game.tiles.key.tilePreset)
end
