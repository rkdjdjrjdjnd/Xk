-- // RUSSIAN YAD v29.0 // КРАСИВОЕ МЕНЮ + ПЛАВНАЯ ИКОНКА //
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

-- // ========== КРАСИВАЯ ИКОНКА (ПЛАВНОЕ ПЕРЕТАСКИВАНИЕ) ========== //
local IconButton = Instance.new("ImageButton")
IconButton.Parent = ScreenGui
IconButton.Size = UDim2.new(0, 65, 0, 65)
IconButton.Position = UDim2.new(0.85, -32, 0.85, -32)
IconButton.BackgroundColor3 = Color3.fromRGB(15, 0, 30)
IconButton.BorderSizePixel = 0
IconButton.Image = "rbxassetid://123456789"
IconButton.ImageColor3 = Color3.fromRGB(255, 50, 150)
IconButton.ScaleType = Enum.ScaleType.Fit
IconButton.ClipsDescendants = true
IconButton.ZIndex = 10
IconButton.BackgroundTransparency = 0.2

-- Стекло и свечение
local iconGlow = Instance.new("ImageLabel")
iconGlow.Parent = IconButton
iconGlow.Size = UDim2.new(1.8, 0, 1.8, 0)
iconGlow.Position = UDim2.new(-0.4, 0, -0.4, 0)
iconGlow.BackgroundTransparency = 1
iconGlow.Image = "rbxassetid://13158748277"
iconGlow.ImageColor3 = Color3.fromRGB(255, 50, 150)
iconGlow.ImageTransparency = 0.5
iconGlow.ZIndex = 0
iconGlow.Name = "Glow"

local iconCorner = Instance.new("UICorner")
iconCorner.Parent = IconButton
iconCorner.CornerRadius = UDim.new(1, 0)

local IconText = Instance.new("TextLabel")
IconText.Parent = IconButton
IconText.Size = UDim2.new(1, 0, 1, 0)
IconText.BackgroundTransparency = 1
IconText.Text = "☠"
IconText.TextColor3 = Color3.fromRGB(255, 255, 255)
IconText.TextScaled = true
IconText.Font = Enum.Font.GothamBold
IconText.ZIndex = 11

-- Вращение иконки
spawn(function()
    while IconButton and IconButton.Parent do
        for i = 0, 360, 2 do
            wait(0.01)
            IconButton.Rotation = i
            iconGlow.Rotation = i * 0.5
        end
    end
end)

-- Пульсация размера
spawn(function()
    while IconButton and IconButton.Parent do
        local tween1 = TweenService:Create(IconButton, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {Size = UDim2.new(0, 70, 0, 70)})
        tween1:Play()
        wait(0.8)
        local tween2 = TweenService:Create(IconButton, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {Size = UDim2.new(0, 60, 0, 60)})
        tween2:Play()
        wait(0.8)
    end
end)

-- // ========== ПЛАВНОЕ ПЕРЕТАСКИВАНИЕ ИКОНКИ ========== //
local iconDragToggle = false
local iconDragStart = nil
local iconStartPos = nil
local iconDragConnection = nil

IconButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        iconDragToggle = true
        iconDragStart = input.Position
        iconStartPos = IconButton.Position
        if iconDragConnection then iconDragConnection:Disconnect() end
        iconDragConnection = RunService.Heartbeat:Connect(function()
            if iconDragToggle then
                local mousePos = UIS:GetMouseLocation()
                local delta = mousePos - iconDragStart
                local newX = math.clamp(iconStartPos.X.Offset + delta.X, 0, UIS:GetMouseLocation().X - 65)
                local newY = math.clamp(iconStartPos.Y.Offset + delta.Y, 0, UIS:GetMouseLocation().Y - 65)
                IconButton.Position = UDim2.new(0, newX, 0, newY)
            end
        end)
    end
end)

IconButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        iconDragToggle = false
        if iconDragConnection then
            iconDragConnection:Disconnect()
            iconDragConnection = nil
        end
    end
end)

-- // ========== КРАСИВОЕ МЕНЮ (СТИЛЬ КИБЕРПАНК) ========== //
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 320, 0, 280)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -140)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 0, 25)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.ZIndex = 5

-- Анимированный фон (градиент)
local bgGradient = Instance.new("UIGradient")
bgGradient.Parent = MainFrame
bgGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 0, 40)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(10, 0, 60)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 0, 40))
})
bgGradient.Rotation = 45

-- Движущийся градиент
spawn(function()
    while MainFrame and MainFrame.Parent do
        for i = 0, 360, 1 do
            wait(0.02)
            bgGradient.Rotation = i
        end
    end
end)

local cornerMenu = Instance.new("UICorner")
cornerMenu.Parent = MainFrame
cornerMenu.CornerRadius = UDim.new(0, 25)

