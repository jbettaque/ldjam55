game.tiles.pit = {}

local asset = "assets/tiles/tile_pit.png"

function game.tiles.pit.register()
	local assetOffset = game.tilemap.getAssetCount()

	game.tilemap.registerAsset(asset)
	print("assetOffset: " .. assetOffset)

	game.tiles.pit.tilePreset = {
		asset = 1 + assetOffset,
		walkable = true,
	}

	game.tilemap.registerTilePreset("pit", game.tiles.pit.tilePreset)
end
