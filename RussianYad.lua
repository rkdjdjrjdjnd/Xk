-- ===================================================================
-- ROBLOX MASTER v7.0 — ЧАСТЬ 1/3
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

-- ЗАГРУЗКА
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

-- ИКОНКА
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

-- ХЕЛПЕРЫ
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

-- ГЛАВНОЕ МЕНЮ
local menu = Instance.new("Frame")
menu.Size = UDim2.fromOffset(300,390)
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
for i,text in ipairs({"ESP","PLAYER","AIMBOT","MISC"}) do
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
    Tween:Create(menu, TweenInfo.new(.28, Enum.EasingStyle.Back), {Size = UDim2.fromOffset(300,390)}):Play()
end
local function hideMain()
    Tween:Create(menu, TweenInfo.new(.18), {Size = UDim2.fromOffset(0,0)}):Play()
    task.wait(.18)
    menu.Visible = false
end

-- ESP
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

local clearESP

createSwitch(espMenu, 60, "Enable ESP", function() return espEnabled end, function(v) espEnabled = v end, function(v) espTitle.Text = "ESP ("..(v and "ON" or "OFF")..")"; if not v and clearESP then clearESP() end end)
createSwitch(espMenu, 105, "Boxes", function() return espSettings.boxes end, function(v) espSettings.boxes = v end)
createSwitch(espMenu, 150, "Names", function() return espSettings.names end, function(v) espSettings.names = v end)
createSwitch(espMenu, 195, "Health", function() return espSettings.health end, function(v) espSettings.health = v end)
createSwitch(espMenu, 240, "Distance", function() return espSettings.distance end, function(v) espSettings.distance = v end)

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

print("PART 1/3 LOADED")

-- ===================================================================
-- ROBLOX MASTER v7.0 — ЧАСТЬ 2/3
-- ===================================================================

-- ========== УНИВЕРСАЛЬНОЕ ОКНО ВВОДА ==========
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
popupBox.PlaceholderText = "Введи число..."
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
local function showPopup(titleTxt, placeholder, callback)
    popupTitle.Text = titleTxt
    popupBox.PlaceholderText = placeholder
    popupBox.Text = ""
    popupCallback = function(input)
        local num = tonumber(input)
        if num then callback(num); hidePopup()
        else
            popupBox.Text = ""
            popupBox.PlaceholderText = "Не число!"
        end
    end
    inputPopup.Visible = true
    inputPopup.Size = UDim2.fromOffset(0,0)
    Tween:Create(inputPopup, TweenInfo.new(.22, Enum.EasingStyle.Back), {Size = UDim2.fromOffset(300,225)}):Play()
    task.wait(.05)
    popupBox:CaptureFocus()
end
popupClose.MouseButton1Click:Connect(hidePopup)
popupOk.MouseButton1Click:Connect(function() if popupCallback then popupCallback(popupBox.Text) end end)
popupBox.FocusLost:Connect(function(enter) if enter and popupCallback then popupCallback(popupBox.Text) end end)

-- ========== PLAYER ==========
local playerMenu, playerTitle, playerBack = createSubmenu("PLAYER")

local currentSpeed = 16
local infiniteJump = false

local speedBtn = Instance.new("TextButton")
speedBtn.Size = UDim2.new(1,-30,0,55)
speedBtn.Position = UDim2.fromOffset(15,65)
speedBtn.BackgroundColor3 = Color3.fromRGB(28,28,35)
speedBtn.Text = "Speed: 16"
speedBtn.TextColor3 = Color3.new(1,1,1)
speedBtn.TextSize = 18
speedBtn.Font = Enum.Font.GothamBold
speedBtn.Parent = playerMenu
Instance.new("UICorner",speedBtn).CornerRadius = UDim.new(0,11)
speedBtn.MouseButton1Click:Connect(function()
    showPopup("Speed (1-500)", "1-500", function(v)
        currentSpeed = v
        speedBtn.Text = "Speed: "..math.floor(v)
    end)
end)