-- Неоновая рамка с анимацией
local borderGlow = Instance.new("ImageLabel")
borderGlow.Parent = MainFrame
borderGlow.Size = UDim2.new(1.1, 0, 1.1, 0)
borderGlow.Position = UDim2.new(-0.05, 0, -0.05, 0)
borderGlow.BackgroundTransparency = 1
borderGlow.Image = "rbxassetid://13158748277"
borderGlow.ImageColor3 = Color3.fromRGB(255, 50, 150)
borderGlow.ImageTransparency = 0.4
borderGlow.ZIndex = 0
borderGlow.Name = "BorderGlow"

-- Анимация свечения рамки
spawn(function()
    while borderGlow and borderGlow.Parent do
        for i = 0.3, 0.7, 0.02 do
            wait(0.02)
            borderGlow.ImageTransparency = i
        end
        for i = 0.7, 0.3, -0.02 do
            wait(0.02)
            borderGlow.ImageTransparency = i
        end
    end
end)

-- Заголовок с градиентом
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "☠ RUSSIAN YAD"
Title.TextColor3 = Color3.fromRGB(255, 80, 150)
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true
Title.ZIndex = 3

-- Эффект свечения заголовка
local titleGlow = Instance.new("ImageLabel")
titleGlow.Parent = Title
titleGlow.Size = UDim2.new(1, 0, 1, 0)
titleGlow.Position = UDim2.new(0, 0, 0, 0)
titleGlow.BackgroundTransparency = 1
titleGlow.Image = "rbxassetid://13158748277"
titleGlow.ImageColor3 = Color3.fromRGB(255, 50, 150)
titleGlow.ImageTransparency = 0.8
titleGlow.ZIndex = 0

-- Крестик закрытия
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = MainFrame
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -40, 0, 8)
CloseBtn.Text = "✖"
CloseBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
CloseBtn.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
CloseBtn.BackgroundTransparency = 0.4
CloseBtn.BorderSizePixel = 0
CloseBtn.TextScaled = true
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.ZIndex = 3
local cornerClose = Instance.new("UICorner")
cornerClose.Parent = CloseBtn
cornerClose.CornerRadius = UDim.new(0, 10)
CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    IconButton.Visible = true
end)

-- // ========== КНОПКИ С АНИМАЦИЕЙ ========== //
local function createStyledButton(parent, text, x, y, w, h, color)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.Size = UDim2.new(0, w, 0, h)
    btn.Position = UDim2.new(x, 0, 0, y)
    btn.Text = text
    btn.BackgroundColor3 = color or Color3.fromRGB(30, 15, 50)
    btn.BackgroundTransparency = 0.3
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Color3.fromRGB(255, 50, 150)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    btn.ZIndex = 3
    
    local corner = Instance.new("UICorner")
    corner.Parent = btn
    corner.CornerRadius = UDim.new(0, 12)
    
    -- Эффект свечения при наведении
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.1}):Play()
        TweenService:Create(btn, TweenInfo.new(0.2), {BorderSizePixel = 2}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.3}):Play()
        TweenService:Create(btn, TweenInfo.new(0.2), {BorderSizePixel = 1}):Play()
    end)
    
    -- Анимация нажатия
    btn.MouseButton1Down:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.1), {Size = UDim2.new(0, w * 0.95, 0, h * 0.95)}):Play()
    end)
    btn.MouseButton1Up:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.1), {Size = UDim2.new(0, w, 0, h)}):Play()
    end)
    
    return btn
end

local yPos = 55
local btnH = 34
local btnW = 135

local FlyBtn = createStyledButton(MainFrame, "🚀 FLY", 0.035, yPos, btnW, btnH, Color3.fromRGB(30, 30, 80))
local NoclipBtn = createStyledButton(MainFrame, "⬜ НОКЛИП", 0.535, yPos, btnW, btnH, Color3.fromRGB(80, 30, 30))
yPos = yPos + btnH + 8

local KillallBtn = createStyledButton(MainFrame, "💀 KILLALL", 0.035, yPos, btnW, btnH, Color3.fromRGB(80, 0, 0))
local SpeedBtn = createStyledButton(MainFrame, "⚡ СПИДХАК", 0.535, yPos, btnW, btnH, Color3.fromRGB(50, 50, 30))

-- // ========== ПЕРЕТАСКИВАНИЕ МЕНЮ ========== //
local menuDragToggle = false
local menuDragStart = nil
local menuStartPos = nil
local menuDragConnection = nil

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        menuDragToggle = true
        menuDragStart = input.Position
        menuStartPos = MainFrame.Position
        if menuDragConnection then menuDragConnection:Disconnect() end
        menuDragConnection = RunService.Heartbeat:Connect(function()
            if menuDragToggle then
                local delta = UIS:GetMouseLocation() - menuDragStart
                MainFrame.Position = UDim2.new(menuStartPos.X.Scale, menuStartPos.X.Offset + delta.X, menuStartPos.Y.Scale, menuStartPos.Y.Offset + delta.Y)
            end
        end)
    end
end)

MainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        menuDragToggle = false
        if menuDragConnection then
            menuDragConnection:Disconnect()
            menuDragConnection = nil
        end
    end
end)

-- // ========== ФУНКЦИИ ========== //
local flyGuiInstance = nil
local isFlyRunning = false
local noclipActive = false
local speedActive = false
local currentSpeed = 16
local speedConnection = nil

