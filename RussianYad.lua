-- ===================================================================
-- † ROBLOX MASTER v7.0 — ЧАСТЬ 1/2 (50%) †
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

-- ========== ЗАГРУЗКА (на весь экран) ==========
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

-- ========== ГЛАВНОЕ МЕНЮ ==========
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

local mainButtons = {}
local mainTexts = {"ESP", "PLAYER", "MISC"}
for i,text in ipairs(mainTexts) do
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1,-30,0,60)
    b.Position = UDim2.fromOffset(15,65+(i-1)*70)
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

-- ========== ПОДМЕНЮ ESP ==========
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
espTitle.Text = "ESP (OFF)"
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

local espEnabled = false
local espSettings = {
    boxes = false,
    names = false,
    health = false,
    distance = false
}

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
            espTitle.Text = "ESP ("..(newVal and "ON" or "OFF")..")"
            if not newVal then clearESP() end
        end
    end)
    return frame
end

local yOff = 65
createSwitch(espMenu, yOff, "Enable ESP", function() return espEnabled end, function(v) espEnabled = v end)
yOff = yOff + 50
createSwitch(espMenu, yOff, "Boxes", function() return espSettings.boxes end, function(v) espSettings.boxes = v end)
yOff = yOff + 50
createSwitch(espMenu, yOff, "Names", function() return espSettings.names end, function(v) espSettings.names = v end)
yOff = yOff + 50
createSwitch(espMenu, yOff, "Health", function() return espSettings.health end, function(v) espSettings.health = v end)
yOff = yOff + 50
createSwitch(espMenu, yOff, "Distance", function() return espSettings.distance end, function(v) espSettings.distance = v end)

-- ========== ЛОГИКА ESP ==========
local espObjects = {}
local function clearESP()
    for _, data in pairs(espObjects) do
        if data.box then data.box:Destroy() end
        if data.name then data.name:Destroy() end
        if data.health then data.health:Destroy() end
        if data.dist then data.dist:Destroy() end
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
    box.BackgroundTransparency = 0.5
    box.BorderSizePixel = 2
    box.BorderColor3 = Color3.new(1,1,1)
    box.BackgroundColor3 = Color3.new(0,0,0)
    box.Visible = true
    box.Parent = gui
    local name = Instance.new("TextLabel")
    name.Size = UDim2.fromOffset(150,20)
    name.BackgroundTransparency = 1
    name.Text = target.Name
    name.TextColor3 = Color3.new(1,1,1)
    name.TextSize = 14
    name.Font = Enum.Font.GothamBold
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
    data.box = box; data.name = name; data.health = health; data.dist = dist
    espObjects[target] = data
end

local function updateESP()
    if not espEnabled then clearESP() return end
    local myChar = player.Character
    if not myChar or not myChar.PrimaryPart then return end
    for _, target in ipairs(Players:GetPlayers()) do
        if target ~= player then
            local char = target.Character
            if char and char.PrimaryPart and char:FindFirstChild("Head") then
                local head = char.Head
                local pos = head.Position
                local screenPos, onScreen = Camera:WorldToViewportPoint(pos)
                if onScreen then
                    if not espObjects[target] then createESP(target) end
                    local data = espObjects[target]
                    if data then
                        local size = 2.5 / (pos - Camera.CFrame.Position).Magnitude * 500
                        local boxSize = math.clamp(size, 20, 150)
                        data.box.Size = UDim2.fromOffset(boxSize, boxSize*1.5)
                        data.box.Position = UDim2.new(0, screenPos.X - boxSize/2, 0, screenPos.Y - boxSize*0.75)
                        data.box.BorderColor3 = Color3.new(1,1,1)
                        data.box.Visible = espSettings.boxes
                        data.name.Position = UDim2.new(0, screenPos.X - 75, 0, screenPos.Y - boxSize*0.75 - 20)
                        data.name.Text = target.Name
                        data.name.Visible = espSettings.names
                        local hum = char:FindFirstChildOfClass("Humanoid")
                        if hum and hum.Health > 0 then
                            local hp = hum.Health / hum.MaxHealth
                            data.health.Size = UDim2.fromOffset(boxSize*hp, 4)
                            data.health.Position = UDim2.new(0, screenPos.X - boxSize/2, 0, screenPos.Y + boxSize*0.75 - 10)
                            data.health.BackgroundColor3 = Color3.fromRGB(255*(1-hp), 255*hp, 0)
                            data.health.Visible = espSettings.health
                        else
                            data.health.Visible = false
                        end
                        local distVal = (pos - myChar.PrimaryPart.Position).Magnitude
                        data.dist.Position = UDim2.new(0, screenPos.X - 40, 0, screenPos.Y + boxSize*0.75 + 6)
                        data.dist.Text = string.format("%dm", distVal)
                        data.dist.Visible = espSettings.distance
                    end
                else
                    if espObjects[target] then
                        local data = espObjects[target]
                        if data.box then data.box:Destroy() end
                        if data.name then data.name:Destroy() end
                        if data.health then data.health:Destroy() end
                        if data.dist then data.dist:Destroy() end
                        espObjects[target] = nil
                    end
                end
            end
        end
    end
