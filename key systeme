-- ╔══════════════════════════════════════════════════════════════╗
-- ║   三 XT 四 SY  — キーシステム  —  Key System v2            ║
-- ║   桜の道 — The path of the cherry blossom                  ║
-- ╚══════════════════════════════════════════════════════════════╝

local API_URL  = "https://3xt4sy-hub.vercel.app/api/check?key="
local SITE_URL = "https://3xt4sy-hub.vercel.app"

local HttpService  = game:GetService("HttpService")
local Players      = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService   = game:GetService("RunService")
local localPlayer  = Players.LocalPlayer
local playerGui    = localPlayer:WaitForChild("PlayerGui")

-- ── Palette ────────────────────────────────────────────────────
local C = {
    black    = Color3.fromRGB(0,   0,   0),
    surface  = Color3.fromRGB(8,   6,   7),
    surface2 = Color3.fromRGB(13,  10,  11),
    border   = Color3.fromRGB(28,  22,  25),
    white    = Color3.fromRGB(255, 255, 255),
    dim      = Color3.fromRGB(120, 110, 115),
    muted    = Color3.fromRGB(55,  48,  51),
    pink     = Color3.fromRGB(255, 196, 229),   -- #FFC4E5
    pinkDim  = Color3.fromRGB(180, 120, 155),
    pinkFade = Color3.fromRGB(40,  28,  34),
    red      = Color3.fromRGB(255, 60,  80),
}

-- ══════════════════════════════════════════════════════════════
--  SCREENGUI
-- ══════════════════════════════════════════════════════════════
local gui = Instance.new("ScreenGui")
gui.Name           = "Ext4syKeySystem"
gui.ResetOnSpawn   = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
gui.Parent         = playerGui

-- Background
local bg = Instance.new("Frame")
bg.Size                   = UDim2.fromScale(1, 1)
bg.BackgroundColor3       = C.black
bg.BackgroundTransparency = 0.08
bg.BorderSizePixel        = 0
bg.ZIndex                 = 1
bg.Parent                 = gui

-- ══════════════════════════════════════════════════════════════
--  STARS — pink tinted (ZIndex 2)
-- ══════════════════════════════════════════════════════════════
local starHolder = Instance.new("Frame")
starHolder.Size                   = UDim2.fromScale(1, 1)
starHolder.BackgroundTransparency = 1
starHolder.BorderSizePixel        = 0
starHolder.ZIndex                 = 2
starHolder.Parent                 = gui

local stars = {}
for i = 1, 90 do
    local f   = Instance.new("Frame")
    local sz  = math.random(1, 3)
    -- 30% of stars are pink tinted
    local isPink = math.random() > 0.7
    f.Size                   = UDim2.new(0, sz, 0, sz)
    f.Position               = UDim2.new(math.random(), 0, math.random(), 0)
    f.BackgroundColor3       = isPink and C.pink or C.white
    f.BackgroundTransparency = math.random() * 0.5 + 0.35
    f.BorderSizePixel        = 0
    f.ZIndex                 = 2
    f.Parent                 = starHolder
    Instance.new("UICorner", f).CornerRadius = UDim.new(1, 0)

    stars[i] = {
        frame  = f,
        px     = f.Position.X.Scale,
        py     = f.Position.Y.Scale,
        vx     = (math.random() - 0.5) * 0.00011,
        vy     = (math.random() - 0.5) * 0.00011,
        baseT  = math.random() * 0.5 + 0.3,
        tVal   = 0,
        tSpd   = math.random() * 0.009 + 0.003,
        tDir   = math.random() > 0.5 and 1 or -1,
    }
end

-- ══════════════════════════════════════════════════════════════
--  FALLING PETALS (ZIndex 3)
-- ══════════════════════════════════════════════════════════════
local petalHolder = Instance.new("Frame")
petalHolder.Size                   = UDim2.fromScale(1, 1)
petalHolder.BackgroundTransparency = 1
petalHolder.BorderSizePixel        = 0
petalHolder.ClipsDescendants       = false
petalHolder.ZIndex                 = 3
petalHolder.Parent                 = gui

