--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "3xt4sy HUB " .. Fluent.Version,
    SubTitle = "xt4sy",
    TabWidth = 150,
    Size = UDim2.fromOffset(435, 335),
    Acrylic = false, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "amethyst",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})


local Tabs = {
    Main = Window:AddTab({ Title = "INF Ammo", Icon = "crosshair" }),
}

local Options = Fluent.Options

    local Toggle = Tabs.Main:AddToggle("Ammo", {Title = "Inf Ammo", Default = false })

    Toggle:OnChanged(function()
        print("Toggle changed:", Options.Ammo.Value)
while (Options.Ammo.Value) do 
game:GetService("Players").LocalPlayer.PlayerGui.GUI.Client.Variables.ammocount.Value = 999
game:GetService("Players").LocalPlayer.PlayerGui.GUI.Client.Variables.ammocount2.Value = 999
task.wait(0.1)
end
    end)

     Options.Ammo:SetValue(false)

wait(2.5)

setclipboard("https://discord.gg/PWtzj67Vtv")

Fluent:Notify({
    Title = "Discord Server",
    Content = "Discord Server Link Copyied To Your Clipboard",
    Duration = 5
})



      