local infJumpBtn = Instance.new("TextButton")
infJumpBtn.Size = UDim2.new(1,-30,0,55)
infJumpBtn.Position = UDim2.fromOffset(15,130)
infJumpBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
infJumpBtn.Text = "Infinite Jump: OFF"
infJumpBtn.TextColor3 = Color3.new(1,1,1)
infJumpBtn.TextSize = 17
infJumpBtn.Font = Enum.Font.GothamBold
infJumpBtn.Parent = playerMenu
Instance.new("UICorner",infJumpBtn).CornerRadius = UDim.new(0,11)
infJumpBtn.MouseButton1Click:Connect(function()
    infiniteJump = not infiniteJump
    infJumpBtn.Text = "Infinite Jump: "..(infiniteJump and "ON" or "OFF")
    infJumpBtn.BackgroundColor3 = infiniteJump and Color3.fromRGB(0,200,80) or Color3.fromRGB(80,80,80)
end)
UIS.JumpRequest:Connect(function()
    if infiniteJump then
        local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

local flyBtn = Instance.new("TextButton")
flyBtn.Size = UDim2.new(1,-30,0,60)
flyBtn.Position = UDim2.fromOffset(15,195)
flyBtn.BackgroundColor3 = Color3.fromRGB(40,80,200)
flyBtn.Text = "Fly"
flyBtn.TextColor3 = Color3.new(1,1,1)
flyBtn.TextSize = 18
flyBtn.Font = Enum.Font.GothamBold
flyBtn.Parent = playerMenu
Instance.new("UICorner",flyBtn).CornerRadius = UDim.new(0,11)

-- ========== FLY (СТОИТ РОВНО, БЕЗ ОПИСАНИЯ) ==========
local flyMenu, flyTitle, flyBack = createSubmenu("FLY")

local flyEnabled = false
local flySpeed = 60
local flyBodyVelocity = nil
local flyBodyGyro = nil
local flyConnection = nil

local flyToggle = Instance.new("TextButton")
flyToggle.Size = UDim2.fromOffset(90,40)
flyToggle.Position = UDim2.new(1,-140,0,14)
flyToggle.BackgroundColor3 = Color3.fromRGB(80,80,80)
flyToggle.Text = "OFF"
flyToggle.TextColor3 = Color3.new(1,1,1)
flyToggle.TextSize = 16
flyToggle.Font = Enum.Font.GothamBold
flyToggle.Parent = flyMenu
Instance.new("UICorner",flyToggle).CornerRadius = UDim.new(0,10)

local function stopFly()
    if flyBodyVelocity then flyBodyVelocity:Destroy(); flyBodyVelocity = nil end
    if flyBodyGyro then flyBodyGyro:Destroy(); flyBodyGyro = nil end
    if flyConnection then flyConnection:Disconnect(); flyConnection = nil end
    local char = player.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.PlatformStand = false; hum.AutoRotate = true end
    end
end

local function startFly()
    local char = player.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local root = char.PrimaryPart
    if not hum or not root then return end

    flyBodyVelocity = Instance.new("BodyVelocity")
    flyBodyVelocity.MaxForce = Vector3.new(1e5,1e5,1e5)
    flyBodyVelocity.Velocity = Vector3.new(0,0,0)
    flyBodyVelocity.Parent = root

    -- BodyGyro держит ориентацию ровно
    flyBodyGyro = Instance.new("BodyGyro")
    flyBodyGyro.MaxTorque = Vector3.new(1e5,1e5,1e5)
    flyBodyGyro.P = 10000
    flyBodyGyro.D = 500
    flyBodyGyro.CFrame = root.CFrame
    flyBodyGyro.Parent = root

    hum.PlatformStand = true
    hum.AutoRotate = false

    flyConnection = RunService.Heartbeat:Connect(function()
        if not flyEnabled or not flyBodyVelocity or not flyBodyGyro then return end
        local c = player.Character
        if not c or not c.PrimaryPart then return end
        local h = c:FindFirstChildOfClass("Humanoid")
        if not h then return end

        -- Держим гироскоп — персонаж НЕ крутится
        local cam = workspace.CurrentCamera
        flyBodyGyro.CFrame = CFrame.new(c.PrimaryPart.Position, c.PrimaryPart.Position + cam.CFrame.LookVector)

        if h.MoveDirection.Magnitude > 0.1 then
            flyBodyVelocity.Velocity = cam.CFrame.LookVector * flySpeed
        else
            flyBodyVelocity.Velocity = Vector3.new(0,0,0)
        end
    end)
end

local function setFly(on)
    flyEnabled = on
    if on then startFly() else stopFly() end
    flyToggle.Text = on and "ON" or "OFF"
    flyToggle.BackgroundColor3 = on and Color3.fromRGB(0,200,80) or Color3.fromRGB(80,80,80)
    flyBtn.Text = on and "Fly: ON" or "Fly"
    flyBtn.BackgroundColor3 = on and Color3.fromRGB(0,200,80) or Color3.fromRGB(40,80,200)
end
flyToggle.MouseButton1Click:Connect(function() setFly(not flyEnabled) end)

local flySpeedBtn = Instance.new("TextButton")
flySpeedBtn.Size = UDim2.new(1,-30,0,55)
flySpeedBtn.Position = UDim2.fromOffset(15,80)
flySpeedBtn.BackgroundColor3 = Color3.fromRGB(28,28,35)
flySpeedBtn.Text = "Fly Speed: 60"
flySpeedBtn.TextColor3 = Color3.new(1,1,1)
flySpeedBtn.TextSize = 17
flySpeedBtn.Font = Enum.Font.GothamBold
flySpeedBtn.Parent = flyMenu
Instance.new("UICorner",flySpeedBtn).CornerRadius = UDim.new(0,11)
flySpeedBtn.MouseButton1Click:Connect(function()
    showPopup("Fly Speed (1-1000)", "1-1000", function(v)
        flySpeed = v
        flySpeedBtn.Text = "Fly Speed: "..math.floor(v)
    end)
end)

-- ========== AIMBOT (РЕЗКИЙ + КРУГ + МЕТРЫ) ==========
local aimbotMenu, aimbotTitle, aimbotBack = createSubmenu("AIMBOT")

local aimbotEnabled = false
local aimbotRadius = 120
local aimbotTeamCheck = true
local aimbotPart = "Head"

-- FOV КРУГ
local fovCircle = Instance.new("Frame")
fovCircle.Size = UDim2.fromOffset(aimbotRadius*2, aimbotRadius*2)
fovCircle.Position = UDim2.new(0.5, -aimbotRadius, 0.5, -aimbotRadius)
fovCircle.BackgroundTransparency = 1
fovCircle.BorderSizePixel = 2
fovCircle.BorderColor3 = Color3.fromRGB(255,80,80)
fovCircle.Visible = false
fovCircle.ZIndex = 5
fovCircle.Parent = gui
Instance.new("UICorner",fovCircle).CornerRadius = UDim.new(1,0)

-- Подпись радиуса (пиксели + метры)
local fovLabel = Instance.new("TextLabel")
fovLabel.Size = UDim2.fromOffset(200,20)
fovLabel.Position = UDim2.new(0.5, -100, 0.5, aimbotRadius + 10)
fovLabel.BackgroundTransparency = 1
fovLabel.Text = "120px (~0m)"
fovLabel.TextColor3 = Color3.fromRGB(255,80,80)
fovLabel.TextSize = 13
fovLabel.Font = Enum.Font.GothamBold
fovLabel.TextStrokeTransparency = 0.5
fovLabel.Visible = false
fovLabel.ZIndex = 6
fovLabel.Parent = gui

local function pxToMeters(px)
    -- Приблизительно: 1м ≈ 3.5 px на среднем экране
    return math.floor(px / 3.5)
end

local function updateFovCircle()
    fovCircle.Size = UDim2.fromOffset(aimbotRadius*2, aimbotRadius*2)
    fovCircle.Position = UDim2.new(0.5, -aimbotRadius, 0.5, -aimbotRadius)
    fovCircle.Visible = aimbotEnabled
    fovLabel.Position = UDim2.new(0.5, -100, 0.5, aimbotRadius + 10)
    fovLabel.Text = aimbotRadius.."px (~"..pxToMeters(aimbotRadius).."m)"
    fovLabel.Visible = aimbotEnabled
end

local aimbotToggle = Instance.new("TextButton")
aimbotToggle.Size = UDim2.new(1,-30,0,50)
aimbotToggle.Position = UDim2.fromOffset(15,60)
aimbotToggle.BackgroundColor3 = Color3.fromRGB(80,80,80)
aimbotToggle.Text = "Aimbot: OFF"
aimbotToggle.TextColor3 = Color3.new(1,1,1)
aimbotToggle.TextSize = 17
aimbotToggle.Font = Enum.Font.GothamBold
aimbotToggle.Parent = aimbotMenu
Instance.new("UICorner",aimbotToggle).CornerRadius = UDim.new(0,11)
aimbotToggle.MouseButton1Click:Connect(function()
    aimbotEnabled = not aimbotEnabled
    aimbotToggle.Text = "Aimbot: "..(aimbotEnabled and "ON" or "OFF")
    aimbotToggle.BackgroundColor3 = aimbotEnabled and Color3.fromRGB(0,200,80) or Color3.fromRGB(80,80,80)
    updateFovCircle()
end)

local aimbotRadiusBtn = Instance.new("TextButton")
aimbotRadiusBtn.Size = UDim2.new(1,-30,0,50)
aimbotRadiusBtn.Position = UDim2.fromOffset(15,118)
aimbotRadiusBtn.BackgroundColor3 = Color3.fromRGB(28,28,35)
aimbotRadiusBtn.Text = "Радиус: 120px (~34m)"
aimbotRadiusBtn.TextColor3 = Color3.new(1,1,1)
aimbotRadiusBtn.TextSize = 16
aimbotRadiusBtn.Font = Enum.Font.GothamBold
aimbotRadiusBtn.Parent = aimbotMenu
Instance.new("UICorner",aimbotRadiusBtn).CornerRadius = UDim.new(0,11)
aimbotRadiusBtn.MouseButton1Click:Connect(function()
    showPopup("Aimbot Радиус (20-500)", "20-500", function(v)
        aimbotRadius = v
        aimbotRadiusBtn.Text = "Радиус: "..math.floor(v).."px (~"..pxToMeters(v).."m)"
        updateFovCircle()
    end)
end)

local aimbotPartBtn = Instance.new("TextButton")
aimbotPartBtn.Size = UDim2.new(1,-30,0,50)
aimbotPartBtn.Position = UDim2.fromOffset(15,176)
aimbotPartBtn.BackgroundColor3 = Color3.fromRGB(28,28,35)
aimbotPartBtn.Text = "Часть: Head"
aimbotPartBtn.TextColor3 = Color3.new(1,1,1)
aimbotPartBtn.TextSize = 17
aimbotPartBtn.Font = Enum.Font.GothamBold
aimbotPartBtn.Parent = aimbotMenu
Instance.new("UICorner",aimbotPartBtn).CornerRadius = UDim.new(0,11)
aimbotPartBtn.MouseButton1Click:Connect(function()
    aimbotPart = (aimbotPart == "Head") and "Torso" or "Head"
    aimbotPartBtn.Text = "Часть: "..aimbotPart
end)

local aimbotTeamBtn = Instance.new("TextButton")
aimbotTeamBtn.Size = UDim2.new(1,-30,0,50)
aimbotTeamBtn.Position = UDim2.fromOffset(15,234)
aimbotTeamBtn.BackgroundColor3 = Color3.fromRGB(0,200,80)
aimbotTeamBtn.Text = "Team Check: ON"
aimbotTeamBtn.TextColor3 = Color3.new(1,1,1)
aimbotTeamBtn.TextSize = 17
aimbotTeamBtn.Font = Enum.Font.GothamBold
aimbotTeamBtn.Parent = aimbotMenu
Instance.new("UICorner",aimbotTeamBtn).CornerRadius = UDim.new(0,11)
aimbotTeamBtn.MouseButton1Click:Connect(function()
    aimbotTeamCheck = not aimbotTeamCheck
    aimbotTeamBtn.Text = "Team Check: "..(aimbotTeamCheck and "ON" or "OFF")
    aimbotTeamBtn.BackgroundColor3 = aimbotTeamCheck and Color3.fromRGB(0,200,80) or Color3.fromRGB(80,80,80)
end)

-- Логика AIMBOT — МГНОВЕННОЕ наведение
RunService.RenderStepped:Connect(function()
    if not aimbotEnabled then return end
    local myChar = player.Character
    if not myChar or not myChar:FindFirstChild("Head") then return end

    local center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    local closestPart = nil
    local closestDist = aimbotRadius

    for _, target in ipairs(Players:GetPlayers()) do
        if target ~= player then
            if not (aimbotTeamCheck and target.Team and player.Team and target.Team == player.Team) then
                local char = target.Character
                if char and char.PrimaryPart then
                    local part = char:FindFirstChild(aimbotPart) or char:FindFirstChild("Head")
                    if part then
                        local sp, onScreen = Camera:WorldToViewportPoint(part.Position)
                        if onScreen then
                            local d = (Vector2.new(sp.X, sp.Y) - center).Magnitude
                            if d < closestDist then
                                closestDist = d
                                closestPart = part
                            end
                        end
                    end
                end
            end
        end
    end

    if closestPart then
        -- РЕЗКОЕ наведение (мгновенно)
        Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, closestPart.Position)
    end
end)

