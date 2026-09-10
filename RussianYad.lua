-- ===================================================================
-- ROBLOX MASTER v7.0 — ЧАСТЬ 1/2 (50%)
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
gui.IgnoreGuiInset = true
gui.Parent = player:WaitForChild("PlayerGui")

-- ========== ЗАГРУЗКА (на весь экран) ==========
local loading = Instance.new("TextLabel")
loading.Size = UDim2.new(1,0,1,0)
loading.BackgroundColor3 = Color3.fromRGB(8,8,10)
loading.TextColor3 = Color3.new(1,1,1)
loading.TextSize = 26
loading.Font = Enum.Font.GothamBold
loading.Text = "LOADING 0%"
loading.ZIndex = 10
loading.Parent = gui
task.spawn(function()
    for i=0,100,5 do
        loading.Text = "LOADING "..i.."%"
        task.wait(0.04)
    end
    Tween:Create(loading,TweenInfo.new(.4),{TextTransparency=1,BackgroundTransparency=1}):Play()
    task.wait(.4)
    loading:Destroy()
end)

-- ========== ИКОНКА ==========
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
Instance.new("UICorner",icon).CornerRadius = UDim.new(1,0)
local iconStroke = Instance.new("UIStroke",icon)
iconStroke.Thickness = 2
iconStroke.Color = Color3.new(1,1,1)
local dot = Instance.new("Frame")
dot.Size = UDim2.fromOffset(10,10)
dot.Position = UDim2.new(1,-13,0,4)
dot.BackgroundColor3 = Color3.fromRGB(255,40,40)
dot.Parent = icon
Instance.new("UICorner",dot).CornerRadius = UDim.new(1,0)

-- ========== ХЕЛПЕРЫ ==========
local function createSubmenu(titleText)
    local f = Instance.new("Frame")
    f.Size = UDim2.fromOffset(0,0)
    f.Position = UDim2.fromScale(.5,.5)
    f.AnchorPoint = Vector2.new(.5,.5)
    f.BackgroundColor3 = Color3.fromRGB(18,18,24)
    f.Visible = false
    f.Parent = gui
    Instance.new("UICorner",f).CornerRadius = UDim.new(0,16)
    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(1,-60,0,50)
    t.Position = UDim2.fromOffset(15,5)
    t.BackgroundTransparency = 1
    t.Text = titleText
    t.TextColor3 = Color3.new(1,1,1)
    t.TextSize = 20
    t.Font = Enum.Font.GothamBold
    t.TextXAlignment = Enum.TextXAlignment.Left
    t.Parent = f
    local back = Instance.new("TextButton")
    back.Size = UDim2.fromOffset(40,40)
    back.Position = UDim2.new(1,-48,0,10)
    back.BackgroundColor3 = Color3.fromRGB(35,35,40)
    back.Text = "<"
    back.TextColor3 = Color3.new(1,1,1)
    back.TextSize = 24
    back.Font = Enum.Font.GothamBold
    back.Parent = f
    Instance.new("UICorner",back).CornerRadius = UDim.new(0,10)
    return f, t, back
end

local function openFrame(f, w, h)
    f.Visible = true
    f.Size = UDim2.fromOffset(0,0)
    Tween:Create(f, TweenInfo.new(.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(w,h)}):Play()
end
local function closeFrame(f)
    Tween:Create(f, TweenInfo.new(.18, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.fromOffset(0,0)}):Play()
    task.wait(.18)
    f.Visible = false
end

-- ========== ГЛАВНОЕ МЕНЮ ==========
local menu = Instance.new("Frame")
menu.Size = UDim2.fromOffset(300,320)
menu.Position = UDim2.fromScale(.5,.5)
menu.AnchorPoint = Vector2.new(.5,.5)
menu.BackgroundColor3 = Color3.fromRGB(12,12,16)
menu.Visible = false
menu.Parent = gui
Instance.new("UICorner",menu).CornerRadius = UDim.new(0,16)

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
Instance.new("UICorner",close).CornerRadius = UDim.new(0,10)

