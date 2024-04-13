game.tiles.button = {}

local asset = "assets/tiles/tile_button.png"

function game.tiles.button.register()
	local assetOffset = game.tilemap.getAssetCount()

	game.tilemap.registerAsset(asset)
	print("assetOffset: " .. assetOffset)

	game.tiles.button.tilePreset = {
		asset = 1 + assetOffset,
		walkable = true,
		overFlyable = true,
	}

	game.tilemap.registerTilePreset("button", game.tiles.button.tilePreset)
end