print("PART 2/3 LOADED")

-- ===================================================================
-- ROBLOX MASTER v7.0 — ЧАСТЬ 3/3
-- ===================================================================

local Lighting = game:GetService("Lighting")

-- DRAG
local function makeDraggable(frame, dragArea)
    local dragging, startPos, startAbs = false, nil, nil
    dragArea.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.Touch or inp.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            startPos = inp.Position
            startAbs = frame.AbsolutePosition
            frame.AnchorPoint = Vector2.new(0,0)
            frame.Position = UDim2.fromOffset(startAbs.X, startAbs.Y)
        end
    end)
    UIS.InputChanged:Connect(function(inp)
        if dragging and (inp.UserInputType == Enum.UserInputType.Touch or inp.UserInputType == Enum.UserInputType.MouseMovement) then
            local d = inp.Position - startPos
            frame.Position = UDim2.fromOffset(startAbs.X + d.X, startAbs.Y + d.Y)
        end
    end)
    UIS.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.Touch or inp.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

-- MISC
local miscMenu, miscTitle, miscBack = createSubmenu("MISC")

local noclipEnabled = false
local noclipConn = nil
local antiAfkEnabled = false
local antiAfkConn = nil
local fullbrightEnabled = false
local origLighting = {Ambient = Lighting.Ambient, Outdoor = Lighting.OutdoorAmbient, Brightness = Lighting.Brightness}
local hitboxEnabled = false
local hitboxConn = nil

