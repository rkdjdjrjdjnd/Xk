-- // RUSSIAN YAD v27.1 // АИМ ВКЛЮЧАЕТСЯ 1 РАЗ //
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
IconButton.Size = UDim2.new(0, 60, 0, 60)
IconButton.Position = UDim2.new(0.85, -30, 0.85, -30)
IconButton.BackgroundColor3 = Color3.fromRGB(10, 0, 20)
IconButton.BorderSizePixel = 0
IconButton.Image = "rbxassetid://123456789"
IconButton.ImageColor3 = Color3.fromRGB(255, 50, 100)
IconButton.ScaleType = Enum.ScaleType.Fit
IconButton.ClipsDescendants = true
IconButton.ZIndex = 10

local glassEffect = Instance.new("Frame")
glassEffect.Parent = IconButton
glassEffect.Size = UDim2.new(1, 0, 1, 0)
glassEffect.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
glassEffect.BackgroundTransparency = 0.8
glassEffect.ZIndex = 1

local cornerIcon = Instance.new("UICorner")
cornerIcon.Parent = IconButton
cornerIcon.CornerRadius = UDim.new(1, 0)

local glowIcon = Instance.new("ImageLabel")
glowIcon.Parent = IconButton
glowIcon.Size = UDim2.new(1.6, 0, 1.6, 0)
glowIcon.Position = UDim2.new(-0.3, 0, -0.3, 0)
glowIcon.BackgroundTransparency = 1
glowIcon.Image = "rbxassetid://13158748277"
glowIcon.ImageColor3 = Color3.fromRGB(255, 50, 100)
glowIcon.ImageTransparency = 0.6
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

-- Вращение
spawn(function()
    while IconButton and IconButton.Parent do
        for i = 0, 360, 3 do
            wait(0.01)
            IconButton.Rotation = i
            glowIcon.Rotation = i * 0.5
        end
    end
end)

-- Пульсация
spawn(function()
    while IconButton and IconButton.Parent do
        local tween1 = TweenService:Create(IconButton, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {Size = UDim2.new(0, 65, 0, 65)})
        tween1:Play()
        wait(0.6)
        local tween2 = TweenService:Create(IconButton, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {Size = UDim2.new(0, 55, 0, 55)})
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
        local newX = math.clamp(iconStartPos.X.Offset + delta.X, 0, UIS:GetMouseLocation().X - 60)
        local newY = math.clamp(iconStartPos.Y.Offset + delta.Y, 0, UIS:GetMouseLocation().Y - 60)
        IconButton.Position = UDim2.new(0, newX, 0, newY)
    end
end)

-- // ========== МЕНЮ ========== //
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 280, 0, 260)
MainFrame.Position = UDim2.new(0.5, -140, 0.5, -130)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 0, 25)
MainFrame.BackgroundTransparency = 0.15
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true

local menuGlass = Instance.new("Frame")
menuGlass.Parent = MainFrame
menuGlass.Size = UDim2.new(1, 0, 1, 0)
menuGlass.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
menuGlass.BackgroundTransparency = 0.9
menuGlass.ZIndex = 0

local cornerMenu = Instance.new("UICorner")
cornerMenu.Parent = MainFrame
cornerMenu.CornerRadius = UDim.new(0, 20)

local borderGlow = Instance.new("ImageLabel")
borderGlow.Parent = MainFrame
borderGlow.Size = UDim2.new(1.1, 0, 1.1, 0)
borderGlow.Position = UDim2.new(-0.05, 0, -0.05, 0)
borderGlow.BackgroundTransparency = 1
borderGlow.Image = "rbxassetid://13158748277"
borderGlow.ImageColor3 = Color3.fromRGB(255, 50, 100)
borderGlow.ImageTransparency = 0.5
borderGlow.ZIndex = 2

local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 45)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "☠ RUSSIAN YAD"
Title.TextColor3 = Color3.fromRGB(255, 80, 120)
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true
Title.ZIndex = 3

local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = MainFrame
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -40, 0, 5)
CloseBtn.Text = "✖"
CloseBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
CloseBtn.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
CloseBtn.BackgroundTransparency = 0.5
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

-- // ========== КНОПКИ ========== //
local yPos = 50
local btnH = 32
local btnW = 120

local function createStyledButton(parent, text, x, y, w, h, color)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.Size = UDim2.new(0, w, 0, h)
    btn.Position = UDim2.new(x, 0, 0, y)
    btn.Text = text
    btn.BackgroundColor3 = color or Color3.fromRGB(30, 15, 40)
    btn.BackgroundTransparency = 0.3
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Color3.fromRGB(255, 50, 100)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    local corner = Instance.new("UICorner")
    corner.Parent = btn
    corner.CornerRadius = UDim.new(0, 10)
    return btn
end

