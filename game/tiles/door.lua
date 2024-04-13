game.tilemap = game.tilemap or require("game.tilemap")
game.tiles.door = {}

door_func = function(x, y, button)
	if button == 1 then
		local assetOpen = game.tilemap.getValue(x, y, "assetOpen")
		game.tilemap.setAsset(x, y, assetOpen)
		game.tilemap.setValue(x, y, "walkable", true)
	elseif button == 2 then
		local assetClosed = game.tilemap.getValue(x, y, "assetClosed")
		game.tilemap.setAsset(x, y, assetClosed)
		game.tilemap.setValue(x, y, "walkable", false)
	end
end

local doorAssets = {
	"assets/tiles/door_hor_closed.png",
	"assets/tiles/door_hor_open.png",
	"assets/tiles/door_ver_closed.png",
	"assets/tiles/door_ver_open.png",
}

function game.tiles.door.register()
	local assetOffset = game.tilemap.getAssetCount()

	game.tiles.door.doorTilePresets = {
		door_hor = {
			asset = 1 + assetOffset,
			assetOpen = 2 + assetOffset,
			assetClosed = 1 + assetOffset,
			walkable = false,
			interact = door_func,
		},
		door_vert = {
			asset = 3 + assetOffset,
			assetOpen = 4 + assetOffset,
			assetClosed = 3 + assetOffset,
			walkable = false,
			interact = door_func,
		},
	}

	for i = 1, #doorAssets do
		game.tilemap.registerAsset(doorAssets[i])
	end

	game.tilemap.registerTilePresets(game.tiles.door.doorTilePresets)
end