local noclipBtn = Instance.new("TextButton")
noclipBtn.Size = UDim2.new(1,-30,0,48)
noclipBtn.Position = UDim2.fromOffset(15,60)
noclipBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
noclipBtn.Text = "Noclip: OFF"
noclipBtn.TextColor3 = Color3.new(1,1,1)
noclipBtn.TextSize = 16
noclipBtn.Font = Enum.Font.GothamBold
noclipBtn.Parent = miscMenu
Instance.new("UICorner",noclipBtn).CornerRadius = UDim.new(0,11)
noclipBtn.MouseButton1Click:Connect(function()
    noclipEnabled = not noclipEnabled
    if noclipEnabled then
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
end)

local antiAfkBtn = Instance.new("TextButton")
antiAfkBtn.Size = UDim2.new(1,-30,0,48)
antiAfkBtn.Position = UDim2.fromOffset(15,114)
antiAfkBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
antiAfkBtn.Text = "Anti-AFK: OFF"
antiAfkBtn.TextColor3 = Color3.new(1,1,1)
antiAfkBtn.TextSize = 16
antiAfkBtn.Font = Enum.Font.GothamBold
antiAfkBtn.Parent = miscMenu
Instance.new("UICorner",antiAfkBtn).CornerRadius = UDim.new(0,11)
antiAfkBtn.MouseButton1Click:Connect(function()
    antiAfkEnabled = not antiAfkEnabled
    if antiAfkEnabled then
        antiAfkConn = RunService.Heartbeat:Connect(function()
            local vim = game:GetService("VirtualUser")
            vim:CaptureController()
            vim:ClickButton2(Vector2.new())
        end)
        antiAfkBtn.Text = "Anti-AFK: ON"
        antiAfkBtn.BackgroundColor3 = Color3.fromRGB(0,200,80)
    else
        if antiAfkConn then antiAfkConn:Disconnect(); antiAfkConn = nil end
        antiAfkBtn.Text = "Anti-AFK: OFF"
        antiAfkBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
    end
end)

