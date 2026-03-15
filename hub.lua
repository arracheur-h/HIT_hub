-- ╔══════════════════════════════════════════════════════════════╗
-- ║   三 XT 四 SY  —  Script Hub                               ║
-- ║   桜の道 — Add your scripts below                          ║
-- ╚══════════════════════════════════════════════════════════════╝

local TweenService  = game:GetService("TweenService")
local RunService    = game:GetService("RunService")
local Players       = game:GetService("Players")
local UIS           = game:GetService("UserInputService")
local playerGui     = Players.LocalPlayer:WaitForChild("PlayerGui")

-- ══════════════════════════════════════════════════════════════
--  ✦ AJOUTE TES SCRIPTS ICI ✦
-- ══════════════════════════════════════════════════════════════
local SCRIPTS = {
    {
        name = "⚡Ninja Legends",
        desc = "Auto Farm, Auto Play",
        url  = "https://raw.githubusercontent.com/arracheur-h/HIT_hub/refs/heads/main/ninjalegends.lua",
    },
    {
        name = "Taxi Boss 🚖",
        desc = "Auto Farm, Money Hack",
        url  = "https://raw.githubusercontent.com/arracheur-h/HIT_hub/refs/heads/main/TaxiBoss.lua",
    },
    {
        name = "OP Auto Play Piano",
        desc = "Auto Play",
        url  = "https://raw.githubusercontent.com/arracheur-h/HIT_hub/refs/heads/main/Digital%20Piano.lua",
    },
    {
        name = "Aimbot Rivals",
        desc = "Aimbot for Rivals",
        url  = "https://raw.githubusercontent.com/arracheur-h/HIT_hub/refs/heads/main/rivals.lua",
    },
    {
        name = "Hide or Die",
        desc = "Auto Farm, Steal Win",
        url  = "https://raw.githubusercontent.com/arracheur-h/HIT_hub/refs/heads/main/hideordie.lua",
    },
    {
        name = "Universal TargetBot",
        desc = "Aimbot, Target Bot",
        url  = "https://raw.githubusercontent.com/arracheur-h/HIT_hub/refs/heads/main/aimbot.lua",
    },
}
-- ══════════════════════════════════════════════════════════════

local C = {
    black    = Color3.fromRGB(0,   0,   0),
    surface  = Color3.fromRGB(8,   6,   7),
    surface2 = Color3.fromRGB(13,  10,  11),
    border   = Color3.fromRGB(28,  22,  25),
    white    = Color3.fromRGB(255, 255, 255),
    dim      = Color3.fromRGB(110, 100, 105),
    muted    = Color3.fromRGB(50,  42,  46),
    pink     = Color3.fromRGB(255, 196, 229),
    pinkDim  = Color3.fromRGB(180, 120, 155),
    pinkFade = Color3.fromRGB(30,  20,  26),
    red      = Color3.fromRGB(255, 60,  80),
    green    = Color3.fromRGB(100, 220, 160),
}

-- ══════════════════════════════════════════════════════════════
--  GUI
-- ══════════════════════════════════════════════════════════════
local gui = Instance.new("ScreenGui")
gui.Name           = "Ext4syScriptHub"
gui.ResetOnSpawn   = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
gui.Parent         = playerGui

-- ── Stars ──────────────────────────────────────────────────────
local starHolder = Instance.new("Frame", gui)
starHolder.Size = UDim2.fromScale(1,1)
starHolder.BackgroundTransparency = 1
starHolder.BorderSizePixel = 0
starHolder.ZIndex = 1

local stars = {}
for i = 1, 70 do
    local f = Instance.new("Frame", starHolder)
    local sz = math.random(1,2)
    f.Size = UDim2.new(0,sz,0,sz)
    f.Position = UDim2.new(math.random(),0,math.random(),0)
    f.BackgroundColor3 = math.random()>0.65 and C.pink or C.white
    f.BackgroundTransparency = math.random()*0.5+0.4
    f.BorderSizePixel = 0
    f.ZIndex = 1
    Instance.new("UICorner",f).CornerRadius = UDim.new(1,0)
    stars[i] = {
        frame=f, px=f.Position.X.Scale, py=f.Position.Y.Scale,
        vx=(math.random()-.5)*0.0001, vy=(math.random()-.5)*0.0001,
        baseT=math.random()*0.5+0.3, tVal=0,
        tSpd=math.random()*0.008+0.002, tDir=math.random()>0.5 and 1 or -1
    }
