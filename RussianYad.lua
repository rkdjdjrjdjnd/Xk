-- // RUSSIAN YAD v14.0 // FLY GUI V3 + ОСТАНОВКА //
local Player = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")

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

-- // ========== GUI ========== //
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

-- // ========== МЕНЮ ========== //
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 240, 0, 180)
MainFrame.Position = UDim2.new(0.5, -120, 0.5, -90)
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

-- // ========== КНОПКИ ========== //
local yPos = 45
local btnH = 38

-- FLY (теперь запускает FlyGuiV3)
local FlyBtn = Instance.new("TextButton")
FlyBtn.Parent = MainFrame
FlyBtn.Size = UDim2.new(0, 210, 0, btnH)
FlyBtn.Position = UDim2.new(0.05, 0, 0, yPos)
FlyBtn.Text = "🌀 FLY"
FlyBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 80)
FlyBtn.BorderSizePixel = 0
FlyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyBtn.Font = Enum.Font.GothamBold
FlyBtn.TextScaled = true
local cornerFly = Instance.new("UICorner")
cornerFly.Parent = FlyBtn
cornerFly.CornerRadius = UDim.new(0, 10)

yPos = yPos + btnH + 8

-- НОКЛИП
local NoclipBtn = Instance.new("TextButton")
NoclipBtn.Parent = MainFrame
NoclipBtn.Size = UDim2.new(0, 210, 0, btnH)
NoclipBtn.Position = UDim2.new(0.05, 0, 0, yPos)
NoclipBtn.Text = "⬜ НОКЛИП"
NoclipBtn.BackgroundColor3 = Color3.fromRGB(80, 30, 30)
NoclipBtn.BorderSizePixel = 0
NoclipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
NoclipBtn.Font = Enum.Font.GothamBold
NoclipBtn.TextScaled = true
local cornerNoclip = Instance.new("UICorner")
cornerNoclip.Parent = NoclipBtn
cornerNoclip.CornerRadius = UDim.new(0, 10)

yPos = yPos + btnH + 8

-- ВЫСОТА (+ и -)
local HeightFrame = Instance.new("Frame")
HeightFrame.Parent = MainFrame
HeightFrame.Size = UDim2.new(0, 210, 0, btnH)
HeightFrame.Position = UDim2.new(0.05, 0, 0, yPos)
HeightFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
HeightFrame.BorderSizePixel = 0
local cornerHeight = Instance.new("UICorner")
cornerHeight.Parent = HeightFrame
cornerHeight.CornerRadius = UDim.new(0, 10)

local HeightMinus = Instance.new("TextButton")
HeightMinus.Parent = HeightFrame
HeightMinus.Size = UDim2.new(0, 60, 0, btnH)
HeightMinus.Position = UDim2.new(0, 0, 0, 0)
HeightMinus.Text = "▼"
HeightMinus.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
HeightMinus.BorderSizePixel = 0
HeightMinus.TextColor3 = Color3.fromRGB(255, 255, 255)
HeightMinus.Font = Enum.Font.GothamBold
HeightMinus.TextScaled = true
local cornerMinus = Instance.new("UICorner")
cornerMinus.Parent = HeightMinus
cornerMinus.CornerRadius = UDim.new(0, 8)

local HeightLabel = Instance.new("TextLabel")
HeightLabel.Parent = HeightFrame
HeightLabel.Size = UDim2.new(0, 90, 0, btnH)
HeightLabel.Position = UDim2.new(0.28, 0, 0, 0)
HeightLabel.Text = "ВЫСОТА 0"
HeightLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
HeightLabel.BorderSizePixel = 0
HeightLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
HeightLabel.Font = Enum.Font.GothamBold
HeightLabel.TextScaled = true
local cornerLabel = Instance.new("UICorner")
cornerLabel.Parent = HeightLabel
cornerLabel.CornerRadius = UDim.new(0, 8)