local fullbrightBtn = Instance.new("TextButton")
fullbrightBtn.Size = UDim2.new(1,-30,0,48)
fullbrightBtn.Position = UDim2.fromOffset(15,168)
fullbrightBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
fullbrightBtn.Text = "Fullbright: OFF"
fullbrightBtn.TextColor3 = Color3.new(1,1,1)
fullbrightBtn.TextSize = 16
fullbrightBtn.Font = Enum.Font.GothamBold
fullbrightBtn.Parent = miscMenu
Instance.new("UICorner",fullbrightBtn).CornerRadius = UDim.new(0,11)
fullbrightBtn.MouseButton1Click:Connect(function()
    fullbrightEnabled = not fullbrightEnabled
    if fullbrightEnabled then
        Lighting.Ambient = Color3.fromRGB(255,255,255)
        Lighting.OutdoorAmbient = Color3.fromRGB(255,255,255)
        Lighting.Brightness = 3
        fullbrightBtn.Text = "Fullbright: ON"
        fullbrightBtn.BackgroundColor3 = Color3.fromRGB(0,200,80)
    else
        Lighting.Ambient = origLighting.Ambient
        Lighting.OutdoorAmbient = origLighting.Outdoor
        Lighting.Brightness = origLighting.Brightness
        fullbrightBtn.Text = "Fullbright: OFF"
        fullbrightBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
    end
end)

