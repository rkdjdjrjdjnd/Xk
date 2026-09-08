-- // RUSSIAN YAD v8.0 // КОМПАКТНЫЙ + НОКЛИП //
local Player = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")

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
            if IconButton then IconButton.Size = UDim2.new(0, 70 * i, 0, 70 * i) end
        end
        for i = 1.2, 0.8, -0.05 do
            wait(0.02)
            if IconButton then IconButton.Size = UDim2.new(0, 70 * i, 0, 70 * i) end
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

-- // ========== КОМПАКТНОЕ МЕНЮ ========== //
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 200, 0, 180)
MainFrame.Position = UDim2.new(0.5, -100, 0.5, -90)
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
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundTransparency = 1
Title.Text = "☠ FLY"
Title.TextScaled = true
Title.TextColor3 = Color3.fromRGB(255, 0, 80)
Title.Font = Enum.Font.GothamBold

-- КРЕСТИК
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = MainFrame
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 3)
CloseBtn.Text = "✖"
CloseBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
CloseBtn.BorderColor3 = Color3.fromRGB(255, 0, 0)
CloseBtn.BorderSizePixel = 1
CloseBtn.TextScaled = true
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    IconButton.Visible = true
end)

-- // ========== КНОПКИ (ТОЛЬКО 3) ========== //
local yPos = 40
local btnH = 35

-- FLY
local FlyBtn = Instance.new("TextButton")
FlyBtn.Parent = MainFrame
FlyBtn.Size = UDim2.new(0, 170, 0, btnH)
FlyBtn.Position = UDim2.new(0.05, 0, 0, yPos)
FlyBtn.Text = "🌀 FLY"
FlyBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 80)
FlyBtn.BorderColor3 = Color3.fromRGB(100, 100, 255)
FlyBtn.BorderSizePixel = 2
FlyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyBtn.Font = Enum.Font.GothamBold
FlyBtn.TextScaled = true
FlyBtn.Name = "FlyBtn"

yPos = yPos + btnH + 5

-- НОКЛИП
local NoclipBtn = Instance.new("TextButton")
NoclipBtn.Parent = MainFrame
NoclipBtn.Size = UDim2.new(0, 170, 0, btnH)
NoclipBtn.Position = UDim2.new(0.05, 0, 0, yPos)
NoclipBtn.Text = "⬜ НОКЛИП"
NoclipBtn.BackgroundColor3 = Color3.fromRGB(80, 30, 30)
NoclipBtn.BorderColor3 = Color3.fromRGB(255, 100, 100)
NoclipBtn.BorderSizePixel = 2
NoclipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
NoclipBtn.Font = Enum.Font.GothamBold
NoclipBtn.TextScaled = true
NoclipBtn.Name = "NoclipBtn"

yPos = yPos + btnH + 5

-- СКОРОСТЬ
local SpeedFrame = Instance.new("Frame")
SpeedFrame.Parent = MainFrame
SpeedFrame.Size = UDim2.new(0, 170, 0, btnH)
SpeedFrame.Position = UDim2.new(0.05, 0, 0, yPos)
SpeedFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
SpeedFrame.BorderColor3 = Color3.fromRGB(100, 100, 100)
SpeedFrame.BorderSizePixel = 1

local SpeedMinus = Instance.new("TextButton")
SpeedMinus.Parent = SpeedFrame
SpeedMinus.Size = UDim2.new(0, 40, 0, btnH)
SpeedMinus.Position = UDim2.new(0, 0, 0, 0)
SpeedMinus.Text = "-"
SpeedMinus.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SpeedMinus.BorderColor3 = Color3.fromRGB(255, 255, 255)
SpeedMinus.BorderSizePixel = 1
SpeedMinus.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedMinus.Font = Enum.Font.GothamBold
SpeedMinus.TextScaled = true
SpeedMinus.Name = "SpeedMinus"

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Parent = SpeedFrame
SpeedLabel.Size = UDim2.new(0, 50, 0, btnH)
SpeedLabel.Position = UDim2.new(0.35, 0, 0, 0)
SpeedLabel.Text = "5"
SpeedLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SpeedLabel.BorderColor3 = Color3.fromRGB(255, 255, 0)
SpeedLabel.BorderSizePixel = 1
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
SpeedLabel.Font = Enum.Font.GothamBold
SpeedLabel.TextScaled = true
SpeedLabel.Name = "SpeedLabel"