local petals = {}
for i = 1, 18 do
    local p  = Instance.new("Frame")
    local sz = math.random(4, 9)
    p.Size                   = UDim2.new(0, sz, 0, sz)
    p.Position               = UDim2.new(math.random(), 0, -0.05, 0)
    p.BackgroundColor3       = C.pink
    p.BackgroundTransparency = math.random() * 0.35 + 0.45
    p.BorderSizePixel        = 0
    p.ZIndex                 = 3
    p.Parent                 = petalHolder
    -- Petal shape
    local corner = Instance.new("UICorner", p)
    corner.CornerRadius = math.random() > 0.5 and UDim.new(1, 0) or UDim.new(0.5, 0)

    petals[i] = {
        frame   = p,
        px      = math.random(),
        py      = -0.05 - math.random() * 0.3,
        speed   = math.random() * 0.0003 + 0.0001,
        drift   = (math.random() - 0.5) * 0.00015,
        rot     = 0,
        rotSpd  = (math.random() - 0.5) * 2,
        wobble  = 0,
        wobSpd  = math.random() * 0.04 + 0.02,
    }
end

-- ══════════════════════════════════════════════════════════════
--  MAIN WINDOW (ZIndex 10)
-- ══════════════════════════════════════════════════════════════
local win = Instance.new("Frame")
win.Size            = UDim2.new(0, 400, 0, 390)
win.Position        = UDim2.new(0.5, -200, 0.5, -195)
win.BackgroundColor3 = C.surface
win.BorderSizePixel = 0
win.ZIndex          = 10
win.Parent          = gui
Instance.new("UICorner", win).CornerRadius = UDim.new(0, 4)

-- Window border glow (pink)
local winStroke = Instance.new("UIStroke", win)
winStroke.Color       = C.border
winStroke.Thickness   = 1
winStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Top accent line (pink shimmer)
local topLine = Instance.new("Frame")
topLine.Size             = UDim2.new(1, 0, 0, 1)
topLine.BackgroundColor3 = C.pink
topLine.BackgroundTransparency = 0.4
topLine.BorderSizePixel  = 0
topLine.ZIndex           = 11
topLine.Parent           = win
Instance.new("UIGradient", topLine).Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0,   Color3.fromRGB(0,0,0)),
    ColorSequenceKeypoint.new(0.3, C.pink),
    ColorSequenceKeypoint.new(0.5, C.white),
    ColorSequenceKeypoint.new(0.7, C.pink),
    ColorSequenceKeypoint.new(1,   Color3.fromRGB(0,0,0)),
}

-- Scan line animation
local scanLine = Instance.new("Frame")
scanLine.Size             = UDim2.new(0.4, 0, 0, 1)
scanLine.BackgroundColor3 = C.pink
scanLine.BackgroundTransparency = 0.55
scanLine.BorderSizePixel  = 0
scanLine.ZIndex           = 12
scanLine.Parent           = win
Instance.new("UIGradient", scanLine).Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0,   Color3.fromRGB(0,0,0)),
    ColorSequenceKeypoint.new(0.5, C.pink),
    ColorSequenceKeypoint.new(1,   Color3.fromRGB(0,0,0)),
}

-- Corner decorations
local function makeCorner(parent, xAlign, yAlign, zidx)
    local cFrame = Instance.new("Frame")
    cFrame.Size             = UDim2.new(0, 8, 0, 8)
    cFrame.Position         = UDim2.new(xAlign == "right" and 1 or 0, xAlign == "right" and -10 or 2, yAlign == "bottom" and 1 or 0, yAlign == "bottom" and -10 or 2)
    cFrame.BackgroundTransparency = 1
    cFrame.BorderSizePixel  = 0
    cFrame.ZIndex           = zidx
    cFrame.Parent           = parent
    local s = Instance.new("UIStroke", cFrame)
    s.Color     = C.pinkDim
    s.Thickness = 1
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    return cFrame
end
makeCorner(win, "left",  "top",    12)
makeCorner(win, "right", "top",    12)
makeCorner(win, "left",  "bottom", 12)
makeCorner(win, "right", "bottom", 12)

-- ── HEADER AREA ────────────────────────────────────────────────
local header = Instance.new("Frame")
header.Size             = UDim2.new(1, 0, 0, 72)
header.BackgroundColor3 = C.surface2
header.BackgroundTransparency = 0.3
header.BorderSizePixel  = 0
header.ZIndex           = 11
header.Parent           = win
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 4)