end

-- ── Petals ─────────────────────────────────────────────────────
local petalHolder = Instance.new("Frame", gui)
petalHolder.Size = UDim2.fromScale(1,1)
petalHolder.BackgroundTransparency = 1
petalHolder.BorderSizePixel = 0
petalHolder.ZIndex = 2

local petals = {}
for i = 1, 14 do
    local p = Instance.new("Frame", petalHolder)
    local sz = math.random(4,8)
    p.Size = UDim2.new(0,sz,0,sz)
    p.Position = UDim2.new(math.random(),0,-0.05,0)
    p.BackgroundColor3 = C.pink
    p.BackgroundTransparency = math.random()*0.35+0.45
    p.BorderSizePixel = 0
    p.ZIndex = 2
    Instance.new("UICorner",p).CornerRadius = math.random()>0.5 and UDim.new(1,0) or UDim.new(0.5,0)
    petals[i] = {
        frame=p, px=math.random(), py=-0.05-math.random()*0.3,
        speed=math.random()*0.0003+0.0001, drift=(math.random()-.5)*0.00014,
        wb=0, wbSpd=math.random()*0.035+0.015
    }
end

-- ══════════════════════════════════════════════════════════════
--  STARTUP ANIMATION OVERLAY
-- ══════════════════════════════════════════════════════════════
local introFrame = Instance.new("Frame", gui)
introFrame.Size = UDim2.fromScale(1,1)
introFrame.BackgroundColor3 = C.black
introFrame.BackgroundTransparency = 0
introFrame.BorderSizePixel = 0
introFrame.ZIndex = 100

local introLogo = Instance.new("TextLabel", introFrame)
introLogo.Size = UDim2.new(0,300,0,50)
introLogo.Position = UDim2.new(0.5,-150,0.5,-60)
introLogo.BackgroundTransparency = 1
introLogo.Text = "3XT4SY"
introLogo.Font = Enum.Font.GothamBold
introLogo.TextSize = 32
introLogo.TextColor3 = C.white
introLogo.TextTransparency = 1
introLogo.TextXAlignment = Enum.TextXAlignment.Center
introLogo.ZIndex = 101

local introJp = Instance.new("TextLabel", introFrame)
introJp.Size = UDim2.new(0,300,0,20)
introJp.Position = UDim2.new(0.5,-150,0.5,-10)
introJp.BackgroundTransparency = 1
introJp.Text = "三 XT 四 SY　—　Script Hub"
introJp.Font = Enum.Font.Gotham
introJp.TextSize = 11
introJp.TextColor3 = C.pink
introJp.TextTransparency = 1
introJp.TextXAlignment = Enum.TextXAlignment.Center
introJp.ZIndex = 101

local introLine = Instance.new("Frame", introFrame)
introLine.Size = UDim2.new(0,0,0,1)
introLine.Position = UDim2.new(0.5,0,0.5,18)
introLine.BackgroundColor3 = C.pink
introLine.BackgroundTransparency = 0.4
introLine.BorderSizePixel = 0
introLine.ZIndex = 101
local ilg = Instance.new("UIGradient", introLine)
ilg.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.new(0,0,0)),
    ColorSequenceKeypoint.new(0.5, C.pink),
    ColorSequenceKeypoint.new(1, Color3.new(0,0,0)),
}

local introSub = Instance.new("TextLabel", introFrame)
introSub.Size = UDim2.new(0,300,0,18)
introSub.Position = UDim2.new(0.5,-150,0.5,28)
introSub.BackgroundTransparency = 1
introSub.Text = "// 桜の道  —  the path opens"
introSub.Font = Enum.Font.Gotham
introSub.TextSize = 10
introSub.TextColor3 = C.muted
introSub.TextTransparency = 1
introSub.TextXAlignment = Enum.TextXAlignment.Center
introSub.ZIndex = 101

-- Extra intro elements
local introMsg = Instance.new("TextLabel", introFrame)
introMsg.Size = UDim2.new(0,320,0,16)
introMsg.Position = UDim2.new(0.5,-160,0.5,52)
introMsg.BackgroundTransparency = 1
introMsg.Text = ""
introMsg.Font = Enum.Font.Gotham
introMsg.TextSize = 9
introMsg.TextColor3 = C.pinkDim
introMsg.TextTransparency = 1
introMsg.TextXAlignment = Enum.TextXAlignment.Center
introMsg.ZIndex = 101