local SpeedPlus = Instance.new("TextButton")
SpeedPlus.Parent = SpeedFrame
SpeedPlus.Size = UDim2.new(0, 40, 0, btnH)
SpeedPlus.Position = UDim2.new(0.76, 0, 0, 0)
SpeedPlus.Text = "+"
SpeedPlus.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SpeedPlus.BorderColor3 = Color3.fromRGB(255, 255, 255)
SpeedPlus.BorderSizePixel = 1
SpeedPlus.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedPlus.Font = Enum.Font.GothamBold
SpeedPlus.TextScaled = true
SpeedPlus.Name = "SpeedPlus"

-- // ========== ПЕРЕМЕННЫЕ ========== //
local flying = false
local flySpeed = 5
local flyBV = nil
local flyBG = nil
local isR6 = false
local moveDirection = Vector3.new(0, 0, 0)
local joystickActive = false
local noclipActive = false

-- // ========== НОКЛИП ========== //
local function toggleNoclip()
    noclipActive = not noclipActive
    NoclipBtn.BackgroundColor3 = noclipActive and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(80, 30, 30)
    NoclipBtn.Text = noclipActive and "⬜ НОКЛИП ON" or "⬜ НОКЛИП"
    
    if noclipActive then
        RunService.Stepped:Connect(function()
            if noclipActive and Player.Character then
                for _, part in ipairs(Player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if Player.Character then
            for _, part in ipairs(Player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end

NoclipBtn.MouseButton1Click:Connect(toggleNoclip)

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
    
    if not joystickActive then
        move = move * 0.9
        if move.Magnitude < 0.1 then move = Vector3.new(0, 0, 0) end
    end
    
    flyBV.Velocity = move
    if move.Magnitude > 0.1 then
        flyBG.CFrame = CFrame.new(torso.Position, torso.Position + move)
    end
end

FlyBtn.MouseButton1Click:Connect(function()
    if flying then stopFly() else startFly() end
end)

-- // ========== СКОРОСТЬ ========== //
SpeedPlus.MouseButton1Click:Connect(function()
    flySpeed = math.min(flySpeed + 1, 20)
    SpeedLabel.Text = tostring(flySpeed)
end)

SpeedMinus.MouseButton1Click:Connect(function()
    flySpeed = math.max(flySpeed - 1, 1)
    SpeedLabel.Text = tostring(flySpeed)
end)

-- // ========== ДЖОЙСТИК ========== //
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

UIS.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        handleTouch(input)
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        handleTouchEnd(input)
    end
end)

-- // ========== ОБНОВЛЕНИЕ ========== //
RunService.Heartbeat:Connect(function()
    if flying then updateFly() end
end)

-- // ========== СБРОС ПРИ СМЕРТИ ========== //
Player.CharacterAdded:Connect(function()
    wait(0.5)
    if flying then stopFly() end
    if noclipActive then toggleNoclip() end
end)

-- // ========== ОТКРЫТИЕ/ЗАКРЫТИЕ ========== //
local menuOpen = false
IconButton.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    MainFrame.Visible = menuOpen
    IconButton.Visible = not menuOpen
end)

-- // ========== ПЕРЕТАСКИВАНИЕ ========== //
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

print("☠ RUSSIAN YAD v8.0 ЗАГРУЖЕН")
print("📌 ИКОНКА ☠ — ОТКРЫТЬ/ЗАКРЫТЬ")
print("🌀 FLY — ВКЛЮЧИТЬ ПОЛЁТ")
print("⬜ НОКЛИП — ПРОХОД СКВОЗЬ СТЕНЫ")
print("👆 ТЯНИ ПАЛЕЦ ПО ЭКРАНУ — ЛЕТИШЬ")