local hitboxBtn = Instance.new("TextButton")
hitboxBtn.Size = UDim2.new(1,-30,0,48)
hitboxBtn.Position = UDim2.fromOffset(15,222)
hitboxBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
hitboxBtn.Text = "Hitbox Expand: OFF"
hitboxBtn.TextColor3 = Color3.new(1,1,1)
hitboxBtn.TextSize = 16
hitboxBtn.Font = Enum.Font.GothamBold
hitboxBtn.Parent = miscMenu
Instance.new("UICorner",hitboxBtn).CornerRadius = UDim.new(0,11)
hitboxBtn.MouseButton1Click:Connect(function()
    hitboxEnabled = not hitboxEnabled
    if hitboxEnabled then
        hitboxConn = RunService.Heartbeat:Connect(function()
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= player and p.Character then
                    for _, part in ipairs(p.Character:GetDescendants()) do
                        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                            part.Size = Vector3.new(10,10,10)
                            part.Transparency = 0.7
                            part.CanCollide = false
                            part.Massless = true
                        end
                    end
                end
            end
        end)
        hitboxBtn.Text = "Hitbox Expand: ON"
        hitboxBtn.BackgroundColor3 = Color3.fromRGB(0,200,80)
    else
        if hitboxConn then hitboxConn:Disconnect(); hitboxConn = nil end
        hitboxBtn.Text = "Hitbox Expand: OFF"
        hitboxBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
    end
end)