local headerLine = Instance.new("Frame")
headerLine.Size             = UDim2.new(1, 0, 0, 1)
headerLine.Position         = UDim2.new(0, 0, 1, -1)
headerLine.BackgroundColor3 = C.pink
headerLine.BackgroundTransparency = 0.75
headerLine.BorderSizePixel  = 0
headerLine.ZIndex           = 12
headerLine.Parent           = header
Instance.new("UIGradient", headerLine).Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0,0,0)),
    ColorSequenceKeypoint.new(0.5, C.pink),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0,0,0)),
}

-- Logo text
local logoText = Instance.new("TextLabel")
logoText.Size            = UDim2.new(1, 0, 0, 28)
logoText.Position        = UDim2.new(0, 0, 0, 10)
logoText.BackgroundTransparency = 1
logoText.Text            = "3XT4SY"
logoText.Font            = Enum.Font.GothamBold
logoText.TextSize        = 22
logoText.TextColor3      = C.white
logoText.TextXAlignment  = Enum.TextXAlignment.Center
logoText.ZIndex          = 13
logoText.Parent          = header

-- Japanese subtitle
local logoJp = Instance.new("TextLabel")
logoJp.Size             = UDim2.new(1, 0, 0, 16)
logoJp.Position         = UDim2.new(0, 0, 0, 36)
logoJp.BackgroundTransparency = 1
logoJp.Text             = "三 XT 四 SY　—　キーシステム"
logoJp.Font             = Enum.Font.Gotham
logoJp.TextSize         = 10
logoJp.TextColor3       = C.pinkDim
logoJp.TextXAlignment   = Enum.TextXAlignment.Center
logoJp.ZIndex           = 13
logoJp.Parent           = header

-- Tagline
local tagLine = Instance.new("TextLabel")
tagLine.Size             = UDim2.new(1, 0, 0, 14)
tagLine.Position         = UDim2.new(0, 0, 0, 52)
tagLine.BackgroundTransparency = 1
tagLine.Text             = "// 桜の道  —  the path of the cherry blossom"
tagLine.Font             = Enum.Font.Gotham
tagLine.TextSize         = 9
tagLine.TextColor3       = C.muted
tagLine.TextXAlignment   = Enum.TextXAlignment.Center
tagLine.ZIndex           = 13
tagLine.Parent           = header

-- ── SEPARATOR ──────────────────────────────────────────────────
local function makeSep(parent, yPos, zidx)
    local sep = Instance.new("Frame")
    sep.Size             = UDim2.new(1, -32, 0, 1)
    sep.Position         = UDim2.new(0, 16, 0, yPos)
    sep.BackgroundColor3 = C.pink
    sep.BackgroundTransparency = 0.82
    sep.BorderSizePixel  = 0
    sep.ZIndex           = zidx
    sep.Parent           = parent
    Instance.new("UIGradient", sep).Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0,   Color3.fromRGB(0,0,0)),
        ColorSequenceKeypoint.new(0.5, C.pink),
        ColorSequenceKeypoint.new(1,   Color3.fromRGB(0,0,0)),
    }
    -- Diamond center
    local dia = Instance.new("Frame")
    dia.Size             = UDim2.new(0, 5, 0, 5)
    dia.Position         = UDim2.new(0.5, -2, 0.5, -2)
    dia.BackgroundColor3 = C.pink
    dia.BackgroundTransparency = 0.55
    dia.BorderSizePixel  = 0
    dia.ZIndex           = zidx + 1
    dia.Rotation         = 45
    dia.Parent           = sep
    return sep
end

-- ── KEY INPUT AREA ─────────────────────────────────────────────
local inputLabel = Instance.new("TextLabel")
inputLabel.Size             = UDim2.new(1, -32, 0, 14)
inputLabel.Position         = UDim2.new(0, 16, 0, 84)
inputLabel.BackgroundTransparency = 1
inputLabel.Text             = "あなたの鍵  —  YOUR KEY"
inputLabel.Font             = Enum.Font.GothamBold
inputLabel.TextSize         = 9
inputLabel.TextColor3       = C.pinkDim
inputLabel.TextXAlignment   = Enum.TextXAlignment.Left
inputLabel.ZIndex           = 11
inputLabel.Parent           = win

