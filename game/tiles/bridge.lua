game.tiles.bridge= {}

local asset = "assets/tiles/tile_bridge.png"

function game.tiles.bridge.register()
    local assetOffset = game.tilemap.getAssetCount()

    game.tilemap.registerAsset(asset)
    print("assetOffset: " .. assetOffset)

    game.tiles.bridge.tilePreset = {
        asset = 1 + assetOffset,
        walkable = false,
    }

    game.tilemap.registerTilePreset("bridge", game.tiles.bridge.tilePreset)
end
