game.tiles.spike = {}

local assets = {
	"assets/tiles/tile_spike_up.png",
	"assets/tiles/tile_spike_down.png",
}
spike_step = function(x, y, minion)
	print(minion.name .. " " .. tostring(minion.id) .. " stepped on a spike; killing them")

	if game.tilemap.getValue(x, y, "asset") == game.tiles.spike.tilePreset.asset_down then
		return
	end
	game.minions.kill(minion)
end

spike_update_func = function(x, y, dt)
	print("update spike")
	local shouldBeUp = true
	if game.tilemap.getValue(x, y, "needs_redstone") then
		local redstoneNeeded = game.tilemap.getValue(x, y, "needs_redstone")

		for i = 1, #redstoneNeeded do
			local redstoneX = redstoneNeeded[i].x
			local redstoneY = redstoneNeeded[i].y

			if not game.tilemap.getValue(redstoneX, redstoneY, "redstone") then
				shouldBeUp = false
			end
		end
	end

	local assetUp = game.tilemap.getValue(x, y, "asset_up")
	local assetDown = game.tilemap.getValue(x, y, "asset_down")

	if game.tilemap.getValue(x, y, "inverted") then
		shouldBeUp = not shouldBeUp
	end

	if shouldBeUp then
		game.tilemap.setAsset(x, y, assetUp)
	else
		game.tilemap.setAsset(x, y, assetDown)
	end
end

function game.tiles.spike.register()
	local assetOffset = game.tilemap.getAssetCount()
	print("assetOffset: " .. assetOffset)

	game.tilemap.registerAsset(assets[1])
	game.tilemap.registerAsset(assets[2])

	game.tiles.spike.tilePreset = {
		asset = 1 + assetOffset,
		asset_up = 1 + assetOffset,
		asset_down = 2 + assetOffset,
		walkable = true,
		overFlyable = true,
		inverted = false,
		step_on = "spike_step",
		update = "spike_update_func",
	}

	game.tilemap.registerTilePreset("spike", game.tiles.spike.tilePreset)
	game.tilemap.registerStepOnFunction("spike_step", spike_step)
	game.tilemap.registerUpdateFunction("spike_update_func", spike_update_func)
end
