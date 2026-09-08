-- // RUSSIAN YAD v20.0 // ПОЛНОЕ УПРАВЛЕНИЕ АИМБОТОМ //
local Player = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local Camera = Workspace.CurrentCamera

-- // ========== ОБХОД АНТИЧИТА ========== //
pcall(function()
    for _, v in pairs(getgc(true)) do
        if type(v) == "function" and getfenv(v) then
            local env = getfenv(v)
            if env and env.script and tostring(env.script):find("AntiCheat") then
                env.script.Disabled = true
            end
        end
    end
end)

-- // ========== ГЛАВНЫЙ GUI ========== //
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = CoreGui
ScreenGui.Name = "RussianYadGUI"
ScreenGui.ResetOnSpawn = false

-- // ========== ИКОНКА ========== //
local IconButton = Instance.new("ImageButton")
IconButton.Parent = ScreenGui
IconButton.Size = UDim2.new(0, 70, 0, 70)
IconButton.Position = UDim2.new(0.85, -35, 0.85, -35)
IconButton.BackgroundColor3 = Color3.fromRGB(20, 0, 30)
IconButton.BorderSizePixel = 0
IconButton.Image = "rbxassetid://123456789"
IconButton.ImageColor3 = Color3.fromRGB(255, 0, 80)
IconButton.ScaleType = Enum.ScaleType.Fit
IconButton.ClipsDescendants = true
IconButton.ZIndex = 10

local cornerIcon = Instance.new("UICorner")
cornerIcon.Parent = IconButton
cornerIcon.CornerRadius = UDim.new(1, 0)

local glowIcon = Instance.new("ImageLabel")
glowIcon.Parent = IconButton
glowIcon.Size = UDim2.new(1.4, 0, 1.4, 0)
glowIcon.Position = UDim2.new(-0.2, 0, -0.2, 0)
glowIcon.BackgroundTransparency = 1
glowIcon.Image = "rbxassetid://13158748277"
glowIcon.ImageColor3 = Color3.fromRGB(255, 0, 80)
glowIcon.ImageTransparency = 0.7
glowIcon.ZIndex = 0

local IconText = Instance.new("TextLabel")
IconText.Parent = IconButton
IconText.Size = UDim2.new(1, 0, 1, 0)
IconText.BackgroundTransparency = 1
IconText.Text = "☠"
IconText.TextColor3 = Color3.fromRGB(255, 255, 255)
IconText.TextScaled = true
IconText.Font = Enum.Font.GothamBold
IconText.ZIndex = 11

-- ПУЛЬСАЦИЯ
spawn(function()
    while IconButton and IconButton.Parent do
        local tween = TweenService:Create(IconButton, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {Size = UDim2.new(0, 75, 0, 75)})
        tween:Play()
        wait(0.6)
        local tween2 = TweenService:Create(IconButton, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {Size = UDim2.new(0, 65, 0, 65)})
        tween2:Play()
        wait(0.6)
    end
end)

-- // ========== ПЕРЕТАСКИВАНИЕ ИКОНКИ ========== //
local iconDragToggle, iconDragStart, iconStartPos = false
IconButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        iconDragToggle = true
        iconDragStart = input.Position
        iconStartPos = IconButton.Position
    end
end)
IconButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        iconDragToggle = false
    end
end)
UIS.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch and iconDragToggle then
        local delta = input.Position - iconDragStart
        local newX = math.clamp(iconStartPos.X.Offset + delta.X, 0, UIS:GetMouseLocation().X - 70)
        local newY = math.clamp(iconStartPos.Y.Offset + delta.Y, 0, UIS:GetMouseLocation().Y - 70)
        IconButton.Position = UDim2.new(0, newX, 0, newY)
    end
end)

-- // ========== ГЛАВНОЕ МЕНЮ ========== //
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 280, 0, 250)
MainFrame.Position = UDim2.new(0.5, -140, 0.5, -125)
MainFrame.BackgroundColor3 = Color3.fromRGB(8, 0, 18)
MainFrame.BorderSizePixel = 0
MainFrame.BackgroundTransparency = 0.1
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true

local cornerMenu = Instance.new("UICorner")
cornerMenu.Parent = MainFrame
cornerMenu.CornerRadius = UDim.new(0, 20)