local mainButtons = {}
for i,text in ipairs({"ESP","PLAYER","MISC"}) do
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1,-30,0,65)
    b.Position = UDim2.fromOffset(15,65+(i-1)*75)
    b.BackgroundColor3 = Color3.fromRGB(28,28,35)
    b.Text = text
    b.TextColor3 = Color3.new(1,1,1)
    b.TextSize = 18
    b.Font = Enum.Font.GothamBold
    b.Parent = menu
    Instance.new("UICorner",b).CornerRadius = UDim.new(0,11)
    mainButtons[i] = b
end

local function openMain()
    menu.Visible = true
    menu.Size = UDim2.fromOffset(0,0)
    Tween:Create(menu, TweenInfo.new(.28, Enum.EasingStyle.Back), {Size = UDim2.fromOffset(300,320)}):Play()
end
local function hideMain()
    Tween:Create(menu, TweenInfo.new(.18), {Size = UDim2.fromOffset(0,0)}):Play()
    task.wait(.18)
    menu.Visible = false
end

-- ========== ПОДМЕНЮ ESP ==========
local espMenu, espTitle, espBack = createSubmenu("ESP (OFF)")

local espEnabled = false
local espSettings = {boxes=false, names=false, health=false, distance=false}

local function createSwitch(parent, y, labelText, getter, setter, onChange)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1,-30,0,40)
    frame.Position = UDim2.fromOffset(15,y)
    frame.BackgroundTransparency = 1
    frame.Parent = parent
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.6,0,1,0)
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
    Instance.new("UICorner",btn).CornerRadius = UDim.new(0,8)
    btn.MouseButton1Click:Connect(function()
        local nv = not getter()
        setter(nv)
        btn.BackgroundColor3 = nv and Color3.fromRGB(0,200,80) or Color3.fromRGB(80,80,80)
        btn.Text = nv and "ON" or "OFF"
        if onChange then onChange(nv) end
    end)
end

-- ВАЖНО: clearESP объявляем заранее как forward declaration
local clearESP

createSwitch(espMenu, 60, "Enable ESP", function() return espEnabled end, function(v) espEnabled = v end, function(v) espTitle.Text = "ESP ("..(v and "ON" or "OFF")..")"; if not v and clearESP then clearESP() end end)
createSwitch(espMenu, 105, "Boxes", function() return espSettings.boxes end, function(v) espSettings.boxes = v end)
createSwitch(espMenu, 150, "Names", function() return espSettings.names end, function(v) espSettings.names = v end)
createSwitch(espMenu, 195, "Health", function() return espSettings.health end, function(v) espSettings.health = v end)
createSwitch(espMenu, 240, "Distance", function() return espSettings.distance end, function(v) espSettings.distance = v end)

-- ESP логика
local espObjects = {}
clearESP = function()
    for _, d in pairs(espObjects) do
        if d.box then d.box:Destroy() end
        if d.name then d.name:Destroy() end
        if d.health then d.health:Destroy() end
        if d.dist then d.dist:Destroy() end
    end
    espObjects = {}
end

local function createESP(target)
    if espObjects[target] then return end
    local data = {}
    local char = target.Character
    if not char or not char.PrimaryPart then return end
    local box = Instance.new("Frame")
    box.Size = UDim2.fromOffset(0,0)
    box.BackgroundTransparency = 0.6
    box.BorderSizePixel = 2
    box.BorderColor3 = Color3.new(1,1,1)
    box.BackgroundColor3 = Color3.new(0,0,0)
    box.Parent = gui
    local name = Instance.new("TextLabel")
    name.Size = UDim2.fromOffset(150,20)
    name.BackgroundTransparency = 1
    name.Text = target.Name
    name.TextColor3 = Color3.new(1,1,1)
    name.TextSize = 14
    name.Font = Enum.Font.GothamBold
    name.TextStrokeTransparency = 0.5
    name.Parent = gui
    local health = Instance.new("Frame")
    health.Size = UDim2.fromOffset(0,4)
    health.BackgroundColor3 = Color3.fromRGB(0,255,0)
    health.BorderSizePixel = 0
    health.Parent = gui
    local dist = Instance.new("TextLabel")
    dist.Size = UDim2.fromOffset(80,16)
    dist.BackgroundTransparency = 1
    dist.TextColor3 = Color3.new(1,1,1)
    dist.TextSize = 12
    dist.Font = Enum.Font.Gotham
    dist.Parent = gui
    data.box = box; data.name = name; data.health = health; data.dist = dist
    espObjects[target] = data
end