local FlyBtn = createStyledButton(MainFrame, "🚀 FLY", 0.04, yPos, btnW, btnH, Color3.fromRGB(30, 30, 80))
local NoclipBtn = createStyledButton(MainFrame, "⬜ НОКЛИП", 0.54, yPos, btnW, btnH, Color3.fromRGB(80, 30, 30))
yPos = yPos + btnH + 6

local EspBtn = createStyledButton(MainFrame, "👁️ ESP", 0.04, yPos, btnW, btnH, Color3.fromRGB(30, 50, 80))
local AimBtn = createStyledButton(MainFrame, "🎯 АИМ", 0.54, yPos, btnW, btnH, Color3.fromRGB(50, 30, 80))
yPos = yPos + btnH + 6

local SpeedBtn = createStyledButton(MainFrame, "⚡ СПИДХАК", 0.04, yPos, btnW, btnH, Color3.fromRGB(50, 50, 30))
local HammerBtn = createStyledButton(MainFrame, "🔨 МОЛОТОК", 0.54, yPos, btnW, btnH, Color3.fromRGB(80, 50, 30))
yPos = yPos + btnH + 6

local OffBtn = createStyledButton(MainFrame, "❌ ВЫКЛ ВСЁ", 0.04, yPos, 250, btnH, Color3.fromRGB(80, 0, 0))

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
local flyGuiInstance = nil
local isFlyRunning = false
local noclipActive = false
local espLoaded = false
local hammerActive = false
local hammerTool = nil
local speedActive = false
local currentSpeed = 16
local speedConnection = nil

-- // ========== АИМБОТ (ВКЛЮЧАЕТСЯ 1 РАЗ И БЛОКИРУЕТСЯ) ========== //
local aimbotLoaded = false
local aimbotThread = nil
local aimButtonBlocked = false

local function loadAimbot()
    if aimbotLoaded or aimButtonBlocked then
        print("☠ АИМБОТ УЖЕ АКТИВЕН И ЗАБЛОКИРОВАН!")
        return
    end
    
    local success, err = pcall(function()
        aimbotThread = RunService.Heartbeat:Connect(function()
            local aimScript = game:HttpGet("https://raw.githubusercontent.com/DanielHubll/DanielHubll/refs/heads/main/Aimbot%20Mobile")
            loadstring(aimScript)()
        end)
    end)
    
    if success then
        aimbotLoaded = true
        aimButtonBlocked = true
        AimBtn.Text = "🎯 АИМ ВКЛ"
        AimBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
        AimBtn.BorderColor3 = Color3.fromRGB(0, 255, 0)
        AimBtn.TextColor3 = Color3.fromRGB(200, 255, 200)
        AimBtn.Active = false
        AimBtn.Selectable = false
        print("☠ АИМБОТ АКТИВИРОВАН (НАВСЕГДА)")
    else
        print("Ошибка загрузки аимбота: " .. tostring(err))
    end
end

-- // ========== СПИДХАК ========== //
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
    frame.BorderColor3 = Color3.fromRGB(255, 50, 100)
    
    local corner = Instance.new("UICorner")
    corner.Parent = frame
    corner.CornerRadius = UDim.new(0, 10)
    
    local title = Instance.new("TextLabel")
    title.Parent = frame
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Text = "⚡ ВВЕДИТЕ СКОРОСТЬ"
    title.TextColor3 = Color3.fromRGB(255, 80, 120)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextScaled = true
    
    local input = Instance.new("TextBox")
    input.Parent = frame
    input.Size = UDim2.new(0, 150, 0, 30)
    input.Position = UDim2.new(0.5, -75, 0, 40)
    input.PlaceholderText = "от 16 до 500"
    input.BackgroundColor3 = Color3.fromRGB(30, 15, 40)
    input.BorderColor3 = Color3.fromRGB(255, 50, 100)
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

