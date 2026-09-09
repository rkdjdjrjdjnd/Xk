-- ===================================================================
-- † ROBLOX MASTER v7.0 — АБСОЛЮТНЫЙ ИНЖЕКТОР (ЧАСТЬ 1/2) †
-- ===================================================================

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local Tween = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "ADMenu"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- ========== ЗАГРУЗКА (НА ВЕСЬ ЭКРАН) ==========
local loading = Instance.new("TextLabel")
loading.Size = UDim2.new(1,0,1,0)
loading.BackgroundColor3 = Color3.fromRGB(8,8,10)
loading.TextColor3 = Color3.new(1,1,1)
loading.TextSize = 22
loading.Font = Enum.Font.GothamBold
loading.Text = "LOADING 0%"
loading.ZIndex = 10
loading.Parent = gui

task.spawn(function()
    for i = 0,100,5 do
        loading.Text = "LOADING "..i.."%"
        task.wait(0.15)
    end
    Tween:Create(loading,TweenInfo.new(.4),{
        TextTransparency=1,
        BackgroundTransparency=1
    }):Play()
    task.wait(.4)
    loading:Destroy()
end)

-- ========== ПЛАВАЮЩАЯ ИКОНКА ==========
local icon = Instance.new("TextButton")
icon.Size = UDim2.fromOffset(64,64)
icon.Position = UDim2.new(0,20,.5,-32)
icon.BackgroundColor3 = Color3.fromRGB(8,8,8)
icon.Text = "AD"
icon.TextColor3 = Color3.new(1,1,1)
icon.TextSize = 21
icon.Font = Enum.Font.GothamBold
icon.AutoButtonColor = false
icon.Parent = gui

local c = Instance.new("UICorner",icon)
c.CornerRadius = UDim.new(1,0)
local s = Instance.new("UIStroke",icon)
s.Thickness = 2
s.Color = Color3.fromRGB(255,255,255)

local dot = Instance.new("Frame")
dot.Size = UDim2.fromOffset(10,10)
dot.Position = UDim2.new(1,-13,0,4)
dot.BackgroundColor3 = Color3.fromRGB(255,40,40)
dot.Parent = icon
local dc = Instance.new("UICorner",dot)
dc.CornerRadius = UDim.new(1,0)

-- ========== ГЛАВНОЕ МЕНЮ (только ESP и PLAYER) ==========
local menu = Instance.new("Frame")
menu.Size = UDim2.fromOffset(300,300)
menu.Position = UDim2.new(.5,-150,.5,-150)
menu.BackgroundColor3 = Color3.fromRGB(12,12,16)
menu.Visible = false
menu.Parent = gui
local mc = Instance.new("UICorner",menu)
mc.CornerRadius = UDim.new(0,16)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,-60,0,50)
title.Position = UDim2.fromOffset(15,5)
title.BackgroundTransparency = 1
title.Text = "AD MENU"
title.TextColor3 = Color3.new(1,1,1)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = menu

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(40,40)
close.Position = UDim2.new(1,-48,0,10)
close.BackgroundColor3 = Color3.fromRGB(35,35,40)
close.Text = "X"
close.TextColor3 = Color3.new(1,1,1)
close.TextSize = 18
close.Font = Enum.Font.GothamBold
close.Parent = menu
local cc = Instance.new("UICorner",close)
cc.CornerRadius = UDim.new(0,10)

-- Кнопки главного меню
local mainButtons = {}
local mainTexts = {"ESP", "PLAYER"}
for i,text in ipairs(mainTexts) do
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1,-30,0,70)
    b.Position = UDim2.fromOffset(15,65+(i-1)*80)
    b.BackgroundColor3 = Color3.fromRGB(28,28,35)
    b.Text = text
    b.TextColor3 = Color3.new(1,1,1)
    b.TextSize = 18
    b.Font = Enum.Font.GothamBold
    b.Parent = menu
    local bc = Instance.new("UICorner",b)  
    bc.CornerRadius = UDim.new(0,11)
    mainButtons[i] = b
end

-- ========== ПОДМЕНЮ ESP (полностью, без изменений) ==========
local espMenu = Instance.new("Frame")
espMenu.Size = UDim2.fromOffset(0,0)
espMenu.Position = UDim2.new(.5,-170,.5,-220)
espMenu.BackgroundColor3 = Color3.fromRGB(18,18,24)
espMenu.Visible = false
espMenu.Parent = gui
local espMc = Instance.new("UICorner",espMenu)
espMc.CornerRadius = UDim.new(0,16)

