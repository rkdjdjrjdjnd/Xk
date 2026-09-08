-- // RUSSIAN YAD v17.0 // АИМБОТ С FOV КРУГОМ //
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
MainFrame.Size = UDim2.new(0, 280, 0, 400)
MainFrame.Position = UDim2.new(0.5, -140, 0.5, -200)
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

-- РЯД 2: АИМБОТ ГОЛОВА + ТЕЛО
local AimHeadBtn = Instance.new("TextButton")
AimHeadBtn.Parent = MainFrame
AimHeadBtn.Size = UDim2.new(0, btnW, 0, btnH)
AimHeadBtn.Position = UDim2.new(0.03, 0, 0, yPos)
AimHeadBtn.Text = "🎯 ГОЛОВА"
AimHeadBtn.BackgroundColor3 = Color3.fromRGB(50, 30, 80)
AimHeadBtn.BorderSizePixel = 0
AimHeadBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AimHeadBtn.Font = Enum.Font.GothamBold
AimHeadBtn.TextScaled = true
local cornerHead = Instance.new("UICorner")
cornerHead.Parent = AimHeadBtn
cornerHead.CornerRadius = UDim.new(0, 8)

local AimBodyBtn = Instance.new("TextButton")
AimBodyBtn.Parent = MainFrame
AimBodyBtn.Size = UDim2.new(0, btnW, 0, btnH)
AimBodyBtn.Position = UDim2.new(0.53, 0, 0, yPos)
AimBodyBtn.Text = "🎯 ТЕЛО"
AimBodyBtn.BackgroundColor3 = Color3.fromRGB(50, 30, 80)
AimBodyBtn.BorderSizePixel = 0
AimBodyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AimBodyBtn.Font = Enum.Font.GothamBold
AimBodyBtn.TextScaled = true
local cornerBody = Instance.new("UICorner")
cornerBody.Parent = AimBodyBtn
cornerBody.CornerRadius = UDim.new(0, 8)

yPos = yPos + btnH + 5

-- РЯД 3: FOV КРУГ + РАДИУС
local FovBtn = Instance.new("TextButton")
FovBtn.Parent = MainFrame
FovBtn.Size = UDim2.new(0, btnW, 0, btnH)
FovBtn.Position = UDim2.new(0.03, 0, 0, yPos)
FovBtn.Text = "⭕ FOV КРУГ"
FovBtn.BackgroundColor3 = Color3.fromRGB(30, 50, 80)
FovBtn.BorderSizePixel = 0
FovBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FovBtn.Font = Enum.Font.GothamBold
FovBtn.TextScaled = true
local cornerFov = Instance.new("UICorner")
cornerFov.Parent = FovBtn
cornerFov.CornerRadius = UDim.new(0, 8)

local RadiusBtn = Instance.new("TextButton")
RadiusBtn.Parent = MainFrame
RadiusBtn.Size = UDim2.new(0, btnW, 0, btnH)
RadiusBtn.Position = UDim2.new(0.53, 0, 0, yPos)
RadiusBtn.Text = "📏 РАДИУС"
RadiusBtn.BackgroundColor3 = Color3.fromRGB(30, 50, 80)
RadiusBtn.BorderSizePixel = 0
RadiusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RadiusBtn.Font = Enum.Font.GothamBold
RadiusBtn.TextScaled = true
local cornerRadius = Instance.new("UICorner")
cornerRadius.Parent = RadiusBtn
cornerRadius.CornerRadius = UDim.new(0, 8)

yPos = yPos + btnH + 5

-- РЯД 4: ESP + ЛИНИИ
local EspBtn = Instance.new("TextButton")
EspBtn.Parent = MainFrame
EspBtn.Size = UDim2.new(0, btnW, 0, btnH)
EspBtn.Position = UDim2.new(0.03, 0, 0, yPos)
EspBtn.Text = "👁️ ESP"
EspBtn.BackgroundColor3 = Color3.fromRGB(30, 50, 80)
EspBtn.BorderSizePixel = 0
EspBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
EspBtn.Font = Enum.Font.GothamBold
EspBtn.TextScaled = true
local cornerEsp = Instance.new("UICorner")
cornerEsp.Parent = EspBtn
cornerEsp.CornerRadius = UDim.new(0, 8)

local LineBtn = Instance.new("TextButton")
LineBtn.Parent = MainFrame
LineBtn.Size = UDim2.new(0, btnW, 0, btnH)
LineBtn.Position = UDim2.new(0.53, 0, 0, yPos)
LineBtn.Text = "📏 ЛИНИИ"
LineBtn.BackgroundColor3 = Color3.fromRGB(30, 50, 80)
LineBtn.BorderSizePixel = 0
LineBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
LineBtn.Font = Enum.Font.GothamBold
LineBtn.TextScaled = true
local cornerLine = Instance.new("UICorner")
cornerLine.Parent = LineBtn
cornerLine.CornerRadius = UDim.new(0, 8)

