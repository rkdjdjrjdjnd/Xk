-- ===================================================================
-- ROBLOX MASTER v7.0 — ЧАСТЬ 1/3
-- ===================================================================

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local Tween = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local player = Players.LocalPlayer

-- ========== ЯЗЫК ==========
local currentLang = "EN"

local LANG = {
    EN = {
        title = "AD MENU", esp = "ESP", player = "PLAYER", aimbot = "AIMBOT", misc = "MISC", settings = "SETTINGS",
        enable_esp = "Enable ESP", boxes = "Boxes", names = "Names", health = "Health", distance = "Distance",
        speed = "Speed", infinite_jump = "Infinite Jump", fly = "Fly", fly_on = "Fly: ON", fly_off = "Fly: OFF",
        fly_speed = "Fly Speed", on = "ON", off = "OFF",
        aimbot_on = "Aimbot: ON", aimbot_off = "Aimbot: OFF", radius = "Radius", part = "Part", team_check = "Team Check",
        fov = "FOV", range = "Range", fov_circle = "FOV Circle",
        noclip = "Noclip", fullbright = "Fullbright", tp_player = "TP to Player",
        fast_click = "Fast Click", fast_click_on = "Fast Click: ON", fast_click_off = "Fast Click: OFF",
        click_delay = "Click Delay",
        no_players = "No players", ok = "OK", enter_value = "Enter value...", not_number = "Not a number!",
    },
    RU = {
        title = "AD МЕНЮ", esp = "ESP", player = "ИГРОК", aimbot = "АИМБОТ", misc = "РАЗНОЕ", settings = "НАСТРОЙКИ",
        enable_esp = "Включить ESP", boxes = "Рамки", names = "Имена", health = "Здоровье", distance = "Дистанция",
        speed = "Скорость", infinite_jump = "Беск. прыжок", fly = "Полёт", fly_on = "Полёт: ВКЛ", fly_off = "Полёт: ВЫКЛ",
        fly_speed = "Скорость полёта", on = "ВКЛ", off = "ВЫКЛ",
        aimbot_on = "Аимбот: ВКЛ", aimbot_off = "Аимбот: ВЫКЛ", radius = "Радиус", part = "Часть", team_check = "Проверка команды",
        fov = "ФОВ", range = "Дальность", fov_circle = "Круг ФОВ",
        noclip = "Сквозь стены", fullbright = "Яркость", tp_player = "ТП к игроку",
        fast_click = "Фаст клик", fast_click_on = "Фаст клик: ВКЛ", fast_click_off = "Фаст клик: ВЫКЛ",
        click_delay = "Задержка клика",
        no_players = "Нет игроков", ok = "ОК", enter_value = "Введи число...", not_number = "Не число!",
    }
}

local function T(key)
    return LANG[currentLang][key] or key
end

local gui = Instance.new("ScreenGui")
gui.Name = "ADMenu"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = player:WaitForChild("PlayerGui")

-- ========== ЗАГРУЗКА ==========
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

-- ========== ГЛАВНОЕ МЕНЮ (5 кнопок) ==========
local menu = Instance.new("Frame")
menu.Size = UDim2.fromOffset(300,395)
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
title.Text = T("title")
title.TextColor3 = Color3.new(1,1,1)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = menu
title:SetAttribute("langKey", "title")

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
local mainKeys = {"esp","player","aimbot","misc","settings"}
for i,key in ipairs(mainKeys) do
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1,-30,0,55)
    b.Position = UDim2.fromOffset(15,60+(i-1)*62)
    b.BackgroundColor3 = (key == "settings") and Color3.fromRGB(40,50,90) or Color3.fromRGB(28,28,35)
    b.Text = T(key)
    b.TextColor3 = Color3.new(1,1,1)
    b.TextSize = 17
    b.Font = Enum.Font.GothamBold
    b.Parent = menu
    Instance.new("UICorner",b).CornerRadius = UDim.new(0,11)
    b:SetAttribute("langKey", key)
    mainButtons[i] = b
end

local function openMain()
    menu.Visible = true
    menu.Size = UDim2.fromOffset(0,0)
    Tween:Create(menu, TweenInfo.new(.28, Enum.EasingStyle.Back), {Size = UDim2.fromOffset(300,395)}):Play()
end
local function hideMain()
    Tween:Create(menu, TweenInfo.new(.18), {Size = UDim2.fromOffset(0,0)}):Play()
    task.wait(.18)
    menu.Visible = false
end

-- ========== ESP (с ❤️ здоровьем) ==========
local espMenu, espTitle, espBack = createSubmenu(T("esp").." (OFF)")

