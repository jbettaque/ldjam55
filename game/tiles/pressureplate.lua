game.tiles.pressureplate = {}

local assets = {
	"assets/tiles/tile_pressureplate_off.png",
	"assets/tiles/tile_pressureplate_on.png",
}

pressureplate_step = function(x, y)
	print("step on pressureplate")
	game.tilemap.setAsset(x, y, game.tiles.pressureplate.tilePreset.asset_on)
	game.tilemap.setValue(x, y, "redstone", true)
end

pressureplate_step_off = function(x, y)
	print("step off pressureplate")
	game.tilemap.setAsset(x, y, game.tiles.pressureplate.tilePreset.asset_off)
	game.tilemap.setValue(x, y, "redstone", false)
end

function game.tiles.pressureplate.register()
	local assetOffset = game.tilemap.getAssetCount()
	print("assetOffset: " .. assetOffset)

	game.tilemap.registerAsset(assets[1])
	game.tilemap.registerAsset(assets[2])

	game.tiles.pressureplate.tilePreset = {
		preset = "pressureplate",
		asset = 1 + assetOffset,
		asset_on = 2 + assetOffset,
		asset_off = 1 + assetOffset,
		walkable = true,
		overFlyable = true,
		redstone = false,
		step_on = "pressureplate_step",
		step_off = "pressureplate_step_off",
	}

	game.tilemap.registerTilePreset("pressureplate", game.tiles.pressureplate.tilePreset)
	game.tilemap.registerStepOnFunction("pressureplate_step", pressureplate_step)
	game.tilemap.registerStepOffFunction("pressureplate_step_off", pressureplate_step_off)
end