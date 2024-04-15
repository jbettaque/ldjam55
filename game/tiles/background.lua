game.tiles.background = {}

local asset = "assets/tiles/tile_background.png"

function game.tiles.background.register()
	local assetOffset = game.tilemap.getAssetCount()

	game.tilemap.registerAsset(asset)
	print("assetOffset: " .. assetOffset)

	game.tiles.background.tilePreset = {
		preset = "background",
		asset = 1 + assetOffset,
		walkable = false,
		overFlyable = false,
	}

	game.tilemap.registerTilePreset("background", game.tiles.background.tilePreset)
end