local espTitle = Instance.new("TextLabel")
espTitle.Size = UDim2.new(1,-60,0,50)
espTitle.Position = UDim2.fromOffset(15,5)
espTitle.BackgroundTransparency = 1
espTitle.Text = "ESP SETTINGS"
espTitle.TextColor3 = Color3.new(1,1,1)
espTitle.TextSize = 20
espTitle.Font = Enum.Font.GothamBold
espTitle.TextXAlignment = Enum.TextXAlignment.Left
espTitle.Parent = espMenu

local espBack = Instance.new("TextButton")
espBack.Size = UDim2.fromOffset(40,40)
espBack.Position = UDim2.new(1,-48,0,10)
espBack.BackgroundColor3 = Color3.fromRGB(35,35,40)
espBack.Text = "<"
espBack.TextColor3 = Color3.new(1,1,1)
espBack.TextSize = 24
espBack.Font = Enum.Font.GothamBold
espBack.Parent = espMenu
local espBackCorner = Instance.new("UICorner",espBack)
espBackCorner.CornerRadius = UDim.new(0,10)

-- Настройки ESP
local espSettings = {
    enabled = true,
    boxes = true,
    names = true,
    health = true,
    distance = true,
    tracers = false,
    teamColor = true,
    transparency = 0.5,
    colorSelf = Color3.fromRGB(0,150,255),
    colorEnemy = Color3.fromRGB(255,50,50)
}

-- Функция создания переключателя
local function createSwitch(parent, y, labelText, getter, setter)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1,-30,0,40)
    frame.Position = UDim2.fromOffset(15,y)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.6,0,1,0)
    label.Position = UDim2.new(0,0,0,0)
    label.BackgroundTransparency = 1
    label.Text = labelText
    label.TextColor3 = Color3.new(1,1,1)
    label.TextSize = 16
    label.Font = Enum.Font.GothamSemibold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0,60,0,30)
    btn.Position = UDim2.new(1,-65,0.5,-15)
    btn.BackgroundColor3 = getter() and Color3.fromRGB(0,200,80) or Color3.fromRGB(80,80,80)
    btn.Text = getter() and "ON" or "OFF"
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextSize = 14
    btn.Font = Enum.Font.GothamBold
    btn.AutoButtonColor = false
    btn.Parent = frame
    local btnCorner = Instance.new("UICorner",btn)
    btnCorner.CornerRadius = UDim.new(0,8)

    btn.MouseButton1Click:Connect(function()
        local newVal = not getter()
        setter(newVal)
        btn.BackgroundColor3 = newVal and Color3.fromRGB(0,200,80) or Color3.fromRGB(80,80,80)
        btn.Text = newVal and "ON" or "OFF"
        if labelText == "Enable ESP" then
            espEnabled = newVal
            if not newVal then clearESP() end
        end
    end)
    return frame
end

-- Создаём элементы ESP
local yOffset = 65
local switchEnable = createSwitch(espMenu, yOffset, "Enable ESP", function() return espSettings.enabled end, function(v) espSettings.enabled = v end)
yOffset = yOffset + 50
local switchBoxes = createSwitch(espMenu, yOffset, "Boxes", function() return espSettings.boxes end, function(v) espSettings.boxes = v end)
yOffset = yOffset + 50
local switchNames = createSwitch(espMenu, yOffset, "Names", function() return espSettings.names end, function(v) espSettings.names = v end)
yOffset = yOffset + 50
local switchHealth = createSwitch(espMenu, yOffset, "Health Bar", function() return espSettings.health end, function(v) espSettings.health = v end)
yOffset = yOffset + 50
local switchDistance = createSwitch(espMenu, yOffset, "Distance", function() return espSettings.distance end, function(v) espSettings.distance = v end)
yOffset = yOffset + 50
local switchTracers = createSwitch(espMenu, yOffset, "Tracers", function() return espSettings.tracers end, function(v) espSettings.tracers = v end)
yOffset = yOffset + 50
local switchTeamColor = createSwitch(espMenu, yOffset, "Team Color", function() return espSettings.teamColor end, function(v) espSettings.teamColor = v end)

-- Слайдер прозрачности
local transpFrame = Instance.new("Frame")
transpFrame.Size = UDim2.new(1,-30,0,40)
transpFrame.Position = UDim2.fromOffset(15, yOffset)
transpFrame.BackgroundTransparency = 1
transpFrame.Parent = espMenu

local transpLabel = Instance.new("TextLabel")
transpLabel.Size = UDim2.new(0.6,0,1,0)
transpLabel.Position = UDim2.new(0,0,0,0)
transpLabel.BackgroundTransparency = 1
transpLabel.Text = "Transparency"
transpLabel.TextColor3 = Color3.new(1,1,1)
transpLabel.TextSize = 16
transpLabel.Font = Enum.Font.GothamSemibold
transpLabel.TextXAlignment = Enum.TextXAlignment.Left
transpLabel.Parent = transpFrame