RunService.RenderStepped:Connect(function()
    if not espEnabled then
        if next(espObjects) then clearESP() end
        return
    end
    local myChar = player.Character
    if not myChar or not myChar.PrimaryPart then return end
    for _, target in ipairs(Players:GetPlayers()) do
        if target ~= player then
            local char = target.Character
            if char and char:FindFirstChild("Head") then
                local pos = char.Head.Position
                local screenPos, onScreen = Camera:WorldToViewportPoint(pos)
                if onScreen then
                    if not espObjects[target] then createESP(target) end
                    local d = espObjects[target]
                    if d then
                        local dist3D = (pos - Camera.CFrame.Position).Magnitude
                        local boxSize = math.clamp(2.5 / dist3D * 500, 20, 150)
                        d.box.Size = UDim2.fromOffset(boxSize, boxSize*1.5)
                        d.box.Position = UDim2.new(0, screenPos.X - boxSize/2, 0, screenPos.Y - boxSize*0.75)
                        d.box.Visible = espSettings.boxes
                        d.name.Position = UDim2.new(0, screenPos.X - 75, 0, screenPos.Y - boxSize*0.75 - 20)
                        d.name.Text = target.Name
                        d.name.Visible = espSettings.names
                        local hum = char:FindFirstChildOfClass("Humanoid")
                        if hum then
                            local hp = hum.Health / math.max(hum.MaxHealth, 1)
                            d.health.Size = UDim2.fromOffset(boxSize*hp, 4)
                            d.health.Position = UDim2.new(0, screenPos.X - boxSize/2, 0, screenPos.Y + boxSize*0.75 - 10)
                            d.health.BackgroundColor3 = Color3.fromRGB(255*(1-hp), 255*hp, 0)
                            d.health.Visible = espSettings.health
                        end
                        local dv = (pos - myChar.PrimaryPart.Position).Magnitude
                        d.dist.Position = UDim2.new(0, screenPos.X - 40, 0, screenPos.Y + boxSize*0.75 + 6)
                        d.dist.Text = string.format("%dm", math.floor(dv))
                        d.dist.Visible = espSettings.distance
                    end
                else
                    if espObjects[target] then
                        local d = espObjects[target]
                        if d.box then d.box:Destroy() end
                        if d.name then d.name:Destroy() end
                        if d.health then d.health:Destroy() end
                        if d.dist then d.dist:Destroy() end
                        espObjects[target] = nil
                    end
                end
            end
        end
    end
end)

Players.PlayerRemoving:Connect(function(p)
    if espObjects[p] then
        local d = espObjects[p]
        if d.box then d.box:Destroy() end
        if d.name then d.name:Destroy() end
        if d.health then d.health:Destroy() end
        if d.dist then d.dist:Destroy() end
        espObjects[p] = nil
    end
end)

print("PART 1/2 LOADED")
-- ===================================================================
-- ROBLOX MASTER v7.0 — ЧАСТЬ 2/2 (50%)
-- ===================================================================

-- ========== ПОДМЕНЮ PLAYER ==========
local playerMenu, _, playerBack = createSubmenu("PLAYER")

local currentSpeed = 16
local currentJump = 5

local speedBtn = Instance.new("TextButton")
speedBtn.Size = UDim2.new(1,-30,0,60)
speedBtn.Position = UDim2.fromOffset(15,65)
speedBtn.BackgroundColor3 = Color3.fromRGB(28,28,35)
speedBtn.Text = "Speed: 16"
speedBtn.TextColor3 = Color3.new(1,1,1)
speedBtn.TextSize = 18
speedBtn.Font = Enum.Font.GothamBold
speedBtn.Parent = playerMenu
Instance.new("UICorner",speedBtn).CornerRadius = UDim.new(0,11)

local jumpBtn = Instance.new("TextButton")
jumpBtn.Size = UDim2.new(1,-30,0,60)
jumpBtn.Position = UDim2.fromOffset(15,135)
jumpBtn.BackgroundColor3 = Color3.fromRGB(28,28,35)
jumpBtn.Text = "Jump: 5"
jumpBtn.TextColor3 = Color3.new(1,1,1)
jumpBtn.TextSize = 18
jumpBtn.Font = Enum.Font.GothamBold
jumpBtn.Parent = playerMenu
Instance.new("UICorner",jumpBtn).CornerRadius = UDim.new(0,11)