local introCounter = Instance.new("TextLabel", introFrame)
introCounter.Size = UDim2.new(0,200,0,14)
introCounter.Position = UDim2.new(0.5,-100,1,-30)
introCounter.BackgroundTransparency = 1
introCounter.Text = "// initializing..."
introCounter.Font = Enum.Font.Gotham
introCounter.TextSize = 8
introCounter.TextColor3 = C.muted
introCounter.TextTransparency = 0.4
introCounter.TextXAlignment = Enum.TextXAlignment.Center
introCounter.ZIndex = 101

-- Progress bar
local introBarBg = Instance.new("Frame", introFrame)
introBarBg.Size = UDim2.new(0,200,0,2)
introBarBg.Position = UDim2.new(0.5,-100,1,-50)
introBarBg.BackgroundColor3 = Color3.fromRGB(20,14,17)
introBarBg.BorderSizePixel = 0
introBarBg.ZIndex = 101
Instance.new("UICorner", introBarBg).CornerRadius = UDim.new(1,0)

local introBar = Instance.new("Frame", introBarBg)
introBar.Size = UDim2.new(0,0,1,0)
introBar.BackgroundColor3 = C.pink
introBar.BorderSizePixel = 0
introBar.ZIndex = 102
Instance.new("UICorner", introBar).CornerRadius = UDim.new(1,0)
local ibg = Instance.new("UIGradient", introBar)
ibg.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, C.white),
    ColorSequenceKeypoint.new(0.5, C.pink),
    ColorSequenceKeypoint.new(1, C.white),
}

local MESSAGES = {
    "thanks for using 3xt4sy hub 🌸",
    "loading your scripts...",
    "三 XT 四 SY — stay safe !",
    "桜の道 — the path is ready",
    "welcome back, warrior ⚡",
}

local function fadeMsg(txt, delay)
    task.wait(delay)
    introMsg.Text = txt
    introMsg.TextTransparency = 1
    TweenService:Create(introMsg, TweenInfo.new(0.3), {TextTransparency = 0.1}):Play()
    task.wait(0.7)
    TweenService:Create(introMsg, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
end

local function setProgress(pct, t)
    TweenService:Create(introBar, TweenInfo.new(t or 0.4, Enum.EasingStyle.Quart), {
        Size = UDim2.new(pct, 0, 1, 0)
    }):Play()
end

-- Run intro sequence
task.spawn(function()
    task.wait(0.15)

    -- 1. Logo appears
    TweenService:Create(introLogo, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        TextTransparency = 0,
        Position = UDim2.new(0.5,-150,0.5,-65)
    }):Play()
    task.wait(0.4)

    -- 2. JP subtitle
    TweenService:Create(introJp, TweenInfo.new(0.5), {TextTransparency = 0.25}):Play()
    task.wait(0.3)

    -- 3. Line expands
    TweenService:Create(introLine, TweenInfo.new(0.6, Enum.EasingStyle.Quart), {
        Size = UDim2.new(0,200,0,1),
        Position = UDim2.new(0.5,-100,0.5,18)
    }):Play()
    task.wait(0.25)

    -- 4. Sub tagline
    TweenService:Create(introSub, TweenInfo.new(0.4), {TextTransparency = 0.4}):Play()
    task.wait(0.3)

    -- 5. Progress starts + messages cycle
    setProgress(0.15, 0.3)
    introCounter.Text = "// loading scripts..."
    task.spawn(function() fadeMsg(MESSAGES[1], 0) end)
    task.wait(0.9)

    setProgress(0.38, 0.35)
    introCounter.Text = "// checking connection..."
    task.spawn(function() fadeMsg(MESSAGES[2], 0) end)
    task.wait(0.9)

    setProgress(0.60, 0.35)
    introCounter.Text = "// building interface..."
    task.spawn(function() fadeMsg(MESSAGES[3], 0) end)
    task.wait(0.9)

    setProgress(0.82, 0.3)
    introCounter.Text = "// almost ready..."
    task.spawn(function() fadeMsg(MESSAGES[4], 0) end)
    task.wait(0.85)

    setProgress(1.0, 0.25)
    introCounter.Text = "// ready !"
    task.spawn(function() fadeMsg(MESSAGES[5], 0) end)
    task.wait(0.7)

    -- 6. Fade everything out
    local fadeInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quart)
    TweenService:Create(introFrame,   fadeInfo, {BackgroundTransparency = 1}):Play()
    TweenService:Create(introLogo,    fadeInfo, {TextTransparency = 1}):Play()
    TweenService:Create(introJp,      fadeInfo, {TextTransparency = 1}):Play()
    TweenService:Create(introSub,     fadeInfo, {TextTransparency = 1}):Play()
    TweenService:Create(introMsg,     fadeInfo, {TextTransparency = 1}):Play()
    TweenService:Create(introCounter, fadeInfo, {TextTransparency = 1}):Play()
    TweenService:Create(introLine,    fadeInfo, {BackgroundTransparency = 1}):Play()
    TweenService:Create(introBarBg,   fadeInfo, {BackgroundTransparency = 1}):Play()
    TweenService:Create(introBar,     fadeInfo, {BackgroundTransparency = 1}):Play()
    task.wait(0.55)
    introFrame:Destroy()

    -- 7. Window pops in with bounce
    win.Position         = UDim2.new(0.5,-WIN_W/2, 0.5,-WIN_H/2 + 18)
    win.BackgroundTransparency = 1
    TweenService:Create(win, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5,-WIN_W/2, 0.5,-WIN_H/2),
        BackgroundTransparency = 0,
    }):Play()