local espEnabled = false
local espSettings = {boxes=false, names=false, health=false, distance=false}

local function createSwitch(parent, y, labelKey, getter, setter, onChange)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1,-30,0,32)
    frame.Position = UDim2.fromOffset(15,y)
    frame.BackgroundTransparency = 1
    frame.Parent = parent
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.65,0,1,0)
    label.BackgroundTransparency = 1
    label.Text = T(labelKey)
    label.TextColor3 = Color3.new(1,1,1)
    label.TextSize = 15
    label.Font = Enum.Font.GothamSemibold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    label:SetAttribute("langKey", labelKey)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0,55,0,26)
    btn.Position = UDim2.new(1,-60,0.5,-13)
    btn.BackgroundColor3 = getter() and Color3.fromRGB(0,200,80) or Color3.fromRGB(80,80,80)
    btn.Text = getter() and T("on") or T("off")
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextSize = 13
    btn.Font = Enum.Font.GothamBold
    btn.AutoButtonColor = false
    btn.Parent = frame
    Instance.new("UICorner",btn).CornerRadius = UDim.new(0,8)
    btn.MouseButton1Click:Connect(function()
        local nv = not getter()
        setter(nv)
        btn.BackgroundColor3 = nv and Color3.fromRGB(0,200,80) or Color3.fromRGB(80,80,80)
        btn.Text = nv and T("on") or T("off")
        if onChange then onChange(nv) end
    end)
end

local clearESP

createSwitch(espMenu, 55, "enable_esp", function() return espEnabled end, function(v) espEnabled = v end, function(v) espTitle.Text = T("esp").." ("..(v and T("on") or T("off"))..")"; if not v and clearESP then clearESP() end end)
createSwitch(espMenu, 92, "boxes", function() return espSettings.boxes end, function(v) espSettings.boxes = v end)
createSwitch(espMenu, 129, "names", function() return espSettings.names end, function(v) espSettings.names = v end)
createSwitch(espMenu, 166, "health", function() return espSettings.health end, function(v) espSettings.health = v end)
createSwitch(espMenu, 203, "distance", function() return espSettings.distance end, function(v) espSettings.distance = v end)

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

    local health = Instance.new("TextLabel")
    health.Size = UDim2.fromOffset(100,18)
    health.BackgroundTransparency = 1
    health.TextColor3 = Color3.fromRGB(255,255,255)
    health.TextSize = 14
    health.Font = Enum.Font.GothamBold
    health.TextStrokeTransparency = 0.5
    health.Text = "❤️ 100"
    health.Parent = gui

    local dist = Instance.new("TextLabel")
    dist.Size = UDim2.fromOffset(80,16)
    dist.BackgroundTransparency = 1
    dist.TextColor3 = Color3.new(1,1,1)
    dist.TextSize = 12
    dist.Font = Enum.Font.Gotham
    dist.Parent = gui

    data.box = box
    data.name = name
    data.health = health
    data.dist = dist
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

                        d.name.Position = UDim2.new(0, screenPos.X - 75, 0, screenPos.Y - boxSize*0.75 - 40)
                        d.name.Text = target.Name
                        d.name.Visible = espSettings.names

                        local hum = char:FindFirstChildOfClass("Humanoid")
                        if hum then
                            d.health.Text = "❤️ "..math.floor(hum.Health)
                            d.health.Position = UDim2.new(0, screenPos.X - 50, 0, screenPos.Y - boxSize*0.75 - 20)
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
popupBox.PlaceholderText = T("enter_value")
popupBox.Parent = inputPopup
Instance.new("UICorner",popupBox).CornerRadius = UDim.new(0,8)

local popupOk = Instance.new("TextButton")
popupOk.Size = UDim2.new(1,-60,0,55)
popupOk.Position = UDim2.fromOffset(30,150)
popupOk.BackgroundColor3 = Color3.fromRGB(0,150,80)
popupOk.Text = T("ok")
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
            popupBox.PlaceholderText = T("not_number")
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
local playerMenu, playerTitle, playerBack = createSubmenu(T("player"))

local currentSpeed = 16
local infiniteJump = false

local speedBtn = Instance.new("TextButton")
speedBtn.Size = UDim2.new(1,-30,0,55)
speedBtn.Position = UDim2.fromOffset(15,65)
speedBtn.BackgroundColor3 = Color3.fromRGB(28,28,35)
speedBtn.Text = T("speed")..": 16"
speedBtn.TextColor3 = Color3.new(1,1,1)
speedBtn.TextSize = 18
speedBtn.Font = Enum.Font.GothamBold
speedBtn.Parent = playerMenu
Instance.new("UICorner",speedBtn).CornerRadius = UDim.new(0,11)
speedBtn.MouseButton1Click:Connect(function()
    showPopup(T("speed").." (1-500)", "1-500", function(v)
        currentSpeed = v
        speedBtn.Text = T("speed")..": "..math.floor(v)
    end)
end)

