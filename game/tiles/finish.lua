game.tiles.finish = {}
game.tilemap = game.tilemap or require("game.tilemap")

local asset = "assets/tiles/tile_finish.png"

stepOnFinish = function(x, y)
	print("step on finish")
	game.tilemap.nextLevel()
end

function game.tiles.finish.register()
	local assetOffset = game.tilemap.getAssetCount()

	game.tilemap.registerAsset(asset)
	print("assetOffset: " .. assetOffset)

	game.tiles.finish.tilePreset = {
		preset = "finish",
		asset = 1 + assetOffset,
		walkable = true,
		overFlyable = true,
		step_on = "finish_step",
	}

	game.tilemap.registerStepOnFunction("finish_step", stepOnFinish)
	game.tilemap.registerTilePreset("finish", game.tiles.finish.tilePreset)
end
