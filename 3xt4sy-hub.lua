-- Load CompKiller Library
local Compkiller = loadstring(game:HttpGet("https://raw.githubusercontent.com/4lpaca-pin/CompKiller/refs/heads/main/src/source.luau"))();

task.wait(1)

Compkiller:Loader(nil, 1).yield()

-- Games configuration with colors
local games = {
    {name = "⚡Ninja Legends", url = "https://raw.githubusercontent.com/arracheur-h/HIT_hub/refs/heads/main/ninjalegends.lua", color = Color3.fromRGB(180, 100, 255)},
    {name = "Taxi Boss 🚖", url = "https://raw.githubusercontent.com/arracheur-h/HIT_hub/refs/heads/main/TaxiBoss.lua", color = Color3.fromRGB(180, 100, 255)},
    {name = "OP auto piano", url = "https://raw.githubusercontent.com/arracheur-h/HIT_hub/refs/heads/main/Digital%20Piano.lua", color = Color3.fromRGB(180, 100, 255)},
    {name = "Aimbot Rivals", url = "https://raw.githubusercontent.com/arracheur-h/HIT_hub/refs/heads/main/rivals.lua", color = Color3.fromRGB(180, 100, 255)},
    {name = "Hide or Die", url = "https://raw.githubusercontent.com/arracheur-h/HIT_hub/refs/heads/main/hideordie.lua", color = Color3.fromRGB(180, 100, 255)},
    {name = "niversal TiggerBot", url = "https://raw.githubusercontent.com/arracheur-h/HIT_hub/refs/heads/main/aimbot.lua", color = Color3.fromRGB(180, 100, 255)},
    {name = "Taxi Bos", url = "https://vss.pandadevelopment.net/virtual/file/aed90696aa61490a", color = Color3.fromRGB(180, 100, 255)},
    {name = "Fisch", url = "https://vss.pandadevelopment.net/virtual/file/876871e95b2e4b7d", color = Color3.fromRGB(180, 100, 255)},
}
-- Create Config Manager
local FileWatcher = Compkiller:ConfigManager({
    Directory = "GameLoader",
    Config = "Default-Config"	
});

-- Set cyan/purple theme color
Compkiller:ChangeHighlightColor(Color3.fromRGB(100, 150, 255))

-- Create Window
local Window = Compkiller.new({
    Keybind = "LeftAlt",
});

-- Create Watermark
local watermark = Window:Watermark();

watermark:AddText({
    Icon = "user",
    Text = "Game Loader"
})

local timeDisplay = watermark:AddText({
    Icon = "clock",
    Text = Compkiller:GetTimeNow()
})

task.spawn(function()
    while true do 
        task.wait()
        timeDisplay:SetText(Compkiller:GetTimeNow())
        Window.Username = "Player"
    end
end)

watermark:AddText({
    Icon = "server",
    Text = "Hub"
})

-- Create Main Tab
local GamesTab = Window:DrawTab({
    Icon = "box",
    Name = "Games",
    Type = "Double"
});

-- Create sections for games
local Section1 = GamesTab:DrawSection({
    Name = "Popular Games",
    Position = "LEFT"
});

local Section2 = GamesTab:DrawSection({
    Name = "More Games",
    Position = "RIGHT"
});

-- Function to load script with color effect
local function loadGameScript(gameName, gameUrl, gameColor)
    Compkiller:ChangeHighlightColor(gameColor)
    
    local success, err = pcall(function()
        local script = game:HttpGet(gameUrl)
        loadstring(script)()
    end)
    
    if success then
        Compkiller:Notification({
            Title = "✓ Success!",
            Content = gameName .. " loaded!",
            Duration = 3
        })
    else
        Compkiller:Notification({
            Title = "✗ Error",
            Content = "Failed to load " .. gameName,
            Duration = 3
        })
        warn("Error loading " .. gameName .. ":", err)
    end
end

-- ══════════════════════════════════════════════════
-- 🌟 BIG BUTTON - GET EVERY SCRIPT (50+ games)
-- ══════════════════════════════════════════════════
Section1:AddParagraph({
    Title = "All script go to become back",
    Content = "Click for copy"
})