local borderGlow = Instance.new("ImageLabel")
borderGlow.Parent = MainFrame
borderGlow.Size = UDim2.new(1.1, 0, 1.1, 0)
borderGlow.Position = UDim2.new(-0.05, 0, -0.05, 0)
borderGlow.BackgroundTransparency = 1
borderGlow.Image = "rbxassetid://13158748277"
borderGlow.ImageColor3 = Color3.fromRGB(255, 0, 80)
borderGlow.ImageTransparency = 0.6
borderGlow.ZIndex = 0

local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "☠ RUSSIAN YAD"
Title.TextColor3 = Color3.fromRGB(255, 0, 80)
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true
Title.ZIndex = 2

local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = MainFrame
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -40, 0, 3)
CloseBtn.Text = "✖"
CloseBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
CloseBtn.BorderSizePixel = 0
CloseBtn.TextScaled = true
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.ZIndex = 2
local cornerClose = Instance.new("UICorner")
cornerClose.Parent = CloseBtn
cornerClose.CornerRadius = UDim.new(0, 10)
CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    IconButton.Visible = true
end)

-- // ========== КНОПКИ ГЛАВНОГО МЕНЮ ========== //
local yPos = 45
local btnH = 30
local btnW = 125

-- РЯД 1: FLY + НОКЛИП
local FlyBtn = Instance.new("TextButton")
FlyBtn.Parent = MainFrame
FlyBtn.Size = UDim2.new(0, btnW, 0, btnH)
FlyBtn.Position = UDim2.new(0.03, 0, 0, yPos)
FlyBtn.Text = "🚀 FLY"
FlyBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 80)
FlyBtn.BorderSizePixel = 0
FlyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyBtn.Font = Enum.Font.GothamBold
FlyBtn.TextScaled = true
local cornerFly = Instance.new("UICorner")
cornerFly.Parent = FlyBtn
cornerFly.CornerRadius = UDim.new(0, 8)

local NoclipBtn = Instance.new("TextButton")
NoclipBtn.Parent = MainFrame
NoclipBtn.Size = UDim2.new(0, btnW, 0, btnH)
NoclipBtn.Position = UDim2.new(0.53, 0, 0, yPos)
NoclipBtn.Text = "⬜ НОКЛИП"
NoclipBtn.BackgroundColor3 = Color3.fromRGB(80, 30, 30)
NoclipBtn.BorderSizePixel = 0
NoclipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
NoclipBtn.Font = Enum.Font.GothamBold
NoclipBtn.TextScaled = true
local cornerNoclip = Instance.new("UICorner")
cornerNoclip.Parent = NoclipBtn
cornerNoclip.CornerRadius = UDim.new(0, 8)

yPos = yPos + btnH + 5

-- РЯД 2: ESP
local EspBtn = Instance.new("TextButton")
EspBtn.Parent = MainFrame
EspBtn.Size = UDim2.new(0, 125, 0, btnH)
EspBtn.Position = UDim2.new(0.03, 0, 0, yPos)
EspBtn.Text = "👁️ ESP"
EspBtn.BackgroundColor3 = Color3.fromRGB(80, 30, 30)
EspBtn.BorderSizePixel = 0
EspBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
EspBtn.Font = Enum.Font.GothamBold
EspBtn.TextScaled = true
local cornerEsp = Instance.new("UICorner")
cornerEsp.Parent = EspBtn
cornerEsp.CornerRadius = UDim.new(0, 8)

-- КНОПКА ОТКРЫТИЯ МЕНЮ АИМБОТА
local AimMenuBtn = Instance.new("TextButton")
AimMenuBtn.Parent = MainFrame
AimMenuBtn.Size = UDim2.new(0, btnW, 0, btnH)
AimMenuBtn.Position = UDim2.new(0.53, 0, 0, yPos)
AimMenuBtn.Text = "🎯 АИМ"
AimMenuBtn.BackgroundColor3 = Color3.fromRGB(30, 50, 80)
AimMenuBtn.BorderSizePixel = 0
AimMenuBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AimMenuBtn.Font = Enum.Font.GothamBold
AimMenuBtn.TextScaled = true
local cornerAimMenu = Instance.new("UICorner")
cornerAimMenu.Parent = AimMenuBtn
cornerAimMenu.CornerRadius = UDim.new(0, 8)

yPos = yPos + btnH + 5

