local Players = game:GetService("Players")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui")
gui.Name = "RocketMobileMenu"
gui.ResetOnSpawn = false
gui.Parent = playerGui

-- Плавающая кнопка
local icon = Instance.new("TextButton")
icon.Name = "OpenButton"
icon.Size = UDim2.fromOffset(58, 58)
icon.Position = UDim2.new(0, 18, 0.5, -29)
icon.Text = "R"
icon.TextSize = 25
icon.BackgroundTransparency = 0.1
icon.Parent = gui

local iconCorner = Instance.new("UICorner")
iconCorner.CornerRadius = UDim.new(1, 0)
iconCorner.Parent = icon

-- Главное меню
local menu = Instance.new("Frame")
menu.Name = "MainMenu"
menu.Size = UDim2.fromOffset(300, 360)
menu.Position = UDim2.new(0.5, -150, 0.5, -180)
menu.Visible = false -- сначала закрыто
menu.Parent = gui

local menuCorner = Instance.new("UICorner")
menuCorner.CornerRadius = UDim.new(0, 14)
menuCorner.Parent = menu

-- Заголовок
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 55)
title.BackgroundTransparency = 1
title.Text = "ROCKET MENU"
title.TextSize = 22
title.Parent = menu

-- Кнопка закрытия
local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(42, 42)
close.Position = UDim2.new(1, -48, 0, 7)
close.Text = "X"
close.TextSize = 18
close.Parent = menu

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 10)
closeCorner.Parent = close

-- Открытие
icon.Activated:Connect(function()
	menu.Visible = true
	icon.Visible = false
end)

-- Закрытие
close.Activated:Connect(function()
	menu.Visible = false
	icon.Visible = true
end)