local infJumpBtn = Instance.new("TextButton")
infJumpBtn.Size = UDim2.new(1,-30,0,55)
infJumpBtn.Position = UDim2.fromOffset(15,130)
infJumpBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
infJumpBtn.Text = T("infinite_jump")..": "..T("off")
infJumpBtn.TextColor3 = Color3.new(1,1,1)
infJumpBtn.TextSize = 17
infJumpBtn.Font = Enum.Font.GothamBold
infJumpBtn.Parent = playerMenu
Instance.new("UICorner",infJumpBtn).CornerRadius = UDim.new(0,11)
infJumpBtn.MouseButton1Click:Connect(function()
    infiniteJump = not infiniteJump
    infJumpBtn.Text = T("infinite_jump")..": "..(infiniteJump and T("on") or T("off"))
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
flyBtn.Text = T("fly")
flyBtn.TextColor3 = Color3.new(1,1,1)
flyBtn.TextSize = 18
flyBtn.Font = Enum.Font.GothamBold
flyBtn.Parent = playerMenu
Instance.new("UICorner",flyBtn).CornerRadius = UDim.new(0,11)

-- ========== FLY ==========
local flyMenu, flyTitle, flyBack = createSubmenu(T("fly"))

local flyEnabled = false
local flySpeed = 60
local flyBodyVelocity = nil
local flyBodyGyro = nil
local flyConnection = nil

local flyToggle = Instance.new("TextButton")
flyToggle.Size = UDim2.new(1,-30,0,55)
flyToggle.Position = UDim2.fromOffset(15,65)
flyToggle.BackgroundColor3 = Color3.fromRGB(80,80,80)
flyToggle.Text = T("fly_off")
flyToggle.TextColor3 = Color3.new(1,1,1)
flyToggle.TextSize = 17
flyToggle.Font = Enum.Font.GothamBold
flyToggle.Parent = flyMenu
Instance.new("UICorner",flyToggle).CornerRadius = UDim.new(0,11)

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
    flyToggle.Text = on and T("fly_on") or T("fly_off")
    flyToggle.BackgroundColor3 = on and Color3.fromRGB(0,200,80) or Color3.fromRGB(80,80,80)
    flyBtn.Text = on and T("fly_on") or T("fly")
    flyBtn.BackgroundColor3 = on and Color3.fromRGB(0,200,80) or Color3.fromRGB(40,80,200)
end
flyToggle.MouseButton1Click:Connect(function() setFly(not flyEnabled) end)

local flySpeedBtn = Instance.new("TextButton")
flySpeedBtn.Size = UDim2.new(1,-30,0,55)
flySpeedBtn.Position = UDim2.fromOffset(15,130)
flySpeedBtn.BackgroundColor3 = Color3.fromRGB(28,28,35)
flySpeedBtn.Text = T("fly_speed")..": 60"
flySpeedBtn.TextColor3 = Color3.new(1,1,1)
flySpeedBtn.TextSize = 17
flySpeedBtn.Font = Enum.Font.GothamBold
flySpeedBtn.Parent = flyMenu
Instance.new("UICorner",flySpeedBtn).CornerRadius = UDim.new(0,11)
flySpeedBtn.MouseButton1Click:Connect(function()
    showPopup(T("fly_speed").." (1-1000)", "1-1000", function(v)
        flySpeed = v
        flySpeedBtn.Text = T("fly_speed")..": "..math.floor(v)
    end)
end)

-- ========== AIMBOT (БЕЛЫЙ КРУГ + ВСЕГДА В ГОЛОВУ + ПОВОРОТ) ==========
local aimbotMenu, aimbotTitle, aimbotBack = createSubmenu(T("aimbot"))

local aimbotEnabled = false
local aimbotRadius = 200
local aimbotRange = 300
local aimbotTeamCheck = true
local fovCircleEnabled = true

-- БЕЛЫЙ FOV КРУГ
local fovCircle = Instance.new("Frame")
fovCircle.Name = "FOV"
fovCircle.Size = UDim2.fromOffset(aimbotRadius*2, aimbotRadius*2)
fovCircle.Position = UDim2.fromScale(0.5, 0.5)
fovCircle.AnchorPoint = Vector2.new(0.5, 0.5)
fovCircle.BackgroundColor3 = Color3.new(1,1,1)
fovCircle.BackgroundTransparency = 1
fovCircle.BorderSizePixel = 0
fovCircle.Visible = false
fovCircle.ZIndex = 999
fovCircle.Parent = gui

local fovCorner = Instance.new("UICorner")
fovCorner.CornerRadius = UDim.new(1, 0)
fovCorner.Parent = fovCircle

local fovStroke = Instance.new("UIStroke")
fovStroke.Thickness = 4
fovStroke.Color = Color3.new(1,1,1)
fovStroke.Transparency = 0
fovStroke.Parent = fovCircle

-- Подпись радиуса (пиксели + studs)
local fovLabel = Instance.new("TextLabel")
fovLabel.Size = UDim2.fromOffset(220,22)
fovLabel.Position = UDim2.new(0.5, -110, 0.5, aimbotRadius + 15)
fovLabel.BackgroundTransparency = 1
fovLabel.Text = ""
fovLabel.TextColor3 = Color3.new(1,1,1)
fovLabel.TextSize = 14
fovLabel.Font = Enum.Font.GothamBold
fovLabel.TextStrokeTransparency = 0
fovLabel.TextStrokeColor3 = Color3.new(0,0,0)
fovLabel.Visible = false
fovLabel.ZIndex = 1000
fovLabel.Parent = gui

local function pixelsToStuds(px)
    local cam = workspace.CurrentCamera
    if not cam then return 0 end
    local viewportY = cam.ViewportSize.Y
    local fovRad = math.rad(cam.FieldOfView)
    local refDist = 50
    local pxPerStud = viewportY / (2 * math.tan(fovRad/2) * refDist)
    if pxPerStud <= 0 then return 0 end
    return math.floor(px / pxPerStud)
end

-- ФУНКЦИЯ: обновляет круг И подпись при смене радиуса
local function updateFovCircle()
    fovCircle.Size = UDim2.fromOffset(aimbotRadius*2, aimbotRadius*2)
    fovCircle.Visible = aimbotEnabled and fovCircleEnabled
    fovLabel.Position = UDim2.new(0.5, -110, 0.5, aimbotRadius + 15)
    fovLabel.Text = aimbotRadius.."px (~"..pixelsToStuds(aimbotRadius).." studs)"
    fovLabel.Visible = aimbotEnabled and fovCircleEnabled
end

RunService.RenderStepped:Connect(function()
    if aimbotEnabled and fovCircleEnabled then
        fovCircle.Visible = true
        fovLabel.Visible = true
    else
        fovCircle.Visible = false
        fovLabel.Visible = false
    end
end)

local aimbotToggle = Instance.new("TextButton")
aimbotToggle.Size = UDim2.new(1,-30,0,48)
aimbotToggle.Position = UDim2.fromOffset(15,58)
aimbotToggle.BackgroundColor3 = Color3.fromRGB(80,80,80)
aimbotToggle.Text = T("aimbot_off")
aimbotToggle.TextColor3 = Color3.new(1,1,1)
aimbotToggle.TextSize = 16
aimbotToggle.Font = Enum.Font.GothamBold
aimbotToggle.Parent = aimbotMenu
Instance.new("UICorner",aimbotToggle).CornerRadius = UDim.new(0,11)
aimbotToggle.MouseButton1Click:Connect(function()
    aimbotEnabled = not aimbotEnabled
    aimbotToggle.Text = aimbotEnabled and T("aimbot_on") or T("aimbot_off")
    aimbotToggle.BackgroundColor3 = aimbotEnabled and Color3.fromRGB(0,200,80) or Color3.fromRGB(80,80,80)
    updateFovCircle()
end)

local aimbotRadiusBtn = Instance.new("TextButton")
aimbotRadiusBtn.Size = UDim2.new(1,-30,0,48)
aimbotRadiusBtn.Position = UDim2.fromOffset(15,112)
aimbotRadiusBtn.BackgroundColor3 = Color3.fromRGB(28,28,35)
aimbotRadiusBtn.Text = T("fov")..": "..aimbotRadius.."px"
aimbotRadiusBtn.TextColor3 = Color3.new(1,1,1)
aimbotRadiusBtn.TextSize = 16
aimbotRadiusBtn.Font = Enum.Font.GothamBold
aimbotRadiusBtn.Parent = aimbotMenu
Instance.new("UICorner",aimbotRadiusBtn).CornerRadius = UDim.new(0,11)
aimbotRadiusBtn.MouseButton1Click:Connect(function()
    showPopup(T("fov").." (50-500px)", "50-500", function(v)
        aimbotRadius = v
        aimbotRadiusBtn.Text = T("fov")..": "..math.floor(v).."px"
        updateFovCircle()
    end)
end)

local fovCircleBtn = Instance.new("TextButton")
fovCircleBtn.Size = UDim2.new(1,-30,0,48)
fovCircleBtn.Position = UDim2.fromOffset(15,166)
fovCircleBtn.BackgroundColor3 = Color3.fromRGB(0,200,80)
fovCircleBtn.Text = T("fov_circle")..": "..T("on")
fovCircleBtn.TextColor3 = Color3.new(1,1,1)
fovCircleBtn.TextSize = 16
fovCircleBtn.Font = Enum.Font.GothamBold
fovCircleBtn.Parent = aimbotMenu
Instance.new("UICorner",fovCircleBtn).CornerRadius = UDim.new(0,11)
fovCircleBtn.MouseButton1Click:Connect(function()
    fovCircleEnabled = not fovCircleEnabled
    fovCircleBtn.Text = T("fov_circle")..": "..(fovCircleEnabled and T("on") or T("off"))
    fovCircleBtn.BackgroundColor3 = fovCircleEnabled and Color3.fromRGB(0,200,80) or Color3.fromRGB(80,80,80)
    updateFovCircle()
end)

local aimbotRangeBtn = Instance.new("TextButton")
aimbotRangeBtn.Size = UDim2.new(1,-30,0,48)
aimbotRangeBtn.Position = UDim2.fromOffset(15,220)
aimbotRangeBtn.BackgroundColor3 = Color3.fromRGB(28,28,35)
aimbotRangeBtn.Text = T("range")..": "..aimbotRange.." studs"
aimbotRangeBtn.TextColor3 = Color3.new(1,1,1)
aimbotRangeBtn.TextSize = 16
aimbotRangeBtn.Font = Enum.Font.GothamBold
aimbotRangeBtn.Parent = aimbotMenu
Instance.new("UICorner",aimbotRangeBtn).CornerRadius = UDim.new(0,11)
aimbotRangeBtn.MouseButton1Click:Connect(function()
    showPopup(T("range").." (10-2000 studs)", "10-2000", function(v)
        aimbotRange = v
        aimbotRangeBtn.Text = T("range")..": "..math.floor(v).." studs"
    end)
end)

local aimbotTeamBtn = Instance.new("TextButton")
aimbotTeamBtn.Size = UDim2.new(1,-30,0,48)
aimbotTeamBtn.Position = UDim2.fromOffset(15,274)
aimbotTeamBtn.BackgroundColor3 = Color3.fromRGB(0,200,80)
aimbotTeamBtn.Text = T("team_check")..": "..T("on")
aimbotTeamBtn.TextColor3 = Color3.new(1,1,1)
aimbotTeamBtn.TextSize = 16
aimbotTeamBtn.Font = Enum.Font.GothamBold
aimbotTeamBtn.Parent = aimbotMenu
Instance.new("UICorner",aimbotTeamBtn).CornerRadius = UDim.new(0,11)
aimbotTeamBtn.MouseButton1Click:Connect(function()
    aimbotTeamCheck = not aimbotTeamCheck
    aimbotTeamBtn.Text = T("team_check")..": "..(aimbotTeamCheck and T("on") or T("off"))
    aimbotTeamBtn.BackgroundColor3 = aimbotTeamCheck and Color3.fromRGB(0,200,80) or Color3.fromRGB(80,80,80)
end)

-- ===== ЛОГИКА AIMBOT — ВСЕГДА В ГОЛОВУ + ПОВОРОТ =====
RunService.RenderStepped:Connect(function()
    if not aimbotEnabled then return end
    local myChar = player.Character
    if not myChar or not myChar:FindFirstChild("Head") then return end

    local center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    local closestPart = nil
    local closestDist = aimbotRadius
    local myPos = myChar.Head.Position

    for _, target in ipairs(Players:GetPlayers()) do
        if target ~= player then
            if not (aimbotTeamCheck and target.Team and player.Team and target.Team == player.Team) then
                local char = target.Character
                if char and char.PrimaryPart and char:FindFirstChild("Head") then
                    local distInStuds = (char.Head.Position - myPos).Magnitude
                    if distInStuds <= aimbotRange then
                        local part = char:FindFirstChild("Head")
                        if part then
                            local sp, onScreen = Camera:WorldToViewportPoint(part.Position)
                            if onScreen then
                                local screenDist = (Vector2.new(sp.X, sp.Y) - center).Magnitude
                                if screenDist <= aimbotRadius then
                                    if screenDist < closestDist then
                                        closestDist = screenDist
                                        closestPart = part
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    if closestPart then
        Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, closestPart.Position)
        local hrp = myChar:FindFirstChild("HumanoidRootPart")
        if hrp then
            local headPos = closestPart.Position
            local myPos2 = hrp.Position
            local lookAt = CFrame.lookAt(myPos2, Vector3.new(headPos.X, myPos2.Y, headPos.Z))
            hrp.CFrame = lookAt
        end
    end
end)

