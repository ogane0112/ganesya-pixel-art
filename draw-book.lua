-- Book Pixel Art Generator for Aseprite
local spr = Sprite(32, 32, ColorMode.RGB)
spr:setPalette(Palette{
  Color{ r=60, g=40, b=30 },   -- outline
  Color{ r=120, g=40, b=40 }, -- cover
  Color{ r=180, g=70, b=70 }, -- highlight
  Color{ r=230, g=220, b=200 } -- pages
})

local outline = spr:newLayer()
outline.name = "Outline"
local cover = spr:newLayer()
cover.name = "Cover"
local pages = spr:newLayer()
pages.name = "Pages"

local function px(layer, x, y, c)
  spr.cels[layer].image:drawPixel(x, y, c)
end

-- Pages
for y=6,25 do
  for x=10,21 do
    px(pages, x, y, 3)
  end
end

-- Cover
for y=5,26 do
  for x=6,19 do
    px(cover, x, y, 1)
  end
end

-- Highlight
for y=6,25 do
  px(cover, 7, y, 2)
end

-- Outline
for x=5,20 do
  px(outline, x, 4, 0)
  px(outline, x, 27, 0)
end
for y=4,27 do
  px(outline, 5, y, 0)
  px(outline, 20, y, 0)
end

app.refresh()
