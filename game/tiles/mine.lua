game.tiles.mine = {}

local asset = "assets/tiles/tile_mine.png"

audioMine = love.audio.newSource("assets/sfx/Mine1.mp3", "stream")

mine_step_func = function(x, y, minion)
	print(minion.name .. " " .. tostring(minion.id) .. " stepped on a mine")
	audioMine:setVolume(game.conf.volume.mineExplosion)
	love.audio.stop(audioMine)
	love.audio.play(audioMine)
	game.minions.kill(minion)
	game.tilemap.setTileWithPreset(x, y, tilePresets["ground"])
end

function game.tiles.mine.register()
	local assetOffset = game.tilemap.getAssetCount()

	game.tilemap.registerAsset(asset)
	print("assetOffset: " .. assetOffset)

	game.tiles.mine.tilePreset = {
		preset = "mine",
		asset = 1 + assetOffset,
		walkable = true,
		overFlyable = true,
		step_on = "mine_step_func",
	}

	game.tilemap.registerTilePreset("mine", game.tiles.mine.tilePreset)
	game.tilemap.registerStepOnFunction("mine_step_func", mine_step_func)
end