print("PART 2/3 LOADED")

-- ===================================================================
-- ROBLOX MASTER v7.0 — ЧАСТЬ 3/3
-- ===================================================================

local Lighting = game:GetService("Lighting")
local VIM = game:GetService("VirtualInputManager")

-- ========== DRAG ==========
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

-- ========== MISC ==========
local miscMenu, miscTitle, miscBack = createSubmenu(T("misc"))

local noclipEnabled = false
local noclipConn = nil
local fullbrightEnabled = false
local origLighting = {Ambient = Lighting.Ambient, Outdoor = Lighting.OutdoorAmbient, Brightness = Lighting.Brightness}

-- Noclip
local noclipBtn = Instance.new("TextButton")
noclipBtn.Size = UDim2.new(1,-30,0,52)
noclipBtn.Position = UDim2.fromOffset(15,60)
noclipBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
noclipBtn.Text = T("noclip")..": "..T("off")
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
        noclipBtn.Text = T("noclip")..": "..T("on")
        noclipBtn.BackgroundColor3 = Color3.fromRGB(0,200,80)
    else
        if noclipConn then noclipConn:Disconnect(); noclipConn = nil end
        local char = player.Character
        if char then
            for _, p in ipairs(char:GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide = true end
            end
        end
        noclipBtn.Text = T("noclip")..": "..T("off")
        noclipBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
    end
end)