-- // ========== МОЛОТОК ========== //
local function createHammer()
    if hammerActive then
        if hammerTool then
            hammerTool:Destroy()
            hammerTool = nil
        end
        hammerActive = false
        HammerBtn.Text = "🔨 МОЛОТОК"
        HammerBtn.BackgroundColor3 = Color3.fromRGB(80, 50, 30)
        print("☠ МОЛОТОК УБРАН")
        return
    end
    
    hammerTool = Instance.new("Tool")
    hammerTool.Name = "🔨 АДМИН-МОЛОТОК"
    hammerTool.RequiresHandle = true
    hammerTool.CanBeDropped = false
    
    local handle = Instance.new("Part")
    handle.Parent = hammerTool
    handle.Size = Vector3.new(0.4, 0.4, 2)
    handle.BrickColor = BrickColor.new("Dark stone grey")
    handle.Material = Enum.Material.SmoothPlastic
    
    local head = Instance.new("Part")
    head.Parent = hammerTool
    head.Size = Vector3.new(2.5, 1.2, 1.5)
    head.Position = Vector3.new(0, 1, 0)
    head.BrickColor = BrickColor.new("Bright red")
    head.Material = Enum.Material.Neon
    
    local glow = Instance.new("Attachment")
    glow.Parent = head
    local beam = Instance.new("Beam")
    beam.Parent = head
    beam.Attachment0 = glow
    beam.Attachment1 = glow
    beam.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0))
    beam.Transparency = NumberSequence.new(0.3)
    
    hammerTool.Activated:Connect(function()
        local char = Player.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        
        local camera = Workspace.CurrentCamera
        if not camera then return end
        
        local ray = Ray.new(camera.CFrame.Position, camera.CFrame.LookVector * 100)
        local hit, pos = Workspace:FindPartOnRay(ray, char)
        
        if hit and hit ~= char and hit.Parent ~= char then
            local parent = hit.Parent
            if parent and parent:IsA("Model") then
                parent:Destroy()
            else
                hit:Destroy()
            end
            
            local explode = Instance.new("Explosion")
            explode.Position = pos
            explode.BlastRadius = 2
            explode.BlastDamage = 0
            explode.Parent = Workspace
            game:GetService("Debris"):AddItem(explode, 0.5)
        end
    end)
    
    hammerTool.SecondaryActivated:Connect(function()
        local char = Player.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        
        local camera = Workspace.CurrentCamera
        if not camera then return end
        
        local ray = Ray.new(camera.CFrame.Position, camera.CFrame.LookVector * 50)
        local hit, pos = Workspace:FindPartOnRay(ray, char)
        
        if pos then
            local block = Instance.new("Part")
            block.Size = Vector3.new(3, 3, 3)
            block.Position = pos + Vector3.new(0, 1.5, 0)
            block.BrickColor = BrickColor.new("Bright red")
            block.Material = Enum.Material.Neon
            block.Anchored = true
            block.Parent = Workspace
            block.Name = "AdminBlock"
            
            local bg = Instance.new("BodyGyro")
            bg.Parent = block
            bg.MaxTorque = Vector3.new(4000, 4000, 4000)
            bg.CFrame = block.CFrame
            
            block.Size = Vector3.new(0.1, 0.1, 0.1)
            TweenService:Create(block, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Size = Vector3.new(3, 3, 3)}):Play()
            game:GetService("Debris"):AddItem(block, 30)
        end
    end)
    
    hammerTool.Parent = Player.Backpack
    hammerActive = true
    HammerBtn.Text = "🔨 МОЛОТОК ON"
    HammerBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
    print("☠ МОЛОТОК СОЗДАН")
end

-- // ========== ОБРАБОТЧИКИ КНОПОК ========== //

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
        EspBtn.BackgroundColor3 = Color3.fromRGB(30, 50, 80)
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

-- АИМ (одноразовый)
AimBtn.MouseButton1Click:Connect(function()
    if not aimbotLoaded and not aimButtonBlocked then
        loadAimbot()
    else
        print("☠ АИМБОТ УЖЕ АКТИВЕН")
    end
end)

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

-- МОЛОТОК
HammerBtn.MouseButton1Click:Connect(createHammer)

-- ВЫКЛЮЧИТЬ ВСЁ
OffBtn.MouseButton1Click:Connect(function()
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
        EspBtn.BackgroundColor3 = Color3.fromRGB(30, 50, 80)
    end
    
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
    end
    
    if hammerActive then
        if hammerTool then
            hammerTool:Destroy()
            hammerTool = nil
        end
        hammerActive = false
        HammerBtn.Text = "🔨 МОЛОТОК"
        HammerBtn.BackgroundColor3 = Color3.fromRGB(80, 50, 30)
    end
    
    print("☠ ВСЁ ВЫКЛЮЧЕНО (КРОМЕ АИМБОТА)")
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
        if isFlyRunning then
            if flyGuiInstance then flyGuiInstance:Destroy() end
            local gui = CoreGui:FindFirstChild("main")
            if gui then gui:Destroy() end
        end
        if hammerTool then
            hammerTool:Destroy()
            hammerTool = nil
        end
        if speedActive then
            speedActive = false
            if speedConnection then
                speedConnection:Disconnect()
                speedConnection = nil
            end
            if Player.Character and Player.Character:FindFirstChild("Humanoid") then
                Player.Character.Humanoid.WalkSpeed = 16
            end
        end
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

print("☠ RUSSIAN YAD v27.1 ЗАГРУЖЕН")
print("📌 ИКОНКА 60x60 — МОЖНО ТАСКАТЬ")
print("⚡ СПИДХАК С ВВОДОМ СКОРОСТИ")
print("🎯 АИМБОТ ВКЛЮЧАЕТСЯ 1 РАЗ И БЛОКИРУЕТСЯ")