-- РЯД 3: ВЫКЛЮЧИТЬ ВСЁ
local OffBtn = Instance.new("TextButton")
OffBtn.Parent = MainFrame
OffBtn.Size = UDim2.new(0, 260, 0, btnH)
OffBtn.Position = UDim2.new(0.03, 0, 0, yPos)
OffBtn.Text = "❌ ВЫКЛЮЧИТЬ ВСЁ"
OffBtn.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
OffBtn.BorderSizePixel = 0
OffBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
OffBtn.Font = Enum.Font.GothamBold
OffBtn.TextScaled = true
local cornerOff = Instance.new("UICorner")
cornerOff.Parent = OffBtn
cornerOff.CornerRadius = UDim.new(0, 8)

-- // ========== МЕНЮ АИМБОТА (ОТДЕЛЬНЫЙ GUI) ========== //
local AimFrame = Instance.new("Frame")
AimFrame.Parent = ScreenGui
AimFrame.Size = UDim2.new(0, 280, 0, 200)
AimFrame.Position = UDim2.new(0.5, -140, 0.5, -100)
AimFrame.BackgroundColor3 = Color3.fromRGB(8, 0, 18)
AimFrame.BorderSizePixel = 0
AimFrame.BackgroundTransparency = 0.1
AimFrame.Visible = false
AimFrame.Active = true
AimFrame.Draggable = true
AimFrame.ClipsDescendants = true

local cornerAim = Instance.new("UICorner")
cornerAim.Parent = AimFrame
cornerAim.CornerRadius = UDim.new(0, 20)

local borderAim = Instance.new("ImageLabel")
borderAim.Parent = AimFrame
borderAim.Size = UDim2.new(1.1, 0, 1.1, 0)
borderAim.Position = UDim2.new(-0.05, 0, -0.05, 0)
borderAim.BackgroundTransparency = 1
borderAim.Image = "rbxassetid://13158748277"
borderAim.ImageColor3 = Color3.fromRGB(0, 255, 0)
borderAim.ImageTransparency = 0.6
borderAim.ZIndex = 0

local AimTitle = Instance.new("TextLabel")
AimTitle.Parent = AimFrame
AimTitle.Size = UDim2.new(1, 0, 0, 35)
AimTitle.Position = UDim2.new(0, 0, 0, 0)
AimTitle.BackgroundTransparency = 1
AimTitle.Text = "🎯 НАСТРОЙКИ АИМА"
AimTitle.TextColor3 = Color3.fromRGB(0, 255, 0)
AimTitle.Font = Enum.Font.GothamBold
AimTitle.TextScaled = true
AimTitle.ZIndex = 2

local AimCloseBtn = Instance.new("TextButton")
AimCloseBtn.Parent = AimFrame
AimCloseBtn.Size = UDim2.new(0, 35, 0, 35)
AimCloseBtn.Position = UDim2.new(1, -40, 0, 0)
AimCloseBtn.Text = "✖"
AimCloseBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
AimCloseBtn.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
AimCloseBtn.BorderSizePixel = 0
AimCloseBtn.TextScaled = true
AimCloseBtn.Font = Enum.Font.GothamBold
AimCloseBtn.ZIndex = 2
local cornerAimClose = Instance.new("UICorner")
cornerAimClose.Parent = AimCloseBtn
cornerAimClose.CornerRadius = UDim.new(0, 10)
AimCloseBtn.MouseButton1Click:Connect(function()
    AimFrame.Visible = false
    MainFrame.Visible = true
end)

-- // ========== КНОПКИ МЕНЮ АИМБОТА ========== //
local aimY = 40
local aimH = 32
local aimW = 125

-- ВКЛ/ВЫКЛ АИМБОТА
local AimToggleBtn = Instance.new("TextButton")
AimToggleBtn.Parent = AimFrame
AimToggleBtn.Size = UDim2.new(0, aimW, 0, aimH)
AimToggleBtn.Position = UDim2.new(0.03, 0, 0, aimY)
AimToggleBtn.Text = "🎯 АИМ ВКЛ"
AimToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
AimToggleBtn.BorderSizePixel = 0
AimToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AimToggleBtn.Font = Enum.Font.GothamBold
AimToggleBtn.TextScaled = true
local cornerAimToggle = Instance.new("UICorner")
cornerAimToggle.Parent = AimToggleBtn
cornerAimToggle.CornerRadius = UDim.new(0, 8)

