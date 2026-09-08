-- // RUSSIAN YAD v7.0 // ДЛЯ DELTA НА ТЕЛЕФОНЕ //
local Player = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")

-- // ========== ОБХОД АНТИЧИТА ========== //
local function bypassAntiCheat()
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
end
pcall(bypassAntiCheat)

-- // ========== СОЗДАНИЕ GUI ========== //
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = CoreGui
ScreenGui.Name = "RussianYadGUI"
ScreenGui.ResetOnSpawn = false

-- // ========== ИКОНКА (60x60 ДЛЯ ПАЛЬЦА) ========== //
local IconButton = Instance.new("ImageButton")
IconButton.Parent = ScreenGui
IconButton.Size = UDim2.new(0, 70, 0, 70)
IconButton.Position = UDim2.new(0.85, -35, 0.85, -35)
IconButton.BackgroundColor3 = Color3.fromRGB(20, 0, 30)
IconButton.BorderColor3 = Color3.fromRGB(255, 0, 80)
IconButton.BorderSizePixel = 3
IconButton.Image = "rbxassetid://123456789"
IconButton.ImageColor3 = Color3.fromRGB(255, 0, 80)
IconButton.ScaleType = Enum.ScaleType.Fit
IconButton.Name = "IconButton"
IconButton.ZIndex = 10

-- ПУЛЬСАЦИЯ
spawn(function()
    while IconButton and IconButton.Parent do
        for i = 0.8, 1.2, 0.05 do
            wait(0.02)
            if IconButton then
                IconButton.Size = UDim2.new(0, 70 * i, 0, 70 * i)
            end
        end
        for i = 1.2, 0.8, -0.05 do
            wait(0.02)
            if IconButton then
                IconButton.Size = UDim2.new(0, 70 * i, 0, 70 * i)
            end
        end
    end
end)

local IconText = Instance.new("TextLabel")
IconText.Parent = IconButton
IconText.Size = UDim2.new(1, 0, 1, 0)
IconText.BackgroundTransparency = 1
IconText.Text = "☠"
IconText.TextColor3 = Color3.fromRGB(255, 0, 80)
IconText.TextScaled = true
IconText.Font = Enum.Font.GothamBold
IconText.ZIndex = 11

-- // ========== ОСНОВНОЕ МЕНЮ (БОЛЬШЕ КНОПКИ) ========== //
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 280, 0, 380)
MainFrame.Position = UDim2.new(0.5, -140, 0.5, -190)
MainFrame.BackgroundColor3 = Color3.fromRGB(8, 0, 15)
MainFrame.BorderSizePixel = 3
MainFrame.BorderColor3 = Color3.fromRGB(255, 0, 60)
MainFrame.BackgroundTransparency = 0.05
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Name = "MainFrame"

-- ЗАГОЛОВОК
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Text = "☠ FLY V7 ☠"
Title.TextScaled = true
Title.TextColor3 = Color3.fromRGB(255, 0, 80)
Title.Font = Enum.Font.GothamBold

-- КНОПКА ЗАКРЫТИЯ
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = MainFrame
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -45, 0, 5)
CloseBtn.Text = "✖"
CloseBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
CloseBtn.BorderColor3 = Color3.fromRGB(255, 0, 0)
CloseBtn.BorderSizePixel = 2
CloseBtn.TextScaled = true
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    IconButton.Visible = true
end)

-- // ========== БОЛЬШИЕ КНОПКИ ДЛЯ ТЕЛЕФОНА ========== //
local yPos = 55
local btnHeight = 45
local btnWidth = 120

-- КНОПКА ВВЕРХ
local UpBtn = Instance.new("TextButton")
UpBtn.Parent = MainFrame
UpBtn.Size = UDim2.new(0, btnWidth, 0, btnHeight)
UpBtn.Position = UDim2.new(0.03, 0, 0, yPos)
UpBtn.Text = "⬆ ВВЕРХ"
UpBtn.BackgroundColor3 = Color3.fromRGB(20, 100, 20)
UpBtn.BorderColor3 = Color3.fromRGB(0, 255, 0)
UpBtn.BorderSizePixel = 2
UpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
UpBtn.Font = Enum.Font.GothamBold
UpBtn.TextScaled = true
UpBtn.Name = "UpBtn"

