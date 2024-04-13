---@class love.video
---This module is responsible for decoding, controlling, and streaming video files.
---
---It can't draw the videos, see love.graphics.newVideo and Video objects for that.
local m = {}

--region VideoStream
---@class VideoStream
---An object which decodes, streams, and controls Videos.
local VideoStream = {}
---Gets the filename of the VideoStream.
---@return string
function VideoStream:getFilename() end

---Gets whether the VideoStream is playing.
---@return boolean
function VideoStream:isPlaying() end

---Pauses the VideoStream.
function VideoStream:pause() end

---Plays the VideoStream.
function VideoStream:play() end

---Rewinds the VideoStream. Synonym to VideoStream:seek(0).
function VideoStream:rewind() end

---Sets the current playback position of the VideoStream.
---@param offset number @The time in seconds since the beginning of the VideoStream.
function VideoStream:seek(offset) end

---Gets the current playback position of the VideoStream.
---@return number
function VideoStream:tell() end

--endregion VideoStream
---Creates a new VideoStream. Currently only Ogg Theora video files are supported. VideoStreams can't draw videos, see love.graphics.newVideo for that.
---@param filename string @The file path to the Ogg Theora video file.
---@return VideoStream
---@overload fun(file:File):VideoStream
function m.newVideoStream(filename) end

return m