-- КРУГ ВКЛ/ВЫКЛ
local FovToggleBtn = Instance.new("TextButton")
FovToggleBtn.Parent = AimFrame
FovToggleBtn.Size = UDim2.new(0, aimW, 0, aimH)
FovToggleBtn.Position = UDim2.new(0.53, 0, 0, aimY)
FovToggleBtn.Text = "⭕ КРУГ ВКЛ"
FovToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
FovToggleBtn.BorderSizePixel = 0
FovToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FovToggleBtn.Font = Enum.Font.GothamBold
FovToggleBtn.TextScaled = true
local cornerFovToggle = Instance.new("UICorner")
cornerFovToggle.Parent = FovToggleBtn
cornerFovToggle.CornerRadius = UDim.new(0, 8)

aimY = aimY + aimH + 5

-- РАДИУС КРУГА (ГРАДУСЫ)
local RadiusLabel = Instance.new("TextLabel")
RadiusLabel.Parent = AimFrame
RadiusLabel.Size = UDim2.new(0, 100, 0, aimH)
RadiusLabel.Position = UDim2.new(0.03, 0, 0, aimY)
RadiusLabel.Text = "РАДИУС: 90°"
RadiusLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
RadiusLabel.BorderSizePixel = 0
RadiusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
RadiusLabel.Font = Enum.Font.GothamBold
RadiusLabel.TextScaled = true
local cornerRadiusLabel = Instance.new("UICorner")
cornerRadiusLabel.Parent = RadiusLabel
cornerRadiusLabel.CornerRadius = UDim.new(0, 8)

local RadiusMinus = Instance.new("TextButton")
RadiusMinus.Parent = AimFrame
RadiusMinus.Size = UDim2.new(0, 40, 0, aimH)
RadiusMinus.Position = UDim2.new(0.50, 0, 0, aimY)
RadiusMinus.Text = "-"
RadiusMinus.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
RadiusMinus.BorderSizePixel = 0
RadiusMinus.TextColor3 = Color3.fromRGB(255, 255, 255)
RadiusMinus.Font = Enum.Font.GothamBold
RadiusMinus.TextScaled = true
local cornerRadiusMinus = Instance.new("UICorner")
cornerRadiusMinus.Parent = RadiusMinus
cornerRadiusMinus.CornerRadius = UDim.new(0, 8)

local RadiusPlus = Instance.new("TextButton")
RadiusPlus.Parent = AimFrame
RadiusPlus.Size = UDim2.new(0, 40, 0, aimH)
RadiusPlus.Position = UDim2.new(0.73, 0, 0, aimY)
RadiusPlus.Text = "+"
RadiusPlus.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
RadiusPlus.BorderSizePixel = 0
RadiusPlus.TextColor3 = Color3.fromRGB(255, 255, 255)
RadiusPlus.Font = Enum.Font.GothamBold
RadiusPlus.TextScaled = true
local cornerRadiusPlus = Instance.new("UICorner")
cornerRadiusPlus.Parent = RadiusPlus
cornerRadiusPlus.CornerRadius = UDim.new(0, 8)

aimY = aimY + aimH + 5

-- ДАЛЬНОСТЬ (МЕТРЫ)
local DistLabel = Instance.new("TextLabel")
DistLabel.Parent = AimFrame
DistLabel.Size = UDim2.new(0, 100, 0, aimH)
DistLabel.Position = UDim2.new(0.03, 0, 0, aimY)
DistLabel.Text = "ДИСТ.: 100 м"
DistLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
DistLabel.BorderSizePixel = 0
DistLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
DistLabel.Font = Enum.Font.GothamBold
DistLabel.TextScaled = true
local cornerDistLabel = Instance.new("UICorner")
cornerDistLabel.Parent = DistLabel
cornerDistLabel.CornerRadius = UDim.new(0, 8)

local DistMinus = Instance.new("TextButton")
DistMinus.Parent = AimFrame
DistMinus.Size = UDim2.new(0, 40, 0, aimH)
DistMinus.Position = UDim2.new(0.50, 0, 0, aimY)
DistMinus.Text = "-"
DistMinus.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
DistMinus.BorderSizePixel = 0
DistMinus.TextColor3 = Color3.fromRGB(255, 255, 255)
DistMinus.Font = Enum.Font.GothamBold
DistMinus.TextScaled = true
local cornerDistMinus = Instance.new("UICorner")
cornerDistMinus.Parent = DistMinus
cornerDistMinus.CornerRadius = UDim.new(0, 8)

