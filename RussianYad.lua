local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local plr = Players.LocalPlayer
local gui = Instance.new("ScreenGui", plr:WaitForChild("PlayerGui"))
gui.Name = "ADMenu"
gui.ResetOnSpawn = false

-- ИКОНКА
local icon = Instance.new("TextButton", gui)
icon.Size = UDim2.fromOffset(55, 55)
icon.Position = UDim2.new(1, -65, 0.5, -25)
icon.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
icon.Text = "🔧"
icon.TextSize = 25
icon.ZIndex = 999
Instance.new("UICorner", icon).CornerRadius = UDim.new(0, 27)

-- Перетаскивание иконки
local drag = false
local start = nil
local pos = nil

icon.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        drag = true
        start = i.Position
        pos = icon.Position
    end
end)

icon.InputChanged:Connect(function(i)
    if drag and (i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseMovement) then
        local d = i.Position - start
        icon.Position = UDim2.new(pos.X.Scale, pos.X.Offset + d.X, pos.Y.Scale, pos.Y.Offset + d.Y)
    end
end)

icon.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        drag = false
    end
end)

-- ГЛАВНОЕ МЕНЮ
local menu = Instance.new("Frame", gui)
menu.Size = UDim2.fromOffset(300, 310)
menu.Position = UDim2.new(0.5, -150, 0.5, -155)
menu.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
menu.Visible = false

Instance.new("UICorner", menu).CornerRadius = UDim.new(0, 16)

local title = Instance.new("TextLabel", menu)
title.Size = UDim2.new(1, -100, 0, 50)
title.Position = UDim2.fromOffset(50, 5)
title.BackgroundTransparency = 1
title.Text = "AD MENU"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 20
title.Font = Enum.Font.GothamBold

local close = Instance.new("TextButton", menu)
close.Size = UDim2.fromOffset(40, 40)
close.Position = UDim2.new(1, -48, 0, 10)
close.Text = "X"
close.TextSize = 18
close.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
close.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", close).CornerRadius = UDim.new(0, 10)

local function btn(text, y)
    local b = Instance.new("TextButton", menu)
    b.Size = UDim2.new(1, -30, 0, 50)
    b.Position = UDim2.fromOffset(15, y)
    b.Text = text
    b.TextColor3 = Color3.new(1, 1, 1)
    b.TextSize = 15
    b.Font = Enum.Font.GothamSemibold
    b.BackgroundColor3 = Color3.fromRGB(27, 27, 34)
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 10)
    return b
end

local espOpen = btn("ESP", 65)

-- ESP ОКНО
local esp = Instance.new("Frame", gui)
esp.Size = menu.Size
esp.Position = menu.Position
esp.BackgroundColor3 = menu.BackgroundColor3
esp.Visible = false
Instance.new("UICorner", esp).CornerRadius = UDim.new(0, 16)

local et = Instance.new("TextLabel", esp)
et.Size = UDim2.new(1, -60, 0, 50)
et.Position = UDim2.fromOffset(15, 5)
et.BackgroundTransparency = 1
et.Text = "ESP"
et.TextColor3 = Color3.new(1, 1, 1)
et.TextSize = 20
et.Font = Enum.Font.GothamBold
et.TextXAlignment = Enum.TextXAlignment.Left

local back = Instance.new("TextButton", esp)
back.Size = UDim2.fromOffset(40, 40)
back.Position = UDim2.new(1, -48, 0, 10)
back.Text = "<"
back.TextSize = 20
back.TextColor3 = Color3.new(1, 1, 1)
back.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
Instance.new("UICorner", back).CornerRadius = UDim.new(0, 10)

-- ESP ВКЛ/ВЫКЛ
local espOn = false

local espToggle = Instance.new("TextButton", esp)
espToggle.Size = UDim2.new(1, -30, 0, 50)
espToggle.Position = UDim2.fromOffset(15, 65)
espToggle.BackgroundColor3 = Color3.fromRGB(27, 27, 34)
espToggle.TextColor3 = Color3.new(1, 1, 1)
espToggle.TextSize = 15
espToggle.Font = Enum.Font.GothamSemibold
espToggle.Text = "ESP: OFF"
Instance.new("UICorner", espToggle).CornerRadius = UDim.new(0, 10)

espToggle.Activated:Connect(function()
    espOn = not espOn
    espToggle.Text = "ESP: "..(espOn and "ON" or "OFF")
    
    if not espOn then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= plr and p.Character then
                local h = p.Character:FindFirstChild("AD_ESP")
                if h then
                    h:Destroy()
                end
            end
        end
    end
end)

-- ОТКРЫТИЕ МЕНЮ ПО ИКОНКЕ
icon.Activated:Connect(function()
    if not drag then
        menu.Visible = not menu.Visible
        if menu.Visible then
            esp.Visible = false
        end
    end
end)

-- КНОПКИ
espOpen.Activated:Connect(function()
    menu.Visible = false
    esp.Visible = true
end)

back.Activated:Connect(function()
    esp.Visible = false
    menu.Visible = true
end)

close.Activated:Connect(function()
    menu.Visible = false
end)

-- ESP HIGHLIGHT
RunService.RenderStepped:Connect(function()
    if not espOn then
        return
    end
    
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= plr and p.Character then
            local h = p.Character:FindFirstChild("AD_ESP")
            if not h then
                h = Instance.new("Highlight")
                h.Name = "AD_ESP"
                h.FillTransparency = 0.65
                h.Parent = p.Character
            end
        end
    end
end)
