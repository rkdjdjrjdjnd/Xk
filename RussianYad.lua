-- // RUSSIAN YAD v13.0 // С ПЕРЕМЕЩЕНИЕМ ОТ XNEOFF //
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

-- FLY
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

-- // ========== ПЕРЕМЕННЫЕ ========== //
local flying = false
local noclipActive = false
local verticalOffset = 0
local bodyVelocity = nil
local bodyGyro = nil
local ctrl = {f = 0, b = 0, l = 0, r = 0}
local lastctrl = {f = 0, b = 0, l = 0, r = 0}
local speed = 0
local maxspeed = 50
local isR6 = false

-- // ========== НОКЛИП ========== //
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

-- // ========== ФУНКЦИИ ПОЛЁТА (СПИЖЖЕНО У XNEOFF) ========== //
local function startFly()
    local char = Player.Character
    if not char then return end
    local hum = char:FindFirstChildWhichIsA("Humanoid")
    if not hum then return end
    
    isR6 = hum.RigType == Enum.HumanoidRigType.R6
    
    local torso = isR6 and char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
    if not torso then return end
    
    hum.PlatformStand = true
    local anim = char:FindFirstChild("Animate")
    if anim then anim.Disabled = true end
    
    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bodyVelocity.Velocity = Vector3.new(0, 0.1, 0)
    bodyVelocity.Parent = torso
    
    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.P = 9e4
    bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    bodyGyro.CFrame = torso.CFrame
    bodyGyro.Parent = torso
    
    flying = true
    FlyBtn.Text = "🌀 FLY ON"
    FlyBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
end

local function stopFly()
    flying = false
    if bodyVelocity then bodyVelocity:Destroy() bodyVelocity = nil end
    if bodyGyro then bodyGyro:Destroy() bodyGyro = nil end
    
    if Player.Character then
        local hum = Player.Character:FindFirstChildWhichIsA("Humanoid")
        if hum then
            hum.PlatformStand = false
            local anim = Player.Character:FindFirstChild("Animate")
            if anim then anim.Disabled = false end
        end
    end
    
    ctrl = {f = 0, b = 0, l = 0, r = 0}
    lastctrl = {f = 0, b = 0, l = 0, r = 0}
    speed = 0
    
    FlyBtn.Text = "🌀 FLY"
    FlyBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 80)
end

local function updateFly()
    if not flying or not bodyVelocity or not bodyGyro then return end
    local char = Player.Character
    if not char then return end
    local hum = char:FindFirstChildWhichIsA("Humanoid")
    if not hum then return end
    
    local torso = isR6 and char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
    if not torso then return end
    
    local camera = Workspace.CurrentCamera
    if not camera then return end
    
    -- ОБНОВЛЕНИЕ СКОРОСТИ (как в XNEOFF)
    if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
        speed = speed + 0.5 + (speed / maxspeed)
        if speed > maxspeed then speed = maxspeed end
    elseif speed ~= 0 then
        speed = speed - 1
        if speed < 0 then speed = 0 end
    end
    
    local moveVector = Vector3.new(0, 0, 0)
    if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
        moveVector = ((camera.CoordinateFrame.LookVector * (ctrl.f + ctrl.b)) + 
                     ((camera.CoordinateFrame * CFrame.new(ctrl.l + ctrl.r, (ctrl.f + ctrl.b) * 0.2, 0).p) - 
                     camera.CoordinateFrame.p)) * speed
        lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
    elseif speed ~= 0 then
        moveVector = ((camera.CoordinateFrame.LookVector * (lastctrl.f + lastctrl.b)) + 
                     ((camera.CoordinateFrame * CFrame.new(lastctrl.l + lastctrl.r, (lastctrl.f + lastctrl.b) * 0.2, 0).p) - 
                     camera.CoordinateFrame.p)) * speed
    end
    
    -- ВЕРТИКАЛЬ
    local vertical = Vector3.new(0, verticalOffset, 0)
    moveVector = moveVector + vertical
    
    bodyVelocity.Velocity = moveVector
    if moveVector.Magnitude > 0.1 then
        bodyGyro.CFrame = camera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f + ctrl.b) * 50 * speed / maxspeed), 0, 0)
    end
end

FlyBtn.MouseButton1Click:Connect(function()
    if flying then stopFly() else startFly() end
end)

-- // ========== УПРАВЛЕНИЕ (WASD / СТРЕЛКИ) ========== //
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.W or input.KeyCode == Enum.KeyCode.Up then
        ctrl.f = 1
    elseif input.KeyCode == Enum.KeyCode.S or input.KeyCode == Enum.KeyCode.Down then
        ctrl.b = -1
    elseif input.KeyCode == Enum.KeyCode.A or input.KeyCode == Enum.KeyCode.Left then
        ctrl.l = -1
    elseif input.KeyCode == Enum.KeyCode.D or input.KeyCode == Enum.KeyCode.Right then
        ctrl.r = 1
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.W or input.KeyCode == Enum.KeyCode.Up then
        ctrl.f = 0
    elseif input.KeyCode == Enum.KeyCode.S or input.KeyCode == Enum.KeyCode.Down then
        ctrl.b = 0
    elseif input.KeyCode == Enum.KeyCode.A or input.KeyCode == Enum.KeyCode.Left then
        ctrl.l = 0
    elseif input.KeyCode == Enum.KeyCode.D or input.KeyCode == Enum.KeyCode.Right then
        ctrl.r = 0
    end
end)

-- // ========== УПРАВЛЕНИЕ ВЫСОТОЙ ========== //
HeightPlus.MouseButton1Click:Connect(function()
    verticalOffset = math.min(verticalOffset + 2, 20)
    HeightLabel.Text = "ВЫСОТА " .. tostring(verticalOffset)
end)

HeightMinus.MouseButton1Click:Connect(function()
    verticalOffset = math.max(verticalOffset - 2, -20)
    HeightLabel.Text = "ВЫСОТА " .. tostring(verticalOffset)
end)

-- // ========== ОБНОВЛЕНИЕ ========== //
RunService.Heartbeat:Connect(function()
    if flying then updateFly() end
end)

-- // ========== СБРОС ========== //
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

print("☠ RUSSIAN YAD v13.0 ЗАГРУЖЕН")
print("📌 УПРАВЛЕНИЕ: WASD / СТРЕЛКИ (ДЛЯ ТЕЛЕФОНА — ДЖОЙСТИК)")
print("🌀 FLY — ВКЛЮЧИТЬ/ВЫКЛЮЧИТЬ")
print("▲▼ — ВЫСОТА")