local flyBtn = Instance.new("TextButton")
flyBtn.Size = UDim2.new(1,-30,0,60)
flyBtn.Position = UDim2.fromOffset(15,205)
flyBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
flyBtn.Text = "Fly: OFF"
flyBtn.TextColor3 = Color3.new(1,1,1)
flyBtn.TextSize = 18
flyBtn.Font = Enum.Font.GothamBold
flyBtn.Parent = playerMenu
Instance.new("UICorner",flyBtn).CornerRadius = UDim.new(0,11)

-- ========== ПОДМЕНЮ FLY (с джойстиком) ==========
local flyMenu, flyTitle, flyBack = createSubmenu("FLY CONTROL")

local flyEnabled = false
local flyDirection = Vector2.new(0,0)
local flyVertical = 0
local flySpeed = 50
local flyBodyVelocity = nil
local flyConnection = nil

-- Кнопка ON/OFF в правом верхнем углу подменю
local flyToggle = Instance.new("TextButton")
flyToggle.Size = UDim2.fromOffset(70,36)
flyToggle.Position = UDim2.new(1,-130,0,14)
flyToggle.BackgroundColor3 = Color3.fromRGB(80,80,80)
flyToggle.Text = "OFF"
flyToggle.TextColor3 = Color3.new(1,1,1)
flyToggle.TextSize = 15
flyToggle.Font = Enum.Font.GothamBold
flyToggle.Parent = flyMenu
Instance.new("UICorner",flyToggle).CornerRadius = UDim.new(0,8)

local function stopFly()
    if flyBodyVelocity then flyBodyVelocity:Destroy(); flyBodyVelocity = nil end
    if flyConnection then flyConnection:Disconnect(); flyConnection = nil end
    local char = player.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.PlatformStand = false end
    end
end

local function startFly()
    local char = player.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local root = char.PrimaryPart
    if not hum or not root then return end
    flyBodyVelocity = Instance.new("BodyVelocity")
    flyBodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    flyBodyVelocity.Velocity = Vector3.new(0,0,0)
    flyBodyVelocity.Parent = root
    hum.PlatformStand = true
    flyConnection = RunService.Heartbeat:Connect(function()
        if not flyEnabled then return end
        local c = player.Character
        if not c or not c.PrimaryPart or not flyBodyVelocity then return end
        local camCF = Camera.CFrame
        local fwd = camCF.LookVector
        local rgt = camCF.RightVector
        local moveDir = (fwd * -flyDirection.Y + rgt * flyDirection.X)
        moveDir = Vector3.new(moveDir.X, 0, moveDir.Z)
        if moveDir.Magnitude > 0.01 then moveDir = moveDir.Unit end
        local horiz = moveDir * flySpeed
        local vert = Vector3.new(0, flyVertical * flySpeed, 0)
        flyBodyVelocity.Velocity = horiz + vert
    end)
end

function setFly(on)
    flyEnabled = on
    if on then startFly() else stopFly() end
    flyToggle.Text = on and "ON" or "OFF"
    flyToggle.BackgroundColor3 = on and Color3.fromRGB(0,200,80) or Color3.fromRGB(80,80,80)
    flyBtn.Text = "Fly: "..(on and "ON" or "OFF")
    flyBtn.BackgroundColor3 = on and Color3.fromRGB(0,200,80) or Color3.fromRGB(80,80,80)
end

flyToggle.MouseButton1Click:Connect(function() setFly(not flyEnabled) end)

-- ДЖОЙСТИК
local joyBg = Instance.new("Frame")
joyBg.Size = UDim2.fromOffset(200,200)
joyBg.Position = UDim2.new(0.5,-100,0,80)
joyBg.BackgroundColor3 = Color3.fromRGB(30,30,40)
joyBg.BackgroundTransparency = 0.2
joyBg.Parent = flyMenu
Instance.new("UICorner",joyBg).CornerRadius = UDim.new(1,0)
local joyStroke = Instance.new("UIStroke",joyBg)
joyStroke.Color = Color3.fromRGB(80,80,110)
joyStroke.Thickness = 2

local knob = Instance.new("Frame")
knob.Size = UDim2.fromOffset(80,80)
knob.Position = UDim2.new(0.5,-40,0.5,-40)
knob.BackgroundColor3 = Color3.fromRGB(110,110,160)
knob.Parent = joyBg
Instance.new("UICorner",knob).CornerRadius = UDim.new(1,0)