end)

-- ══════════════════════════════════════════════════════════════
--  WINDOW
-- ══════════════════════════════════════════════════════════════
local WIN_W, WIN_H = 420, 480
local MINI_H       = 40  -- height when minimized

local win = Instance.new("Frame", gui)
win.Size             = UDim2.new(0, WIN_W, 0, WIN_H)
win.Position         = UDim2.new(0.5,-WIN_W/2, 0.5,-WIN_H/2)
win.BackgroundColor3 = C.surface
win.BackgroundTransparency = 1  -- starts invisible (intro handles reveal)
win.BorderSizePixel  = 0
win.ClipsDescendants = true
win.ZIndex           = 10
Instance.new("UICorner", win).CornerRadius = UDim.new(0,4)
local ws = Instance.new("UIStroke", win)
ws.Color = C.border; ws.Thickness = 1

-- Top accent line
local topLine = Instance.new("Frame", win)
topLine.Size = UDim2.new(1,0,0,1)
topLine.BackgroundColor3 = C.pink
topLine.BackgroundTransparency = 0.35
topLine.BorderSizePixel = 0
topLine.ZIndex = 11
local tg = Instance.new("UIGradient", topLine)
tg.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.new(0,0,0)),
    ColorSequenceKeypoint.new(0.3, C.pink),
    ColorSequenceKeypoint.new(0.5, C.white),
    ColorSequenceKeypoint.new(0.7, C.pink),
    ColorSequenceKeypoint.new(1, Color3.new(0,0,0)),
}

-- Scan line
local scanLine = Instance.new("Frame", win)
scanLine.Size = UDim2.new(0.4,0,0,1)
scanLine.BackgroundColor3 = C.pink
scanLine.BackgroundTransparency = 0.5
scanLine.BorderSizePixel = 0
scanLine.ZIndex = 12
local slg = Instance.new("UIGradient", scanLine)
slg.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.new(0,0,0)),
    ColorSequenceKeypoint.new(0.5, C.pink),
    ColorSequenceKeypoint.new(1, Color3.new(0,0,0)),
}

-- ── Navbar (also the drag handle) ──────────────────────────────
local nav = Instance.new("Frame", win)
nav.Size             = UDim2.new(1,0,0,40)
nav.BackgroundColor3 = C.surface2
nav.BackgroundTransparency = 0.3
nav.BorderSizePixel  = 0
nav.ZIndex           = 11
Instance.new("UICorner", nav).CornerRadius = UDim.new(0,4)