yPos = yPos + btnH + 5

-- РЯД 5: HP + ИМЕНА
local HealthBtn = Instance.new("TextButton")
HealthBtn.Parent = MainFrame
HealthBtn.Size = UDim2.new(0, btnW, 0, btnH)
HealthBtn.Position = UDim2.new(0.03, 0, 0, yPos)
HealthBtn.Text = "❤️ HP"
HealthBtn.BackgroundColor3 = Color3.fromRGB(80, 30, 30)
HealthBtn.BorderSizePixel = 0
HealthBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
HealthBtn.Font = Enum.Font.GothamBold
HealthBtn.TextScaled = true
local cornerHealth = Instance.new("UICorner")
cornerHealth.Parent = HealthBtn
cornerHealth.CornerRadius = UDim.new(0, 8)

local NameBtn = Instance.new("TextButton")
NameBtn.Parent = MainFrame
NameBtn.Size = UDim2.new(0, btnW, 0, btnH)
NameBtn.Position = UDim2.new(0.53, 0, 0, yPos)
NameBtn.Text = "🏷️ ИМЕНА"
NameBtn.BackgroundColor3 = Color3.fromRGB(80, 30, 30)
NameBtn.BorderSizePixel = 0
NameBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
NameBtn.Font = Enum.Font.GothamBold
NameBtn.TextScaled = true
local cornerName = Instance.new("UICorner")
cornerName.Parent = NameBtn
cornerName.CornerRadius = UDim.new(0, 8)

yPos = yPos + btnH + 5

-- РЯД 6: ВЫКЛЮЧИТЬ ВСЁ
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

-- // ========== FOV КРУГ (ВИЗУАЛ) ========== //
local fovCircle = nil
local fovRadius = 200
local fovColor = Color3.fromRGB(0, 255, 0)
local fovActive = false
local fovVisible = false

local function createFovCircle()
    if fovCircle then fovCircle:Destroy() end
    fovCircle = Drawing.new("Circle")
    fovCircle.Visible = fovVisible
    fovCircle.Radius = fovRadius
    fovCircle.Color = fovColor
    fovCircle.Thickness = 2
    fovCircle.Filled = false
    fovCircle.NumSides = 64
    fovCircle.Transparency = 0.7
end

local function updateFovCircle()
    if fovCircle then
        fovCircle.Position = UIS:GetMouseLocation()
        fovCircle.Radius = fovRadius
        fovCircle.Color = fovColor
        fovCircle.Visible = fovVisible
    end
end

-- // ========== ПЕРЕМЕННЫЕ ========== //
local flyGuiInstance = nil
local isFlyRunning = false
local noclipActive = false
local espActive = false
local lineActive = false
local healthActive = false
local nameActive = false
local aimHeadActive = false
local aimBodyActive = false
local espObjects = {}
local lineObjects = {}
local healthObjects = {}
local nameObjects = {}

-- // ========== ФУНКЦИЯ ОЧИСТКИ ESP ========== //
local function clearEsp()
    for _, obj in ipairs(espObjects) do
        if obj and obj.Parent then obj:Destroy() end
    end
    espObjects = {}
    for _, obj in ipairs(lineObjects) do
        if obj and obj.Parent then obj:Destroy() end
    end
    lineObjects = {}
    for _, obj in ipairs(healthObjects) do
        if obj and obj.Parent then obj:Destroy() end
    end
    healthObjects = {}
    for _, obj in ipairs(nameObjects) do
        if obj and obj.Parent then obj:Destroy() end
    end
    nameObjects = {}
end

