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

game.tiles.door.doorTilePresets = {
	door_hor = { asset = 3, assetOpen = 4, assetClosed = 3, walkable = false, interact = door_func },
	door_vert = { asset = 5, assetOpen = 6, assetClosed = 5, walkable = false, interact = door_func },
}

local doorAssets = {
	"assets/tiles/door_hor_closed.png",
	"assets/tiles/door_hor_open.png",
	"assets/tiles/door_ver_closed.png",
	"assets/tiles/door_ver_open.png",
}

function game.tiles.door.register()
	game.tilemap.registerTilePresets(game.tiles.door.doorTilePresets)
	for i = 1, #doorAssets do
		game.tilemap.registerAsset(doorAssets[i])
	end
end
