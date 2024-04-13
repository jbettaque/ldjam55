---@class love.font
---Allows you to work with fonts.
local m = {}

--region GlyphData
---@class GlyphData
---A GlyphData represents a drawable symbol of a font Rasterizer.
local GlyphData = {}
---Gets glyph advance.
---@return number
function GlyphData:getAdvance() end

---Gets glyph bearing.
---@return number, number
function GlyphData:getBearing() end

---Gets glyph bounding box.
---@return number, number, number, number
function GlyphData:getBoundingBox() end

---Gets glyph dimensions.
---@return number, number
function GlyphData:getDimensions() end

---Gets glyph pixel format.
---@return PixelFormat
function GlyphData:getFormat() end

---Gets glyph number.
---@return number
function GlyphData:getGlyph() end

---Gets glyph string.
---@return string
function GlyphData:getGlyphString() end

---Gets glyph height.
---@return number
function GlyphData:getHeight() end

---Gets glyph width.
---@return number
function GlyphData:getWidth() end

--endregion GlyphData
--region Rasterizer
---@class Rasterizer
---A Rasterizer handles font rendering, containing the font data (image or TrueType font) and drawable glyphs.
local Rasterizer = {}
---Gets font advance.
---@return number
function Rasterizer:getAdvance() end

---Gets ascent height.
---@return number
function Rasterizer:getAscent() end

---Gets descent height.
---@return number
function Rasterizer:getDescent() end

---Gets number of glyphs in font.
---@return number
function Rasterizer:getGlyphCount() end

---Gets glyph data of a specified glyph.
---@param glyph string @Glyph
---@return GlyphData
---@overload fun(glyphNumber:number):GlyphData
function Rasterizer:getGlyphData(glyph) end

---Gets font height.
---@return number
function Rasterizer:getHeight() end

---Gets line height of a font.
---@return number
function Rasterizer:getLineHeight() end

---Checks if font contains specified glyphs.
---@param glyph1 string or number @Glyph
---@param glyph2 string or number @Glyph
---@param ... string or number @Additional glyphs
---@return boolean
function Rasterizer:hasGlyphs(glyph1, glyph2, ...) end

--endregion Rasterizer
---True Type hinting mode.
HintingMode = {
	---Default hinting. Should be preferred for typical antialiased fonts.
	['normal'] = 1,
	---Results in fuzzier text but can sometimes preserve the original glyph shapes of the text better than normal hinting.
	['light'] = 2,
	---Results in aliased / unsmoothed text with either full opacity or completely transparent pixels. Should be used when antialiasing is not desired for the font.
	['mono'] = 3,
	---Disables hinting for the font. Results in fuzzier text.
	['none'] = 4,
}
---Creates a new BMFont Rasterizer.
---@param imageData ImageData @The image data containing the drawable pictures of font glyphs.
---@param glyphs string @The sequence of glyphs in the ImageData.
---@param dpiscale number @DPI scale.
---@return Rasterizer
---@overload fun(fileName:string, glyphs:string, dpiscale:number):Rasterizer
function m.newBMFontRasterizer(imageData, glyphs, dpiscale) end

---Creates a new GlyphData.
---@param rasterizer Rasterizer @The Rasterizer containing the font.
---@param glyph number @The character code of the glyph.
function m.newGlyphData(rasterizer, glyph) end

---Creates a new Image Rasterizer.
---@param imageData ImageData @Font image data.
---@param glyphs string @String containing font glyphs.
---@param extraSpacing number @Font extra spacing.
---@param dpiscale number @Font DPI scale.
---@return Rasterizer
function m.newImageRasterizer(imageData, glyphs, extraSpacing, dpiscale) end

---Creates a new Rasterizer.
---@param filename string @The font file.
---@return Rasterizer
---@overload fun(data:FileData):Rasterizer
---@overload fun(size:number, hinting:HintingMode, dpiscale:number):Rasterizer
---@overload fun(fileName:string, size:number, hinting:HintingMode, dpiscale:number):Rasterizer
---@overload fun(fileData:FileData, size:number, hinting:HintingMode, dpiscale:number):Rasterizer
---@overload fun(imageData:ImageData, glyphs:string, dpiscale:number):Rasterizer
---@overload fun(fileName:string, glyphs:string, dpiscale:number):Rasterizer
function m.newRasterizer(filename) end

---Creates a new TrueType Rasterizer.
---@param size number @The font size.
---@param hinting HintingMode @True Type hinting mode.
---@param dpiscale number @The font DPI scale.
---@return Rasterizer
---@overload fun(fileName:string, size:number, hinting:HintingMode, dpiscale:number):Rasterizer
---@overload fun(fileData:FileData, size:number, hinting:HintingMode, dpiscale:number):Rasterizer
function m.newTrueTypeRasterizer(size, hinting, dpiscale) end

return m