-- Fullbright
local fullbrightBtn = Instance.new("TextButton")
fullbrightBtn.Size = UDim2.new(1,-30,0,52)
fullbrightBtn.Position = UDim2.fromOffset(15,118)
fullbrightBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
fullbrightBtn.Text = T("fullbright")..": "..T("off")
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
        fullbrightBtn.Text = T("fullbright")..": "..T("on")
        fullbrightBtn.BackgroundColor3 = Color3.fromRGB(0,200,80)
    else
        Lighting.Ambient = origLighting.Ambient
        Lighting.OutdoorAmbient = origLighting.Outdoor
        Lighting.Brightness = origLighting.Brightness
        fullbrightBtn.Text = T("fullbright")..": "..T("off")
        fullbrightBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
    end
end)

-- TP to Player
local tpPlayerBtn = Instance.new("TextButton")
tpPlayerBtn.Size = UDim2.new(1,-30,0,52)
tpPlayerBtn.Position = UDim2.fromOffset(15,176)
tpPlayerBtn.BackgroundColor3 = Color3.fromRGB(28,28,35)
tpPlayerBtn.Text = T("tp_player")
tpPlayerBtn.TextColor3 = Color3.new(1,1,1)
tpPlayerBtn.TextSize = 16
tpPlayerBtn.Font = Enum.Font.GothamBold
tpPlayerBtn.Parent = miscMenu
Instance.new("UICorner",tpPlayerBtn).CornerRadius = UDim.new(0,11)

