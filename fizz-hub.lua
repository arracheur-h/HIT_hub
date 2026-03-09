local arg = game:GetService("Players")
local fuc = game:GetService("TweenService")
local upv = game:GetService("RunService")

local arg1 = arg.LocalPlayer
local arg2 = arg1
local arg3 = arg2
local uprv1 = (arg3:WaitForChild("PlayerGui"))

local arg4 = Instance.new("ScreenGui", uprv1)
local arg5 = arg4
local arg6 = arg5
arg6.Name = "WelAnima"
arg6.IgnoreGuiInset = true

local arg7 = Instance.new("Frame", arg6)
local arg8 = arg7
local arg9 = arg8
arg9.Name = "MnFrem"
arg9.Size = UDim2.new(1,0,1,0)
arg9.BackgroundTransparency = 1

local arg10 = Instance.new("UIStroke", arg9)
local arg11 = arg10
local arg12 = arg11
arg12.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
arg12.BorderStrokePosition = Enum.BorderStrokePosition.Outer
arg12.Color = Color3.new(0,0,0)
arg12.Thickness = 1

local arg13 = Instance.new("TextLabel", arg9)
local arg14 = arg13
local arg15 = arg14
local dm1 = arg15
dm1.Name = "TtlLable"
dm1.Size = UDim2.new(0,400,0,80)
dm1.Position = UDim2.new(0.5,-200,0.5,-40)
dm1.BackgroundTransparency = 1
dm1.Text = "Welcome to"
dm1.TextColor3 = Color3.new(1,1,1)
dm1.TextScaled = true
dm1.Font = Enum.Font.GothamBold
dm1.TextStrokeTransparency = 0

local arg16 = Instance.new("TextLabel", arg9)
local arg17 = arg16
local arg18 = arg17
local md2 = arg18
md2.Name = "SbTitalble"
md2.Size = UDim2.new(0,300,0,40)
md2.Position = UDim2.new(0.5,-150,0.5,30)
md2.BackgroundTransparency = 1
md2.Text = "3xt4sy hub"
md2.TextColor3 = Color3.new(0.8,0.8,0.8)
md2.TextScaled = true
md2.Font = Enum.Font.Gotham
md2.TextStrokeTransparency = 0

local function uprv2(objct, inf, gol)
	return fuc:Create(objct, inf, gol)
end

local dm3 = 1.5
local md4 = 2
local uprv5 = 1

local function func1()
	dm1.TextTransparency = 1
	md2.TextTransparency = 1

	local arg19 = uprv2(dm1, TweenInfo.new(dm3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
		{ TextTransparency = 0, Size = UDim2.new(0,400,0,80) })
	local arg20 = uprv2(md2, TweenInfo.new(dm3, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0.3),
		{ TextTransparency = 0, Size = UDim2.new(0,300,0,40) })

	arg19:Play()
	arg20:Play()

	task.wait(dm3 + md4)

	local arg21 = uprv2(dm1, TweenInfo.new(uprv5, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
		{ TextTransparency = 1, Size = UDim2.new(0,400,0,80) })
	local arg22 = uprv2(md2, TweenInfo.new(uprv5, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
		{ TextTransparency = 1, Size = UDim2.new(0,300,0,40) })

	arg21:Play()
	arg22:Play()

	task.wait(uprv5)
	arg6:Destroy()
end

arg3.CharacterAdded:Connect(function()
	task.wait(1)
	func1()
end)

if arg3.Character then
	task.wait(1)
	func1()
end
