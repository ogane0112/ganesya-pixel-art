-- Isometric Book Pixel Art Generator for Aseprite

local spr = Sprite(64, 64, ColorMode.RGB)

-- レイヤーとセル
local layer = spr:newLayer()
layer.name = "Book"
local cel = spr:newCel(layer, 1)
local img = cel.image

-- 描画用関数
local function px(x, y, r, g, b)
  img:drawPixel(x, y, Color{r=r, g=g, b=b})
end

local function rect(x1, y1, x2, y2, r, g, b)
  for y=y1,y2 do
    for x=x1,x2 do
      px(x, y, r, g, b)
    end
  end
end

-- 色定義
local outline = {40, 60, 100}
local bookDark = {100, 140, 200}
local bookMid = {140, 180, 240}
local bookLight = {180, 210, 255}
local pageDark = {200, 160, 100}
local pageMid = {230, 200, 140}
local pageLight = {250, 230, 180}
local ribbonDark = {180, 40, 40}
local ribbon = {220, 60, 60}
local ribbonLight = {255, 100, 80}

-- 本の上面（表紙の上部）
-- アイソメトリックの上面を描画
for i=0,10 do
  for j=0,25 do
    local x = 18 + i + j
    local y = 15 + math.floor(i/2) - math.floor(j/2)
    if i < 3 then
      px(x, y, bookLight[1], bookLight[2], bookLight[3])
    elseif i < 6 then
      px(x, y, bookMid[1], bookMid[2], bookMid[3])
    else
      px(x, y, bookDark[1], bookDark[2], bookDark[3])
    end
  end
end

-- 本の左側面（背表紙）
for i=0,10 do
  for j=0,30 do
    local x = 18 + i
    local y = 20 + math.floor(i/2) + j
    px(x, y, bookDark[1]-30, bookDark[2]-30, bookDark[3]-30)
  end
end

-- 本の右側面
for i=0,25 do
  for j=0,30 do
    local x = 44 + i
    local y = 15 - math.floor(i/2) + j
    if j < 5 then
      px(x, y, bookMid[1], bookMid[2], bookMid[3])
    else
      px(x, y, bookDark[1], bookDark[2], bookDark[3])
    end
  end
end

-- ページ（本の下部の黄色い部分）
for i=0,25 do
  for j=0,6 do
    local x = 30 + i
    local y = 40 + j - math.floor(i/2)
    if j < 2 then
      px(x, y, pageLight[1], pageLight[2], pageLight[3])
    elseif j < 4 then
      px(x, y, pageMid[1], pageMid[2], pageMid[3])
    else
      px(x, y, pageDark[1], pageDark[2], pageDark[3])
    end
  end
end

-- しおり（赤いリボン）
for i=0,3 do
  for j=0,12 do
    local x = 35 + i
    local y = 46 + j
    if i == 0 or j < 2 then
      px(x, y, ribbonLight[1], ribbonLight[2], ribbonLight[3])
    elseif j > 10 then
      px(x, y, ribbonDark[1], ribbonDark[2], ribbonDark[3])
    else
      px(x, y, ribbon[1], ribbon[2], ribbon[3])
    end
  end
end

app.refresh()