-- ========== FAST CLICK ==========
local fastClickEnabled = false
local clickDelay = 0.001

local fastClickBtn = Instance.new("TextButton")
fastClickBtn.Size = UDim2.new(1,-30,0,52)
fastClickBtn.Position = UDim2.fromOffset(15,234)
fastClickBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
fastClickBtn.Text = T("fast_click_off")
fastClickBtn.TextColor3 = Color3.new(1,1,1)
fastClickBtn.TextSize = 16
fastClickBtn.Font = Enum.Font.GothamBold
fastClickBtn.Parent = miscMenu
Instance.new("UICorner",fastClickBtn).CornerRadius = UDim.new(0,11)
fastClickBtn.MouseButton1Click:Connect(function()
    fastClickEnabled = not fastClickEnabled
    fastClickBtn.Text = fastClickEnabled and T("fast_click_on") or T("fast_click_off")
    fastClickBtn.BackgroundColor3 = fastClickEnabled and Color3.fromRGB(0,200,80) or Color3.fromRGB(80,80,80)
end)

local clickDelayBtn = Instance.new("TextButton")
clickDelayBtn.Size = UDim2.new(1,-30,0,44)
clickDelayBtn.Position = UDim2.fromOffset(15,292)
clickDelayBtn.BackgroundColor3 = Color3.fromRGB(28,28,35)
clickDelayBtn.Text = T("click_delay")..": 0.001"
clickDelayBtn.TextColor3 = Color3.new(1,1,1)
clickDelayBtn.TextSize = 15
clickDelayBtn.Font = Enum.Font.GothamBold
clickDelayBtn.Parent = miscMenu
Instance.new("UICorner",clickDelayBtn).CornerRadius = UDim.new(0,11)
clickDelayBtn.MouseButton1Click:Connect(function()
    showPopup(T("click_delay").." (1-100)", "1", function(v)
        clickDelay = math.clamp(v/1000, 0.001, 0.1)
        clickDelayBtn.Text = T("click_delay")..": "..string.format("%.3f", clickDelay)
    end)
end)

