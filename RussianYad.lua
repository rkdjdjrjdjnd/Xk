-- // RUSSIAN YAD v36.0 // DRONEFRONT // БЕЛОЕ МЕНЮ, ЧЁРНЫЕ КНОПКИ //
local Player = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")

-- // ========== ОБХОД АНТИЧИТА (ПРОСТОЙ) ========== //
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

-- // ========== ИКОНКА 40x40 (БЕЛАЯ) ========== //
local IconButton = Instance.new("ImageButton")
IconButton.Parent = ScreenGui
IconButton.Size = UDim2.new(0, 40, 0, 40)
IconButton.Position = UDim2.new(0.85, -20, 0.85, -20)
IconButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
IconButton.BorderSizePixel = 1
IconButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
IconButton.Image = "rbxassetid://123456789"
IconButton.ImageColor3 = Color3.fromRGB(0, 0, 0)
IconButton.ScaleType = Enum.ScaleType.Fit
IconButton.ClipsDescendants = true
IconButton.ZIndex = 10

local iconCorner = Instance.new("UICorner")
iconCorner.Parent = IconButton
iconCorner.CornerRadius = UDim.new(1, 0)

local IconText = Instance.new("TextLabel")
IconText.Parent = IconButton
IconText.Size = UDim2.new(1, 0, 1, 0)
IconText.BackgroundTransparency = 1
IconText.Text = "☠"
IconText.TextColor3 = Color3.fromRGB(0, 0, 0)
IconText.TextScaled = true
IconText.Font = Enum.Font.GothamBold
IconText.ZIndex = 11

-- Пульсация
spawn(function()
    while IconButton and IconButton.Parent do
        TweenService:Create(IconButton, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 45, 0, 45)}):Play()
        wait(0.5)
        TweenService:Create(IconButton, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 35, 0, 35)}):Play()
        wait(0.5)
    end
end)

-- // ========== ПЕРЕТАСКИВАНИЕ ИКОНКИ (ТЕЛЕФОН) ========== //
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
        local newX = math.clamp(iconStartPos.X.Offset + delta.X, 0, UIS:GetMouseLocation().X - 40)
        local newY = math.clamp(iconStartPos.Y.Offset + delta.Y, 0, UIS:GetMouseLocation().Y - 40)
        IconButton.Position = UDim2.new(0, newX, 0, newY)
    end
end)

-- // ========== БЕЛОЕ МЕНЮ ========== //
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 320, 0, 280)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -140)
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.BackgroundTransparency = 0.05
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.ZIndex = 5

local mainCorner = Instance.new("UICorner")
mainCorner.Parent = MainFrame
mainCorner.CornerRadius = UDim.new(0, 20)

-- Заголовок
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "☠ DRONEFRONT"
Title.TextColor3 = Color3.fromRGB(0, 0, 0)
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true
Title.ZIndex = 3

-- Крестик (ЗАКРЫВАЕТ МЕНЮ)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = MainFrame
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -40, 0, 3)
CloseBtn.Text = "✖"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
CloseBtn.BorderSizePixel = 0
CloseBtn.TextScaled = true
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.ZIndex = 3
local cornerClose = Instance.new("UICorner")
cornerClose.Parent = CloseBtn
cornerClose.CornerRadius = UDim.new(0, 10)

-- ОБРАБОТЧИК ДЛЯ КРЕСТИКА (НАДЁЖНО)
local function closeMenu()
    MainFrame.Visible = false
    IconButton.Visible = true
end
CloseBtn.MouseButton1Click:Connect(closeMenu)
CloseBtn.TouchTap:Connect(closeMenu)
CloseBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        closeMenu()
    end
end)

-- // ========== ЧЁРНЫЕ КНОПКИ С ON/OFF ========== //
local function createButton(text, y, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = MainFrame
    btn.Size = UDim2.new(0, 280, 0, 35)
    btn.Position = UDim2.new(0.05, 0, 0, y)
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    btn.BackgroundTransparency = 0.1
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Color3.fromRGB(0, 0, 0)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    local corner = Instance.new("UICorner")
    corner.Parent = btn
    corner.CornerRadius = UDim.new(0, 10)
    -- Обработчики для ПК и телефона
    btn.MouseButton1Click:Connect(callback)
    btn.TouchTap:Connect(callback)
    btn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            callback()
        end
    end)
    return btn
end

local yPos = 50

-- Кнопка 1: Ускорение дронов
local speedBtn = createButton("🚀 УСКОРЕНИЕ ДРОНОВ", yPos, function()
    toggleDroneSpeed()
end)
yPos = yPos + 42

-- Кнопка 2: ESP дронов
local espBtn = createButton("👁️ ESP ДРОНОВ", yPos, function()
    toggleDroneESP()
end)
yPos = yPos + 42

-- Кнопка 3: Бесконечные дроны
local infBtn = createButton("♾️ БЕСКОНЕЧНЫЕ ДРОНЫ", yPos, function()
    toggleInfiniteDrones()
end)
yPos = yPos + 42

-- Кнопка 4: Сброс
local resetBtn = createButton("🔄 СБРОСИТЬ ВСЁ", yPos, function()
    resetAll()
end)