local transpVal = Instance.new("TextLabel")
transpVal.Size = UDim2.new(0,40,0,30)
transpVal.Position = UDim2.new(0.7,0,0.5,-15)
transpVal.BackgroundColor3 = Color3.fromRGB(40,40,50)
transpVal.Text = string.format("%.1f", espSettings.transparency)
transpVal.TextColor3 = Color3.new(1,1,1)
transpVal.TextSize = 14
transpVal.Font = Enum.Font.GothamBold
transpVal.Parent = transpFrame
local transpCorner = Instance.new("UICorner",transpVal)
transpCorner.CornerRadius = UDim.new(0,6)

local decBtn = Instance.new("TextButton")
decBtn.Size = UDim2.fromOffset(30,30)
decBtn.Position = UDim2.new(0.85,0,0.5,-15)
decBtn.BackgroundColor3 = Color3.fromRGB(50,50,60)
decBtn.Text = "-"
decBtn.TextColor3 = Color3.new(1,1,1)
decBtn.TextSize = 20
decBtn.Font = Enum.Font.GothamBold
decBtn.Parent = transpFrame
local decCorner = Instance.new("UICorner",decBtn)
decCorner.CornerRadius = UDim.new(0,8)

local incBtn = Instance.new("TextButton")
incBtn.Size = UDim2.fromOffset(30,30)
incBtn.Position = UDim2.new(0.95,0,0.5,-15)
incBtn.BackgroundColor3 = Color3.fromRGB(50,50,60)
incBtn.Text = "+"
incBtn.TextColor3 = Color3.new(1,1,1)
incBtn.TextSize = 20
incBtn.Font = Enum.Font.GothamBold
incBtn.Parent = transpFrame
local incCorner = Instance.new("UICorner",incBtn)
incCorner.CornerRadius = UDim.new(0,8)

decBtn.MouseButton1Click:Connect(function()
    espSettings.transparency = math.max(0, espSettings.transparency - 0.1)
    transpVal.Text = string.format("%.1f", espSettings.transparency)
end)
incBtn.MouseButton1Click:Connect(function()
    espSettings.transparency = math.min(1, espSettings.transparency + 0.1)
    transpVal.Text = string.format("%.1f", espSettings.transparency)
end)

-- Выбор цветов (упрощённо)
local colorFrame = Instance.new("Frame")
colorFrame.Size = UDim2.new(1,-30,0,40)
colorFrame.Position = UDim2.fromOffset(15, yOffset + 50)
colorFrame.BackgroundTransparency = 1
colorFrame.Parent = espMenu

local colorLabel = Instance.new("TextLabel")
colorLabel.Size = UDim2.new(0.5,0,1,0)
colorLabel.Position = UDim2.new(0,0,0,0)
colorLabel.BackgroundTransparency = 1
colorLabel.Text = "Team Colors"
colorLabel.TextColor3 = Color3.new(1,1,1)
colorLabel.TextSize = 16
colorLabel.Font = Enum.Font.GothamSemibold
colorLabel.TextXAlignment = Enum.TextXAlignment.Left
colorLabel.Parent = colorFrame