-- ЛОГИКА FAST CLICK
task.spawn(function()
    while true do
        if fastClickEnabled then
            pcall(function()
                VIM:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                task.wait(0.0001)
                VIM:SendMouseButtonEvent(0, 0, 0, false, game, 0)
            end)
            task.wait(clickDelay)
        else
            task.wait(0.1)
        end
    end
end)

-- ========== TP TO PLAYER ==========
local tpMenu, tpTitle, tpBack = createSubmenu(T("tp_player"))

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
        none.Text = T("no_players")
        none.TextColor3 = Color3.fromRGB(150,150,150)
        none.TextSize = 15
        none.Font = Enum.Font.Gotham
        none.Parent = tpScroll
        y = 40
    end
    tpScroll.CanvasSize = UDim2.new(0,0,0,y)
end

-- ========== SETTINGS ==========
local settingsMenu, settingsTitle, settingsBack = createSubmenu(T("settings"))

local currentLangLabel = Instance.new("TextLabel")
currentLangLabel.Size = UDim2.new(1,-30,0,40)
currentLangLabel.Position = UDim2.fromOffset(15,65)
currentLangLabel.BackgroundTransparency = 1
currentLangLabel.Text = (currentLang == "EN") and "Current language: EN" or "Текущий язык: RU"
currentLangLabel.TextColor3 = Color3.new(1,1,1)
currentLangLabel.TextSize = 16
currentLangLabel.Font = Enum.Font.GothamBold
currentLangLabel.TextXAlignment = Enum.TextXAlignment.Left
currentLangLabel.Parent = settingsMenu

local langENBtn = Instance.new("TextButton")
langENBtn.Size = UDim2.new(1,-30,0,55)
langENBtn.Position = UDim2.fromOffset(15,115)
langENBtn.BackgroundColor3 = (currentLang == "EN") and Color3.fromRGB(0,150,80) or Color3.fromRGB(35,35,45)
langENBtn.Text = "English"
langENBtn.TextColor3 = Color3.new(1,1,1)
langENBtn.TextSize = 18
langENBtn.Font = Enum.Font.GothamBold
langENBtn.Parent = settingsMenu
Instance.new("UICorner",langENBtn).CornerRadius = UDim.new(0,11)

local langRUBtn = Instance.new("TextButton")
langRUBtn.Size = UDim2.new(1,-30,0,55)
langRUBtn.Position = UDim2.fromOffset(15,180)
langRUBtn.BackgroundColor3 = (currentLang == "RU") and Color3.fromRGB(0,150,80) or Color3.fromRGB(35,35,45)
langRUBtn.Text = "Русский"
langRUBtn.TextColor3 = Color3.new(1,1,1)
langRUBtn.TextSize = 18
langRUBtn.Font = Enum.Font.GothamBold
langRUBtn.Parent = settingsMenu
Instance.new("UICorner",langRUBtn).CornerRadius = UDim.new(0,11)

local settingsInfo = Instance.new("TextLabel")
settingsInfo.Size = UDim2.new(1,-30,0,60)
settingsInfo.Position = UDim2.fromOffset(15,245)
settingsInfo.BackgroundTransparency = 1
settingsInfo.Text = "Choose your language below\nВыбери язык ниже"
settingsInfo.TextColor3 = Color3.fromRGB(150,150,150)
settingsInfo.TextSize = 13
settingsInfo.Font = Enum.Font.Gotham
settingsInfo.TextWrapped = true
settingsInfo.TextYAlignment = Enum.TextYAlignment.Top
settingsInfo.Parent = settingsMenu