local navTitle = Instance.new("TextLabel", nav)
navTitle.Size = UDim2.new(0,220,1,0)
navTitle.Position = UDim2.new(0,12,0,0)
navTitle.BackgroundTransparency = 1
navTitle.Text = "三 XT 四 SY  —  Script Hub"
navTitle.Font = Enum.Font.GothamBold
navTitle.TextSize = 11
navTitle.TextColor3 = C.pinkDim
navTitle.TextXAlignment = Enum.TextXAlignment.Left
navTitle.ZIndex = 12

local navJp = Instance.new("TextLabel", nav)
navJp.Size = UDim2.new(0,120,1,0)
navJp.Position = UDim2.new(0.5,-60,0,0)
navJp.BackgroundTransparency = 1
navJp.Text = "スクリプト  ·  " .. #SCRIPTS .. " scripts"
navJp.Font = Enum.Font.Gotham
navJp.TextSize = 9
navJp.TextColor3 = C.muted
navJp.ZIndex = 12

-- Close button
local closeBtn = Instance.new("TextButton", nav)
closeBtn.Size = UDim2.new(0,24,0,24)
closeBtn.Position = UDim2.new(1,-30,0.5,-12)
closeBtn.BackgroundColor3 = Color3.fromRGB(255,60,80)
closeBtn.BackgroundTransparency = 0.72
closeBtn.BorderSizePixel = 0
closeBtn.Text = "✕"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 10
closeBtn.TextColor3 = Color3.fromRGB(255,60,80)
closeBtn.AutoButtonColor = false
closeBtn.ZIndex = 14
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1,0)
closeBtn.MouseButton1Click:Connect(function()
    TweenService:Create(win, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
        BackgroundTransparency = 1,
        Size = UDim2.new(0, WIN_W, 0, 0),
        Position = UDim2.new(win.Position.X.Scale, win.Position.X.Offset, win.Position.Y.Scale, win.Position.Y.Offset + WIN_H/2),
    }):Play()
    task.wait(0.3)
    gui:Destroy()
end)

-- Minimize button
local isMinimized = false
local miniBtn = Instance.new("TextButton", nav)
miniBtn.Size = UDim2.new(0,24,0,24)
miniBtn.Position = UDim2.new(1,-58,0.5,-12)
miniBtn.BackgroundColor3 = C.pink
miniBtn.BackgroundTransparency = 0.72
miniBtn.BorderSizePixel = 0
miniBtn.Text = "−"
miniBtn.Font = Enum.Font.GothamBold
miniBtn.TextSize = 13
miniBtn.TextColor3 = C.pink
miniBtn.AutoButtonColor = false
miniBtn.ZIndex = 14
Instance.new("UICorner", miniBtn).CornerRadius = UDim.new(1,0)

miniBtn.MouseButton1Click:Connect(function()
    if isMinimized then
        -- Expand
        isMinimized = false
        miniBtn.Text = "−"
        TweenService:Create(win, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, WIN_W, 0, WIN_H)
        }):Play()
    else
        -- Minimize
        isMinimized = true
        miniBtn.Text = "□"
        TweenService:Create(win, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, WIN_W, 0, MINI_H)
        }):Play()
    end
end)

-- Nav bottom line
local navLine = Instance.new("Frame", nav)
navLine.Size = UDim2.new(1,0,0,1)
navLine.Position = UDim2.new(0,0,1,-1)
navLine.BackgroundColor3 = C.pink
navLine.BackgroundTransparency = 0.8
navLine.BorderSizePixel = 0
navLine.ZIndex = 12
local nlg = Instance.new("UIGradient", navLine)
nlg.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.new(0,0,0)),
    ColorSequenceKeypoint.new(0.5, C.pink),
    ColorSequenceKeypoint.new(1, Color3.new(0,0,0)),
}

-- ══════════════════════════════════════════════════════════════
--  DRAG SYSTEM
-- ══════════════════════════════════════════════════════════════
local dragging    = false
local dragStart   = nil
local startPos    = nil

nav.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging  = true
        dragStart = input.Position
        startPos  = win.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement or
        input.UserInputType == Enum.UserInputType.Touch
    ) then
        local delta = input.Position - dragStart
        local vp    = gui.AbsoluteSize
        local newX  = startPos.X.Offset + delta.X
        local newY  = startPos.Y.Offset + delta.Y
        -- Clamp inside screen
        newX = math.clamp(newX, 0, vp.X - WIN_W)
        newY = math.clamp(newY, 0, vp.Y - MINI_H)
        win.Position = UDim2.new(0, newX, 0, newY)
    end
