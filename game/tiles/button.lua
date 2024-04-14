game.tiles.button = {}

local assets = {
	"assets/tiles/tile_button_off.png",
	"assets/tiles/tile_button_on.png",
}

button_interact = function(x, y, minion)
	print(minion.name .. " " .. tostring(minion.id) .. " is interacting with a button")

	game.tilemap.setAsset(x, y, game.tiles.button.tilePreset.asset_on)
	game.tilemap.setValue(x, y, "redstone", true)
	game.tilemap.setValue(x, y, "timer", 5)
end

button_update_func = function(x, y, dt)
	local timer = game.tilemap.getValue(x, y, "timer")
	if timer > 0 then
		timer = timer - dt
		if timer <= 0 then
			game.tilemap.setAsset(x, y, game.tiles.button.tilePreset.asset_off)
			game.tilemap.setValue(x, y, "redstone", false)
		end
		game.tilemap.setValue(x, y, "timer", timer)
	end
end

function game.tiles.button.register()
	local assetOffset = game.tilemap.getAssetCount()
	print("assetOffset: " .. assetOffset)

	game.tilemap.registerAsset(assets[1])
	game.tilemap.registerAsset(assets[2])

	game.tiles.button.tilePreset = {
		preset = "button",
		asset = 1 + assetOffset,
		asset_on = 2 + assetOffset,
		asset_off = 1 + assetOffset,
		walkable = true,
		overFlyable = true,
		redstone = false,
		interact = "button_interact",
		timer = 0,
		update = "button_update_func",
	}

	game.tilemap.registerTilePreset("button", game.tiles.button.tilePreset)
	game.tilemap.registerInteractFunction("button_interact", button_interact)
	game.tilemap.registerUpdateFunction("button_update_func", button_update_func)
end
