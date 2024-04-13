game.tiles.spike = {}

local asset = "assets/tiles/tile_spike.png"

function game.tiles.spike.register()
    local assetOffset = game.tilemap.getAssetCount()

    game.tilemap.registerAsset(asset)
    print("assetOffset: " .. assetOffset)

    game.tiles.spike.tilePreset = {
        asset = 1 + assetOffset,
        walkable = false,
    }

    game.tilemap.registerTilePreset("spike", game.tiles.spike.tilePreset)
end