local inputBox = Instance.new("Frame")
inputBox.Size             = UDim2.new(1, -32, 0, 40)
inputBox.Position         = UDim2.new(0, 16, 0, 100)
inputBox.BackgroundColor3 = Color3.fromRGB(5, 4, 5)
inputBox.BorderSizePixel  = 0
inputBox.ZIndex           = 11
inputBox.Parent           = win
Instance.new("UICorner", inputBox).CornerRadius = UDim.new(0, 3)
local inputStroke = Instance.new("UIStroke", inputBox)
inputStroke.Color     = C.border
inputStroke.Thickness = 1

local keyInput = Instance.new("TextBox")
keyInput.Size             = UDim2.new(1, -16, 1, 0)
keyInput.Position         = UDim2.new(0, 8, 0, 0)
keyInput.BackgroundTransparency = 1
keyInput.Text             = ""
keyInput.PlaceholderText  = "HUB-XXXXX-XXXXX-XXXXX-XXXXX"
keyInput.Font             = Enum.Font.GothamBold
keyInput.TextSize         = 12
keyInput.TextColor3       = C.white
keyInput.PlaceholderColor3 = C.muted
keyInput.TextXAlignment   = Enum.TextXAlignment.Center
keyInput.ClearTextOnFocus = false
keyInput.ZIndex           = 12
keyInput.Parent           = inputBox

-- ── BUTTONS ────────────────────────────────────────────────────
local function makeButton(parent, text, yPos, isPrimary, zidx)
    local btn = Instance.new("TextButton")
    btn.Size             = UDim2.new(1, -32, 0, 38)
    btn.Position         = UDim2.new(0, 16, 0, yPos)
    btn.BackgroundColor3 = isPrimary and C.pink or C.surface2
    btn.BackgroundTransparency = isPrimary and 0 or 0.3
    btn.BorderSizePixel  = 0
    btn.Text             = text
    btn.Font             = Enum.Font.GothamBold
    btn.TextSize         = 11
    btn.TextColor3       = isPrimary and C.black or C.dim
    btn.AutoButtonColor  = false
    btn.ZIndex           = zidx
    btn.Parent           = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 3)

    if isPrimary then
        -- Gradient on primary button
        local g = Instance.new("UIGradient", btn)
        g.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0,   C.white),
            ColorSequenceKeypoint.new(0.5, C.pink),
            ColorSequenceKeypoint.new(1,   C.white),
        }
        g.Rotation = 90
    else
        local s = Instance.new("UIStroke", btn)
        s.Color     = C.border
        s.Thickness = 1
    end

    -- Hover effect
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {
            BackgroundTransparency = isPrimary and 0.1 or 0.15
        }):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {
            BackgroundTransparency = isPrimary and 0 or 0.3
        }):Play()
    end)

    return btn
end

local verifyBtn = makeButton(win, "✦  VERIFY KEY  —  鍵を確認", 152, true,  12)
makeSep(win, 200, 11)
local getKeyBtn = makeButton(win, "🌸  GET KEY  —  鍵を取得する", 210, false, 12)

-- ── STATUS AREA ────────────────────────────────────────────────
local statusBox = Instance.new("Frame")
statusBox.Size             = UDim2.new(1, -32, 0, 62)
statusBox.Position         = UDim2.new(0, 16, 0, 258)
statusBox.BackgroundColor3 = Color3.fromRGB(5, 4, 5)
statusBox.BackgroundTransparency = 0.3
statusBox.BorderSizePixel  = 0
statusBox.ZIndex           = 11
statusBox.Parent           = win
Instance.new("UICorner", statusBox).CornerRadius = UDim.new(0, 3)
local statusStroke = Instance.new("UIStroke", statusBox)
statusStroke.Color     = C.border
statusStroke.Thickness = 1

local statusIcon = Instance.new("TextLabel")
statusIcon.Size             = UDim2.new(0, 32, 1, 0)
statusIcon.BackgroundTransparency = 1
statusIcon.Text             = "◈"
statusIcon.Font             = Enum.Font.GothamBold
statusIcon.TextSize         = 14
statusIcon.TextColor3       = C.muted
statusIcon.ZIndex           = 12
statusIcon.Parent           = statusBox