local DistPlus = Instance.new("TextButton")
DistPlus.Parent = AimFrame
DistPlus.Size = UDim2.new(0, 40, 0, aimH)
DistPlus.Position = UDim2.new(0.73, 0, 0, aimY)
DistPlus.Text = "+"
DistPlus.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
DistPlus.BorderSizePixel = 0
DistPlus.TextColor3 = Color3.fromRGB(255, 255, 255)
DistPlus.Font = Enum.Font.GothamBold
DistPlus.TextScaled = true
local cornerDistPlus = Instance.new("UICorner")
cornerDistPlus.Parent = DistPlus
cornerDistPlus.CornerRadius = UDim.new(0, 8)

-- // ========== ПЕРЕМЕННЫЕ АИМБОТА ========== //
local aimbotEnabled = true
local fovVisible = true
local fovRadius = 90
local maxDistance = 100
local fovCircle = nil
local fovColor = Color3.fromRGB(0, 255, 0)

-- // ========== ФУНКЦИИ АИМБОТА ========== //
local function createFovCircle()
    if fovCircle then fovCircle:Destroy() end
    fovCircle = Drawing.new("Circle")
    fovCircle.Visible = fovVisible
    fovCircle.Radius = fovRadius
    fovCircle.Color = fovColor
    fovCircle.Thickness = 2
    fovCircle.Filled = false
    fovCircle.NumSides = 64
    fovCircle.Transparency = 0.6
    local screenSize = Camera.ViewportSize
    fovCircle.Position = Vector2.new(screenSize.X / 2, screenSize.Y / 2)
end

local function updateFovCircle()
    if fovCircle then
        fovCircle.Radius = fovRadius
        fovCircle.Color = fovColor
        fovCircle.Visible = fovVisible
        local screenSize = Camera.ViewportSize
        fovCircle.Position = Vector2.new(screenSize.X / 2, screenSize.Y / 2)
    end
end

local function getClosestPlayerInFov()
    if not aimbotEnabled then return nil end
    local closest = nil
    local minDist = math.huge
    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    local playerPos = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
    if not playerPos then return nil end
    
    for _, plr in pairs(Player:GetPlayers()) do
        if plr ~= Player and plr.Character and plr.Character:FindFirstChild("Head") then
            local head = plr.Character.Head
            local worldDist = (head.Position - playerPos.Position).Magnitude
            if worldDist > maxDistance then continue end -- Дальность
            
            local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
            if onScreen then
                local dist = (Vector2.new(screenPos.X, screenPos.Y) - screenCenter).Magnitude
                if dist < fovRadius and dist < minDist then
                    minDist = dist
                    closest = head
                end
            end
        end
    end
    return closest
end

local function aimbot(targetHead)
    if not aimbotEnabled then return end
    if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then return end
    local hrp = Player.Character.HumanoidRootPart
    if not targetHead then return end
    hrp.CFrame = CFrame.new(hrp.Position, targetHead.Position)
end

-- // ========== ОБРАБОТЧИКИ КНОПОК АИМБОТА ========== //

-- ВКЛ/ВЫКЛ АИМБОТА
AimToggleBtn.MouseButton1Click:Connect(function()
    aimbotEnabled = not aimbotEnabled
    AimToggleBtn.BackgroundColor3 = aimbotEnabled and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(80, 30, 30)
    AimToggleBtn.Text = aimbotEnabled and "🎯 АИМ ВКЛ" or "🎯 АИМ ВЫКЛ"
end)

-- ВКЛ/ВЫКЛ КРУГА
FovToggleBtn.MouseButton1Click:Connect(function()
    fovVisible = not fovVisible
    FovToggleBtn.BackgroundColor3 = fovVisible and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(80, 30, 30)
    FovToggleBtn.Text = fovVisible and "⭕ КРУГ ВКЛ" or "⭕ КРУГ ВЫКЛ"
    if fovCircle then fovCircle.Visible = fovVisible end
end)