-- КНОПКА ВНИЗ
local DownBtn = Instance.new("TextButton")
DownBtn.Parent = MainFrame
DownBtn.Size = UDim2.new(0, btnWidth, 0, btnHeight)
DownBtn.Position = UDim2.new(0.53, 0, 0, yPos)
DownBtn.Text = "⬇ ВНИЗ"
DownBtn.BackgroundColor3 = Color3.fromRGB(100, 20, 20)
DownBtn.BorderColor3 = Color3.fromRGB(255, 0, 0)
DownBtn.BorderSizePixel = 2
DownBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DownBtn.Font = Enum.Font.GothamBold
DownBtn.TextScaled = true
DownBtn.Name = "DownBtn"

yPos = yPos + btnHeight + 10

-- КНОПКА ВКЛЮЧИТЬ FLY
local FlyBtn = Instance.new("TextButton")
FlyBtn.Parent = MainFrame
FlyBtn.Size = UDim2.new(0, 250, 0, btnHeight)
FlyBtn.Position = UDim2.new(0.03, 0, 0, yPos)
FlyBtn.Text = "🌀 FLY"
FlyBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 80)
FlyBtn.BorderColor3 = Color3.fromRGB(100, 100, 255)
FlyBtn.BorderSizePixel = 2
FlyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyBtn.Font = Enum.Font.GothamBold
FlyBtn.TextScaled = true
FlyBtn.Name = "FlyBtn"

yPos = yPos + btnHeight + 10

-- КНОПКИ СКОРОСТИ
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Parent = MainFrame
SpeedLabel.Size = UDim2.new(0, 80, 0, btnHeight)
SpeedLabel.Position = UDim2.new(0.35, 0, 0, yPos)
SpeedLabel.Text = "5"
SpeedLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SpeedLabel.BorderColor3 = Color3.fromRGB(255, 255, 0)
SpeedLabel.BorderSizePixel = 2
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
SpeedLabel.Font = Enum.Font.GothamBold
SpeedLabel.TextScaled = true
SpeedLabel.Name = "SpeedLabel"

local SpeedMinus = Instance.new("TextButton")
SpeedMinus.Parent = MainFrame
SpeedMinus.Size = UDim2.new(0, 60, 0, btnHeight)
SpeedMinus.Position = UDim2.new(0.03, 0, 0, yPos)
SpeedMinus.Text = "-"
SpeedMinus.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SpeedMinus.BorderColor3 = Color3.fromRGB(255, 255, 255)
SpeedMinus.BorderSizePixel = 2
SpeedMinus.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedMinus.Font = Enum.Font.GothamBold
SpeedMinus.TextScaled = true
SpeedMinus.Name = "SpeedMinus"

local SpeedPlus = Instance.new("TextButton")
SpeedPlus.Parent = MainFrame
SpeedPlus.Size = UDim2.new(0, 60, 0, btnHeight)
SpeedPlus.Position = UDim2.new(0.74, 0, 0, yPos)
SpeedPlus.Text = "+"
SpeedPlus.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SpeedPlus.BorderColor3 = Color3.fromRGB(255, 255, 255)
SpeedPlus.BorderSizePixel = 2
SpeedPlus.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedPlus.Font = Enum.Font.GothamBold
SpeedPlus.TextScaled = true
SpeedPlus.Name = "SpeedPlus"

yPos = yPos + btnHeight + 10