local statusLabel = Instance.new("TextLabel")
statusLabel.Size             = UDim2.new(1, -40, 0, 20)
statusLabel.Position         = UDim2.new(0, 36, 0, 8)
statusLabel.BackgroundTransparency = 1
statusLabel.Text             = "待機中  —  Waiting for key..."
statusLabel.Font             = Enum.Font.GothamBold
statusLabel.TextSize         = 11
statusLabel.TextColor3       = C.muted
statusLabel.TextXAlignment   = Enum.TextXAlignment.Left
statusLabel.ZIndex           = 12
statusLabel.Parent           = statusBox

local statusSub = Instance.new("TextLabel")
statusSub.Size             = UDim2.new(1, -40, 0, 16)
statusSub.Position         = UDim2.new(0, 36, 0, 30)
statusSub.BackgroundTransparency = 1
statusSub.Text             = "// enter your key above"
statusSub.Font             = Enum.Font.Gotham
statusSub.TextSize         = 9
statusSub.TextColor3       = C.muted
statusSub.TextXAlignment   = Enum.TextXAlignment.Left
statusSub.ZIndex           = 12
statusSub.Parent           = statusBox

makeSep(win, 330, 11)

-- ── FOOTER ─────────────────────────────────────────────────────
local footerText = Instance.new("TextLabel")
footerText.Size             = UDim2.new(1, -32, 0, 14)
footerText.Position         = UDim2.new(0, 16, 0, 340)
footerText.BackgroundTransparency = 1
footerText.Text             = "三 XT 四 SY  ·  迷子になっても、戻る道はある"
footerText.Font             = Enum.Font.Gotham
footerText.TextSize         = 9
footerText.TextColor3       = C.pinkFade
footerText.TextXAlignment   = Enum.TextXAlignment.Center
footerText.ZIndex           = 11
footerText.Parent           = win

local footerRight = Instance.new("TextLabel")
footerRight.Size             = UDim2.new(1, -32, 0, 12)
footerRight.Position         = UDim2.new(0, 16, 0, 357)
footerRight.BackgroundTransparency = 1
footerRight.Text             = "// 3xt4sy-hub.vercel.app"
footerRight.Font             = Enum.Font.Gotham
footerRight.TextSize         = 8
footerRight.TextColor3       = C.muted
footerRight.TextXAlignment   = Enum.TextXAlignment.Center
footerRight.ZIndex           = 11
footerRight.Parent           = win

-- ══════════════════════════════════════════════════════════════
--  LOGIC
-- ══════════════════════════════════════════════════════════════
local function setStatus(icon, msg, sub, color)
    statusIcon.Text       = icon
    statusIcon.TextColor3 = color or C.muted
    statusLabel.Text      = msg
    statusLabel.TextColor3 = color or C.muted
    statusSub.Text        = sub or ""
end