-- РАДИУС (1-360)
RadiusPlus.MouseButton1Click:Connect(function()
    if fovRadius < 360 then
        fovRadius = fovRadius + 1
        RadiusLabel.Text = "РАДИУС: " .. tostring(fovRadius) .. "°"
        if fovCircle then fovCircle.Radius = fovRadius end
    end
end)

RadiusMinus.MouseButton1Click:Connect(function()
    if fovRadius > 1 then
        fovRadius = fovRadius - 1
        RadiusLabel.Text = "РАДИУС: " .. tostring(fovRadius) .. "°"
        if fovCircle then fovCircle.Radius = fovRadius end
    end
end)

-- ДАЛЬНОСТЬ (5-500 метров)
DistPlus.MouseButton1Click:Connect(function()
    if maxDistance < 500 then
        maxDistance = maxDistance + 5
        DistLabel.Text = "ДИСТ.: " .. tostring(maxDistance) .. " м"
    end
end)

DistMinus.MouseButton1Click:Connect(function()
    if maxDistance > 5 then
        maxDistance = maxDistance - 5
        DistLabel.Text = "ДИСТ.: " .. tostring(maxDistance) .. " м"
    end
end)

-- ОТКРЫТИЕ МЕНЮ АИМБОТА
AimMenuBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    AimFrame.Visible = true
end)

-- // ========== ПЕРЕТАСКИВАНИЕ МЕНЮ АИМБОТА ========== //
local aimDragToggle, aimDragStart, aimStartPos = false
AimFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        aimDragToggle = true
        aimDragStart = input.Position
        aimStartPos = AimFrame.Position
    end
end)
AimFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        aimDragToggle = false
    end
end)
UIS.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch and aimDragToggle then
        local delta = input.Position - aimDragStart
        AimFrame.Position = UDim2.new(aimStartPos.X.Scale, aimStartPos.X.Offset + delta.X, aimStartPos.Y.Scale, aimStartPos.Y.Offset + delta.Y)
    end
end)

-- // ========== ПЕРЕМЕННЫЕ ========== //
local flyGuiInstance = nil
local isFlyRunning = false
local noclipActive = false
local espLoaded = false

-- // ========== ОБРАБОТЧИКИ ГЛАВНЫХ КНОПОК ========== //

-- FLY
FlyBtn.MouseButton1Click:Connect(function()
    if isFlyRunning then
        if flyGuiInstance then
            if flyGuiInstance.Parent then flyGuiInstance:Destroy() end
            flyGuiInstance = nil
        end
        local gui = CoreGui:FindFirstChild("main")
        if gui then gui:Destroy() end
        isFlyRunning = false
        FlyBtn.Text = "🚀 FLY"
        FlyBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 80)
    else
        local success, err = pcall(function()
            local script = game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt")
            flyGuiInstance = loadstring(script)()
        end)
        if success then
            isFlyRunning = true
            FlyBtn.Text = "🛑 FLY"
            FlyBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
        end
    end
end)