-- УПРАВЛЕНИЕ ДЖОЙСТИКОМ (ТЕЛЕФОН)
local JoystickLabel = Instance.new("TextLabel")
JoystickLabel.Parent = MainFrame
JoystickLabel.Size = UDim2.new(1, 0, 0, 30)
JoystickLabel.Position = UDim2.new(0, 0, 0, yPos)
JoystickLabel.Text = "👆 ТЯНИ ПАЛЕЦ ПО ЭКРАНУ ДЛЯ ДВИЖЕНИЯ"
JoystickLabel.BackgroundTransparency = 1
JoystickLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
JoystickLabel.Font = Enum.Font.Code
JoystickLabel.TextScaled = true

-- // ========== ПЕРЕМЕННЫЕ ========== //
local flying = false
local flySpeed = 5
local currentSpeed = 5
local flyBV = nil
local flyBG = nil
local isR6 = false
local moveDirection = Vector3.new(0, 0, 0)
local touchPos = nil
local joystickActive = false

-- // ========== ФУНКЦИИ ПОЛЁТА ========== //
local function startFly()
    if not Player.Character then return end
    local chr = Player.Character
    local hum = chr:FindFirstChildWhichIsA("Humanoid")
    if not hum then return end
    
    isR6 = hum.RigType == Enum.HumanoidRigType.R6
    
    local anim = chr:FindFirstChild("Animate")
    if anim then anim.Disabled = true end
    
    local torso = isR6 and chr:FindFirstChild("Torso") or chr:FindFirstChild("UpperTorso")
    if not torso then return end
    
    flyBV = Instance.new("BodyVelocity")
    flyBV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    flyBV.Velocity = Vector3.new(0, 0.1, 0)
    flyBV.Parent = torso
    
    flyBG = Instance.new("BodyGyro")
    flyBG.P = 9e4
    flyBG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    flyBG.CFrame = torso.CFrame
    flyBG.Parent = torso
    
    hum.PlatformStand = true
    flying = true
    FlyBtn.Text = "🌀 FLY ON"
    FlyBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
end

local function stopFly()
    flying = false
    if flyBV then flyBV:Destroy() flyBV = nil end
    if flyBG then flyBG:Destroy() flyBG = nil end
    
    if Player.Character then
        local hum = Player.Character:FindFirstChildWhichIsA("Humanoid")
        if hum then hum.PlatformStand = false end
        local anim = Player.Character:FindFirstChild("Animate")
        if anim then anim.Disabled = false end
    end
    
    FlyBtn.Text = "🌀 FLY"
    FlyBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 80)
end

local function updateFly()
    if not flying or not flyBV or not flyBG then return end
    if not Player.Character then return end
    
    local torso = isR6 and Player.Character:FindFirstChild("Torso") or Player.Character:FindFirstChild("UpperTorso")
    if not torso then return end
    
    local camera = Workspace.CurrentCamera
    if not camera then return end
    
    local speed = flySpeed * 2
    local move = moveDirection * speed
    
    -- Если джойстик не активен, плавно останавливаемся
    if not joystickActive then
        move = move * 0.9
        if move.Magnitude < 0.1 then move = Vector3.new(0, 0, 0) end
    end
    
    flyBV.Velocity = move
    if move.Magnitude > 0.1 then
        flyBG.CFrame = CFrame.new(torso.Position, torso.Position + move)
    end
end

-- // ========== ОБРАБОТЧИКИ КНОПОК ========== //

-- FLY
FlyBtn.MouseButton1Click:Connect(function()
    if flying then stopFly() else startFly() end
end)

-- UP (удержание)
local upHold = false
local upConn = nil

UpBtn.MouseButton1Down:Connect(function()
    upHold = true
    upConn = RunService.Heartbeat:Connect(function()
        if upHold and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            Player.Character.HumanoidRootPart.CFrame = Player.Character.HumanoidRootPart.CFrame * CFrame.new(0, 2, 0)
        end
    end)
end)

UpBtn.MouseButton1Up:Connect(function() upHold = false if upConn then upConn:Disconnect() upConn = nil end end)
UpBtn.MouseLeave:Connect(function() upHold = false if upConn then upConn:Disconnect() upConn = nil end end)

-- DOWN (удержание)
local downHold = false
local downConn = nil

