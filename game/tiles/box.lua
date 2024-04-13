game.tiles.box = {}

local asset = "assets/tiles/tile_box.png"

function game.tiles.box.register()
	local assetOffset = game.tilemap.getAssetCount()

	game.tilemap.registerAsset(asset)
	print("assetOffset: " .. assetOffset)

	game.tiles.box.tilePreset = {
		preset = "box",
		asset = 1 + assetOffset,
		walkable = false,
		overFlyable = false,
	}

	game.tilemap.registerTilePreset("box", game.tiles.box.tilePreset)
end
