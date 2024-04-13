---@class love
local m = {}

--region Data
---@class Data
---The superclass of all data.
local Data = {}
---Creates a new copy of the Data object.
---@return Data
function Data:clone() end

---Gets an FFI pointer to the Data.
---
---This function should be preferred instead of Data:getPointer because the latter uses light userdata which can't store more all possible memory addresses on some new ARM64 architectures, when LuaJIT is used.
---@return cdata
function Data:getFFIPointer() end

---Gets a pointer to the Data. Can be used with libraries such as LuaJIT's FFI.
---@return light userdata
function Data:getPointer() end

---Gets the Data's size in bytes.
---@return number
function Data:getSize() end

---Gets the full Data as a string.
---@return string
function Data:getString() end

--endregion Data
--region Object
---@class Object
---The superclass of all LÖVE types.
local Object = {}
---Destroys the object's Lua reference. The object will be completely deleted if it's not referenced by any other LÖVE object or thread.
---
---This method can be used to immediately clean up resources without waiting for Lua's garbage collector.
---@return boolean
function Object:release() end

---Gets the type of the object as a string.
---@return string
function Object:type() end

---Checks whether an object is of a certain type. If the object has the type with the specified name in its hierarchy, this function will return true.
---@param name string @The name of the type to check for.
---@return boolean
function Object:typeOf(name) end

--endregion Object
---@type love.audio
m.audio = nil

---@type love.data
m.data = nil

---@type love.event
m.event = nil

---@type love.filesystem
m.filesystem = nil

---@type love.font
m.font = nil

---@type love.graphics
m.graphics = nil

---@type love.image
m.image = nil

---@type love.joystick
m.joystick = nil

---@type love.keyboard
m.keyboard = nil

---@type love.math
m.math = nil

---@type love.mouse
m.mouse = nil

---@type love.physics
m.physics = nil

---@type love.sound
m.sound = nil

---@type love.system
m.system = nil

---@type love.thread
m.thread = nil

---@type love.timer
m.timer = nil

---@type love.touch
m.touch = nil

---@type love.video
m.video = nil

---@type love.window
m.window = nil

---Gets the current running version of LÖVE.
---@return number, number, number, string
function m.getVersion() end

---Gets whether LÖVE displays warnings when using deprecated functionality. It is disabled by default in fused mode, and enabled by default otherwise.
---
---When deprecation output is enabled, the first use of a formally deprecated LÖVE API will show a message at the bottom of the screen for a short time, and print the message to the console.
---@return boolean
function m.hasDeprecationOutput() end

---Gets whether the given version is compatible with the current running version of LÖVE.
---@param version string @The version to check (for example '11.3' or '0.10.2').
---@return boolean
---@overload fun(major:number, minor:number, revision:number):boolean
function m.isVersionCompatible(version) end

---Sets whether LÖVE displays warnings when using deprecated functionality. It is disabled by default in fused mode, and enabled by default otherwise.
---
---When deprecation output is enabled, the first use of a formally deprecated LÖVE API will show a message at the bottom of the screen for a short time, and print the message to the console.
---@param enable boolean @Whether to enable or disable deprecation output.
function m.setDeprecationOutput(enable) end

return m