end)

-- ── Script list label ──────────────────────────────────────────
local listLbl = Instance.new("TextLabel", win)
listLbl.Size = UDim2.new(1,-32,0,14)
listLbl.Position = UDim2.new(0,16,0,50)
listLbl.BackgroundTransparency = 1
listLbl.Text = "SCRIPTS  —  スクリプト一覧"
listLbl.Font = Enum.Font.GothamBold
listLbl.TextSize = 9
listLbl.TextColor3 = C.pinkDim
listLbl.TextXAlignment = Enum.TextXAlignment.Left
listLbl.ZIndex = 11

-- ── Scroll frame ───────────────────────────────────────────────
local scroll = Instance.new("ScrollingFrame", win)
scroll.Size = UDim2.new(1,-32,1,-110)
scroll.Position = UDim2.new(0,16,0,68)
scroll.BackgroundColor3 = Color3.fromRGB(4,3,4)
scroll.BackgroundTransparency = 0.5
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 2
scroll.ScrollBarImageColor3 = C.pink
scroll.CanvasSize = UDim2.new(0,0,0,0)
scroll.ZIndex = 11
Instance.new("UICorner", scroll).CornerRadius = UDim.new(0,4)
local ss = Instance.new("UIStroke", scroll)
ss.Color = C.border; ss.Thickness = 1

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0,6)
layout.SortOrder = Enum.SortOrder.LayoutOrder
local pad = Instance.new("UIPadding", scroll)
pad.PaddingTop=UDim.new(0,8); pad.PaddingBottom=UDim.new(0,8)
pad.PaddingLeft=UDim.new(0,8); pad.PaddingRight=UDim.new(0,8)

-- ── Status bar ─────────────────────────────────────────────────
local statusBar = Instance.new("Frame", win)
statusBar.Size = UDim2.new(1,-32,0,32)
statusBar.Position = UDim2.new(0,16,1,-42)
statusBar.BackgroundColor3 = Color3.fromRGB(5,4,5)
statusBar.BackgroundTransparency = 0.4
statusBar.BorderSizePixel = 0
statusBar.ZIndex = 11
Instance.new("UICorner", statusBar).CornerRadius = UDim.new(0,3)
local sbStroke = Instance.new("UIStroke", statusBar)
sbStroke.Color = C.border; sbStroke.Thickness = 1

local statusTxt = Instance.new("TextLabel", statusBar)
statusTxt.Size = UDim2.new(1,-14,1,0)
statusTxt.Position = UDim2.new(0,7,0,0)
statusTxt.BackgroundTransparency = 1
statusTxt.Text = "// スクリプトを選択してください  —  Select a script"
statusTxt.Font = Enum.Font.Gotham
statusTxt.TextSize = 9
statusTxt.TextColor3 = C.muted
statusTxt.TextXAlignment = Enum.TextXAlignment.Left
statusTxt.ZIndex = 12

