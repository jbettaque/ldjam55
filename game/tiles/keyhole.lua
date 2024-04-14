game.tiles.keyhole = {}

local assets = {
	"assets/tiles/tile_keyhole_locked.png",
	"assets/tiles/tile_keyhole_unlocked.png",
}

keyhole_interact = function(x, y, minion)
	print("interact with keyhole")
	print(minion)
	if minion.carrying == "key" then
		game.tilemap.setAsset(x, y, game.tiles.keyhole.tilePreset.unlocked)
		game.tilemap.setValue(x, y, "redstone", true)
		minion.carrying = nil
	end
end

function game.tiles.keyhole.register()
	local assetOffset = game.tilemap.getAssetCount()
	print("assetOffset: " .. assetOffset)

	game.tilemap.registerAsset(assets[1])
	game.tilemap.registerAsset(assets[2])

	game.tiles.keyhole.tilePreset = {
		preset = "keyhole",
		asset = 1 + assetOffset,
		unlocked = 2 + assetOffset,
		locked = 1 + assetOffset,
		walkable = true,
		overFlyable = true,
		redstone = false,
		interact = "keyhole_interact",
	}

	game.tilemap.registerTilePreset("keyhole", game.tiles.keyhole.tilePreset)
	game.tilemap.registerInteractFunction("keyhole_interact", keyhole_interact)
end