local function pulse(label)
    task.spawn(function()
        for i = 1, 4 do
            TweenService:Create(label, TweenInfo.new(0.3), {TextTransparency = 0.5}):Play()
            task.wait(0.3)
            TweenService:Create(label, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
            task.wait(0.3)
        end
    end)
end

-- GET KEY button → open site
getKeyBtn.MouseButton1Click:Connect(function()
    setStatus("🌸", "サイトを開いています  —  Opening site...", "// " .. SITE_URL, C.pink)
    task.spawn(function()
        -- Try setclipboard so user can paste URL
        if setclipboard then
            setclipboard(SITE_URL)
        end
        -- Try opening URL directly
        if syn and syn.open_url then
            syn.open_url(SITE_URL)
        elseif KRNL_LOADED and request then
            request({Url = SITE_URL})
        end
        task.wait(0.5)
        setStatus("◈", "待機中  —  Waiting for key...", "// enter your key above", C.muted)
    end)
end)

-- VERIFY button
verifyBtn.MouseButton1Click:Connect(function()
    local key = keyInput.Text:match("^%s*(.-)%s*$"):upper()

    if key == "" then
        setStatus("⚠", "鍵を入力してください  —  Enter a key", "// field is empty", C.pink)
        pulse(statusLabel)
        return
    end

    setStatus("◌", "確認中  —  Verifying...", "// contacting server...", C.dim)
    verifyBtn.Text = "// 確認中..."

    task.spawn(function()
        local ok, result = false, nil

        -- Method 1
        pcall(function()
            local raw = game:HttpGet(API_URL .. key)
            result = HttpService:JSONDecode(raw)
            ok = true
        end)

        -- Method 2 fallback
        if not ok then
            pcall(function()
                local raw = HttpService:GetAsync(API_URL .. key)
                result = HttpService:JSONDecode(raw)
                ok = true
            end)
        end

        verifyBtn.Text = "✦  VERIFY KEY  —  鍵を確認"

        if not ok or not result then
            setStatus("✕", "接続エラー  —  Connection failed", "// could not reach server", C.red)
            return
        end

        if result.valid then
            local isVip = result.type == "vip"
            if isVip then
                setStatus("👑",
                    "VIP — " .. (result.recipient or "Welcome") .. " 様",
                    "// 永久アクセス  —  Lifetime access granted",
                    C.pink
                )
            else
                setStatus("🌸",
                    "確認済み  —  Key accepted ✓",
                    "// 有効期限  —  " .. (result.expires_in or "—"),
                    C.pink
                )
            end

            -- Pink flash on window border
            TweenService:Create(winStroke, TweenInfo.new(0.3), {Color = C.pink}):Play()
            task.wait(1.5)
            TweenService:Create(winStroke, TweenInfo.new(0.8), {Color = C.border}):Play()

            -- Fade out and destroy GUI
            task.wait(0.5)
            TweenService:Create(bg, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
            TweenService:Create(win, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
            task.wait(0.6)
            gui:Destroy()

            -- ── YOUR SCRIPT HERE ──────────────────────────────
            task.wait(0.8)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/arracheur-h/HIT_hub/refs/heads/main/hub.lua"))()
            print("3XT4SY — Key verified. Replace this line with your script.")
            -- ─────────────────────────────────────────────────
        else
            setStatus("✕",
                "無効な鍵  —  Invalid key",
                "// " .. (result.reason or "key not found"),
                C.red
            )
            TweenService:Create(winStroke, TweenInfo.new(0.2), {Color = C.red}):Play()
            task.wait(1.2)
            TweenService:Create(winStroke, TweenInfo.new(0.6), {Color = C.border}):Play()
        end
    end)
end)

-- ══════════════════════════════════════════════════════════════
--  ANIMATION LOOP
-- ══════════════════════════════════════════════════════════════
-- Scan line
local scanT = 0
-- Petal angles
local petalT = {}
for i = 1, #petals do petalT[i] = math.random() * math.pi * 2 end

RunService.Heartbeat:Connect(function(dt)

    -- Stars
    for _, s in ipairs(stars) do
        s.tVal = s.tVal + s.tSpd * s.tDir
        if s.tVal > 0.45 or s.tVal < -0.15 then s.tDir = -s.tDir end
        s.frame.BackgroundTransparency = math.clamp(s.baseT + s.tVal, 0.05, 0.95)
        s.px = s.px + s.vx
        s.py = s.py + s.vy
        if s.px < 0 then s.px = 1 elseif s.px > 1 then s.px = 0 end
        if s.py < 0 then s.py = 1 elseif s.py > 1 then s.py = 0 end
        s.frame.Position = UDim2.new(s.px, 0, s.py, 0)
    end

    -- Scan line
    scanT = scanT + dt * 0.18
    if scanT > 1.5 then scanT = -0.4 end
    scanLine.Position = UDim2.new(math.clamp(scanT, -0.4, 1), 0, 0, 0)

    -- Petals
    for i, p in ipairs(petals) do
        petalT[i] = petalT[i] + p.wobSpd
        local wobble = math.sin(petalT[i]) * 0.0008
        p.px = p.px + p.drift + wobble
        p.py = p.py + p.speed

        if p.py > 1.1 then
            p.py = -0.05 - math.random() * 0.2
            p.px = math.random()
        end
        if p.px < 0 then p.px = 1 elseif p.px > 1 then p.px = 0 end

        p.frame.Position = UDim2.new(p.px, 0, p.py, 0)
    end
end)
