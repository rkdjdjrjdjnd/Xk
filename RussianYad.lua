-- // RUSSIAN YAD v19.0 // АИМБОТ С КРУГОМ + ESP //
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

-- // ========== МЕНЮ ========== //
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 260, 0, 200)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -100)
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
local btnH = 35
local btnW = 115

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

yPos = yPos + btnH + 8

-- РЯД 2: ESP
local EspBtn = Instance.new("TextButton")
EspBtn.Parent = MainFrame
EspBtn.Size = UDim2.new(0, 240, 0, btnH)
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

yPos = yPos + btnH + 8

-- РЯД 3: ВЫКЛЮЧИТЬ ВСЁ
local OffBtn = Instance.new("TextButton")
OffBtn.Parent = MainFrame
OffBtn.Size = UDim2.new(0, 240, 0, btnH)
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

-- // ========== ПЕРЕМЕННЫЕ ========== //
local flyGuiInstance = nil
local isFlyRunning = false
local noclipActive = false
local espLoaded = false
local espScript = nil

-- // ========== FOV КРУГ (ВИЗУАЛ) ========== //
local fovCircle = nil
local fovRadius = 200
local fovColor = Color3.fromRGB(0, 255, 0)

local function createFovCircle()
    if fovCircle then fovCircle:Destroy() end
    fovCircle = Drawing.new("Circle")
    fovCircle.Visible = true
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
        local screenSize = Camera.ViewportSize
        fovCircle.Position = Vector2.new(screenSize.X / 2, screenSize.Y / 2)
    end
end

-- // ========== АИМБОТ (ВСЕГДА ВКЛЮЧЁН В ГОЛОВУ) ========== //
local function aimbot(targetHead)
    if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then return end
    local hrp = Player.Character.HumanoidRootPart
    if not targetHead then return end
    hrp.CFrame = CFrame.new(hrp.Position, targetHead.Position)
end

local function getClosestPlayerInFov()
    local closest = nil
    local minDist = math.huge
    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    
    for _, plr in pairs(Player:GetPlayers()) do
        if plr ~= Player and plr.Character and plr.Character:FindFirstChild("Head") then
            local head = plr.Character.Head
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

-- ESP (ЗАГРУЗКА Ultimate Esp v1)
EspBtn.MouseButton1Click:Connect(function()
    if espLoaded then
        -- ВЫКЛЮЧАЕМ: удаляем все хайлайты и билборды
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
        print("☠ ESP ВЫКЛЮЧЕН")
    else
        -- ЗАГРУЖАЕМ скрипт Ultimate Esp v1
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Yahahahau/Ultimate-Esp-v1/refs/heads/main/Ultimate%20esp%20v1.lua"))()
        end)
        if success then
            espLoaded = true
            EspBtn.Text = "👁️ ESP ON"
            EspBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
            print("☠ ESP ЗАГРУЖЕН")
        else
            print("Ошибка загрузки ESP: " .. tostring(err))
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
    
    print("☠ ВСЁ ВЫКЛЮЧЕНО")
end)

-- // ========== ОБНОВЛЕНИЕ FOV КРУГА И АИМБОТА ========== //
createFovCircle()

RunService.RenderStepped:Connect(function()
    updateFovCircle()
    -- АИМБОТ ВСЕГДА ВКЛЮЧЁН (в голову)
    local target = getClosestPlayerInFov()
    if target then
        aimbot(target)
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

print("☠ RUSSIAN YAD v19.0 ЗАГРУЖЕН")
print("📌 АИМБОТ ВСЕГДА ВКЛЮЧЁН (ГОЛОВА) — КРУГ ПО ЦЕНТРУ")
print("👁️ ESP — ЗАГРУЖАЕТ Ultimate Esp v1")