local tpMouseBtn = Instance.new("TextButton")
tpMouseBtn.Size = UDim2.new(1,-30,0,48)
tpMouseBtn.Position = UDim2.fromOffset(15,276)
tpMouseBtn.BackgroundColor3 = Color3.fromRGB(28,28,35)
tpMouseBtn.Text = "TP to Mouse"
tpMouseBtn.TextColor3 = Color3.new(1,1,1)
tpMouseBtn.TextSize = 16
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
tpPlayerBtn.Size = UDim2.new(1,-30,0,48)
tpPlayerBtn.Position = UDim2.fromOffset(15,330)
tpPlayerBtn.BackgroundColor3 = Color3.fromRGB(28,28,35)
tpPlayerBtn.Text = "TP to Player"
tpPlayerBtn.TextColor3 = Color3.new(1,1,1)
tpPlayerBtn.TextSize = 16
tpPlayerBtn.Font = Enum.Font.GothamBold
tpPlayerBtn.Parent = miscMenu
Instance.new("UICorner",tpPlayerBtn).CornerRadius = UDim.new(0,11)

-- TP TO PLAYER
local tpMenu, tpTitle, tpBack = createSubmenu("TP TO PLAYER")

local tpScroll = Instance.new("ScrollingFrame")
tpScroll.Size = UDim2.new(1,-20,1,-70)
tpScroll.Position = UDim2.fromOffset(10,60)
tpScroll.BackgroundTransparency = 1
tpScroll.BorderSizePixel = 0
tpScroll.ScrollBarThickness = 5
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
            btn.Size = UDim2.new(1,-10,0,50)
            btn.Position = UDim2.fromOffset(0,y)
            btn.BackgroundColor3 = Color3.fromRGB(28,28,35)
            btn.Text = p.Name
            btn.TextColor3 = Color3.new(1,1,1)
            btn.TextSize = 15
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
            y = y + 55
        end
    end
    if count == 0 then
        local none = Instance.new("TextLabel")
        none.Size = UDim2.new(1,-10,0,40)
        none.BackgroundTransparency = 1
        none.Text = "Нет игроков"
        none.TextColor3 = Color3.fromRGB(150,150,150)
        none.TextSize = 15
        none.Font = Enum.Font.Gotham
        none.Parent = tpScroll
        y = 40
    end
    tpScroll.CanvasSize = UDim2.new(0,0,0,y)
end

-- FIX SPEED
RunService.Heartbeat:Connect(function()
    local char = player.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    if hum.WalkSpeed ~= currentSpeed then hum.WalkSpeed = currentSpeed end
end)

-- НАВИГАЦИЯ
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
aimbotBack.Activated:Connect(function() backToMain(aimbotMenu) end)
miscBack.Activated:Connect(function() backToMain(miscMenu) end)
tpBack.Activated:Connect(function() backToMain(tpMenu) end)

mainButtons[1].Activated:Connect(function() openSub(espMenu, 340, 400) end)
mainButtons[2].Activated:Connect(function() openSub(playerMenu, 340, 280) end)
mainButtons[3].Activated:Connect(function() openSub(aimbotMenu, 340, 300) end)
mainButtons[4].Activated:Connect(function() openSub(miscMenu, 340, 400) end)

flyBtn.Activated:Connect(function()
    closeFrame(playerMenu)
    task.wait(.05)
    openFrame(flyMenu, 340, 160)
end)

tpPlayerBtn.Activated:Connect(function()
    refreshTPList()
    closeFrame(miscMenu)
    task.wait(.05)
    openFrame(tpMenu, 260, 340)
end)

-- DRAGGABLE
makeDraggable(menu, title)
makeDraggable(espMenu, espTitle)
makeDraggable(playerMenu, playerTitle)
makeDraggable(flyMenu, flyTitle)
makeDraggable(aimbotMenu, aimbotTitle)
makeDraggable(miscMenu, miscTitle)
makeDraggable(tpMenu, tpTitle)
makeDraggable(inputPopup, popupTitle)

-- DRAG ИКОНКИ
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

player.CharacterAdded:Connect(function(char)
    task.wait(.5)
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = currentSpeed end
end)

updateFovCircle()

print("PART 3/3 LOADED — ALL SYSTEMS GO")
