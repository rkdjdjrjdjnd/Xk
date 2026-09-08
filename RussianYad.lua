-- // RUSSIAN YAD v10.0 // УПРАВЛЕНИЕ ЧЕРЕЗ ВИРТУАЛЬНЫЙ ДЖОЙСТИК //
local Player = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")

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
IconButton.BorderSizePixel = 0
IconButton.Image = "rbxassetid://123456789"
IconButton.ImageColor3 = Color3.fromRGB(255, 0, 80)
IconButton.ScaleType = Enum.ScaleType.Fit
IconButton.Name = "IconButton"
IconButton.ZIndex = 10
IconButton.ClipsDescendants = true

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
glowIcon.ImageTransparency = 0.8
glowIcon.ZIndex = 0
glowIcon.Name = "Glow"

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
        local tweenInfo = TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
        local tween = TweenService:Create(IconButton, tweenInfo, {Size = UDim2.new(0, 75, 0, 75)})
        tween:Play()
        wait(0.8)
        local tween2 = TweenService:Create(IconButton, tweenInfo, {Size = UDim2.new(0, 65, 0, 65)})
        tween2:Play()
        wait(0.8)
    end
end)

-- // ========== ПЕРЕТАСКИВАНИЕ ИКОНКИ ========== //
local iconDragToggle = false
local iconDragStart = nil
local iconStartPos = nil

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
        local newX = iconStartPos.X.Offset + delta.X
        local newY = iconStartPos.Y.Offset + delta.Y
        local maxX = UIS:GetMouseLocation().X - 70
        local maxY = UIS:GetMouseLocation().Y - 70
        newX = math.clamp(newX, 0, maxX)
        newY = math.clamp(newY, 0, maxY)
        IconButton.Position = UDim2.new(0, newX, 0, newY)
    end
end)

-- // ========== МЕНЮ ========== //
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 220, 0, 200)
MainFrame.Position = UDim2.new(0.5, -110, 0.5, -100)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 0, 20)
MainFrame.BorderSizePixel = 0
MainFrame.BackgroundTransparency = 0.1
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Name = "MainFrame"
MainFrame.ClipsDescendants = true

local cornerMenu = Instance.new("UICorner")
cornerMenu.Parent = MainFrame
cornerMenu.CornerRadius = UDim.new(0, 15)

local borderGlow = Instance.new("ImageLabel")
borderGlow.Parent = MainFrame
borderGlow.Size = UDim2.new(1.1, 0, 1.1, 0)
borderGlow.Position = UDim2.new(-0.05, 0, -0.05, 0)
borderGlow.BackgroundTransparency = 1
borderGlow.Image = "rbxassetid://13158748277"
borderGlow.ImageColor3 = Color3.fromRGB(255, 0, 80)
borderGlow.ImageTransparency = 0.7
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
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.Text = "✖"
CloseBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
CloseBtn.BorderSizePixel = 0
CloseBtn.TextScaled = true
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.ZIndex = 2
CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    IconButton.Visible = true
end)

-- // ========== КНОПКИ ========== //
local yPos = 45
local btnH = 35

-- FLY
local FlyBtn = Instance.new("TextButton")
FlyBtn.Parent = MainFrame
FlyBtn.Size = UDim2.new(0, 190, 0, btnH)
FlyBtn.Position = UDim2.new(0.05, 0, 0, yPos)
FlyBtn.Text = "🌀 FLY"
FlyBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 80)
FlyBtn.BorderSizePixel = 0
FlyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyBtn.Font = Enum.Font.GothamBold
FlyBtn.TextScaled = true
FlyBtn.Name = "FlyBtn"
local cornerFly = Instance.new("UICorner")
cornerFly.Parent = FlyBtn
cornerFly.CornerRadius = UDim.new(0, 8)

yPos = yPos + btnH + 8

-- НОКЛИП
local NoclipBtn = Instance.new("TextButton")
NoclipBtn.Parent = MainFrame
NoclipBtn.Size = UDim2.new(0, 190, 0, btnH)
NoclipBtn.Position = UDim2.new(0.05, 0, 0, yPos)
NoclipBtn.Text = "⬜ НОКЛИП"
NoclipBtn.BackgroundColor3 = Color3.fromRGB(80, 30, 30)
NoclipBtn.BorderSizePixel = 0
NoclipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
NoclipBtn.Font = Enum.Font.GothamBold
NoclipBtn.TextScaled = true
NoclipBtn.Name = "NoclipBtn"
local cornerNoclip = Instance.new("UICorner")
cornerNoclip.Parent = NoclipBtn
cornerNoclip.CornerRadius = UDim.new(0, 8)

yPos = yPos + btnH + 8