-- // ========== ФУНКЦИЯ ОБНОВЛЕНИЯ ESP ========== //
local function updateEsp()
    clearEsp()
    if not espActive and not lineActive and not healthActive and not nameActive then return end
    
    for _, plr in pairs(Player:GetPlayers()) do
        if plr ~= Player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local char = plr.Character
            local hrp = char.HumanoidRootPart
            local hum = char:FindFirstChildWhichIsA("Humanoid")
            if not hum then continue end
            
            if espActive then
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        local hl = Instance.new("Highlight")
                        hl.Parent = part
                        hl.FillColor = Color3.fromRGB(255, 0, 0)
                        hl.OutlineColor = Color3.fromRGB(255, 0, 0)
                        hl.FillTransparency = 0.5
                        table.insert(espObjects, hl)
                    end
                end
            end
            
            if lineActive and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                local line = Instance.new("Part")
                line.Size = Vector3.new(0.1, 0.1, (hrp.Position - Player.Character.HumanoidRootPart.Position).Magnitude)
                line.CFrame = CFrame.lookAt(Player.Character.HumanoidRootPart.Position, hrp.Position) * CFrame.new(0, 0, -line.Size.Z/2)
                line.Anchored = true
                line.CanCollide = false
                line.BrickColor = BrickColor.new("Bright red")
                line.Material = Enum.Material.Neon
                line.Parent = Workspace
                table.insert(lineObjects, line)
            end
            
            if healthActive then
                local bill = Instance.new("BillboardGui")
                bill.Parent = hrp
                bill.Size = UDim2.new(0, 100, 0, 30)
                bill.StudsOffset = Vector3.new(0, 3, 0)
                local label = Instance.new("TextLabel")
                label.Parent = bill
                label.Size = UDim2.new(1, 0, 1, 0)
                label.Text = "❤️ " .. math.floor(hum.Health) .. "/" .. math.floor(hum.MaxHealth)
                label.TextColor3 = Color3.fromRGB(255, 0, 0)
                label.BackgroundTransparency = 1
                label.Font = Enum.Font.GothamBold
                label.TextScaled = true
                table.insert(healthObjects, bill)
            end
            
            if nameActive then
                local bill = Instance.new("BillboardGui")
                bill.Parent = hrp
                bill.Size = UDim2.new(0, 150, 0, 30)
                bill.StudsOffset = Vector3.new(0, 4.5, 0)
                local label = Instance.new("TextLabel")
                label.Parent = bill
                label.Size = UDim2.new(1, 0, 1, 0)
                label.Text = plr.Name
                label.TextColor3 = Color3.fromRGB(0, 255, 0)
                label.BackgroundTransparency = 1
                label.Font = Enum.Font.GothamBold
                label.TextScaled = true
                table.insert(nameObjects, bill)
            end
        end
    end
end

-- // ========== АИМБОТ (С УЧЁТОМ FOV) ========== //
local function aimbot(targetPart)
    if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then return end
    local hrp = Player.Character.HumanoidRootPart
    if not targetPart then return end
    hrp.CFrame = CFrame.new(hrp.Position, targetPart.Position)
end

local function getClosestPlayerInFov(part)
    if not fovVisible then
        -- Если круг выключен, ищем по всей карте
        local closest = nil
        local minDist = math.huge
        for _, plr in pairs(Player:GetPlayers()) do
            if plr ~= Player and plr.Character and plr.Character:FindFirstChild(part) then
                local pos = plr.Character[part].Position
                local dist = (pos - Player.Character.HumanoidRootPart.Position).Magnitude
                if dist < minDist then
                    minDist = dist
                    closest = plr.Character[part]
                end
            end
        end
        return closest
    else
        -- Ищем только в пределах круга FOV
        local closest = nil
        local minDist = math.huge
        local mousePos = UIS:GetMouseLocation()
        
        for _, plr in pairs(Player:GetPlayers()) do
            if plr ~= Player and plr.Character and plr.Character:FindFirstChild(part) then
                local pos = plr.Character[part].Position
                local screenPos, onScreen = Camera:WorldToViewportPoint(pos)
                if onScreen then
                    local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                    if dist < fovRadius and dist < minDist then
                        minDist = dist
                        closest = plr.Character[part]
                    end
                end
            end
        end
        return closest
    end
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

-- АИМБОТ ГОЛОВА
AimHeadBtn.MouseButton1Click:Connect(function()
    aimHeadActive = not aimHeadActive
    AimHeadBtn.BackgroundColor3 = aimHeadActive and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(50, 30, 80)
    AimHeadBtn.Text = aimHeadActive and "🎯 ГОЛОВА ON" or "🎯 ГОЛОВА"
    if aimHeadActive then
        RunService.Heartbeat:Connect(function()
            if aimHeadActive then
                local target = getClosestPlayerInFov("Head")
                if target then aimbot(target) end
            end
        end)
    end
end)

-- АИМБОТ ТЕЛО
AimBodyBtn.MouseButton1Click:Connect(function()
    aimBodyActive = not aimBodyActive
    AimBodyBtn.BackgroundColor3 = aimBodyActive and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(50, 30, 80)
    AimBodyBtn.Text = aimBodyActive and "🎯 ТЕЛО ON" or "🎯 ТЕЛО"
    if aimBodyActive then
        RunService.Heartbeat:Connect(function()
            if aimBodyActive then
                local target = getClosestPlayerInFov("HumanoidRootPart")
                if target then aimbot(target) end
            end
        end)
    end
end)