local joyDragging = false
local joyCenter = Vector2.new(0,0)
local joyRadius = 70

joyBg.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.Touch or inp.UserInputType == Enum.UserInputType.MouseButton1 then
        joyDragging = true
        joyCenter = joyBg.AbsolutePosition + joyBg.AbsoluteSize/2
        joyRadius = joyBg.AbsoluteSize.X/2 - 25
    end
end)
UIS.InputChanged:Connect(function(inp)
    if not joyDragging then return end
    if inp.UserInputType == Enum.UserInputType.Touch or inp.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = Vector2.new(inp.Position.X, inp.Position.Y) - joyCenter
        if delta.Magnitude > joyRadius then delta = delta.Unit * joyRadius end
        knob.Position = UDim2.new(0.5, delta.X - 40, 0.5, delta.Y - 40)
        flyDirection = delta / joyRadius
    end
end)
UIS.InputEnded:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.Touch or inp.UserInputType == Enum.UserInputType.MouseButton1 then
        if joyDragging then
            joyDragging = false
            knob.Position = UDim2.new(0.5,-40,0.5,-40)
            flyDirection = Vector2.new(0,0)
        end
    end
end)

-- КНОПКИ UP/DOWN (большие, держать)
local function createHoldButton(parent, pos, text, onDown, onUp)
    local b = Instance.new("TextButton")
    b.Size = UDim2.fromOffset(140,60)
    b.Position = pos
    b.BackgroundColor3 = Color3.fromRGB(40,40,55)
    b.Text = text
    b.TextColor3 = Color3.new(1,1,1)
    b.TextSize = 22
    b.Font = Enum.Font.GothamBold
    b.AutoButtonColor = false
    b.Parent = parent
    Instance.new("UICorner",b).CornerRadius = UDim.new(0,12)
    local strk = Instance.new("UIStroke",b)
    strk.Color = Color3.fromRGB(80,80,110)
    strk.Thickness = 2
    b.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.Touch or inp.UserInputType == Enum.UserInputType.MouseButton1 then
            b.BackgroundColor3 = Color3.fromRGB(70,70,110)
            onDown()
        end
    end)
    b.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.Touch or inp.UserInputType == Enum.UserInputType.MouseButton1 then
            b.BackgroundColor3 = Color3.fromRGB(40,40,55)
            onUp()
        end
    end)
end

createHoldButton(flyMenu, UDim2.fromOffset(30,300), "UP", function() flyVertical = 1 end, function() flyVertical = 0 end)
createHoldButton(flyMenu, UDim2.new(1,-170,0,300), "DOWN", function() flyVertical = -1 end, function() flyVertical = 0 end)

-- СКОРОСТЬ ПОЛЁТА
local flySpeedLabel = Instance.new("TextLabel")
flySpeedLabel.Size = UDim2.new(1,-30,0,30)
flySpeedLabel.Position = UDim2.fromOffset(15, 375)
flySpeedLabel.BackgroundTransparency = 1
flySpeedLabel.Text = "Fly Speed: 50"
flySpeedLabel.TextColor3 = Color3.new(1,1,1)
flySpeedLabel.TextSize = 16
flySpeedLabel.Font = Enum.Font.GothamSemibold
flySpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
flySpeedLabel.Parent = flyMenu

local flySpeedMinus = Instance.new("TextButton")
flySpeedMinus.Size = UDim2.fromOffset(50,40)
flySpeedMinus.Position = UDim2.new(0.55,0,0,370)
flySpeedMinus.BackgroundColor3 = Color3.fromRGB(50,50,60)
flySpeedMinus.Text = "-"
flySpeedMinus.TextColor3 = Color3.new(1,1,1)
flySpeedMinus.TextSize = 22
flySpeedMinus.Font = Enum.Font.GothamBold
flySpeedMinus.Parent = flyMenu
Instance.new("UICorner",flySpeedMinus).CornerRadius = UDim.new(0,8)