-- // ========== ПЕРЕМЕННЫЕ ========== //
local droneSpeedActive = false
local droneSpeedConnection = nil
local droneEspActive = false
local droneEspObjects = {}
local infDronesActive = false
local infDronesConnection = nil

-- // ========== ПОИСК ДРОНОВ (РАБОТАЕТ В DRONEFRONT) ========== //
local function findDrones()
    local drones = {}
    for _, obj in ipairs(Workspace:GetDescendants()) do
        -- Ищем модели, у которых есть HumanoidRootPart и имя содержит "drone" или "Drone"
        if obj:IsA("Model") and obj:FindFirstChild("HumanoidRootPart") then
            local name = obj.Name:lower()
            if name:find("drone") or name:find("дрон") then
                table.insert(drones, obj)
            end
        end
    end
    return drones
end

-- // ========== УСКОРЕНИЕ ДРОНОВ ========== //
function toggleDroneSpeed()
    droneSpeedActive = not droneSpeedActive
    if droneSpeedActive then
        if droneSpeedConnection then droneSpeedConnection:Disconnect() end
        droneSpeedConnection = RunService.Heartbeat:Connect(function()
            if not droneSpeedActive then return end
            for _, drone in ipairs(findDrones()) do
                local hrp = drone:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local bv = hrp:FindFirstChildOfClass("BodyVelocity")
                    if bv then
                        bv.Velocity = bv.Velocity * 1.5
                    end
                end
            end
        end)
        speedBtn.Text = "🚀 УСКОРЕНИЕ ON"
        speedBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    else
        if droneSpeedConnection then
            droneSpeedConnection:Disconnect()
            droneSpeedConnection = nil
        end
        speedBtn.Text = "🚀 УСКОРЕНИЕ ДРОНОВ"
        speedBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    end
end

-- // ========== ESP ДРОНОВ ========== //
function toggleDroneESP()
    droneEspActive = not droneEspActive
    if droneEspActive then
        -- Удаляем старые объекты ESP
        for _, obj in ipairs(droneEspObjects) do obj:Destroy() end
        droneEspObjects = {}
        -- Добавляем ESP на всех дронов
        for _, drone in ipairs(findDrones()) do
            local hrp = drone:FindFirstChild("HumanoidRootPart")
            if hrp then
                local hl = Instance.new("Highlight")
                hl.Parent = hrp
                hl.FillColor = Color3.fromRGB(255, 0, 0)
                hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                hl.FillTransparency = 0.5
                table.insert(droneEspObjects, hl)
            end
        end
        espBtn.Text = "👁️ ESP ON"
        espBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    else
        for _, obj in ipairs(droneEspObjects) do obj:Destroy() end
        droneEspObjects = {}
        espBtn.Text = "👁️ ESP ДРОНОВ"
        espBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    end
end

-- // ========== БЕСКОНЕЧНЫЕ ДРОНЫ ========== //
function toggleInfiniteDrones()
    infDronesActive = not infDronesActive
    if infDronesActive then
        if infDronesConnection then infDronesConnection:Disconnect() end
        infDronesConnection = RunService.Heartbeat:Connect(function()
            if not infDronesActive then return end
            for _, drone in ipairs(findDrones()) do
                local hum = drone:FindFirstChildWhichIsA("Humanoid")
                if hum and hum.Health <= 0 then
                    hum.Health = hum.MaxHealth
                end
            end
        end)
        infBtn.Text = "♾️ БЕСКОНЕЧНЫЕ ON"
        infBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    else
        if infDronesConnection then
            infDronesConnection:Disconnect()
            infDronesConnection = nil
        end
        infBtn.Text = "♾️ БЕСКОНЕЧНЫЕ ДРОНЫ"
        infBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    end
end

-- // ========== СБРОС ========== //
function resetAll()
    if droneSpeedActive then toggleDroneSpeed() end
    if droneEspActive then toggleDroneESP() end
    if infDronesActive then toggleInfiniteDrones() end
    print("☠ ВСЁ СБРОШЕНО")
end

-- // ========== ПЕРЕТАСКИВАНИЕ МЕНЮ (ТЕЛЕФОН) ========== //
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

-- // ========== ОТКРЫТИЕ/ЗАКРЫТИЕ МЕНЮ (НАДЁЖНО) ========== //
local function toggleMenu()
    MainFrame.Visible = not MainFrame.Visible
    IconButton.Visible = not MainFrame.Visible
end

IconButton.MouseButton1Click:Connect(toggleMenu)
IconButton.TouchTap:Connect(toggleMenu)
IconButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch and not iconDragToggle then
        toggleMenu()
    end
end)

-- // ========== ПАНИКА ========== //
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.P then
        ScreenGui:Destroy()
        if droneSpeedConnection then droneSpeedConnection:Disconnect() end
        if infDronesConnection then infDronesConnection:Disconnect() end
        for _, obj in ipairs(droneEspObjects) do obj:Destroy() end
        print("☠ ПАНИКА")
    end
end)

-- // ========== ЗАГРУЗКА ========== //
print("☠ RUSSIAN YAD v36.0 ЗАГРУЖЕН")
print("📌 БЕЛОЕ МЕНЮ, ЧЁРНЫЕ КНОПКИ")
print("📌 ON/OFF РАБОТАЕТ")
print("📌 КРЕСТИК ЗАКРЫВАЕТ МЕНЮ")
