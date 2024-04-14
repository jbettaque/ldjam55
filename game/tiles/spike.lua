game.tiles.spike = {}

local asset = "assets/tiles/tile_spike.png"

spike_step = function(minion, x, y)
	print("step on spike")
	print(minion)
	game.minions.kill(minion)
end

function game.tiles.spike.register()
	local assetOffset = game.tilemap.getAssetCount()

	game.tilemap.registerAsset(asset)
	print("assetOffset: " .. assetOffset)

	game.tiles.spike.tilePreset = {
		asset = 1 + assetOffset,
		walkable = true,
		overFlyable = true,
		step_on = "spike_step",
	}

	game.tilemap.registerTilePreset("spike", game.tiles.spike.tilePreset)
	game.tilemap.registerStepOnFunction("spike_step", spike_step)
end