local flySpeedPlus = Instance.new("TextButton")
flySpeedPlus.Size = UDim2.fromOffset(50,40)
flySpeedPlus.Position = UDim2.new(0.75,0,0,370)
flySpeedPlus.BackgroundColor3 = Color3.fromRGB(50,50,60)
flySpeedPlus.Text = "+"
flySpeedPlus.TextColor3 = Color3.new(1,1,1)
flySpeedPlus.TextSize = 22
flySpeedPlus.Font = Enum.Font.GothamBold
flySpeedPlus.Parent = flyMenu
Instance.new("UICorner",flySpeedPlus).CornerRadius = UDim.new(0,8)

flySpeedMinus.MouseButton1Click:Connect(function()
    flySpeed = math.max(10, flySpeed - 10)
    flySpeedLabel.Text = "Fly Speed: "..flySpeed
end)
flySpeedPlus.MouseButton1Click:Connect(function()
    flySpeed = math.min(300, flySpeed + 10)
    flySpeedLabel.Text = "Fly Speed: "..flySpeed
end)

-- ========== ПОДМЕНЮ MISC ==========
local miscMenu, _, miscBack = createSubmenu("MISC")

local noclipEnabled = false
local noclipConn = nil

local noclipBtn = Instance.new("TextButton")
noclipBtn.Size = UDim2.new(1,-30,0,60)
noclipBtn.Position = UDim2.fromOffset(15,65)
noclipBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
noclipBtn.Text = "Noclip: OFF"
noclipBtn.TextColor3 = Color3.new(1,1,1)
noclipBtn.TextSize = 18
noclipBtn.Font = Enum.Font.GothamBold
noclipBtn.Parent = miscMenu
Instance.new("UICorner",noclipBtn).CornerRadius = UDim.new(0,11)

local function setNoclip(on)
    noclipEnabled = on
    if on then
        noclipConn = RunService.Heartbeat:Connect(function()
            local char = player.Character
            if char then
                for _, p in ipairs(char:GetDescendants()) do
                    if p:IsA("BasePart") then p.CanCollide = false end
                end
            end
        end)
        noclipBtn.Text = "Noclip: ON"
        noclipBtn.BackgroundColor3 = Color3.fromRGB(0,200,80)
    else
        if noclipConn then noclipConn:Disconnect(); noclipConn = nil end
        local char = player.Character
        if char then
            for _, p in ipairs(char:GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide = true end
            end
        end
        noclipBtn.Text = "Noclip: OFF"
        noclipBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
    end
end
noclipBtn.MouseButton1Click:Connect(function() setNoclip(not noclipEnabled) end)

local tpMouseBtn = Instance.new("TextButton")
tpMouseBtn.Size = UDim2.new(1,-30,0,60)
tpMouseBtn.Position = UDim2.fromOffset(15,135)
tpMouseBtn.BackgroundColor3 = Color3.fromRGB(28,28,35)
tpMouseBtn.Text = "TP to Mouse"
tpMouseBtn.TextColor3 = Color3.new(1,1,1)
tpMouseBtn.TextSize = 18
tpMouseBtn.Font = Enum.Font.GothamBold
tpMouseBtn.Parent = miscMenu
Instance.new("UICorner",tpMouseBtn).CornerRadius = UDim.new(0,11)
tpMouseBtn.MouseButton1Click:Connect(function()
    local mouse = player:GetMouse()
    if mouse and mouse.Hit then
        local char = player.Character
        if char and char.PrimaryPart then
            char.PrimaryPart.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0,3,0))
        end
    end
end)

local tpPlayerBtn = Instance.new("TextButton")
tpPlayerBtn.Size = UDim2.new(1,-30,0,60)
tpPlayerBtn.Position = UDim2.fromOffset(15,205)
tpPlayerBtn.BackgroundColor3 = Color3.fromRGB(28,28,35)
tpPlayerBtn.Text = "TP to Player"
tpPlayerBtn.TextColor3 = Color3.new(1,1,1)
tpPlayerBtn.TextSize = 18
tpPlayerBtn.Font = Enum.Font.GothamBold
tpPlayerBtn.Parent = miscMenu
Instance.new("UICorner",tpPlayerBtn).CornerRadius = UDim.new(0,11)

-- ========== ПОДМЕНЮ TP TO PLAYER ==========
local tpMenu, _, tpBack = createSubmenu("TP TO PLAYER")