local function createColorButton(parent, x, color, label, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.fromOffset(40,30)
    btn.Position = UDim2.new(0, x, 0.5, -15)
    btn.BackgroundColor3 = color
    btn.Text = label
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextSize = 12
    btn.Font = Enum.Font.GothamBold
    btn.AutoButtonColor = false
    btn.Parent = parent
    local corner = Instance.new("UICorner",btn)
    corner.CornerRadius = UDim.new(0,6)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

createColorButton(colorFrame, 180, espSettings.colorSelf, "S", function()
    espSettings.colorSelf = Color3.fromRGB(0,200,255)
end)
createColorButton(colorFrame, 230, espSettings.colorEnemy, "E", function()
    espSettings.colorEnemy = Color3.fromRGB(255,80,80)
end)

-- ========== ЛОГИКА ESP ==========
local espObjects = {}
local espEnabled = true

local function clearESP()
    for _, data in pairs(espObjects) do
        if data.box then data.box:Destroy() end
        if data.name then data.name:Destroy() end
        if data.health then data.health:Destroy() end
        if data.dist then data.dist:Destroy() end
        if data.tracer then data.tracer:Destroy() end
    end
    espObjects = {}
end

local function createESPObjects(targetPlayer)
    if espObjects[targetPlayer] then return end
    local data = {}
    local character = targetPlayer.Character
    if not character or not character.PrimaryPart then return end

    local box = Instance.new("Frame")
    box.Size = UDim2.fromOffset(0,0)
    box.BackgroundTransparency = 0.4
    box.BorderSizePixel = 2
    box.BorderColor3 = Color3.new(1,1,1)
    box.BackgroundColor3 = Color3.new(0,0,0)
    box.Visible = true
    box.Parent = gui

    local name = Instance.new("TextLabel")
    name.Size = UDim2.fromOffset(150,20)
    name.BackgroundTransparency = 1
    name.Text = targetPlayer.Name
    name.TextColor3 = Color3.new(1,1,1)
    name.TextSize = 14
    name.Font = Enum.Font.GothamBold
    name.TextStrokeTransparency = 0.5
    name.Visible = true
    name.Parent = gui

    local health = Instance.new("Frame")
    health.Size = UDim2.fromOffset(0,4)
    health.BackgroundColor3 = Color3.fromRGB(0,255,0)
    health.BorderSizePixel = 0
    health.Visible = true
    health.Parent = gui

    local dist = Instance.new("TextLabel")
    dist.Size = UDim2.fromOffset(80,16)
    dist.BackgroundTransparency = 1
    dist.Text = ""
    dist.TextColor3 = Color3.new(1,1,1)
    dist.TextSize = 12
    dist.Font = Enum.Font.Gotham
    dist.Visible = true
    dist.Parent = gui

    local tracer = Instance.new("Frame")
    tracer.Size = UDim2.fromOffset(0,2)
    tracer.BackgroundColor3 = Color3.fromRGB(255,255,255)
    tracer.BorderSizePixel = 0
    tracer.Visible = true
    tracer.Parent = gui

    data.box = box
    data.name = name
    data.health = health
    data.dist = dist
    data.tracer = tracer
    espObjects[targetPlayer] = data
end

local function updateESP()
    if not espEnabled or not espSettings.enabled then
        clearESP()
        return
    end
    local myChar = player.Character
    if not myChar or not myChar.PrimaryPart then return end
    local myPos = myChar.PrimaryPart.Position

    for _, target in ipairs(Players:GetPlayers()) do
        if target ~= player then
            local char = target.Character
            if char and char.PrimaryPart and char:FindFirstChild("Head") then
                local head = char.Head
                local pos = head.Position
                local screenPos, onScreen = Camera:WorldToViewportPoint(pos)
                if onScreen then
                    if not espObjects[target] then createESPObjects(target) end
                    local data = espObjects[target]
                    if data then
                        local size = 2.5 / (pos - Camera.CFrame.Position).Magnitude * 500
                        local boxSize = math.clamp(size, 20, 150)
                        data.box.Size = UDim2.fromOffset(boxSize, boxSize * 1.5)
                        data.box.Position = UDim2.new(0, screenPos.X - boxSize/2, 0, screenPos.Y - boxSize*0.75)

                        local isEnemy = false
                        if target.Team and player.Team and target.Team ~= player.Team then isEnemy = true end
                        local col = espSettings.teamColor and (isEnemy and espSettings.colorEnemy or espSettings.colorSelf) or Color3.fromRGB(255,255,255)
                        data.box.BorderColor3 = col
                        data.box.BackgroundTransparency = 1 - espSettings.transparency

                        data.name.Position = UDim2.new(0, screenPos.X - 75, 0, screenPos.Y - boxSize*0.75 - 20)
                        data.name.Text = target.Name
                        data.name.TextColor3 = col

                        local hum = char:FindFirstChildOfClass("Humanoid")
                        if hum and hum.Health > 0 then
                            local healthPercent = hum.Health / hum.MaxHealth
                            local healthWidth = boxSize * healthPercent
                            data.health.Size = UDim2.fromOffset(healthWidth, 4)
                            data.health.Position = UDim2.new(0, screenPos.X - boxSize/2, 0, screenPos.Y + boxSize*0.75 - 10)
                            data.health.BackgroundColor3 = Color3.fromRGB(255*(1-healthPercent), 255*healthPercent, 0)
                            data.health.Visible = espSettings.health
                        else
                            data.health.Visible = false
                        end

                        local distVal = (pos - myPos).Magnitude
                        data.dist.Position = UDim2.new(0, screenPos.X - 40, 0, screenPos.Y + boxSize*0.75 + 6)
                        data.dist.Text = string.format("%dm", distVal)
                        data.dist.Visible = espSettings.distance

                        if espSettings.tracers then
                            local centerX = Camera.ViewportSize.X / 2
                            local centerY = Camera.ViewportSize.Y / 2
                            local dx = screenPos.X - centerX
                            local dy = screenPos.Y - centerY
                            local angle = math.atan2(dy, dx)
                            local length = math.sqrt(dx*dx + dy*dy)
                            data.tracer.Size = UDim2.fromOffset(length, 2)
                            data.tracer.Position = UDim2.new(0, centerX, 0, centerY)
                            data.tracer.Rotation = math.deg(angle)
                            data.tracer.BackgroundColor3 = col
                            data.tracer.Visible = true
                        else
                            data.tracer.Visible = false
                        end

                        data.box.Visible = espSettings.boxes
                        data.name.Visible = espSettings.names
                    end
                else
                    if espObjects[target] then
                        local data = espObjects[target]
                        if data.box then data.box:Destroy() end
                        if data.name then data.name:Destroy() end
                        if data.health then data.health:Destroy() end
                        if data.dist then data.dist:Destroy() end
                        if data.tracer then data.tracer:Destroy() end
                        espObjects[target] = nil
                    end
                end
            else
                if espObjects[target] then
                    local data = espObjects[target]
                    if data.box then data.box:Destroy() end
                    if data.name then data.name:Destroy() end
                    if data.health then data.health:Destroy() end
                    if data.dist then data.dist:Destroy() end
                    if data.tracer then data.tracer:Destroy() end
                    espObjects[target] = nil
                end
            end
        end
    end
end

Players.PlayerAdded:Connect(function(p) end)
Players.PlayerRemoving:Connect(function(p)
    if espObjects[p] then
        local data = espObjects[p]
        if data.box then data.box:Destroy() end
        if data.name then data.name:Destroy() end
        if data.health then data.health:Destroy() end
        if data.dist then data.dist:Destroy() end
        if data.tracer then data.tracer:Destroy() end
        espObjects[p] = nil
    end
end)

local espConnection = RunService.RenderStepped:Connect(updateESP)

-- ========== КОНЕЦ ЧАСТИ 1 ==========
print("† ЧАСТЬ 1 ЗАГРУЖЕНА. ПРОДОЛЖАЙТЕ ЧАСТЬ 2 †")
-- ===================================================================
-- † ЧАСТЬ 2/2 — ПОДМЕНЮ PLAYER (FLY, SPEED, JUMP) †
-- ===================================================================

local playerMenu = Instance.new("Frame")
playerMenu.Size = UDim2.fromOffset(0,0)
playerMenu.Position = UDim2.new(.5,-170,.5,-240)
playerMenu.BackgroundColor3 = Color3.fromRGB(18,18,24)
playerMenu.Visible = false
playerMenu.Parent = gui
local playerMc = Instance.new("UICorner",playerMenu)
playerMc.CornerRadius = UDim.new(0,16)

local playerTitle = Instance.new("TextLabel")
playerTitle.Size = UDim2.new(1,-60,0,50)
playerTitle.Position = UDim2.fromOffset(15,5)
playerTitle.BackgroundTransparency = 1
playerTitle.Text = "PLAYER"
playerTitle.TextColor3 = Color3.new(1,1,1)
playerTitle.TextSize = 20
playerTitle.Font = Enum.Font.GothamBold
playerTitle.TextXAlignment = Enum.TextXAlignment.Left
playerTitle.Parent = playerMenu

local playerBack = Instance.new("TextButton")
playerBack.Size = UDim2.fromOffset(40,40)
playerBack.Position = UDim2.new(1,-48,0,10)
playerBack.BackgroundColor3 = Color3.fromRGB(35,35,40)
playerBack.Text = "<"
playerBack.TextColor3 = Color3.new(1,1,1)
playerBack.TextSize = 24
playerBack.Font = Enum.Font.GothamBold
playerBack.Parent = playerMenu
local playerBackCorner = Instance.new("UICorner",playerBack)
playerBackCorner.CornerRadius = UDim.new(0,10)

-- ----- Переменные для Player -----
local flyEnabled = false
local flyVerticalSpeed = 0
local flyBodyVelocity = nil
local flyConnection = nil
local currentSpeed = 16
local currentJump = 5

-- Функция обновления кнопки Fly
local function updateFlyButton()
    if flyEnabled then
        flyBtn.Text = "Fly: ON"
        flyBtn.BackgroundColor3 = Color3.fromRGB(0,200,80)
    else
        flyBtn.Text = "Fly: OFF"
        flyBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
    end
end

-- Функция включения/выключения полёта
local function toggleFly()
    local char = player.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    local root = char.PrimaryPart
    if not root then return end

    flyEnabled = not flyEnabled
    if flyEnabled then
        flyBodyVelocity = Instance.new("BodyVelocity")
        flyBodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
        flyBodyVelocity.Velocity = Vector3.new(0,0,0)
        flyBodyVelocity.Parent = root
        hum.PlatformStand = true
        flyVerticalSpeed = 0
        if flyConnection then flyConnection:Disconnect() end
        flyConnection = RunService.Heartbeat:Connect(function(dt)
            if not flyEnabled or not root or not hum then return end
            local moveDir = hum.MoveDirection
            local speed = 50
            local horizontal = moveDir * speed
            local vertical = Vector3.new(0, flyVerticalSpeed, 0)
            flyBodyVelocity.Velocity = horizontal + vertical
        end)
    else
        if flyBodyVelocity then flyBodyVelocity:Destroy(); flyBodyVelocity = nil end
        if flyConnection then flyConnection:Disconnect(); flyConnection = nil end
        hum.PlatformStand = false
        flyVerticalSpeed = 0
    end
    updateFlyButton()
end

-- Кнопки управления высотой
local function changeFlyHeight(delta)
    if not flyEnabled then return end
    flyVerticalSpeed = math.clamp(flyVerticalSpeed + delta, -30, 30)
end

-- ----- Создаём элементы в playerMenu -----
local pY = 65

-- 1. Кнопка Fly (переключатель)
local flyBtn = Instance.new("TextButton")
flyBtn.Size = UDim2.new(1,-30,0,55)
flyBtn.Position = UDim2.fromOffset(15, pY)
flyBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
flyBtn.Text = "Fly: OFF"
flyBtn.TextColor3 = Color3.new(1,1,1)
flyBtn.TextSize = 18
flyBtn.Font = Enum.Font.GothamBold
flyBtn.Parent = playerMenu
local flyBtnCorner = Instance.new("UICorner",flyBtn)
flyBtnCorner.CornerRadius = UDim.new(0,11)
flyBtn.MouseButton1Click:Connect(toggleFly)

pY = pY + 65

-- 2. Кнопки управления высотой (▲ и ▼)
local heightFrame = Instance.new("Frame")
heightFrame.Size = UDim2.new(1,-30,0,40)
heightFrame.Position = UDim2.fromOffset(15, pY)
heightFrame.BackgroundTransparency = 1
heightFrame.Parent = playerMenu

local heightLabel = Instance.new("TextLabel")
heightLabel.Size = UDim2.new(0.5,0,1,0)
heightLabel.Position = UDim2.new(0,0,0,0)
heightLabel.BackgroundTransparency = 1
heightLabel.Text = "Height"
heightLabel.TextColor3 = Color3.new(1,1,1)
heightLabel.TextSize = 16
heightLabel.Font = Enum.Font.GothamSemibold
heightLabel.TextXAlignment = Enum.TextXAlignment.Left
heightLabel.Parent = heightFrame

local upBtn = Instance.new("TextButton")
upBtn.Size = UDim2.fromOffset(50,40)
upBtn.Position = UDim2.new(0.7,0,0,0)
upBtn.BackgroundColor3 = Color3.fromRGB(50,50,60)
upBtn.Text = "▲"
upBtn.TextColor3 = Color3.new(1,1,1)
upBtn.TextSize = 24
upBtn.Font = Enum.Font.GothamBold
upBtn.Parent = heightFrame
local upCorner = Instance.new("UICorner",upBtn)
upCorner.CornerRadius = UDim.new(0,8)
upBtn.MouseButton1Click:Connect(function() changeFlyHeight(2) end)

local downBtn = Instance.new("TextButton")
downBtn.Size = UDim2.fromOffset(50,40)
downBtn.Position = UDim2.new(0.85,0,0,0)
downBtn.BackgroundColor3 = Color3.fromRGB(50,50,60)
downBtn.Text = "▼"
downBtn.TextColor3 = Color3.new(1,1,1)
downBtn.TextSize = 24
downBtn.Font = Enum.Font.GothamBold
downBtn.Parent = heightFrame
local downCorner = Instance.new("UICorner",downBtn)
downCorner.CornerRadius = UDim.new(0,8)
downBtn.MouseButton1Click:Connect(function() changeFlyHeight(-2) end)

pY = pY + 55

-- 3. Кнопка Speed
local speedBtn = Instance.new("TextButton")
speedBtn.Size = UDim2.new(1,-30,0,55)
speedBtn.Position = UDim2.fromOffset(15, pY)
speedBtn.BackgroundColor3 = Color3.fromRGB(28,28,35)
speedBtn.Text = "Speed: "..currentSpeed
speedBtn.TextColor3 = Color3.new(1,1,1)
speedBtn.TextSize = 18
speedBtn.Font = Enum.Font.GothamBold
speedBtn.Parent = playerMenu
local speedCorner = Instance.new("UICorner",speedBtn)
speedCorner.CornerRadius = UDim.new(0,11)

pY = pY + 65

-- 4. Кнопка Jump
local jumpBtn = Instance.new("TextButton")
jumpBtn.Size = UDim2.new(1,-30,0,55)
jumpBtn.Position = UDim2.fromOffset(15, pY)
jumpBtn.BackgroundColor3 = Color3.fromRGB(28,28,35)
jumpBtn.Text = "Jump: "..currentJump
jumpBtn.TextColor3 = Color3.new(1,1,1)
jumpBtn.TextSize = 18
jumpBtn.Font = Enum.Font.GothamBold
jumpBtn.Parent = playerMenu
local jumpCorner = Instance.new("UICorner",jumpBtn)
jumpCorner.CornerRadius = UDim.new(0,11)

-- ----- Окно ввода (универсальное) -----
local inputPopup = Instance.new("Frame")
inputPopup.Size = UDim2.fromOffset(0,0)
inputPopup.Position = UDim2.new(.5,-150,.5,-120)
inputPopup.BackgroundColor3 = Color3.fromRGB(20,20,28)
inputPopup.Visible = false
inputPopup.Parent = gui
local popupCorner = Instance.new("UICorner",inputPopup)
popupCorner.CornerRadius = UDim.new(0,16)

local popupTitle = Instance.new("TextLabel")
popupTitle.Size = UDim2.new(1,-60,0,50)
popupTitle.Position = UDim2.fromOffset(15,5)
popupTitle.BackgroundTransparency = 1
popupTitle.Text = "Enter Value"
popupTitle.TextColor3 = Color3.new(1,1,1)
popupTitle.TextSize = 18
popupTitle.Font = Enum.Font.GothamBold
popupTitle.TextXAlignment = Enum.TextXAlignment.Left
popupTitle.Parent = inputPopup

local popupClose = Instance.new("TextButton")
popupClose.Size = UDim2.fromOffset(40,40)
popupClose.Position = UDim2.new(1,-48,0,10)
popupClose.BackgroundColor3 = Color3.fromRGB(35,35,40)
popupClose.Text = "X"
popupClose.TextColor3 = Color3.new(1,1,1)
popupClose.TextSize = 18
popupClose.Font = Enum.Font.GothamBold
popupClose.Parent = inputPopup
local popupCloseCorner = Instance.new("UICorner",popupClose)
popupCloseCorner.CornerRadius = UDim.new(0,10)

local popupBox = Instance.new("TextBox")
popupBox.Size = UDim2.new(1,-60,0,50)
popupBox.Position = UDim2.fromOffset(30,80)
popupBox.BackgroundColor3 = Color3.fromRGB(40,40,50)
popupBox.Text = ""
popupBox.TextColor3 = Color3.new(1,1,1)
popupBox.TextSize = 18
popupBox.Font = Enum.Font.Gotham
popupBox.ClearTextOnFocus = false
popupBox.PlaceholderText = "Enter number..."
popupBox.Parent = inputPopup
local boxCorner = Instance.new("UICorner",popupBox)
boxCorner.CornerRadius = UDim.new(0,8)

local popupOk = Instance.new("TextButton")
popupOk.Size = UDim2.new(1,-60,0,50)
popupOk.Position = UDim2.fromOffset(30,150)
popupOk.BackgroundColor3 = Color3.fromRGB(0,150,80)
popupOk.Text = "OK"
popupOk.TextColor3 = Color3.new(1,1,1)
popupOk.TextSize = 20
popupOk.Font = Enum.Font.GothamBold
popupOk.Parent = inputPopup
local okCorner = Instance.new("UICorner",popupOk)
okCorner.CornerRadius = UDim.new(0,8)

-- Переменные для popup
local popupCallback = nil

local function showPopup(title, placeholder, minVal, maxVal, callback)
    popupTitle.Text = title
    popupBox.PlaceholderText = placeholder
    popupBox.Text = ""
    popupCallback = function(input)
        local num = tonumber(input)
        if num and num >= minVal and num <= maxVal then
            callback(num)
            hidePopup()
        else
            -- простая ошибка, можно показать сообщение, но для простоты просто сбросим
            popupBox.Text = ""
            popupBox.PlaceholderText = "Invalid! "..minVal.."-"..maxVal
        end
    end
    inputPopup.Visible = true
    inputPopup.Size = UDim2.fromOffset(0,0)
    Tween:Create(inputPopup,TweenInfo.new(.2,Enum.EasingStyle.Back),{
        Size=UDim2.fromOffset(300,250)
    }):Play()
    -- фокус на поле ввода (на мобильных открывается клавиатура)
    popupBox:CaptureFocus()
end

local function hidePopup()
    Tween:Create(inputPopup,TweenInfo.new(.2),{
        Size=UDim2.fromOffset(0,0)
    }):Play()
    task.wait(.2)
    inputPopup.Visible = false
    popupCallback = nil
end

popupClose.MouseButton1Click:Connect(hidePopup)
popupOk.MouseButton1Click:Connect(function()
    if popupCallback then
        popupCallback(popupBox.Text)
    end
end)
-- Также по нажатию Enter
popupBox.FocusLost:Connect(function(enterPressed)
    if enterPressed and popupCallback then
        popupCallback(popupBox.Text)
    end
end)

-- ----- Обработчики кнопок Speed и Jump -----
speedBtn.MouseButton1Click:Connect(function()
    showPopup("Speed", "16-500", 16, 500, function(val)
        currentSpeed = val
        speedBtn.Text = "Speed: "..val
        local char = player.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = val end
        end
    end)
end)

jumpBtn.MouseButton1Click:Connect(function()
    showPopup("Jump", "5-30", 5, 30, function(val)
        currentJump = val
        jumpBtn.Text = "Jump: "..val
        local char = player.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.JumpPower = val end
        end
    end)
end)

-- ----- Управление открытием/закрытием меню -----
local function openMain()
    menu.Visible = true
    menu.Size = UDim2.fromOffset(270,270)
    Tween:Create(menu,TweenInfo.new(.2,Enum.EasingStyle.Back),{  
        Size=UDim2.fromOffset(300,300)  
    }):Play()
end

local function hideMain()
    menu.Visible = false
end

local function openESP()
    espMenu.Visible = true
    espMenu.Size = UDim2.fromOffset(0,0)
    Tween:Create(espMenu,TweenInfo.new(.25,Enum.EasingStyle.Back),{
        Size=UDim2.fromOffset(340,450)
    }):Play()
    hideMain()
end

local function hideESP()
    Tween:Create(espMenu,TweenInfo.new(.2),{
        Size=UDim2.fromOffset(0,0)
    }):Play()
    task.wait(.2)
    espMenu.Visible = false
    openMain()
end

local function openPlayer()
    playerMenu.Visible = true
    playerMenu.Size = UDim2.fromOffset(0,0)
    Tween:Create(playerMenu,TweenInfo.new(.25,Enum.EasingStyle.Back),{
        Size=UDim2.fromOffset(340,480)
    }):Play()
    hideMain()
end

local function hidePlayer()
    Tween:Create(playerMenu,TweenInfo.new(.2),{
        Size=UDim2.fromOffset(0,0)
    }):Play()
    task.wait(.2)
    playerMenu.Visible = false
    openMain()
end

-- Назначаем кнопки
icon.Activated:Connect(openMain)
close.Activated:Connect(hideMain)
espBack.Activated:Connect(hideESP)
playerBack.Activated:Connect(hidePlayer)
mainButtons[1].Activated:Connect(openESP)  -- ESP
mainButtons[2].Activated:Connect(openPlayer) -- PLAYER

-- ========== ПЕРЕТАСКИВАНИЕ ИКОНКИ ==========
local dragging,start,pos = false,nil,nil
icon.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging=true
        start=input.Position
        pos=icon.Position
    end
end)
UIS.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType==Enum.UserInputType.Touch
        or input.UserInputType==Enum.UserInputType.MouseMovement
    ) then
        local d=input.Position-start
        icon.Position=UDim2.new(  
            pos.X.Scale,pos.X.Offset+d.X,  
            pos.Y.Scale,pos.Y.Offset+d.Y  
        )  
    end
end)
UIS.InputEnded:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.Touch
    or input.UserInputType==Enum.UserInputType.MouseButton1 then
        dragging=false
    end
end)

-- ========== ПРИМЕНЕНИЕ НАСТРОЕК ПРИ ЗАХОДЕ ==========
-- Устанавливаем начальные Speed и Jump при появлении персонажа
player.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed = currentSpeed
        hum.JumpPower = currentJump
    end
end)

-- Если персонаж уже есть, применяем сразу
if player.Character then
    task.wait(0.5)
    local hum = player.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed = currentSpeed
        hum.JumpPower = currentJump
    end
end

print("† АБСОЛЮТНЫЙ ИНЖЕКТОР v7.0 АКТИВИРОВАН. ВСЕ ФУНКЦИИ РАБОТАЮТ. †")
