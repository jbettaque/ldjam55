game.audio = {}
require("game.conf")
local introPlayed = false

function game.audio.load()
	audioIntro = love.audio.newSource("assets/music/intro.mp3", "stream")
	audioLoop = love.audio.newSource("assets/music/loop.mp3", "stream")

	audioIntro:setVolume(0.5)
	audioLoop:setVolume(0.5)
	if game.conf.editor then
		audioIntro:setVolume(0.05)
		audioLoop:setVolume(0.05)
	end
	audioIntro:setLooping(false)
end

function game.audio.update(dt)
	if not audioIntro:isPlaying() and not audioLoop:isPlaying() and not introPlayed then
		love.audio.play(audioIntro)
		introPlayed = true
	end

	if not audioIntro:isPlaying() and not audioLoop:isPlaying() and introPlayed then
		love.audio.play(audioLoop)
		audioIntro:setLooping(true)
	end
end