local tpScroll = Instance.new("ScrollingFrame")
tpScroll.Size = UDim2.new(1,-30,1,-80)
tpScroll.Position = UDim2.fromOffset(15,65)
tpScroll.BackgroundTransparency = 1
tpScroll.BorderSizePixel = 0
tpScroll.ScrollBarThickness = 6
tpScroll.ScrollBarImageColor3 = Color3.fromRGB(80,80,110)
tpScroll.CanvasSize = UDim2.new(0,0,0,0)
tpScroll.Parent = tpMenu

local function refreshTPList()
    for _, c in ipairs(tpScroll:GetChildren()) do
        if c:IsA("TextButton") or c:IsA("TextLabel") then c:Destroy() end
    end
    local y = 0
    local count = 0
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player then
            count = count + 1
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1,-10,0,55)
            btn.Position = UDim2.fromOffset(0,y)
            btn.BackgroundColor3 = Color3.fromRGB(28,28,35)
            btn.Text = p.Name
            btn.TextColor3 = Color3.new(1,1,1)
            btn.TextSize = 16
            btn.Font = Enum.Font.GothamSemibold
            btn.Parent = tpScroll
            Instance.new("UICorner",btn).CornerRadius = UDim.new(0,10)
            btn.MouseButton1Click:Connect(function()
                local tChar = p.Character
                if tChar and tChar.PrimaryPart then
                    local myChar = player.Character
                    if myChar and myChar.PrimaryPart then
                        myChar.PrimaryPart.CFrame = tChar.PrimaryPart.CFrame * CFrame.new(0,3,3)
                    end
                end
            end)
            y = y + 60
        end
    end
    if count == 0 then
        local none = Instance.new("TextLabel")
        none.Size = UDim2.new(1,-10,0,50)
        none.BackgroundTransparency = 1
        none.Text = "No players"
        none.TextColor3 = Color3.fromRGB(150,150,150)
        none.TextSize = 16
        none.Font = Enum.Font.Gotham
        none.Parent = tpScroll
        y = 50
    end
    tpScroll.CanvasSize = UDim2.new(0,0,0,y)
end

-- ========== ОКНО ВВОДА ==========
local inputPopup = Instance.new("Frame")
inputPopup.Size = UDim2.fromOffset(0,0)
inputPopup.Position = UDim2.fromScale(.5,.5)
inputPopup.AnchorPoint = Vector2.new(.5,.5)
inputPopup.BackgroundColor3 = Color3.fromRGB(20,20,28)
inputPopup.Visible = false
inputPopup.Parent = gui
Instance.new("UICorner",inputPopup).CornerRadius = UDim.new(0,16)

local popupTitle = Instance.new("TextLabel")
popupTitle.Size = UDim2.new(1,-60,0,50)
popupTitle.Position = UDim2.fromOffset(15,5)
popupTitle.BackgroundTransparency = 1
popupTitle.Text = "Value"
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
Instance.new("UICorner",popupClose).CornerRadius = UDim.new(0,10)

local popupBox = Instance.new("TextBox")
popupBox.Size = UDim2.new(1,-60,0,55)
popupBox.Position = UDim2.fromOffset(30,80)
popupBox.BackgroundColor3 = Color3.fromRGB(40,40,50)
popupBox.Text = ""
popupBox.TextColor3 = Color3.new(1,1,1)
popupBox.TextSize = 20
popupBox.Font = Enum.Font.Gotham
popupBox.ClearTextOnFocus = false
popupBox.PlaceholderText = "Enter number..."
popupBox.Parent = inputPopup
Instance.new("UICorner",popupBox).CornerRadius = UDim.new(0,8)

local popupOk = Instance.new("TextButton")
popupOk.Size = UDim2.new(1,-60,0,55)
popupOk.Position = UDim2.fromOffset(30,150)
popupOk.BackgroundColor3 = Color3.fromRGB(0,150,80)
popupOk.Text = "OK"
popupOk.TextColor3 = Color3.new(1,1,1)
popupOk.TextSize = 20
popupOk.Font = Enum.Font.GothamBold
popupOk.Parent = inputPopup
Instance.new("UICorner",popupOk).CornerRadius = UDim.new(0,8)

local popupCallback = nil
local function hidePopup()
    Tween:Create(inputPopup, TweenInfo.new(.18), {Size = UDim2.fromOffset(0,0)}):Play()
    task.wait(.18)
    inputPopup.Visible = false
    popupCallback = nil
