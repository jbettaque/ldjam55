game.tiles.mine = {}

local asset = "assets/tiles/tile_mine.png"

function game.tiles.mine.register()
	local assetOffset = game.tilemap.getAssetCount()

	game.tilemap.registerAsset(asset)
	print("assetOffset: " .. assetOffset)

	game.tiles.mine.tilePreset = {
		asset = 1 + assetOffset,
		walkable = false,
	}

	game.tilemap.registerTilePreset("mine", game.tiles.mine.tilePreset)
end
