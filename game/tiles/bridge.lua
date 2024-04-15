game.tiles.bridge = {}

local asset = "assets/tiles/tile_ground.png"

function game.tiles.bridge.register()
	local assetOffset = game.tilemap.getAssetCount()

	game.tilemap.registerAsset(asset)
	print("assetOffset: " .. assetOffset)

	game.tiles.bridge.tilePreset = {
		preset = "bridge",
		asset = 1 + assetOffset,
		walkable = false,
		overFlyable = true,
	}

	game.tilemap.registerTilePreset("bridge", game.tiles.bridge.tilePreset)
end