end
local function showPopup(ptitle, placeholder, minVal, maxVal, callback)
    popupTitle.Text = ptitle
    popupBox.PlaceholderText = placeholder
    popupBox.Text = ""
    popupCallback = function(input)
        local num = tonumber(input)
        if num and num >= minVal and num <= maxVal then
            callback(num)
            hidePopup()
        else
            popupBox.Text = ""
            popupBox.PlaceholderText = "Invalid! "..minVal.."-"..maxVal
        end
    end
    inputPopup.Visible = true
    inputPopup.Size = UDim2.fromOffset(0,0)
    Tween:Create(inputPopup, TweenInfo.new(.22, Enum.EasingStyle.Back), {Size = UDim2.fromOffset(300,225)}):Play()
    task.wait(.05)
    popupBox:CaptureFocus()
end

popupClose.MouseButton1Click:Connect(hidePopup)
popupOk.MouseButton1Click:Connect(function()
    if popupCallback then popupCallback(popupBox.Text) end
end)
popupBox.FocusLost:Connect(function(enter)
    if enter and popupCallback then popupCallback(popupBox.Text) end
end)

speedBtn.MouseButton1Click:Connect(function()
    showPopup("Speed (16-500)", "16-500", 16, 500, function(v)
        currentSpeed = v
        speedBtn.Text = "Speed: "..v
    end)
end)
jumpBtn.MouseButton1Click:Connect(function()
    showPopup("Jump (5-30)", "5-30", 5, 30, function(v)
        currentJump = v
        jumpBtn.Text = "Jump: "..v
    end)
end)

-- ✅ ФИКС SPEED: Heartbeat-цикл держит скорость и прыжок (игры их сбрасывают)
RunService.Heartbeat:Connect(function()
    local char = player.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    if hum.WalkSpeed ~= currentSpeed then hum.WalkSpeed = currentSpeed end
    if hum.JumpPower ~= currentJump then hum.JumpPower = currentJump end
end)

-- ========== НАВИГАЦИЯ ==========
local function backToMain(f)
    closeFrame(f)
    task.wait(.05)
    openMain()
end

local function openSub(f, w, h)
    menu.Visible = false
    openFrame(f, w, h)
end

icon.Activated:Connect(function()
    if menu.Visible then hideMain() else openMain() end
end)
close.Activated:Connect(hideMain)

espBack.Activated:Connect(function() backToMain(espMenu) end)
playerBack.Activated:Connect(function() backToMain(playerMenu) end)
flyBack.Activated:Connect(function() setFly(false); backToMain(flyMenu) end)
miscBack.Activated:Connect(function() backToMain(miscMenu) end)
tpBack.Activated:Connect(function() backToMain(tpMenu) end)

mainButtons[1].Activated:Connect(function() openSub(espMenu, 340, 400) end)
mainButtons[2].Activated:Connect(function() openSub(playerMenu, 340, 300) end)
mainButtons[3].Activated:Connect(function() openSub(miscMenu, 340, 300) end)

flyBtn.Activated:Connect(function()
    closeFrame(playerMenu)
    task.wait(.05)
    openFrame(flyMenu, 340, 480)
end)

tpPlayerBtn.Activated:Connect(function()
    refreshTPList()
    closeFrame(miscMenu)
    task.wait(.05)
    openFrame(tpMenu, 340, 450)
end)

-- ========== ПЕРЕТАСКИВАНИЕ ИКОНКИ ==========
local dragging, startPos, iconStart = false, nil, nil
icon.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.Touch or inp.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        startPos = inp.Position
        iconStart = icon.Position
    end
end)
UIS.InputChanged:Connect(function(inp)
    if dragging and (inp.UserInputType == Enum.UserInputType.Touch or inp.UserInputType == Enum.UserInputType.MouseMovement) then
        local d = inp.Position - startPos
        icon.Position = UDim2.new(iconStart.X.Scale, iconStart.X.Offset + d.X, iconStart.Y.Scale, iconStart.Y.Offset + d.Y)
    end
end)
UIS.InputEnded:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.Touch or inp.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Применение скорости при респавне
player.CharacterAdded:Connect(function(char)
    task.wait(.5)
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed = currentSpeed
        hum.JumpPower = currentJump
    end
end)

print("PART 2/2 LOADED — ALL SYSTEMS GO")