end

Players.PlayerRemoving:Connect(function(p)
    if espObjects[p] then
        local data = espObjects[p]
        if data.box then data.box:Destroy() end
        if data.name then data.name:Destroy() end
        if data.health then data.health:Destroy() end
        if data.dist then data.dist:Destroy() end
        espObjects[p] = nil
    end
end)

local espConnection = RunService.RenderStepped:Connect(updateESP)

-- † КОНЕЦ ЧАСТИ 1/2 †
print("† ЧАСТЬ 1/2 ЗАГРУЖЕНА †")
-- ===================================================================
-- † ROBLOX MASTER v7.0 — ЧАСТЬ 2/2 (50%) †
-- ===================================================================

-- ========== ПОДМЕНЮ PLAYER ==========
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

local flyEnabled = false
local flyVerticalSpeed = 0
local flyBodyVelocity = nil
local flyConnection = nil
local currentSpeed = 16
local currentJump = 5

local function updateFlyButton()
    if flyEnabled then
        flyBtn.Text = "Fly: ON"
        flyBtn.BackgroundColor3 = Color3.fromRGB(0,200,80)
    else
        flyBtn.Text = "Fly: OFF"
        flyBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
    end
end

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
        flyBodyVelocity.MaxForce = Vector3.new(4000,4000,4000)
        flyBodyVelocity.Velocity = Vector3.new(0,0,0)
        flyBodyVelocity.Parent = root
        hum.PlatformStand = true
        flyVerticalSpeed = 0
        if flyConnection then flyConnection:Disconnect() end
        flyConnection = RunService.Heartbeat:Connect(function()
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

local function changeFlyHeight(delta)
    if not flyEnabled then return end
    flyVerticalSpeed = math.clamp(flyVerticalSpeed + delta, -30, 30)
end

local pY = 65
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

-- ========== ОКНО ВВОДА ==========
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

local popupCallback = nil
function showPopup(title, placeholder, minVal, maxVal, callback)
    popupTitle.Text = title
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
    Tween:Create(inputPopup,TweenInfo.new(.2,Enum.EasingStyle.Back),{
        Size=UDim2.fromOffset(300,250)
    }):Play()
    popupBox:CaptureFocus()
end
function hidePopup()
    Tween:Create(inputPopup,TweenInfo.new(.2),{
        Size=UDim2.fromOffset(0,0)
    }):Play()
    task.wait(.2)
    inputPopup.Visible = false
    popupCallback = nil
end
popupClose.MouseButton1Click:Connect(hidePopup)
popupOk.MouseButton1Click:Connect(function()
    if popupCallback then popupCallback(popupBox.Text) end
end)
popupBox.FocusLost:Connect(function(enter)
    if enter and popupCallback then popupCallback(popupBox.Text) end
end)

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

-- ========== ПОДМЕНЮ MISC ==========
local miscMenu = Instance.new("Frame")
miscMenu.Size = UDim2.fromOffset(0,0)
miscMenu.Position = UDim2.new(.5,-170,.5,-200)
miscMenu.BackgroundColor3 = Color3.fromRGB(18,18,24)
miscMenu.Visible = false
miscMenu.Parent = gui
local miscMc = Instance.new("UICorner",miscMenu)
miscMc.CornerRadius = UDim.new(0,16)

local miscTitle = Instance.new("TextLabel")
miscTitle.Size = UDim2.new(1,-60,0,50)
miscTitle.Position = UDim2.fromOffset(15,5)
miscTitle.BackgroundTransparency = 1
miscTitle.Text = "MISC"
miscTitle.TextColor3 = Color3.new(1,1,1)
miscTitle.TextSize = 20
miscTitle.Font = Enum.Font.GothamBold
miscTitle.TextXAlignment = Enum.TextXAlignment.Left
miscTitle.Parent = miscMenu

local miscBack = Instance.new("TextButton")
miscBack.Size = UDim2.fromOffset(40,40)
miscBack.Position = UDim2.new(1,-48,0,10)
miscBack.BackgroundColor3 = Color3.fromRGB(35,35,40)
miscBack.Text = "<"
miscBack.TextColor3 = Color3.new(1,1,1)
miscBack.TextSize = 24
miscBack.Font = Enum.Font.GothamBold
miscBack.Parent = miscMenu
local miscBackCorner = Instance.new("UICorner",miscBack)
miscBackCorner.CornerRadius = UDim.new(0,10)

local noclipEnabled = false
local noclipConnection = nil
local function toggleNoclip()
    noclipEnabled = not noclipEnabled
    if noclipEnabled then
        noclipConnection = RunService.Heartbeat:Connect(function()
            local char = player.Character
            if char then
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end)
        noclipBtn.Text = "Noclip: ON"
        noclipBtn.BackgroundColor3 = Color3.fromRGB(0,200,80)
    else
        if noclipConnection then noclipConnection:Disconnect(); noclipConnection = nil end
        local char = player.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = true end
            end
        end
        noclipBtn.Text = "Noclip: OFF"
        noclipBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
    end
end

local function teleportToMouse()
    local mouse = player:GetMouse()
    if mouse and mouse.Hit then
        local pos = mouse.Hit.Position
        local char = player.Character
        if char and char.PrimaryPart then
            char.PrimaryPart.CFrame = CFrame.new(pos)
        end
    end
end

local mY = 65
local noclipBtn = Instance.new("TextButton")
noclipBtn.Size = UDim2.new(1,-30,0,55)
noclipBtn.Position = UDim2.fromOffset(15, mY)
noclipBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
noclipBtn.Text = "Noclip: OFF"
noclipBtn.TextColor3 = Color3.new(1,1,1)
noclipBtn.TextSize = 18
noclipBtn.Font = Enum.Font.GothamBold
noclipBtn.Parent = miscMenu
local noclipCorner = Instance.new("UICorner",noclipBtn)
noclipCorner.CornerRadius = UDim.new(0,11)
noclipBtn.MouseButton1Click:Connect(toggleNoclip)

mY = mY + 70
local tpBtn = Instance.new("TextButton")
tpBtn.Size = UDim2.new(1,-30,0,55)
tpBtn.Position = UDim2.fromOffset(15, mY)
tpBtn.BackgroundColor3 = Color3.fromRGB(28,28,35)
tpBtn.Text = "TP to Mouse"
tpBtn.TextColor3 = Color3.new(1,1,1)
tpBtn.TextSize = 18
tpBtn.Font = Enum.Font.GothamBold
tpBtn.Parent = miscMenu
local tpCorner = Instance.new("UICorner",tpBtn)
tpCorner.CornerRadius = UDim.new(0,11)
tpBtn.MouseButton1Click:Connect(teleportToMouse)

-- ========== УПРАВЛЕНИЕ МЕНЮ ==========
function openMain()
    menu.Visible = true
    menu.Size = UDim2.fromOffset(270,270)
    Tween:Create(menu,TweenInfo.new(.2,Enum.EasingStyle.Back),{Size=UDim2.fromOffset(300,300)}):Play()
end
function hideMain()
    menu.Visible = false
end
function openESP()
    espMenu.Visible = true
    espMenu.Size = UDim2.fromOffset(0,0)
    Tween:Create(espMenu,TweenInfo.new(.25,Enum.EasingStyle.Back),{Size=UDim2.fromOffset(340,400)}):Play()
    hideMain()
end
function hideESP()
    Tween:Create(espMenu,TweenInfo.new(.2),{Size=UDim2.fromOffset(0,0)}):Play()
    task.wait(.2)
    espMenu.Visible = false
    openMain()
end
function openPlayer()
    playerMenu.Visible = true
    playerMenu.Size = UDim2.fromOffset(0,0)
    Tween:Create(playerMenu,TweenInfo.new(.25,Enum.EasingStyle.Back),{Size=UDim2.fromOffset(340,480)}):Play()
    hideMain()
end
function hidePlayer()
    Tween:Create(playerMenu,TweenInfo.new(.2),{Size=UDim2.fromOffset(0,0)}):Play()
    task.wait(.2)
    playerMenu.Visible = false
    openMain()
end
function openMisc()
    miscMenu.Visible = true
    miscMenu.Size = UDim2.fromOffset(0,0)
    Tween:Create(miscMenu,TweenInfo.new(.25,Enum.EasingStyle.Back),{Size=UDim2.fromOffset(340,250)}):Play()
    hideMain()
end
function hideMisc()
    Tween:Create(miscMenu,TweenInfo.new(.2),{Size=UDim2.fromOffset(0,0)}):Play()
    task.wait(.2)
    miscMenu.Visible = false
    openMain()
end

icon.Activated:Connect(openMain)
close.Activated:Connect(hideMain)
espBack.Activated:Connect(hideESP)
playerBack.Activated:Connect(hidePlayer)
miscBack.Activated:Connect(hideMisc)
mainButtons[1].Activated:Connect(openESP)
mainButtons[2].Activated:Connect(openPlayer)
mainButtons[3].Activated:Connect(openMisc)

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
        icon.Position=UDim2.new(pos.X.Scale,pos.X.Offset+d.X,pos.Y.Scale,pos.Y.Offset+d.Y)
    end
end)
UIS.InputEnded:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.Touch
    or input.UserInputType==Enum.UserInputType.MouseButton1 then
        dragging=false
    end
end)

-- ========== ПРИМЕНЕНИЕ ПРИ ЗАХОДЕ ==========
player.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed = currentSpeed
        hum.JumpPower = currentJump
    end
end)
if player.Character then
    task.wait(0.5)
    local hum = player.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed = currentSpeed
        hum.JumpPower = currentJump
    end
end

print("† ЧАСТЬ 2/2 ЗАГРУЖЕНА. АБСОЛЮТНЫЙ ИНЖЕКТОР АКТИВЕН. †")
