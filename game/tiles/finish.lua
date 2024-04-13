game.tiles.finish = {}

local asset  = "assets/tiles/tile_finish.png"

function game.tiles.finish.register()
	local assetOffset = game.tilemap.getAssetCount()

	game.tilemap.registerAsset(asset)
	print("assetOffset: " .. assetOffset)

	game.tiles.finish.tilePreset = {
		asset = 1 + assetOffset,
		walkable = true,
	}

	game.tilemap.registerTilePreset("finish", game.tiles.finish.tilePreset)
end
