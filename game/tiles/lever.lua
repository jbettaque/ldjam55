game.tiles.lever = {}

local assets = {
	"assets/tiles/tile_lever_off.png",
	"assets/tiles/tile_lever_on.png",
}
audioSwitch = love.audio.newSource("assets/sfx/Light Switch Click On Sfx.wav", "stream")

lever_interact = function(x, y)
	print("interact with lever")
	local asset = game.tilemap.getValue(x, y, "asset")

	 love.audio.stop(audioSwitch)

	if asset == game.tiles.lever.tilePreset.asset_off then
		game.tilemap.setAsset(x, y, game.tiles.lever.tilePreset.asset_on)
		game.tilemap.setValue(x, y, "redstone", true)
		love.audio.play(audioSwitch)
	else
		game.tilemap.setAsset(x, y, game.tiles.lever.tilePreset.asset_off)
		game.tilemap.setValue(x, y, "redstone", false)
		love.audio.play(audioSwitch)
	end
end

function game.tiles.lever.register()
	local assetOffset = game.tilemap.getAssetCount()
	print("assetOffset: " .. assetOffset)

	game.tilemap.registerAsset(assets[1])
	game.tilemap.registerAsset(assets[2])

	game.tiles.lever.tilePreset = {
		preset = "lever",
		asset = 1 + assetOffset,
		asset_on = 2 + assetOffset,
		asset_off = 1 + assetOffset,
		walkable = true,
		overFlyable = true,
		redstone = false,
		interact = "lever_interact",
	}

	game.tilemap.registerTilePreset("lever", game.tiles.lever.tilePreset)
	game.tilemap.registerInteractFunction("lever_interact", lever_interact)
end