local HeightPlus = Instance.new("TextButton")
HeightPlus.Parent = HeightFrame
HeightPlus.Size = UDim2.new(0, 60, 0, btnH)
HeightPlus.Position = UDim2.new(0.71, 0, 0, 0)
HeightPlus.Text = "▲"
HeightPlus.BackgroundColor3 = Color3.fromRGB(0, 80, 0)
HeightPlus.BorderSizePixel = 0
HeightPlus.TextColor3 = Color3.fromRGB(255, 255, 255)
HeightPlus.Font = Enum.Font.GothamBold
HeightPlus.TextScaled = true
local cornerPlus = Instance.new("UICorner")
cornerPlus.Parent = HeightPlus
cornerPlus.CornerRadius = UDim.new(0, 8)

-- // ========== ПЕРЕМЕННЫЕ ДЛЯ FLY GUI V3 ========== //
local flyGuiInstance = nil
local isFlyGuiRunning = false

-- // ========== ФУНКЦИЯ ЗАПУСКА FLY GUI V3 ========== //
local function startFlyGuiV3()
    if isFlyGuiRunning then return end
    isFlyGuiRunning = true
    FlyBtn.Text = "🌀 FLY ON"
    FlyBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
    
    -- Загружаем и выполняем скрипт XNEOFF
    local success, err = pcall(function()
        local script = game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt")
        flyGuiInstance = loadstring(script)()
    end)
    
    if not success then
        isFlyGuiRunning = false
        FlyBtn.Text = "🌀 FLY"
        FlyBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 80)
        print("Ошибка загрузки FlyGuiV3: " .. tostring(err))
    end
end

-- // ========== ФУНКЦИЯ ОСТАНОВКИ FLY GUI V3 ========== //
local function stopFlyGuiV3()
    if not isFlyGuiRunning then return end
    
    -- Удаляем GUI, созданный скриптом XNEOFF
    if flyGuiInstance then
        if flyGuiInstance.Parent then
            flyGuiInstance:Destroy()
        end
        flyGuiInstance = nil
    end
    
    -- Также удаляем любые другие GUI с именем "main"
    local gui = CoreGui:FindFirstChild("main")
    if gui then gui:Destroy() end
    
    isFlyGuiRunning = false
    FlyBtn.Text = "🌀 FLY"
    FlyBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 80)
end

-- // ========== КНОПКА FLY ========== //
FlyBtn.MouseButton1Click:Connect(function()
    if isFlyGuiRunning then
        stopFlyGuiV3()
    else
        startFlyGuiV3()
    end
end)

-- // ========== НОКЛИП ========== //
local noclipActive = false
local function toggleNoclip()
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
end
NoclipBtn.MouseButton1Click:Connect(toggleNoclip)

-- // ========== УПРАВЛЕНИЕ ВЫСОТОЙ (для совместимости) ========== //
-- Эти кнопки теперь управляют высотой в стандартном скрипте, если он запущен отдельно.
-- Если ты хочешь использовать их для FlyGuiV3, они не будут работать,
-- потому что FlyGuiV3 имеет свои собственные кнопки UP/DOWN.
-- Я оставляю их для общего интерфейса, но они не влияют на FlyGuiV3.

HeightPlus.MouseButton1Click:Connect(function()
    print("▲ (Для FlyGuiV3 используйте кнопки в его меню)")
end)

HeightMinus.MouseButton1Click:Connect(function()
    print("▼ (Для FlyGuiV3 используйте кнопки в его меню)")
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
end)

-- // ========== ПАНИКА ========== //
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.P then
        ScreenGui:Destroy()
        stopFlyGuiV3()
        print("☠ ПАНИКА")
    end
end)

print("☠ RUSSIAN YAD v14.0 ЗАГРУЖЕН")
print("📌 КНОПКА FLY ЗАПУСКАЕТ FlyGuiV3 И ОСТАНАВЛИВАЕТ ЕГО")