-- FOV КРУГ
FovBtn.MouseButton1Click:Connect(function()
    fovVisible = not fovVisible
    FovBtn.BackgroundColor3 = fovVisible and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(30, 50, 80)
    FovBtn.Text = fovVisible and "⭕ FOV ON" or "⭕ FOV КРУГ"
    if fovCircle then
        fovCircle.Visible = fovVisible
    else
        createFovCircle()
    end
end)

-- РАДИУС (циклическое переключение)
local radiusOptions = {100, 150, 200, 250, 300, 350, 400, 500}
local radiusIndex = 3 -- 200 по умолчанию

RadiusBtn.MouseButton1Click:Connect(function()
    radiusIndex = radiusIndex + 1
    if radiusIndex > #radiusOptions then radiusIndex = 1 end
    fovRadius = radiusOptions[radiusIndex]
    RadiusBtn.Text = "📏 РАДИУС " .. tostring(fovRadius)
    if fovCircle then
        fovCircle.Radius = fovRadius
    end
end)

-- ESP
EspBtn.MouseButton1Click:Connect(function()
    espActive = not espActive
    EspBtn.BackgroundColor3 = espActive and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(30, 50, 80)
    EspBtn.Text = espActive and "👁️ ESP ON" or "👁️ ESP"
    updateEsp()
end)

-- ЛИНИИ
LineBtn.MouseButton1Click:Connect(function()
    lineActive = not lineActive
    LineBtn.BackgroundColor3 = lineActive and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(30, 50, 80)
    LineBtn.Text = lineActive and "📏 ЛИНИИ ON" or "📏 ЛИНИИ"
    updateEsp()
end)

-- ЗДОРОВЬЕ
HealthBtn.MouseButton1Click:Connect(function()
    healthActive = not healthActive
    HealthBtn.BackgroundColor3 = healthActive and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(80, 30, 30)
    HealthBtn.Text = healthActive and "❤️ HP ON" or "❤️ HP"
    updateEsp()
end)

-- ИМЕНА
NameBtn.MouseButton1Click:Connect(function()
    nameActive = not nameActive
    NameBtn.BackgroundColor3 = nameActive and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(80, 30, 30)
    NameBtn.Text = nameActive and "🏷️ ИМЕНА ON" or "🏷️ ИМЕНА"
    updateEsp()
end)

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
    
    aimHeadActive = false
    aimBodyActive = false
    AimHeadBtn.BackgroundColor3 = Color3.fromRGB(50, 30, 80)
    AimHeadBtn.Text = "🎯 ГОЛОВА"
    AimBodyBtn.BackgroundColor3 = Color3.fromRGB(50, 30, 80)
    AimBodyBtn.Text = "🎯 ТЕЛО"
    
    fovVisible = false
    FovBtn.BackgroundColor3 = Color3.fromRGB(30, 50, 80)
    FovBtn.Text = "⭕ FOV КРУГ"
    if fovCircle then fovCircle.Visible = false end
    
    espActive = false
    lineActive = false
    healthActive = false
    nameActive = false
    EspBtn.BackgroundColor3 = Color3.fromRGB(30, 50, 80)
    EspBtn.Text = "👁️ ESP"
    LineBtn.BackgroundColor3 = Color3.fromRGB(30, 50, 80)
    LineBtn.Text = "📏 ЛИНИИ"
    HealthBtn.BackgroundColor3 = Color3.fromRGB(80, 30, 30)
    HealthBtn.Text = "❤️ HP"
    NameBtn.BackgroundColor3 = Color3.fromRGB(80, 30, 30)
    NameBtn.Text = "🏷️ ИМЕНА"
    
    clearEsp()
    print("☠ ВСЁ ВЫКЛЮЧЕНО")
end)

-- // ========== ОБНОВЛЕНИЕ FOV КРУГА ========== //
RunService.RenderStepped:Connect(function()
    if fovVisible then
        updateFovCircle()
    end
end)

-- // ========== ПЕРЕТАСКИВАНИЕ МЕНЮ ========== //
local menuDragToggle, menuDragStart, menuStartPos = false
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then        menuDragToggle = true
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
        clearEsp()
        if fovCircle then fovCircle:Destroy() end
        print("☠ ПАНИКА")
    end
end)

print("☠ RUSSIAN YAD v17.0 ЗАГРУЖЕН")
print("📌 FOV КРУГ — НАСТРАИВАЕМЫЙ РАДИУС ДЕЙСТВИЯ АИМБОТА")