-- ── Build script cards ─────────────────────────────────────────
local function buildCards()
    for i, s in ipairs(SCRIPTS) do
        local card = Instance.new("Frame", scroll)
        card.Size = UDim2.new(1,0,0,60)
        card.BackgroundColor3 = Color3.fromRGB(12,9,11)
        card.BackgroundTransparency = 0.25
        card.BorderSizePixel = 0
        card.LayoutOrder = i
        card.ZIndex = 12
        Instance.new("UICorner", card).CornerRadius = UDim.new(0,4)
        local cStroke = Instance.new("UIStroke", card)
        cStroke.Color = Color3.fromRGB(38,26,32); cStroke.Thickness = 1

        local nameL = Instance.new("TextLabel", card)
        nameL.Size = UDim2.new(1,-100,0,20)
        nameL.Position = UDim2.new(0,10,0,8)
        nameL.BackgroundTransparency = 1
        nameL.Text = "🌸  " .. s.name
        nameL.Font = Enum.Font.GothamBold
        nameL.TextSize = 13
        nameL.TextColor3 = C.white
        nameL.TextXAlignment = Enum.TextXAlignment.Left
        nameL.ZIndex = 13

        local descL = Instance.new("TextLabel", card)
        descL.Size = UDim2.new(1,-16,0,14)
        descL.Position = UDim2.new(0,10,0,28)
        descL.BackgroundTransparency = 1
        descL.Text = s.desc or ""
        descL.Font = Enum.Font.Gotham
        descL.TextSize = 9
        descL.TextColor3 = C.pinkDim
        descL.TextXAlignment = Enum.TextXAlignment.Left
        descL.ZIndex = 13

        local btn = Instance.new("TextButton", card)
        btn.Size = UDim2.new(0,76,0,24)
        btn.Position = UDim2.new(1,-86,0.5,-12)
        btn.BackgroundColor3 = C.pink
        btn.BackgroundTransparency = 0.1
        btn.BorderSizePixel = 0
        btn.Text = "▶  実行"
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 10
        btn.TextColor3 = C.black
        btn.AutoButtonColor = false
        btn.ZIndex = 14
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,3)

        local bg2 = Instance.new("UIGradient", btn)
        bg2.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, C.white),
            ColorSequenceKeypoint.new(0.5, C.pink),
            ColorSequenceKeypoint.new(1, C.white),
        }
        bg2.Rotation = 90

        btn.MouseEnter:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.12), {BackgroundTransparency=0.2}):Play()
        end)
        btn.MouseLeave:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.12), {BackgroundTransparency=0.1}):Play()
        end)

        local url  = s.url
        local name = s.name
        btn.MouseButton1Click:Connect(function()
            btn.Text = "// 実行中..."
            btn.TextColor3 = C.dim
            statusTxt.Text = "// 実行中  —  Loading: " .. name .. "..."
            statusTxt.TextColor3 = C.pinkDim
            task.spawn(function()
                local ok, err = pcall(function()
                    loadstring(game:HttpGet(url))()
                end)
                if ok then
                    btn.Text = "✓ 完了"
                    btn.TextColor3 = C.green
                    statusTxt.Text = "// ✓ " .. name .. " — loaded!"
                    statusTxt.TextColor3 = C.green
                    task.wait(2.5)
                    btn.Text = "▶  実行"
                    btn.TextColor3 = C.black
                    statusTxt.Text = "// スクリプトを選択してください  —  Select a script"
                    statusTxt.TextColor3 = C.muted
                else
                    btn.Text = "✕ Error"
                    btn.TextColor3 = C.red
                    statusTxt.Text = "// Error: " .. tostring(err):sub(1,45)
                    statusTxt.TextColor3 = C.red
                    task.wait(3)
                    btn.Text = "▶  実行"
                    btn.TextColor3 = C.black
                    statusTxt.Text = "// スクリプトを選択してください  —  Select a script"
                    statusTxt.TextColor3 = C.muted
                end
            end)
        end)
    end

    scroll.CanvasSize = UDim2.new(0,0,0, #SCRIPTS * 66 + 16)
end

buildCards()

-- ══════════════════════════════════════════════════════════════
--  ANIMATION LOOP
-- ══════════════════════════════════════════════════════════════
local scanT  = 0
local petalT = {}
for i = 1, #petals do petalT[i] = math.random()*math.pi*2 end

RunService.Heartbeat:Connect(function(dt)
    for _, s in ipairs(stars) do
        s.tVal += s.tSpd * s.tDir
        if s.tVal > 0.45 or s.tVal < -0.15 then s.tDir = -s.tDir end
        s.frame.BackgroundTransparency = math.clamp(s.baseT+s.tVal, 0.05, 0.95)
        s.px += s.vx; s.py += s.vy
        if s.px < 0 then s.px=1 elseif s.px > 1 then s.px=0 end
        if s.py < 0 then s.py=1 elseif s.py > 1 then s.py=0 end
        s.frame.Position = UDim2.new(s.px,0,s.py,0)
    end

    scanT += dt * 0.18
    if scanT > 1.5 then scanT = -0.4 end
    scanLine.Position = UDim2.new(math.clamp(scanT,-0.4,1),0,0,0)

    for i, p in ipairs(petals) do
        petalT[i] += p.wbSpd
        p.px += p.drift + math.sin(petalT[i])*0.0008
        p.py += p.speed
        if p.py > 1.1 then p.py=-0.05-math.random()*0.2; p.px=math.random() end
        if p.px < 0 then p.px=1 elseif p.px > 1 then p.px=0 end
        p.frame.Position = UDim2.new(p.px,0,p.py,0)
    end
end)