-- ========== APPLY LANGUAGE ==========
local function applyLanguage()
    for _, obj in ipairs(gui:GetDescendants()) do
        local key = obj:GetAttribute("langKey")
        if key and (obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox")) then
            obj.Text = T(key)
        end
    end
    espTitle.Text = T("esp").." ("..(espEnabled and T("on") or T("off"))..")"
    flyToggle.Text = flyEnabled and T("fly_on") or T("fly_off")
    flyBtn.Text = flyEnabled and T("fly_on") or T("fly")
    speedBtn.Text = T("speed")..": "..math.floor(currentSpeed)
    infJumpBtn.Text = T("infinite_jump")..": "..(infiniteJump and T("on") or T("off"))
    flySpeedBtn.Text = T("fly_speed")..": "..math.floor(flySpeed)
    aimbotToggle.Text = aimbotEnabled and T("aimbot_on") or T("aimbot_off")
    aimbotRadiusBtn.Text = T("fov")..": "..aimbotRadius.."px"
    fovCircleBtn.Text = T("fov_circle")..": "..(fovCircleEnabled and T("on") or T("off"))
    aimbotRangeBtn.Text = T("range")..": "..aimbotRange.." studs"
    aimbotTeamBtn.Text = T("team_check")..": "..(aimbotTeamCheck and T("on") or T("off"))
    noclipBtn.Text = T("noclip")..": "..(noclipEnabled and T("on") or T("off"))
    fullbrightBtn.Text = T("fullbright")..": "..(fullbrightEnabled and T("on") or T("off"))
    tpPlayerBtn.Text = T("tp_player")
    fastClickBtn.Text = fastClickEnabled and T("fast_click_on") or T("fast_click_off")
    clickDelayBtn.Text = T("click_delay")..": "..string.format("%.3f", clickDelay)
    popupOk.Text = T("ok")
    popupBox.PlaceholderText = T("enter_value")
    title.Text = T("title")
    playerTitle.Text = T("player")
    aimbotTitle.Text = T("aimbot")
    miscTitle.Text = T("misc")
    settingsTitle.Text = T("settings")
    tpTitle.Text = T("tp_player")
    if currentLangLabel then
        currentLangLabel.Text = (currentLang == "EN") and "Current language: EN" or "Текущий язык: RU"
    end
    if langENBtn then
        langENBtn.BackgroundColor3 = (currentLang == "EN") and Color3.fromRGB(0,150,80) or Color3.fromRGB(35,35,45)
    end
    if langRUBtn then
        langRUBtn.BackgroundColor3 = (currentLang == "RU") and Color3.fromRGB(0,150,80) or Color3.fromRGB(35,35,45)
    end
end

local function setLanguage(lang)
    currentLang = lang
    applyLanguage()
end

langENBtn.MouseButton1Click:Connect(function() setLanguage("EN") end)
langRUBtn.MouseButton1Click:Connect(function() setLanguage("RU") end)

-- ========== ФИКС SPEED ==========
RunService.Heartbeat:Connect(function()
    local char = player.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    if hum.WalkSpeed ~= currentSpeed then hum.WalkSpeed = currentSpeed end
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
aimbotBack.Activated:Connect(function() backToMain(aimbotMenu) end)
miscBack.Activated:Connect(function() backToMain(miscMenu) end)
tpBack.Activated:Connect(function() backToMain(tpMenu) end)
settingsBack.Activated:Connect(function() backToMain(settingsMenu) end)

mainButtons[1].Activated:Connect(function() openSub(espMenu, 340, 260) end)
mainButtons[2].Activated:Connect(function() openSub(playerMenu, 340, 280) end)
mainButtons[3].Activated:Connect(function() openSub(aimbotMenu, 340, 340) end)
mainButtons[4].Activated:Connect(function() openSub(miscMenu, 340, 350) end)
mainButtons[5].Activated:Connect(function() openSub(settingsMenu, 340, 340) end)

flyBtn.Activated:Connect(function()
    closeFrame(playerMenu)
    task.wait(.05)
    openFrame(flyMenu, 340, 200)
end)

tpPlayerBtn.Activated:Connect(function()
    refreshTPList()
    closeFrame(miscMenu)
    task.wait(.05)
    openFrame(tpMenu, 260, 340)
end)

-- ========== DRAGGABLE ==========
makeDraggable(menu, title)
makeDraggable(espMenu, espTitle)
makeDraggable(playerMenu, playerTitle)
makeDraggable(flyMenu, flyTitle)
makeDraggable(aimbotMenu, aimbotTitle)
makeDraggable(miscMenu, miscTitle)
makeDraggable(tpMenu, tpTitle)
makeDraggable(settingsMenu, settingsTitle)
makeDraggable(inputPopup, popupTitle)

-- ========== DRAG ИКОНКИ ==========
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

-- ========== РЕСПАВН ==========
player.CharacterAdded:Connect(function(char)
    task.wait(.5)
    local hum = char:FindFirstChild("Humanoid")
    if hum then hum.WalkSpeed = currentSpeed end
end)

-- ========== СТАРТ ==========
updateFovCircle()
applyLanguage()

print("PART 3/3 LOADED — ALL SYSTEMS GO")