Section1:AddButton({
    Name = "All script",
    Callback = function()
        Compkiller:ChangeHighlightColor(Color3.fromRGB(255, 215, 0))
        setclipboard("https://rscripts.net/@MrPurgeur")
        Compkiller:Notification({
            Title = "Copied",
            Content = "https://rscripts.net/@MrPurgeur copied! Paste it in your browser.",
            Duration = 5
        })
    end
})
-- ══════════════════════════════════════════════════

-- Add buttons for first half of games in left section
for i = 1, math.ceil(#games / 2) do
    local game = games[i]
    Section1:AddButton({
        Name = game.name,
        Callback = function()
            loadGameScript(game.name, game.url, game.color)
        end
    })
end

-- Add buttons for second half of games in right section
for i = math.ceil(#games / 2) + 1, #games do
    local game = games[i]
    Section2:AddButton({
        Name = game.name,
        Callback = function()
            loadGameScript(game.name, game.url, game.color)
        end
    })
end

-- ══════════════════════════════════════════════════
-- UTILITIES TAB
-- ══════════════════════════════════════════════════
local UtilsTab = Window:DrawTab({
    Icon = "zap",
    Name = "Utilities",
    Type = "Double"
});

local UtilsLeft = UtilsTab:DrawSection({
    Name = "Player",
    Position = "LEFT"
});

local UtilsRight = UtilsTab:DrawSection({
    Name = "Visual",
    Position = "RIGHT"
});

-- Current game name display
local currentGameName = "Unknown"
pcall(function()
    currentGameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
end)

UtilsLeft:AddParagraph({
    Title = "Current Game",
    Content = currentGameName
})

-- WalkSpeed Toggle
UtilsLeft:AddToggle({
    Name = "Speed Hack (WalkSpeed x2)",
    Default = false,
    Callback = function(state)
        local char = game.Players.LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.WalkSpeed = state and 32 or 16
            end
        end
        Compkiller:Notification({
            Title = "Speed",
            Content = state and "Speed ON" or "Speed OFF",
            Duration = 2
        })
    end
})

-- JumpPower Toggle
UtilsLeft:AddToggle({
    Name = "Infinite Jump (JumpPower x3)",
    Default = false,
    Callback = function(state)
        local char = game.Players.LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.JumpPower = state and 150 or 50
            end
        end
        Compkiller:Notification({
            Title = "Jump",
            Content = state and "Jump ON" or "Jump OFF",
            Duration = 2
        })
    end
})

-- Noclip Toggle
local noclipConnection = nil
UtilsLeft:AddToggle({
    Name = "Noclip",
    Default = false,
    Callback = function(state)
        if state then
            noclipConnection = game:GetService("RunService").Stepped:Connect(function()
                local char = game.Players.LocalPlayer.Character
                if char then
                    for _, part in pairs(char:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        else
            if noclipConnection then
                noclipConnection:Disconnect()
                noclipConnection = nil
            end
            local char = game.Players.LocalPlayer.Character
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end
        Compkiller:Notification({
            Title = "Noclip",
            Content = state and "Noclip ON" or "Noclip OFF",
            Duration = 2
        })
    end
})

-- Anti-AFK Toggle
local antiAfkConnection = nil
UtilsLeft:AddToggle({
    Name = "Anti-AFK",
    Default = false,
    Callback = function(state)
        if state then
            local VirtualUser = game:GetService("VirtualUser")
            antiAfkConnection = game:GetService("Players").LocalPlayer.Idled:Connect(function()
                VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                task.wait(1)
                VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            end)
        else
            if antiAfkConnection then
                antiAfkConnection:Disconnect()
                antiAfkConnection = nil
            end
        end
        Compkiller:Notification({
            Title = "Anti-AFK",
            Content = state and "Anti-AFK ON" or "Anti-AFK OFF",
            Duration = 2
        })
    end
})

-- Fly Hack Toggle
local flyBodyVelocity = nil
local flyBodyGyro = nil
local flyConnection = nil

UtilsRight:AddToggle({
    Name = "Fly Hack",
    Default = false,
    Callback = function(state)
        local player = game.Players.LocalPlayer
        local char = player.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        if state then
            flyBodyVelocity = Instance.new("BodyVelocity")
            flyBodyVelocity.Velocity = Vector3.zero
            flyBodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
            flyBodyVelocity.Parent = hrp

            flyBodyGyro = Instance.new("BodyGyro")
            flyBodyGyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
            flyBodyGyro.P = 1e4
            flyBodyGyro.Parent = hrp

            flyConnection = game:GetService("RunService").RenderStepped:Connect(function()
                local cam = workspace.CurrentCamera
                local moveDir = Vector3.zero
                local uis = game:GetService("UserInputService")

                if uis:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + cam.CFrame.LookVector end
                if uis:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - cam.CFrame.LookVector end
                if uis:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - cam.CFrame.RightVector end
                if uis:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + cam.CFrame.RightVector end
                if uis:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0,1,0) end
                if uis:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir = moveDir - Vector3.new(0,1,0) end

                if flyBodyVelocity then flyBodyVelocity.Velocity = moveDir * 50 end
                if flyBodyGyro then flyBodyGyro.CFrame = cam.CFrame end
            end)
        else
            if flyConnection then flyConnection:Disconnect() flyConnection = nil end
            if flyBodyVelocity then flyBodyVelocity:Destroy() flyBodyVelocity = nil end
            if flyBodyGyro then flyBodyGyro:Destroy() flyBodyGyro = nil end
        end
        Compkiller:Notification({
            Title = "Fly",
            Content = state and "Fly ON — WASD + Space/Ctrl" or "Fly OFF",
            Duration = 2
        })
    end
})

-- ESP Toggle
local espHighlights = {}
local espConnection = nil

local function removeESP()
    for _, h in pairs(espHighlights) do
        if h and h.Parent then h:Destroy() end
    end
    espHighlights = {}
end

local function addESP()
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= game.Players.LocalPlayer and plr.Character then
            if not plr.Character:FindFirstChild("ESPHighlight") then
                local highlight = Instance.new("Highlight")
                highlight.Name = "ESPHighlight"
                highlight.FillColor = Color3.fromRGB(255, 0, 0)
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.FillTransparency = 0.5
                highlight.OutlineTransparency = 0
                highlight.Parent = plr.Character
                table.insert(espHighlights, highlight)
            end
        end
    end
end

local espEnabled = false
UtilsRight:AddToggle({
    Name = "ESP (Player Highlight)",
    Default = false,
    Callback = function(state)
        espEnabled = state
        if state then
            addESP()
            espConnection = game.Players.PlayerAdded:Connect(function(plr)
                plr.CharacterAdded:Connect(function()
                    task.wait(1)
                    if espEnabled then addESP() end
                end)
            end)
        else
            removeESP()
            if espConnection then espConnection:Disconnect() espConnection = nil end
        end
        Compkiller:Notification({
            Title = "ESP",
            Content = state and "ESP ON" or "ESP OFF",
            Duration = 2
        })
    end
})

-- ══════════════════════════════════════════════════
-- DISCORD TAB
-- ══════════════════════════════════════════════════
local DiscordTab = Window:DrawTab({
    Icon = "message-circle",
    Name = "Discord",
    Type = "Single"
});

local DiscordSection = DiscordTab:DrawSection({
    Name = "Community"
});

DiscordSection:AddParagraph({
    Title = "Join our Discord!",
    Content = "Get the latest scripts, updates and support.\ndiscord.gg/PAeMxdDCfh"
})

DiscordSection:AddButton({
    Name = "Copy Discord Link",
    Callback = function()
        setclipboard("https://discord.gg/PAeMxdDCfh")
        Compkiller:Notification({
            Title = "Copied!",
            Content = "discord.gg/PAeMxdDCfh copied!",
            Duration = 4
        })
    end
})

-- Create Settings Tab
local SettingsTab = Window:DrawTab({
    Name = "Settings",
    Icon = "settings-3",
    Type = "Single"
});

local SettingsSection = SettingsTab:DrawSection({
    Name = "UI Settings"
});

SettingsSection:AddParagraph({
    Title = "Information",
    Content = "3xt4sy Hub\nTotal Games: " .. #games .. "\nPress LeftAlt to toggle menu"
})

-- Create Config Tab
local Configs = Window:DrawConfig({
    Name = "Configs",
    Icon = "folder",
    Config = FileWatcher
});

Configs:Init();