-- KILLALL
local function killAll()
    local count = 0
    for _, plr in pairs(Player:GetPlayers()) do
        if plr ~= Player and plr.Character and plr.Character:FindFirstChild("Humanoid") then
            plr.Character.Humanoid.Health = 0
            count = count + 1
        end
    end
    if count > 0 then
        print("☠ УБИТО ИГРОКОВ: " .. count)
    else
        print("☠ НЕТ ВРАГОВ")
    end
end

-- СПИДХАК
local function setupSpeedHack()
    local inputGui = Instance.new("ScreenGui")
    inputGui.Parent = CoreGui
    inputGui.Name = "SpeedInput"
    
    local frame = Instance.new("Frame")
    frame.Parent = inputGui
    frame.Size = UDim2.new(0, 250, 0, 120)
    frame.Position = UDim2.new(0.5, -125, 0.5, -60)
    frame.BackgroundColor3 = Color3.fromRGB(10, 0, 20)
    frame.BorderSizePixel = 2
    frame.BorderColor3 = Color3.fromRGB(255, 50, 150)
    
    local corner = Instance.new("UICorner")
    corner.Parent = frame
    corner.CornerRadius = UDim.new(0, 10)
    
    local title = Instance.new("TextLabel")
    title.Parent = frame
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Text = "⚡ ВВЕДИТЕ СКОРОСТЬ"
    title.TextColor3 = Color3.fromRGB(255, 80, 150)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextScaled = true
    
    local input = Instance.new("TextBox")
    input.Parent = frame
    input.Size = UDim2.new(0, 150, 0, 30)
    input.Position = UDim2.new(0.5, -75, 0, 40)
    input.PlaceholderText = "от 16 до 500"
    input.BackgroundColor3 = Color3.fromRGB(30, 15, 40)
    input.BorderColor3 = Color3.fromRGB(255, 50, 150)
    input.TextColor3 = Color3.fromRGB(255, 255, 255)
    input.Font = Enum.Font.GothamBold
    input.TextScaled = true
    local cornerInput = Instance.new("UICorner")
    cornerInput.Parent = input
    cornerInput.CornerRadius = UDim.new(0, 8)
    
    local applyBtn = Instance.new("TextButton")
    applyBtn.Parent = frame
    applyBtn.Size = UDim2.new(0, 100, 0, 30)
    applyBtn.Position = UDim2.new(0.5, -50, 0, 80)
    applyBtn.Text = "ПРИМЕНИТЬ"
    applyBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
    applyBtn.BorderSizePixel = 0
    applyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    applyBtn.Font = Enum.Font.GothamBold
    applyBtn.TextScaled = true
    local cornerApply = Instance.new("UICorner")
    cornerApply.Parent = applyBtn
    cornerApply.CornerRadius = UDim.new(0, 8)
    
    applyBtn.MouseButton1Click:Connect(function()
        local speed = tonumber(input.Text)
        if speed and speed >= 16 and speed <= 500 then
            currentSpeed = speed
            SpeedBtn.Text = "⚡ СПИД: " .. tostring(speed)
            SpeedBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
            speedActive = true
            print("☠ СКОРОСТЬ УСТАНОВЛЕНА: " .. tostring(speed))
            
            if speedConnection then speedConnection:Disconnect() end
            speedConnection = RunService.Heartbeat:Connect(function()
                if speedActive and Player.Character and Player.Character:FindFirstChild("Humanoid") then
                    Player.Character.Humanoid.WalkSpeed = currentSpeed
                end
            end)
            inputGui:Destroy()
        else
            input.Text = "ОШИБКА! ВВЕДИ ЧИСЛО (16-500)"
            wait(1)
            input.Text = ""
        end
    end)
end

-- // ========== ОБРАБОТЧИКИ ========== //

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

-- KILLALL
KillallBtn.MouseButton1Click:Connect(killAll)

-- СПИДХАК
SpeedBtn.MouseButton1Click:Connect(function()
    if speedActive then
        speedActive = false
        if speedConnection then
            speedConnection:Disconnect()
            speedConnection = nil
        end
        if Player.Character and Player.Character:FindFirstChild("Humanoid") then
            Player.Character.Humanoid.WalkSpeed = 16
        end
        SpeedBtn.Text = "⚡ СПИДХАК"
        SpeedBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 30)
        print("☠ СПИДХАК ВЫКЛЮЧЕН")
    else
        setupSpeedHack()
    end
end)

-- // ========== ОТКРЫТИЕ/ЗАКРЫТИЕ МЕНЮ ========== //
local menuOpen = false
IconButton.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    MainFrame.Visible = menuOpen
    IconButton.Visible = not menuOpen
    if menuOpen then
        MainFrame.BackgroundTransparency = 0.1
    end
end)

print("☠ RUSSIAN YAD v29.0 ЗАГРУЖЕН")
print("📌 КРАСИВОЕ МЕНЮ С АНИМАЦИЯМИ")
print("📌 ПЛАВНОЕ ПЕРЕТАСКИВАНИЕ ИКОНКИ")