DownBtn.MouseButton1Down:Connect(function()
    downHold = true
    downConn = RunService.Heartbeat:Connect(function()
        if downHold and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            Player.Character.HumanoidRootPart.CFrame = Player.Character.HumanoidRootPart.CFrame * CFrame.new(0, -2, 0)
        end
    end)
end)

DownBtn.MouseButton1Up:Connect(function() downHold = false if downConn then downConn:Disconnect() downConn = nil end end)
DownBtn.MouseLeave:Connect(function() downHold = false if downConn then downConn:Disconnect() downConn = nil end end)

-- СКОРОСТЬ
SpeedPlus.MouseButton1Click:Connect(function()
    flySpeed = math.min(flySpeed + 1, 20)
    SpeedLabel.Text = tostring(flySpeed)
end)

SpeedMinus.MouseButton1Click:Connect(function()
    flySpeed = math.max(flySpeed - 1, 1)
    SpeedLabel.Text = tostring(flySpeed)
end)

-- // ========== ДЖОЙСТИК ДЛЯ ТЕЛЕФОНА ========== //
local function handleTouch(input)
    if not flying then return end
    if input.UserInputType == Enum.UserInputType.Touch then
        joystickActive = true
        local screenSize = UIS:GetMouseLocation()
        local center = Vector2.new(screenSize.X / 2, screenSize.Y / 2)
        local delta = input.Position - center
        local maxDist = 300
        
        local clamped = delta.Unit * math.min(delta.Magnitude, maxDist) / maxDist
        moveDirection = Vector3.new(clamped.X, 0, -clamped.Y)
    end
end

local function handleTouchEnd(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        joystickActive = false
        moveDirection = Vector3.new(0, 0, 0)
    end
end

-- Отслеживаем касания на всём экране (кроме GUI)
UIS.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        -- Проверяем, не нажата ли кнопка GUI
        local guiObject = CoreGui:FindFirstChild("RussianYadGUI")
        if guiObject then
            -- Если коснулись вне кнопок GUI — активируем джойстик
            handleTouch(input)
        end
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        handleTouchEnd(input)
    end
end)

-- Альтернатива: кнопки движения на экране (простое управление)
local moveUpBtn = Instance.new("TextButton")
moveUpBtn.Parent = ScreenGui
moveUpBtn.Size = UDim2.new(0, 60, 0, 60)
moveUpBtn.Position = UDim2.new(0.02, 0, 0.7, 0)
moveUpBtn.Text = "▲"
moveUpBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 80)
moveUpBtn.BorderColor3 = Color3.fromRGB(255, 255, 255)
moveUpBtn.BorderSizePixel = 2
moveUpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
moveUpBtn.Font = Enum.Font.GothamBold
moveUpBtn.TextScaled = true
moveUpBtn.Visible = false
moveUpBtn.Name = "MoveUp"

local moveDownBtn = Instance.new("TextButton")
moveDownBtn.Parent = ScreenGui
moveDownBtn.Size = UDim2.new(0, 60, 0, 60)
moveDownBtn.Position = UDim2.new(0.02, 0, 0.85, 0)
moveDownBtn.Text = "▼"
moveDownBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 80)
moveDownBtn.BorderColor3 = Color3.fromRGB(255, 255, 255)
moveDownBtn.BorderSizePixel = 2
moveDownBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
moveDownBtn.Font = Enum.Font.GothamBold
moveDownBtn.TextScaled = true
moveDownBtn.Visible = false
moveDownBtn.Name = "MoveDown"

local moveLeftBtn = Instance.new("TextButton")
moveLeftBtn.Parent = ScreenGui
moveLeftBtn.Size = UDim2.new(0, 60, 0, 60)
moveLeftBtn.Position = UDim2.new(0.15, 0, 0.775, 0)
moveLeftBtn.Text = "◄"
moveLeftBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 80)
moveLeftBtn.BorderColor3 = Color3.fromRGB(255, 255, 255)
moveLeftBtn.BorderSizePixel = 2
moveLeftBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
moveLeftBtn.Font = Enum.Font.GothamBold
moveLeftBtn.TextScaled = true
moveLeftBtn.Visible = false
moveLeftBtn.Name = "MoveLeft"