-- СКОРОСТЬ
local SpeedFrame = Instance.new("Frame")
SpeedFrame.Parent = MainFrame
SpeedFrame.Size = UDim2.new(0, 190, 0, btnH)
SpeedFrame.Position = UDim2.new(0.05, 0, 0, yPos)
SpeedFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
SpeedFrame.BorderSizePixel = 0
local cornerSpeed = Instance.new("UICorner")
cornerSpeed.Parent = SpeedFrame
cornerSpeed.CornerRadius = UDim.new(0, 8)

local SpeedMinus = Instance.new("TextButton")
SpeedMinus.Parent = SpeedFrame
SpeedMinus.Size = UDim2.new(0, 45, 0, btnH)
SpeedMinus.Position = UDim2.new(0, 0, 0, 0)
SpeedMinus.Text = "-"
SpeedMinus.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SpeedMinus.BorderSizePixel = 0
SpeedMinus.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedMinus.Font = Enum.Font.GothamBold
SpeedMinus.TextScaled = true
SpeedMinus.Name = "SpeedMinus"
local cornerMinus = Instance.new("UICorner")
cornerMinus.Parent = SpeedMinus
cornerMinus.CornerRadius = UDim.new(0, 8)

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Parent = SpeedFrame
SpeedLabel.Size = UDim2.new(0, 60, 0, btnH)
SpeedLabel.Position = UDim2.new(0.34, 0, 0, 0)
SpeedLabel.Text = "5"
SpeedLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SpeedLabel.BorderSizePixel = 0
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
SpeedLabel.Font = Enum.Font.GothamBold
SpeedLabel.TextScaled = true
SpeedLabel.Name = "SpeedLabel"
local cornerLabel = Instance.new("UICorner")
cornerLabel.Parent = SpeedLabel
cornerLabel.CornerRadius = UDim.new(0, 8)

local SpeedPlus = Instance.new("TextButton")
SpeedPlus.Parent = SpeedFrame
SpeedPlus.Size = UDim2.new(0, 45, 0, btnH)
SpeedPlus.Position = UDim2.new(0.76, 0, 0, 0)
SpeedPlus.Text = "+"
SpeedPlus.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SpeedPlus.BorderSizePixel = 0
SpeedPlus.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedPlus.Font = Enum.Font.GothamBold
SpeedPlus.TextScaled = true
SpeedPlus.Name = "SpeedPlus"
local cornerPlus = Instance.new("UICorner")
cornerPlus.Parent = SpeedPlus
cornerPlus.CornerRadius = UDim.new(0, 8)

-- // ========== ПЕРЕТАСКИВАНИЕ МЕНЮ ========== //
local menuDragToggle = false
local menuDragStart = nil
local menuStartPos = nil

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
        MainFrame.Position = UDim2.new(
            menuStartPos.X.Scale,
            menuStartPos.X.Offset + delta.X,
            menuStartPos.Y.Scale,
            menuStartPos.Y.Offset + delta.Y
        )
    end
end)

-- // ========== ПЕРЕМЕННЫЕ ========== //
local flying = false
local flySpeed = 5
local flyBV = nil
local flyBG = nil
local isR6 = false
local noclipActive = false

-- // ========== ДЖОЙСТИК (ВИРТУАЛЬНЫЙ ИЗ РОБЛОКСА) ========== //
-- Получаем направление движения из MoveDirection персонажа
local function getMoveDirection()
    if not Player.Character then return Vector3.new(0, 0, 0) end
    local hum = Player.Character:FindFirstChildWhichIsA("Humanoid")
    if not hum then return Vector3.new(0, 0, 0) end
    return hum.MoveDirection
end

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
    
    -- Получаем направление от джойстика
    local moveDir = getMoveDirection()
    local speed = flySpeed * 2
    
    -- Если джойстик не активен, останавливаемся
    if moveDir.Magnitude < 0.1 then
        flyBV.Velocity = Vector3.new(0, 0, 0)
        return
    end
    
    -- Движение в направлении джойстика
    local move = moveDir * speed
    flyBV.Velocity = move
    
    -- Поворот персонажа в сторону движения
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

-- // ========== ОБНОВЛЕНИЕ В ЦИКЛЕ ========== //
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

-- // ========== ПАНИКА ========== //
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.P then
        ScreenGui:Destroy()
        print("☠ ПАНИКА")
    end
end)

print("☠ RUSSIAN YAD v10.0 ЗАГРУЖЕН")
print("📌 УПРАВЛЕНИЕ ЧЕРЕЗ ВИРТУАЛЬНЫЙ ДЖОЙСТИК (ТОТ, ЧТО В ИГРЕ)")
print("🌀 FLY — ВКЛЮЧИТЬ ПОЛЁТ")
print("⬜ НОКЛИП — ПРОХОД СКВОЗЬ СТЕНЫ")