-- НОКЛИП
NoclipBtn.MouseButton1Click:Connect(function()
    noclipActive = not noclipActive
    NoclipBtn.BackgroundColor3 = noclipActive and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(80, 30, 30)
    NoclipBtn.Text = noclipActive and "⬜ НОКЛИП ON" or "⬜ НОКЛИП"
    if noclipActive then
        RunService.Stepped:Connect(function()
            if noclipActive and Player.Character then
                for _, part in ipairs(Player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end)
    else
        if Player.Character then
            for _, part in ipairs(Player.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = true end
            end
        end
    end
end)

-- ESP
EspBtn.MouseButton1Click:Connect(function()
    if espLoaded then
        for _, plr in pairs(Player:GetPlayers()) do
            if plr.Character then
                local hl = plr.Character:FindFirstChild("ESPHighlight")
                if hl then hl:Destroy() end
                local head = plr.Character:FindFirstChild("Head")
                if head then
                    local tag = head:FindFirstChild("NameTag")
                    if tag then tag:Destroy() end
                end
            end
        end
        espLoaded = false
        EspBtn.Text = "👁️ ESP"
        EspBtn.BackgroundColor3 = Color3.fromRGB(80, 30, 30)
    else
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Yahahahau/Ultimate-Esp-v1/refs/heads/main/Ultimate%20esp%20v1.lua"))()
        end)
        if success then
            espLoaded = true
            EspBtn.Text = "👁️ ESP ON"
            EspBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
        end
    end
end)

-- ВЫКЛЮЧИТЬ ВСЁ
OffBtn.MouseButton1Click:Connect(function()
    -- FLY
    if isFlyRunning then
        if flyGuiInstance then
            if flyGuiInstance.Parent then flyGuiInstance:Destroy() end
            flyGuiInstance = nil
        end
        local gui = CoreGui:FindFirstChild("main")
        if gui then gui:Destroy() end
        isFlyRunning = false
        FlyBtn.Text = "🚀 FLY"
        FlyBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 80)
    end
    
    -- НОКЛИП
    if noclipActive then
        noclipActive = false
        NoclipBtn.BackgroundColor3 = Color3.fromRGB(80, 30, 30)
        NoclipBtn.Text = "⬜ НОКЛИП"
        if Player.Character then
            for _, part in ipairs(Player.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = true end
            end
        end
    end
    
    -- ESP
    if espLoaded then
        for _, plr in pairs(Player:GetPlayers()) do
            if plr.Character then
                local hl = plr.Character:FindFirstChild("ESPHighlight")
                if hl then hl:Destroy() end
                local head = plr.Character:FindFirstChild("Head")
                if head then
                    local tag = head:FindFirstChild("NameTag")
                    if tag then tag:Destroy() end
                end
            end
        end
        espLoaded = false
        EspBtn.Text = "👁️ ESP"
        EspBtn.BackgroundColor3 = Color3.fromRGB(80, 30, 30)
    end
    
    -- АИМБОТ
    aimbotEnabled = false
    AimToggleBtn.BackgroundColor3 = Color3.fromRGB(80, 30, 30)
    AimToggleBtn.Text = "🎯 АИМ ВЫКЛ"
    
    print("☠ ВСЁ ВЫКЛЮЧЕНО")
end)

-- // ========== ОБНОВЛЕНИЕ В ЦИКЛЕ ========== //
createFovCircle()

RunService.RenderStepped:Connect(function()
    updateFovCircle()
    if aimbotEnabled then
        local target = getClosestPlayerInFov()
        if target then
            aimbot(target)
        end
    end
end)

-- // ========== ПЕРЕТАСКИВАНИЕ МЕНЮ ========== //
local menuDragToggle, menuDragStart, menuStartPos = false
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        menuDragToggle = true
        menuDragStart = input.Position
        menuStartPos = MainFrame.Position
    end
end)
MainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        menuDragToggle = false
    end
end)
UIS.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch and menuDragToggle then
        local delta = input.Position - menuDragStart
        MainFrame.Position = UDim2.new(menuStartPos.X.Scale, menuStartPos.X.Offset + delta.X, menuStartPos.Y.Scale, menuStartPos.Y.Offset + delta.Y)
    end
end)

-- // ========== ОТКРЫТИЕ/ЗАКРЫТИЕ ========== //
local menuOpen = false
IconButton.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    MainFrame.Visible = menuOpen
    IconButton.Visible = not menuOpen
    if menuOpen then
        AimFrame.Visible = false
    end
end)

-- // ========== ПАНИКА ========== //
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.P then
        ScreenGui:Destroy()
        if isFlyRunning then
            if flyGuiInstance then flyGuiInstance:Destroy() end
            local gui = CoreGui:FindFirstChild("main")
            if gui then gui:Destroy() end
        end
        if fovCircle then fovCircle:Destroy() end
        if espLoaded then
            for _, plr in pairs(Player:GetPlayers()) do
                if plr.Character then
                    local hl = plr.Character:FindFirstChild("ESPHighlight")
                    if hl then hl:Destroy() end
                    local head = plr.Character:FindFirstChild("Head")
                    if head then
                        local tag = head:FindFirstChild("NameTag")
                        if tag then tag:Destroy() end
                    end
                end
            end
        end
        print("☠ ПАНИКА")
    end
end)

print("☠ RUSSIAN YAD v20.0 ЗАГРУЖЕН")
print("📌 ОТДЕЛЬНОЕ МЕНЮ ДЛЯ АИМБОТА (КНОПКА 'АИМ')")
print("🎯 АИМБОТ РАБОТАЕТ С НАСТРАИВАЕМЫМИ РАДИУСОМ И ДАЛЬНОСТЬЮ")