local moveRightBtn = Instance.new("TextButton")
moveRightBtn.Parent = ScreenGui
moveRightBtn.Size = UDim2.new(0, 60, 0, 60)
moveRightBtn.Position = UDim2.new(0.25, 0, 0.775, 0)
moveRightBtn.Text = "►"
moveRightBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 80)
moveRightBtn.BorderColor3 = Color3.fromRGB(255, 255, 255)
moveRightBtn.BorderSizePixel = 2
moveRightBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
moveRightBtn.Font = Enum.Font.GothamBold
moveRightBtn.TextScaled = true
moveRightBtn.Visible = false
moveRightBtn.Name = "MoveRight"

-- Обработчики кнопок движения (для тех, у кого нет джойстика)
moveUpBtn.MouseButton1Down:Connect(function() if flying then moveDirection = Vector3.new(0, 0, -1) end end)
moveUpBtn.MouseButton1Up:Connect(function() moveDirection = Vector3.new(0, 0, 0) end)

moveDownBtn.MouseButton1Down:Connect(function() if flying then moveDirection = Vector3.new(0, 0, 1) end end)
moveDownBtn.MouseButton1Up:Connect(function() moveDirection = Vector3.new(0, 0, 0) end)

moveLeftBtn.MouseButton1Down:Connect(function() if flying then moveDirection = Vector3.new(-1, 0, 0) end end)
moveLeftBtn.MouseButton1Up:Connect(function() moveDirection = Vector3.new(0, 0, 0) end)

moveRightBtn.MouseButton1Down:Connect(function() if flying then moveDirection = Vector3.new(1, 0, 0) end end)
moveRightBtn.MouseButton1Up:Connect(function() moveDirection = Vector3.new(0, 0, 0) end)

-- // ========== ПОКАЗЫВАТЬ КНОПКИ ДВИЖЕНИЯ ПРИ ПОЛЁТЕ ========== //
local function showMoveButtons(show)
    moveUpBtn.Visible = show
    moveDownBtn.Visible = show
    moveLeftBtn.Visible = show
    moveRightBtn.Visible = show
end

-- // ========== ОБНОВЛЕНИЕ В ЦИКЛЕ ========== //
RunService.Heartbeat:Connect(function()
    if flying then
        updateFly()
        if not moveUpBtn.Visible then
            showMoveButtons(true)
        end
    else
        if moveUpBtn.Visible then
            showMoveButtons(false)
        end
    end
end)

-- // ========== СБРОС ПРИ СМЕРТИ ========== //
Player.CharacterAdded:Connect(function()
    wait(0.5)
    if flying then
        stopFly()
        showMoveButtons(false)
    end
end)

-- // ========== ОТКРЫТИЕ/ЗАКРЫТИЕ ПО ИКОНКЕ ========== //
local menuOpen = false
IconButton.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    MainFrame.Visible = menuOpen
    IconButton.Visible = not menuOpen
end)

-- // ========== ПЕРЕТАСКИВАНИЕ МЕНЮ ========== //
local dragToggle = nil
local dragStart = nil
local startPos = nil

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        dragToggle = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

MainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        dragToggle = false
    end
end)

UIS.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch and dragToggle then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- // ========== ПАНИКА ========== //
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.P then
        ScreenGui:Destroy()
        print("☠ ПАНИКА")
    end
end)

print("☠ RUSSIAN YAD v7.0 ДЛЯ DELTA ТЕЛЕФОН")
print("📌 НАЖМИ НА ИКОНКУ ☠")
print("👆 ТЯНИ ПАЛЕЦ ПО ЭКРАНУ — ЛЕТИШЬ")
print("⬆⬇ КНОПКИ В МЕНЮ — ВВЕРХ/ВНИЗ")
