,-- ===================================================================
-- ROBLOX MASTER v7.0 — ЧАСТЬ 1/2
-- ===================================================================

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local Tween = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local VIM = game:GetService("VirtualInputManager")
local VU = game:GetService("VirtualUser")
local Camera = workspace.CurrentCamera
local player = Players.LocalPlayer

-- ========== ЯЗЫК ==========
currentLang = "EN"
LANG = {
    EN = {
        title="AD MENU", esp="ESP", player="PLAYER", aimbot="AIMBOT", misc="MISC", settings="SETTINGS",
        enable_esp="Enable ESP", boxes="Boxes", names="Names", health="Health", distance="Distance",
        highlight="Highlight",
        speed="Speed", infinite_jump="Infinite Jump", fly="Fly", fly_on="Fly: ON", fly_off="Fly: OFF",
        fly_speed="Fly Speed", on="ON", off="OFF", aimbot_on="Aimbot: ON", aimbot_off="Aimbot: OFF",
        fov="FOV", range="Range", fov_circle="FOV Circle", noclip="Noclip", fullbright="Fullbright",
        tp_player="TP to Player", anti_afk="Anti-AFK", fps_boost="FPS Boost",
        fast_click_on="Fast Click: ON", fast_click_off="Fast Click: OFF", click_delay="Click Delay",
        team_check="Team Check", visible_check="Visible Check",
        spin_bot="Spin Bot", bunny_hop="Bunny Hop",
        no_players="No players", ok="OK", enter_value="Enter value...", not_number="Not a number!",
    },
    RU = {
        title="AD МЕНЮ", esp="ESP", player="ИГРОК", aimbot="АИМБОТ", misc="РАЗНОЕ", settings="НАСТРОЙКИ",
        enable_esp="Включить ESP", boxes="Рамки", names="Имена", health="Здоровье", distance="Дистанция",
        highlight="Обводка",
        speed="Скорость", infinite_jump="Беск. прыжок", fly="Полёт", fly_on="Полёт: ВКЛ", fly_off="Полёт: ВЫКЛ",
        fly_speed="Скорость полёта", on="ВКЛ", off="ВЫКЛ", aimbot_on="Аимбот: ВКЛ", aimbot_off="Аимбот: ВЫКЛ",
        fov="ФОВ", range="Дальность", fov_circle="Круг ФОВ", noclip="Сквозь стены", fullbright="Яркость",
        tp_player="ТП к игроку", anti_afk="Анти-АФК", fps_boost="Буст ФПС",
        fast_click_on="Фаст клик: ВКЛ", fast_click_off="Фаст клик: ВЫКЛ", click_delay="Задержка клика",
        team_check="Проверка команды", visible_check="Видно цель",
        spin_bot="Крутилка", bunny_hop="Банихоп",
        no_players="Нет игроков", ok="ОК", enter_value="Введи число...", not_number="Не число!",
    }
}
function T(k) return LANG[currentLang][k] or k end

-- ========== GUI ==========
gui = Instance.new("ScreenGui")
gui.Name = "ADMenu"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = player:WaitForChild("PlayerGui")

-- ========== ЗАГРУЗКА ==========
loading = Instance.new("TextLabel")
loading.Size = UDim2.new(1,0,1,0)
loading.BackgroundColor3 = Color3.fromRGB(8,8,10)
loading.TextColor3 = Color3.new(1,1,1)
loading.TextSize = 24
loading.Font = Enum.Font.GothamBold
loading.Text = "LOADING 0%"
loading.ZIndex = 10
loading.Parent = gui
task.spawn(function()
    for i=0,100,10 do
        loading.Text = "LOADING "..i.."%"
        task.wait(0.03)
    end
    Tween:Create(loading,TweenInfo.new(.3),{TextTransparency=1,BackgroundTransparency=1}):Play()
    task.wait(.3)
    loading:Destroy()
end)

-- ========== УВЕДОМЛЕНИЯ ==========
notifyGui = Instance.new("Frame")
notifyGui.Size = UDim2.fromOffset(300,55)
notifyGui.Position = UDim2.new(1,-320,1,-75)
notifyGui.BackgroundColor3 = Color3.fromRGB(20,20,28)
notifyGui.BackgroundTransparency = 1
notifyGui.BorderSizePixel = 0
notifyGui.ZIndex = 9999
notifyGui.Parent = gui
Instance.new("UICorner",notifyGui).CornerRadius = UDim.new(0,10)

notifyLine = Instance.new("Frame")
notifyLine.Size = UDim2.new(0,0,0,3)
notifyLine.BackgroundColor3 = Color3.fromRGB(255,220,0)
notifyLine.BorderSizePixel = 0
notifyLine.ZIndex = 10000
notifyLine.Parent = notifyGui
Instance.new("UICorner",notifyLine).CornerRadius = UDim.new(0,2)

notifyText = Instance.new("TextLabel")
notifyText.Size = UDim2.new(1,-20,1,-10)
notifyText.Position = UDim2.new(0,10,0,5)
notifyText.BackgroundTransparency = 1
notifyText.Text = ""
notifyText.TextColor3 = Color3.new(1,1,1)
notifyText.TextSize = 15
notifyText.Font = Enum.Font.GothamBold
notifyText.TextXAlignment = Enum.TextXAlignment.Left
notifyText.TextTransparency = 1
notifyText.ZIndex = 10001
notifyText.Parent = notifyGui

nQueue, nRunning = {}, false
function showNotify(text, color)
    table.insert(nQueue, {text=text, color=color or Color3.fromRGB(255,220,0)})
    if nRunning then return end
    nRunning = true
    task.spawn(function()
        while #nQueue > 0 do
            local d = table.remove(nQueue,1)
            notifyText.Text = d.text
            notifyLine.BackgroundColor3 = d.color
            notifyLine.BackgroundTransparency = 0
            notifyLine.Size = UDim2.new(0,0,0,3)
            Tween:Create(notifyGui,TweenInfo.new(.2),{BackgroundTransparency=0.1}):Play()
            Tween:Create(notifyText,TweenInfo.new(.2),{TextTransparency=0}):Play()
            Tween:Create(notifyLine,TweenInfo.new(.5,Enum.EasingStyle.Linear),{Size=UDim2.new(1,0,0,3)}):Play()
            task.wait(.5)
            task.wait(.7)
            Tween:Create(notifyGui,TweenInfo.new(.25),{BackgroundTransparency=1}):Play()
            Tween:Create(notifyText,TweenInfo.new(.25),{TextTransparency=1}):Play()
            Tween:Create(notifyLine,TweenInfo.new(.25),{BackgroundTransparency=1}):Play()
            task.wait(.3)
        end
        nRunning = false
    end)
end

-- ========== ИКОНКА ==========
icon = Instance.new("TextButton")
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
iconStroke = Instance.new("UIStroke",icon)
iconStroke.Thickness = 2
iconStroke.Color = Color3.new(1,1,1)
dot = Instance.new("Frame")
dot.Size = UDim2.fromOffset(10,10)
dot.Position = UDim2.new(1,-13,0,4)
dot.BackgroundColor3 = Color3.fromRGB(255,40,40)
dot.Parent = icon
Instance.new("UICorner",dot).CornerRadius = UDim.new(1,0)

-- ========== ХЕЛПЕРЫ ==========
function createSubmenu(titleText)
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

function openFrame(f, w, h)
    f.Visible = true
    f.Size = UDim2.fromOffset(0,0)
    Tween:Create(f, TweenInfo.new(.25, Enum.EasingStyle.Back), {Size=UDim2.fromOffset(w,h)}):Play()
end
function closeFrame(f)
    Tween:Create(f, TweenInfo.new(.15), {Size=UDim2.fromOffset(0,0)}):Play()
    task.wait(.15)
    f.Visible = false
end

-- ========== ГЛАВНОЕ МЕНЮ ==========
menu = Instance.new("Frame")
menu.Size = UDim2.fromOffset(300,395)
menu.Position = UDim2.fromScale(.5,.5)
menu.AnchorPoint = Vector2.new(.5,.5)
menu.BackgroundColor3 = Color3.fromRGB(12,12,16)
menu.Visible = false
menu.Parent = gui
Instance.new("UICorner",menu).CornerRadius = UDim.new(0,16)

title = Instance.new("TextLabel")
title.Size = UDim2.new(1,-60,0,50)
title.Position = UDim2.fromOffset(15,5)
title.BackgroundTransparency = 1
title.Text = T("title")
title.TextColor3 = Color3.new(1,1,1)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = menu
title:SetAttribute("langKey","title")

close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(40,40)
close.Position = UDim2.new(1,-48,0,10)
close.BackgroundColor3 = Color3.fromRGB(35,35,40)
close.Text = "X"
close.TextColor3 = Color3.new(1,1,1)
close.TextSize = 18
close.Font = Enum.Font.GothamBold
close.Parent = menu
Instance.new("UICorner",close).CornerRadius = UDim.new(0,10)

mainButtons = {}
mainKeys = {"esp","player","aimbot","misc","settings"}
for i,key in ipairs(mainKeys) do
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1,-30,0,55)
    b.Position = UDim2.fromOffset(15,60+(i-1)*62)
    b.BackgroundColor3 = (key=="settings") and Color3.fromRGB(40,50,90) or Color3.fromRGB(28,28,35)
    b.Text = T(key)
    b.TextColor3 = Color3.new(1,1,1)
    b.TextSize = 17
    b.Font = Enum.Font.GothamBold
    b.Parent = menu
    Instance.new("UICorner",b).CornerRadius = UDim.new(0,11)
    b:SetAttribute("langKey",key)
    mainButtons[i] = b
end

function openMain()
    menu.Visible = true
    menu.Size = UDim2.fromOffset(0,0)
    Tween:Create(menu,TweenInfo.new(.25,Enum.EasingStyle.Back),{Size=UDim2.fromOffset(300,395)}):Play()
end
function hideMain()
    Tween:Create(menu,TweenInfo.new(.15),{Size=UDim2.fromOffset(0,0)}):Play()
    task.wait(.15)
    menu.Visible = false
end

-- ========== ОКНО ВВОДА ==========
inputPopup = Instance.new("Frame")
inputPopup.Size = UDim2.fromOffset(0,0)
inputPopup.Position = UDim2.fromScale(.5,.5)
inputPopup.AnchorPoint = Vector2.new(.5,.5)
inputPopup.BackgroundColor3 = Color3.fromRGB(20,20,28)
inputPopup.Visible = false
inputPopup.Parent = gui
Instance.new("UICorner",inputPopup).CornerRadius = UDim.new(0,16)

popupTitle = Instance.new("TextLabel")
popupTitle.Size = UDim2.new(1,-60,0,50)
popupTitle.Position = UDim2.fromOffset(15,5)
popupTitle.BackgroundTransparency = 1
popupTitle.Text = "Value"
popupTitle.TextColor3 = Color3.new(1,1,1)
popupTitle.TextSize = 18
popupTitle.Font = Enum.Font.GothamBold
popupTitle.TextXAlignment = Enum.TextXAlignment.Left
popupTitle.Parent = inputPopup

popupClose = Instance.new("TextButton")
popupClose.Size = UDim2.fromOffset(40,40)
popupClose.Position = UDim2.new(1,-48,0,10)
popupClose.BackgroundColor3 = Color3.fromRGB(35,35,40)
popupClose.Text = "X"
popupClose.TextColor3 = Color3.new(1,1,1)
popupClose.TextSize = 18
popupClose.Font = Enum.Font.GothamBold
popupClose.Parent = inputPopup
Instance.new("UICorner",popupClose).CornerRadius = UDim.new(0,10)

popupBox = Instance.new("TextBox")
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

popupOk = Instance.new("TextButton")
popupOk.Size = UDim2.new(1,-60,0,55)
popupOk.Position = UDim2.fromOffset(30,150)
popupOk.BackgroundColor3 = Color3.fromRGB(0,150,80)
popupOk.Text = T("ok")
popupOk.TextColor3 = Color3.new(1,1,1)
popupOk.TextSize = 20
popupOk.Font = Enum.Font.GothamBold
popupOk.Parent = inputPopup
Instance.new("UICorner",popupOk).CornerRadius = UDim.new(0,8)

popupCallback = nil
function hidePopup()
    Tween:Create(inputPopup,TweenInfo.new(.15),{Size=UDim2.fromOffset(0,0)}):Play()
    task.wait(.15)
    inputPopup.Visible = false
    popupCallback = nil
end
function showPopup(titleTxt, placeholder, callback)
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
    Tween:Create(inputPopup,TweenInfo.new(.2,Enum.EasingStyle.Back),{Size=UDim2.fromOffset(300,225)}):Play()
    task.wait(.05)
    popupBox:CaptureFocus()
end
popupClose.MouseButton1Click:Connect(hidePopup)
popupOk.MouseButton1Click:Connect(function() if popupCallback then popupCallback(popupBox.Text) end end)
popupBox.FocusLost:Connect(function(enter) if enter and popupCallback then popupCallback(popupBox.Text) end end)

-- ========== ESP ==========
espMenu, espTitle, espBack = createSubmenu(T("esp").." (OFF)")
espEnabled = false
espSettings = {boxes=false, names=false, health=false, distance=false, highlight=false}

function createSwitch(parent, y, labelKey, getter, setter, onChange)
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
    label:SetAttribute("langKey",labelKey)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0,55,0,26)
    btn.Position = UDim2.new(1,-60,0.5,-13)
    btn.BackgroundColor3 = getter() and Color3.fromRGB(0,200,80) or Color3.fromRGB(80,80,80)
    btn.Text = getter() and T("on") or T("off")
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextSize = 13
    btn.Font = Enum.Font.GothamBold
    btn.Parent = frame
    Instance.new("UICorner",btn).CornerRadius = UDim.new(0,8)
    btn.MouseButton1Click:Connect(function()
        local nv = not getter()
        setter(nv)
        btn.BackgroundColor3 = nv and Color3.fromRGB(0,200,80) or Color3.fromRGB(80,80,80)
        btn.Text = nv and T("on") or T("off")
        showNotify(T(labelKey)..": "..(nv and T("on") or T("off")), nv and Color3.fromRGB(0,255,100) or Color3.fromRGB(255,80,80))
        if onChange then onChange(nv) end
    end)
end

createSwitch(espMenu,52,"enable_esp",function() return espEnabled end,function(v) espEnabled=v end,function(v) espTitle.Text=T("esp").." ("..(v and T("on") or T("off"))..")"; if not v and clearESP then clearESP() end end)
createSwitch(espMenu,88,"boxes",function() return espSettings.boxes end,function(v) espSettings.boxes=v end)
createSwitch(espMenu,124,"names",function() return espSettings.names end,function(v) espSettings.names=v end)
createSwitch(espMenu,160,"health",function() return espSettings.health end,function(v) espSettings.health=v end)
createSwitch(espMenu,196,"distance",function() return espSettings.distance end,function(v) espSettings.distance=v end)
createSwitch(espMenu,232,"highlight",function() return espSettings.highlight end,function(v) espSettings.highlight=v end)

espObjects = {}
espHighlights = {}

function clearESP()
    for _,d in pairs(espObjects) do
        if d.topLeft then d.topLeft:Destroy() end
        if d.topRight then d.topRight:Destroy() end
        if d.botLeft then d.botLeft:Destroy() end
        if d.botRight then d.botRight:Destroy() end
        if d.topLine then d.topLine:Destroy() end
        if d.botLine then d.botLine:Destroy() end
        if d.leftLine then d.leftLine:Destroy() end
        if d.rightLine then d.rightLine:Destroy() end
        if d.name then d.name:Destroy() end
        if d.health then d.health:Destroy() end
        if d.dist then d.dist:Destroy() end
    end
    for _,h in pairs(espHighlights) do
        if h then h:Destroy() end
    end
    espObjects = {}
    espHighlights = {}
end

function createESP(target)
    if espObjects[target] then return end
    local data = {}
    local function mkFrame()
        local f = Instance.new("Frame")
        f.BackgroundColor3 = Color3.new(1,1,1)
        f.BorderSizePixel = 0
        f.ZIndex = 3
        f.Visible = false
        f.Parent = gui
        return f
    end
    data.topLeft = mkFrame()
    data.topRight = mkFrame()
    data.botLeft = mkFrame()
    data.botRight = mkFrame()
    data.topLine = mkFrame()
    data.botLine = mkFrame()
    data.leftLine = mkFrame()
    data.rightLine = mkFrame()

    local name = Instance.new("TextLabel")
    name.BackgroundTransparency = 1
    name.TextColor3 = Color3.new(1,1,1)
    name.TextSize = 13
    name.Font = Enum.Font.GothamBold
    name.TextStrokeTransparency = 0
    name.TextStrokeColor3 = Color3.new(0,0,0)
    name.ZIndex = 4
    name.Visible = false
    name.Parent = gui

    local health = Instance.new("TextLabel")
    health.BackgroundTransparency = 1
    health.TextColor3 = Color3.new(1,1,1)
    health.TextSize = 13
    health.Font = Enum.Font.GothamBold
    health.TextStrokeTransparency = 0
    health.TextStrokeColor3 = Color3.new(0,0,0)
    health.ZIndex = 4
    health.Visible = false
    health.Parent = gui

    local dist = Instance.new("TextLabel")
    dist.BackgroundTransparency = 1
    dist.TextColor3 = Color3.fromRGB(200,200,200)
    dist.TextSize = 11
    dist.Font = Enum.Font.Gotham
    dist.TextStrokeTransparency = 0
    dist.TextStrokeColor3 = Color3.new(0,0,0)
    dist.ZIndex = 4
    dist.Visible = false
    dist.Parent = gui

    data.name = name
    data.health = health
    data.dist = dist
    espObjects[target] = data
end

function updateHighlight(target)
    local char = target.Character
    if not char then
        if espHighlights[target] then
            espHighlights[target]:Destroy()
            espHighlights[target] = nil
        end
        return
    end
    if espSettings.highlight then
        if not espHighlights[target] or not espHighlights[target].Parent then
            local h = Instance.new("Highlight")
            h.FillColor = Color3.fromRGB(255,50,50)
            h.FillTransparency = 0.5
            h.OutlineColor = Color3.fromRGB(255,50,50)
            h.OutlineTransparency = 0
            h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            h.Adornee = char
            h.Parent = gui
            espHighlights[target] = h
        else
            espHighlights[target].Adornee = char
        end
    else
        if espHighlights[target] then
            espHighlights[target]:Destroy()
            espHighlights[target] = nil
        end
    end
end

RunService.RenderStepped:Connect(function()
    if not espEnabled then
        if next(espObjects) or next(espHighlights) then clearESP() end
        return
    end
    local myChar = player.Character
    if not myChar or not myChar.PrimaryPart then return end
    local myPos = myChar.PrimaryPart.Position
    local vx, vy = Camera.ViewportSize.X, Camera.ViewportSize.Y
    
    for _,target in ipairs(Players:GetPlayers()) do
        if target ~= player then
            local char = target.Character
            local head = char and char:FindFirstChild("Head")
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if head and hrp then
                local sp, onScreen = Camera:WorldToViewportPoint(head.Position)
                local footPos = hrp.Position - Vector3.new(0, hrp.Size.Y/2 + 2.5, 0)
                local spFoot, onFoot = Camera:WorldToViewportPoint(footPos)
                
                if onScreen and sp.X>-200 and sp.X<vx+200 and sp.Y>-200 and sp.Y<vy+200 then
                    if not espObjects[target] then createESP(target) end
                    local d = espObjects[target]
                    if d then
                        local boxTop = sp.Y
                        local boxBot = spFoot.Y
                        local boxHeight = math.abs(boxBot - boxTop)
                        local boxWidth = boxHeight * 0.55
                        local boxLeft = sp.X - boxWidth/2
                        local boxRight = sp.X + boxWidth/2
                        
                        local isEnemy = target.Team and player.Team and target.Team ~= player.Team
                        local col = isEnemy and Color3.fromRGB(255,80,80) or Color3.fromRGB(80,255,80)
                        
                        local cornerLen = math.max(boxWidth * 0.25, 8)
                        local thick = 2
                        
                        d.topLeft.Visible = espSettings.boxes
                        d.topLeft.BackgroundColor3 = col
                        d.topLeft.Size = UDim2.fromOffset(cornerLen, thick)
                        d.topLeft.Position = UDim2.fromOffset(boxLeft, boxTop)
                        
                        d.leftLine.Visible = espSettings.boxes
                        d.leftLine.BackgroundColor3 = col
                        d.leftLine.Size = UDim2.fromOffset(thick, cornerLen)
                        d.leftLine.Position = UDim2.fromOffset(boxLeft, boxTop)
                        
                        d.topRight.Visible = espSettings.boxes
                        d.topRight.BackgroundColor3 = col
                        d.topRight.Size = UDim2.fromOffset(cornerLen, thick)
                        d.topRight.Position = UDim2.fromOffset(boxRight - cornerLen, boxTop)
                        
                        d.rightLine.Visible = espSettings.boxes
                        d.rightLine.BackgroundColor3 = col
                        d.rightLine.Size = UDim2.fromOffset(thick, cornerLen)
                        d.rightLine.Position = UDim2.fromOffset(boxRight - thick, boxTop)
                        
                        d.botLeft.Visible = espSettings.boxes
                        d.botLeft.BackgroundColor3 = col
                        d.botLeft.Size = UDim2.fromOffset(cornerLen, thick)
                        d.botLeft.Position = UDim2.fromOffset(boxLeft, boxBot - thick)
                        
                        d.topLine.Visible = espSettings.boxes
                        d.topLine.BackgroundColor3 = col
                        d.topLine.Size = UDim2.fromOffset(thick, cornerLen)
                        d.topLine.Position = UDim2.fromOffset(boxLeft, boxBot - cornerLen)
                        
                        d.botRight.Visible = espSettings.boxes
                        d.botRight.BackgroundColor3 = col
                        d.botRight.Size = UDim2.fromOffset(cornerLen, thick)
                        d.botRight.Position = UDim2.fromOffset(boxRight - cornerLen, boxBot - thick)
                        
                        d.botLine.Visible = espSettings.boxes
                        d.botLine.BackgroundColor3 = col
                        d.botLine.Size = UDim2.fromOffset(thick, cornerLen)
                        d.botLine.Position = UDim2.fromOffset(boxRight - thick, boxBot - cornerLen)
                        
                        d.name.Size = UDim2.fromOffset(math.max(boxWidth+40,150),16)
                        d.name.Position = UDim2.new(0, sp.X - d.name.Size.X.Offset/2, 0, boxTop - 18)
                        d.name.Text = target.Name
                        d.name.Visible = espSettings.names
                        d.name.TextColor3 = col
                        
                        local hum = char:FindFirstChildOfClass("Humanoid")
                        if hum and hum.Health>0 then
                            d.health.Position = UDim2.new(0, sp.X-40, 0, boxTop-34)
                            d.health.Text = "❤️ "..math.floor(hum.Health)
                            d.health.Visible = espSettings.health
                        else
                            d.health.Visible = false
                        end
                        
                        local dv = math.floor((head.Position-myPos).Magnitude)
                        d.dist.Position = UDim2.new(0, sp.X-40, 0, boxBot+4)
                        d.dist.Text = dv.."m"
                        d.dist.Visible = espSettings.distance
                    end
                else
                    if espObjects[target] then
                        local d = espObjects[target]
                        d.topLeft:Destroy(); d.topRight:Destroy(); d.botLeft:Destroy(); d.botRight:Destroy()
                        d.topLine:Destroy(); d.botLine:Destroy(); d.leftLine:Destroy(); d.rightLine:Destroy()
                        d.name:Destroy(); d.health:Destroy(); d.dist:Destroy()
                        espObjects[target] = nil
                    end
                end
                updateHighlight(target)
            end
        end
    end
end)

Players.PlayerRemoving:Connect(function(p)
    if espObjects[p] then
        local d = espObjects[p]
        d.topLeft:Destroy(); d.topRight:Destroy(); d.botLeft:Destroy(); d.botRight:Destroy()
        d.topLine:Destroy(); d.botLine:Destroy(); d.leftLine:Destroy(); d.rightLine:Destroy()
        d.name:Destroy(); d.health:Destroy(); d.dist:Destroy()
        espObjects[p] = nil
    end
    if espHighlights[p] then
        espHighlights[p]:Destroy()
        espHighlights[p] = nil
    end
end)

print("PART 1/2 LOADED")

-- ===================================================================
-- ROBLOX MASTER v7.0 — ЧАСТЬ 2/2
-- ===================================================================

-- ========== PLAYER ==========
playerMenu, playerTitle, playerBack = createSubmenu(T("player"))
currentSpeed = 16
infiniteJump = false

speedBtn = Instance.new("TextButton")
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
    showPopup(T("speed").." (1-500)","1-500",function(v)
        currentSpeed = v
        speedBtn.Text = T("speed")..": "..math.floor(v)
        showNotify(T("speed")..": "..math.floor(v), Color3.fromRGB(255,220,0))
    end)
end)

infJumpBtn = Instance.new("TextButton")
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
    showNotify(T("infinite_jump")..": "..(infiniteJump and T("on") or T("off")), infiniteJump and Color3.fromRGB(0,255,100) or Color3.fromRGB(255,80,80))
end)
UIS.JumpRequest:Connect(function()
    if infiniteJump then
        local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

flyBtn = Instance.new("TextButton")
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
flyMenu, flyTitle, flyBack = createSubmenu(T("fly"))
flyEnabled = false
flySpeed = 60
flyBV, flyBG, flyConn = nil,nil,nil

flyToggle = Instance.new("TextButton")
flyToggle.Size = UDim2.new(1,-30,0,55)
flyToggle.Position = UDim2.fromOffset(15,65)
flyToggle.BackgroundColor3 = Color3.fromRGB(80,80,80)
flyToggle.Text = T("fly_off")
flyToggle.TextColor3 = Color3.new(1,1,1)
flyToggle.TextSize = 17
flyToggle.Font = Enum.Font.GothamBold
flyToggle.Parent = flyMenu
Instance.new("UICorner",flyToggle).CornerRadius = UDim.new(0,11)

function stopFly()
    if flyBV then flyBV:Destroy(); flyBV=nil end
    if flyBG then flyBG:Destroy(); flyBG=nil end
    if flyConn then flyConn:Disconnect(); flyConn=nil end
    local char = player.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.PlatformStand=false; hum.AutoRotate=true end
    end
end

function startFly()
    local char = player.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local root = char.PrimaryPart
    if not hum or not root then return end
    flyBV = Instance.new("BodyVelocity")
    flyBV.MaxForce = Vector3.new(1e5,1e5,1e5)
    flyBV.Velocity = Vector3.new(0,0,0)
    flyBV.Parent = root
    flyBG = Instance.new("BodyGyro")
    flyBG.MaxTorque = Vector3.new(1e5,1e5,1e5)
    flyBG.P = 10000
    flyBG.D = 500
    flyBG.CFrame = root.CFrame
    flyBG.Parent = root
    hum.PlatformStand = true
    hum.AutoRotate = false
    flyConn = RunService.Heartbeat:Connect(function()
        if not flyEnabled or not flyBV or not flyBG then return end
        local c = player.Character
        if not c or not c.PrimaryPart then return end
        local h = c:FindFirstChildOfClass("Humanoid")
        if not h then return end
        local cam = workspace.CurrentCamera
        flyBG.CFrame = CFrame.new(c.PrimaryPart.Position, c.PrimaryPart.Position + cam.CFrame.LookVector)
        if h.MoveDirection.Magnitude > 0.1 then
            flyBV.Velocity = cam.CFrame.LookVector * flySpeed
        else
            flyBV.Velocity = Vector3.new(0,0,0)
        end
    end)
end

function setFly(on)
    flyEnabled = on
    if on then startFly() else stopFly() end
    flyToggle.Text = on and T("fly_on") or T("fly_off")
    flyToggle.BackgroundColor3 = on and Color3.fromRGB(0,200,80) or Color3.fromRGB(80,80,80)
    flyBtn.Text = on and T("fly_on") or T("fly")
    flyBtn.BackgroundColor3 = on and Color3.fromRGB(0,200,80) or Color3.fromRGB(40,80,200)
    showNotify(on and T("fly_on") or T("fly_off"), on and Color3.fromRGB(0,255,100) or Color3.fromRGB(255,80,80))
end
flyToggle.MouseButton1Click:Connect(function() setFly(not flyEnabled) end)

flySpeedBtn = Instance.new("TextButton")
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
    showPopup(T("fly_speed").." (1-1000)","1-1000",function(v)
        flySpeed = v
        flySpeedBtn.Text = T("fly_speed")..": "..math.floor(v)
        showNotify(T("fly_speed")..": "..math.floor(v), Color3.fromRGB(255,220,0))
    end)
end)

-- =========================================================
-- AIM ASSIST / FOV
-- Для собственного Roblox-проекта
-- =========================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- =========================================================
-- НАСТРОЙКИ
-- =========================================================

local Aimbot = {
    Enabled = false,

    Radius = 200,
    Range = 500,

    TeamCheck = true,
    VisibleCheck = true,

    FOVCircle = true,

    Target = nil
}

-- =========================================================
-- FOV CIRCLE
-- =========================================================

local fovCircle = Instance.new("Frame")
fovCircle.Name = "AimbotFOV"
fovCircle.Size = UDim2.fromOffset(
    Aimbot.Radius * 2,
    Aimbot.Radius * 2
)

fovCircle.Position = UDim2.fromScale(0.5, 0.5)
fovCircle.AnchorPoint = Vector2.new(0.5, 0.5)

fovCircle.BackgroundTransparency = 1
fovCircle.BorderSizePixel = 0

fovCircle.Visible = false
fovCircle.ZIndex = 999
fovCircle.Parent = gui

local fovCorner = Instance.new("UICorner")
fovCorner.CornerRadius = UDim.new(1, 0)
fovCorner.Parent = fovCircle

local fovStroke = Instance.new("UIStroke")
fovStroke.Thickness = 3
fovStroke.Color = Color3.fromRGB(255, 255, 255)
fovStroke.Parent = fovCircle

-- =========================================================
-- FOV LABEL
-- =========================================================

local fovLabel = Instance.new("TextLabel")

fovLabel.Name = "FOVLabel"
fovLabel.Size = UDim2.fromOffset(220, 22)

fovLabel.AnchorPoint = Vector2.new(0.5, 0)
fovLabel.Position = UDim2.new(
    0.5,
    0,
    0.5,
    Aimbot.Radius + 15
)

fovLabel.BackgroundTransparency = 1

fovLabel.Text = ""
fovLabel.TextColor3 = Color3.fromRGB(255, 255, 255)

fovLabel.TextSize = 14
fovLabel.Font = Enum.Font.GothamBold

fovLabel.TextStrokeTransparency = 0
fovLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

fovLabel.Visible = false
fovLabel.ZIndex = 1000
fovLabel.Parent = gui

-- =========================================================
-- PIXELS -> STUDS
-- =========================================================

local function pixelsToStuds(pixels)
    local camera = workspace.CurrentCamera

    if not camera then
        return 0
    end

    local viewport = camera.ViewportSize

    if viewport.Y <= 0 then
        return 0
    end

    local fov = math.rad(camera.FieldOfView)

    local pixelsPerStud =
        viewport.Y /
        (2 * math.tan(fov / 2) * 50)

    if pixelsPerStud <= 0 then
        return 0
    end

    return math.floor(pixels / pixelsPerStud)
end

-- =========================================================
-- UPDATE FOV
-- =========================================================

local function updateFOV()
    fovCircle.Size = UDim2.fromOffset(
        Aimbot.Radius * 2,
        Aimbot.Radius * 2
    )

    fovCircle.Position = UDim2.fromScale(0.5, 0.5)

    fovLabel.Position = UDim2.new(
        0.5,
        0,
        0.5,
        Aimbot.Radius + 15
    )

    fovLabel.Text =
        tostring(Aimbot.Radius) ..
        "px (~" ..
        tostring(pixelsToStuds(Aimbot.Radius)) ..
        " studs)"

    fovCircle.Visible =
        Aimbot.Enabled and Aimbot.FOVCircle

    fovLabel.Visible =
        Aimbot.Enabled and Aimbot.FOVCircle
end

-- =========================================================
-- RAYCAST
-- =========================================================

local rayParams = RaycastParams.new()

rayParams.FilterType = Enum.RaycastFilterType.Exclude
rayParams.IgnoreWater = true

local function isVisible(targetPart, character)
    local myCharacter = player.Character

    if not myCharacter then
        return false
    end

    local myHead = myCharacter:FindFirstChild("Head")

    if not myHead or not targetPart then
        return false
    end

    rayParams.FilterDescendantsInstances = {
        myCharacter,
        character
    }

    local origin = myHead.Position
    local direction = targetPart.Position - origin

    local result = workspace:Raycast(
        origin,
        direction,
        rayParams
    )

    return result == nil
end

-- =========================================================
-- CHARACTER VALIDATION
-- =========================================================

local function getCharacterInfo(target)
    if not target then
        return nil
    end

    local character = target.Character

    if not character then
        return nil
    end

    local humanoid =
        character:FindFirstChildOfClass("Humanoid")

    local head =
        character:FindFirstChild("Head")

    local root =
        character:FindFirstChild("HumanoidRootPart")

    if not humanoid or humanoid.Health <= 0 then
        return nil
    end

    if not head or not root then
        return nil
    end

    return {
        Character = character,
        Humanoid = humanoid,
        Head = head,
        Root = root
    }
end

-- =========================================================
-- TEAM CHECK
-- =========================================================

local function isEnemy(target)
    if target == player then
        return false
    end

    if not Aimbot.TeamCheck then
        return true
    end

    if not player.Team or not target.Team then
        return true
    end

    return player.Team ~= target.Team
end

-- =========================================================
-- SCREEN DISTANCE
-- =========================================================

local function getScreenDistance(part)
    local camera = workspace.CurrentCamera

    if not camera then
        return math.huge, false
    end

    local screenPosition, onScreen =
        camera:WorldToViewportPoint(part.Position)

    if not onScreen then
        return math.huge, false
    end

    local center = Vector2.new(
        camera.ViewportSize.X / 2,
        camera.ViewportSize.Y / 2
    )

    local point = Vector2.new(
        screenPosition.X,
        screenPosition.Y
    )

    return (point - center).Magnitude, true
end

-- =========================================================
-- VALIDATE CURRENT TARGET
-- =========================================================

local function isTargetValid(target)
    if not target then
        return false
    end

    local info = getCharacterInfo(target)

    if not info then
        return false
    end

    if not isEnemy(target) then
        return false
    end

    local myCharacter = player.Character

    if not myCharacter then
        return false
    end

    local myRoot =
        myCharacter:FindFirstChild("HumanoidRootPart")

    if not myRoot then
        return false
    end

    -- Дальность
    local distance =
        (info.Head.Position - myRoot.Position).Magnitude

    if distance > Aimbot.Range then
        return false
    end

    -- FOV
    local screenDistance, onScreen =
        getScreenDistance(info.Head)

    if not onScreen then
        return false
    end

    if screenDistance > Aimbot.Radius then
        return false
    end

    -- Видимость
    if Aimbot.VisibleCheck then
        if not isVisible(info.Head, info.Character) then
            return false
        end
    end

    return true
end

-- =========================================================
-- FIND BEST TARGET
-- =========================================================

local function findBestTarget()
    local myCharacter = player.Character

    if not myCharacter then
        return nil
    end

    local myHead =
        myCharacter:FindFirstChild("Head")

    local myRoot =
        myCharacter:FindFirstChild("HumanoidRootPart")

    if not myHead or not myRoot then
        return nil
    end

    local bestTarget = nil
    local bestScreenDistance = Aimbot.Radius

    for _, target in ipairs(Players:GetPlayers()) do

        if target ~= player and isEnemy(target) then

            local info = getCharacterInfo(target)

            if info then

                local distance =
                    (info.Head.Position - myHead.Position).Magnitude

                if distance <= Aimbot.Range then

                    local screenDistance, onScreen =
                        getScreenDistance(info.Head)

                    if onScreen and
                       screenDistance <= bestScreenDistance then

                        local visible = true

                        if Aimbot.VisibleCheck then
                            visible =
                                isVisible(
                                    info.Head,
                                    info.Character
                                )
                        end

                        if visible then
                            bestScreenDistance = screenDistance
                            bestTarget = target
                        end
                    end
                end
            end
        end
    end

    return bestTarget
end

-- =========================================================
-- AIM
-- =========================================================

local function aimAt(target)
    local camera = workspace.CurrentCamera

    if not camera then
        return
    end

    local info = getCharacterInfo(target)

    if not info then
        return
    end

    -- Камера смотрит на голову цели
    camera.CFrame = CFrame.lookAt(
        camera.CFrame.Position,
        info.Head.Position
    )

    -- Поворот персонажа по горизонтали
    local myCharacter = player.Character

    if not myCharacter then
        return
    end

    local root =
        myCharacter:FindFirstChild("HumanoidRootPart")

    if not root then
        return
    end

    local myPosition = root.Position

    local targetPosition = Vector3.new(
        info.Head.Position.X,
        myPosition.Y,
        info.Head.Position.Z
    )

    local direction =
        targetPosition - myPosition

    if direction.Magnitude > 0.05 then
        root.CFrame =
            CFrame.lookAt(
                myPosition,
                targetPosition
            )
    end
end

-- =========================================================
-- UI
-- =========================================================

aimbotToggle = Instance.new("TextButton")

aimbotToggle.Size = UDim2.new(1, -30, 0, 46)
aimbotToggle.Position = UDim2.fromOffset(15, 55)

aimbotToggle.BackgroundColor3 =
    Color3.fromRGB(80, 80, 80)

aimbotToggle.Text =
    T("aimbot_off")

aimbotToggle.TextColor3 =
    Color3.fromRGB(255, 255, 255)

aimbotToggle.TextSize = 16
aimbotToggle.Font = Enum.Font.GothamBold

aimbotToggle.Parent = aimbotMenu

Instance.new(
    "UICorner",
    aimbotToggle
).CornerRadius = UDim.new(0, 11)

aimbotToggle.MouseButton1Click:Connect(function()

    Aimbot.Enabled = not Aimbot.Enabled

    if not Aimbot.Enabled then
        Aimbot.Target = nil
    end

    aimbotToggle.Text =
        Aimbot.Enabled
        and T("aimbot_on")
        or T("aimbot_off")

    aimbotToggle.BackgroundColor3 =
        Aimbot.Enabled
        and Color3.fromRGB(0, 200, 80)
        or Color3.fromRGB(80, 80, 80)

    updateFOV()

    showNotify(
        Aimbot.Enabled
        and T("aimbot_on")
        or T("aimbot_off"),

        Aimbot.Enabled
        and Color3.fromRGB(0, 255, 100)
        or Color3.fromRGB(255, 80, 80)
    )
end)

-- =========================================================
-- FOV SIZE
-- =========================================================

aimbotRadiusBtn = Instance.new("TextButton")

aimbotRadiusBtn.Size =
    UDim2.new(1, -30, 0, 46)

aimbotRadiusBtn.Position =
    UDim2.fromOffset(15, 105)

aimbotRadiusBtn.BackgroundColor3 =
    Color3.fromRGB(28, 28, 35)

aimbotRadiusBtn.Text =
    T("fov") .. ": " ..
    Aimbot.Radius .. "px"

aimbotRadiusBtn.TextColor3 =
    Color3.fromRGB(255, 255, 255)

aimbotRadiusBtn.TextSize = 15
aimbotRadiusBtn.Font = Enum.Font.GothamBold

aimbotRadiusBtn.Parent = aimbotMenu

Instance.new(
    "UICorner",
    aimbotRadiusBtn
).CornerRadius = UDim.new(0, 11)

aimbotRadiusBtn.MouseButton1Click:Connect(function()

    showPopup(
        T("fov") .. " (50-500px)",
        "50-500",

        function(value)

            value = math.clamp(
                tonumber(value) or Aimbot.Radius,
                50,
                500
            )

            Aimbot.Radius = value

            aimbotRadiusBtn.Text =
                T("fov") ..
                ": " ..
                math.floor(value) ..
                "px"

            updateFOV()
        end
    )
end)

-- =========================================================
-- FOV CIRCLE TOGGLE
-- =========================================================

fovCircleBtn = Instance.new("TextButton")

fovCircleBtn.Size =
    UDim2.new(1, -30, 0, 46)

fovCircleBtn.Position =
    UDim2.fromOffset(15, 155)

fovCircleBtn.BackgroundColor3 =
    Color3.fromRGB(0, 200, 80)

fovCircleBtn.Text =
    T("fov_circle") ..
    ": " ..
    T("on")

fovCircleBtn.TextColor3 =
    Color3.fromRGB(255, 255, 255)

fovCircleBtn.TextSize = 15
fovCircleBtn.Font = Enum.Font.GothamBold

fovCircleBtn.Parent = aimbotMenu

Instance.new(
    "UICorner",
    fovCircleBtn
).CornerRadius = UDim.new(0, 11)

fovCircleBtn.MouseButton1Click:Connect(function()

    Aimbot.FOVCircle =
        not Aimbot.FOVCircle

    fovCircleBtn.Text =
        T("fov_circle") ..
        ": " ..
        (
            Aimbot.FOVCircle
            and T("on")
            or T("off")
        )

    fovCircleBtn.BackgroundColor3 =
        Aimbot.FOVCircle
        and Color3.fromRGB(0, 200, 80)
        or Color3.fromRGB(80, 80, 80)

    updateFOV()
end)

-- =========================================================
-- RANGE
-- =========================================================

aimbotRangeBtn = Instance.new("TextButton")

aimbotRangeBtn.Size =
    UDim2.new(1, -30, 0, 46)

aimbotRangeBtn.Position =
    UDim2.fromOffset(15, 205)

aimbotRangeBtn.BackgroundColor3 =
    Color3.fromRGB(28, 28, 35)

aimbotRangeBtn.Text =
    T("range") ..
    ": " ..
    Aimbot.Range ..
    " studs"

aimbotRangeBtn.TextColor3 =
    Color3.fromRGB(255, 255, 255)

aimbotRangeBtn.TextSize = 15
aimbotRangeBtn.Font = Enum.Font.GothamBold

aimbotRangeBtn.Parent = aimbotMenu

Instance.new(
    "UICorner",
    aimbotRangeBtn
).CornerRadius = UDim.new(0, 11)

aimbotRangeBtn.MouseButton1Click:Connect(function()

    showPopup(
        T("range") .. " (10-2000)",
        "10-2000",

        function(value)

            value = math.clamp(
                tonumber(value) or Aimbot.Range,
                10,
                2000
            )

            Aimbot.Range = value

            aimbotRangeBtn.Text =
                T("range") ..
                ": " ..
                math.floor(value) ..
                " studs"
        end
    )
end)

-- =========================================================
-- TEAM CHECK
-- =========================================================

aimbotTeamBtn = Instance.new("TextButton")

aimbotTeamBtn.Size =
    UDim2.new(1, -30, 0, 46)

aimbotTeamBtn.Position =
    UDim2.fromOffset(15, 255)

aimbotTeamBtn.BackgroundColor3 =
    Color3.fromRGB(0, 200, 80)

aimbotTeamBtn.Text =
    T("team_check") ..
    ": " ..
    T("on")

aimbotTeamBtn.TextColor3 =
    Color3.fromRGB(255, 255, 255)

aimbotTeamBtn.TextSize = 15
aimbotTeamBtn.Font = Enum.Font.GothamBold

aimbotTeamBtn.Parent = aimbotMenu

Instance.new(
    "UICorner",
    aimbotTeamBtn
).CornerRadius = UDim.new(0, 11)

aimbotTeamBtn.MouseButton1Click:Connect(function()

    Aimbot.TeamCheck =
        not Aimbot.TeamCheck

    aimbotTeamBtn.Text =
        T("team_check") ..
        ": " ..
        (
            Aimbot.TeamCheck
            and T("on")
            or T("off")
        )

    aimbotTeamBtn.BackgroundColor3 =
        Aimbot.TeamCheck
        and Color3.fromRGB(0, 200, 80)
        or Color3.fromRGB(80, 80, 80)
end)

-- =========================================================
-- VISIBLE CHECK
-- =========================================================

visibleBtn = Instance.new("TextButton")

visibleBtn.Size =
    UDim2.new(1, -30, 0, 46)

visibleBtn.Position =
    UDim2.fromOffset(15, 305)

visibleBtn.BackgroundColor3 =
    Color3.fromRGB(0, 200, 80)

visibleBtn.Text =
    T("visible_check") ..
    ": " ..
    T("on")

visibleBtn.TextColor3 =
    Color3.fromRGB(255, 255, 255)

visibleBtn.TextSize = 15
visibleBtn.Font = Enum.Font.GothamBold

visibleBtn.Parent = aimbotMenu

Instance.new(
    "UICorner",
    visibleBtn
).CornerRadius = UDim.new(0, 11)

visibleBtn.MouseButton1Click:Connect(function()

    Aimbot.VisibleCheck =
        not Aimbot.VisibleCheck

    visibleBtn.Text =
        T("visible_check") ..
        ": " ..
        (
            Aimbot.VisibleCheck
            and T("on")
            or T("off")
        )

    visibleBtn.BackgroundColor3 =
        Aimbot.VisibleCheck
        and Color3.fromRGB(0, 200, 80)
        or Color3.fromRGB(80, 80, 80)
end)

-- =========================================================
-- MAIN LOOP
-- =========================================================

RunService.RenderStepped:Connect(function()

    local camera = workspace.CurrentCamera

    if not camera then
        return
    end

    -- FOV
    if Aimbot.Enabled and Aimbot.FOVCircle then
        fovCircle.Visible = true
        fovLabel.Visible = true
    else
        fovCircle.Visible = false
        fovLabel.Visible = false
    end

    if not Aimbot.Enabled then
        Aimbot.Target = nil
        return
    end

    -- Проверяем существующую цель
    if Aimbot.Target then

        if not isTargetValid(Aimbot.Target) then
            Aimbot.Target = nil
        end
    end

    -- Если цели нет — ищем новую
    if not Aimbot.Target then
        Aimbot.Target = findBestTarget()
    end

    -- Наведение
    if Aimbot.Target then

        fovStroke.Color =
            Color3.fromRGB(0, 255, 100)

        aimAt(Aimbot.Target)

    else

        fovStroke.Color =
            Color3.fromRGB(255, 255, 255)
    end
end)

-- =========================================================
-- INITIAL UPDATE
-- =========================================================

updateFOV()
-- ========== MISC (СО СКРОЛЛОМ) ==========
miscMenu, miscTitle, miscBack = createSubmenu(T("misc"))
noclipEnabled = false
noclipConn = nil
fullbrightEnabled = false
origLighting = {Ambient=Lighting.Ambient, Outdoor=Lighting.OutdoorAmbient, Brightness=Lighting.Brightness}

-- Скролл-контейнер для кнопок
miscScroll = Instance.new("ScrollingFrame")
miscScroll.Size = UDim2.new(1,-10,1,-70)
miscScroll.Position = UDim2.fromOffset(5,60)
miscScroll.BackgroundTransparency = 1
miscScroll.BorderSizePixel = 0
miscScroll.ScrollBarThickness = 5
miscScroll.ScrollBarImageColor3 = Color3.fromRGB(80,80,110)
miscScroll.CanvasSize = UDim2.new(0,0,0,600)
miscScroll.Parent = miscMenu

noclipBtn = Instance.new("TextButton")
noclipBtn.Size = UDim2.new(1,-20,0,48)
noclipBtn.Position = UDim2.fromOffset(5,0)
noclipBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
noclipBtn.Text = T("noclip")..": "..T("off")
noclipBtn.TextColor3 = Color3.new(1,1,1)
noclipBtn.TextSize = 15
noclipBtn.Font = Enum.Font.GothamBold
noclipBtn.Parent = miscScroll
Instance.new("UICorner",noclipBtn).CornerRadius = UDim.new(0,11)
noclipBtn.MouseButton1Click:Connect(function()
    noclipEnabled = not noclipEnabled
    if noclipEnabled then
        noclipConn = RunService.Heartbeat:Connect(function()
            local char = player.Character
            if char then
                for _,p in ipairs(char:GetDescendants()) do
                    if p:IsA("BasePart") then p.CanCollide=false end
                end
            end
        end)
        noclipBtn.Text = T("noclip")..": "..T("on")
        noclipBtn.BackgroundColor3 = Color3.fromRGB(0,200,80)
        showNotify(T("noclip")..": "..T("on"), Color3.fromRGB(0,255,100))
    else
        if noclipConn then noclipConn:Disconnect(); noclipConn=nil end
        local char = player.Character
        if char then
            for _,p in ipairs(char:GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide=true end
            end
        end
        noclipBtn.Text = T("noclip")..": "..T("off")
        noclipBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
        showNotify(T("noclip")..": "..T("off"), Color3.fromRGB(255,80,80))
    end
end)

fullbrightBtn = Instance.new("TextButton")
fullbrightBtn.Size = UDim2.new(1,-20,0,48)
fullbrightBtn.Position = UDim2.fromOffset(5,54)
fullbrightBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
fullbrightBtn.Text = T("fullbright")..": "..T("off")
fullbrightBtn.TextColor3 = Color3.new(1,1,1)
fullbrightBtn.TextSize = 15
fullbrightBtn.Font = Enum.Font.GothamBold
fullbrightBtn.Parent = miscScroll
Instance.new("UICorner",fullbrightBtn).CornerRadius = UDim.new(0,11)
fullbrightBtn.MouseButton1Click:Connect(function()
    fullbrightEnabled = not fullbrightEnabled
    if fullbrightEnabled then
        Lighting.Ambient = Color3.fromRGB(255,255,255)
        Lighting.OutdoorAmbient = Color3.fromRGB(255,255,255)
        Lighting.Brightness = 3
        fullbrightBtn.Text = T("fullbright")..": "..T("on")
        fullbrightBtn.BackgroundColor3 = Color3.fromRGB(0,200,80)
        showNotify(T("fullbright")..": "..T("on"), Color3.fromRGB(0,255,100))
    else
        Lighting.Ambient = origLighting.Ambient
        Lighting.OutdoorAmbient = origLighting.Outdoor
        Lighting.Brightness = origLighting.Brightness
        fullbrightBtn.Text = T("fullbright")..": "..T("off")
        fullbrightBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
        showNotify(T("fullbright")..": "..T("off"), Color3.fromRGB(255,80,80))
    end
end)

tpPlayerBtn = Instance.new("TextButton")
tpPlayerBtn.Size = UDim2.new(1,-20,0,48)
tpPlayerBtn.Position = UDim2.fromOffset(5,108)
tpPlayerBtn.BackgroundColor3 = Color3.fromRGB(28,28,35)
tpPlayerBtn.Text = T("tp_player")
tpPlayerBtn.TextColor3 = Color3.new(1,1,1)
tpPlayerBtn.TextSize = 15
tpPlayerBtn.Font = Enum.Font.GothamBold
tpPlayerBtn.Parent = miscScroll
Instance.new("UICorner",tpPlayerBtn).CornerRadius = UDim.new(0,11)

antiAfkEnabled = false
antiAfkConn = nil
antiAfkBtn = Instance.new("TextButton")
antiAfkBtn.Size = UDim2.new(1,-20,0,48)
antiAfkBtn.Position = UDim2.fromOffset(5,162)
antiAfkBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
antiAfkBtn.Text = T("anti_afk")..": "..T("off")
antiAfkBtn.TextColor3 = Color3.new(1,1,1)
antiAfkBtn.TextSize = 15
antiAfkBtn.Font = Enum.Font.GothamBold
antiAfkBtn.Parent = miscScroll
Instance.new("UICorner",antiAfkBtn).CornerRadius = UDim.new(0,11)
antiAfkBtn.MouseButton1Click:Connect(function()
    antiAfkEnabled = not antiAfkEnabled
    if antiAfkEnabled then
        antiAfkConn = RunService.Heartbeat:Connect(function()
            VU:CaptureController()
            VU:ClickButton2(Vector2.new())
        end)
        antiAfkBtn.Text = T("anti_afk")..": "..T("on")
        antiAfkBtn.BackgroundColor3 = Color3.fromRGB(0,200,80)
        showNotify(T("anti_afk")..": "..T("on"), Color3.fromRGB(0,255,100))
    else
        if antiAfkConn then antiAfkConn:Disconnect(); antiAfkConn=nil end
        antiAfkBtn.Text = T("anti_afk")..": "..T("off")
        antiAfkBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
        showNotify(T("anti_afk")..": "..T("off"), Color3.fromRGB(255,80,80))
    end
end)

fpsBoostEnabled = false
origSettings = {}
fpsBoostBtn = Instance.new("TextButton")
fpsBoostBtn.Size = UDim2.new(1,-20,0,48)
fpsBoostBtn.Position = UDim2.fromOffset(5,216)
fpsBoostBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
fpsBoostBtn.Text = T("fps_boost")..": "..T("off")
fpsBoostBtn.TextColor3 = Color3.new(1,1,1)
fpsBoostBtn.TextSize = 15
fpsBoostBtn.Font = Enum.Font.GothamBold
fpsBoostBtn.Parent = miscScroll
Instance.new("UICorner",fpsBoostBtn).CornerRadius = UDim.new(0,11)
fpsBoostBtn.MouseButton1Click:Connect(function()
    fpsBoostEnabled = not fpsBoostEnabled
    if fpsBoostEnabled then
        pcall(function()
            settings().Rendering.QualityLevel = 1
            settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level01
        end)
        for _,obj in ipairs(game:GetDescendants()) do
            if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
                if obj.Enabled then origSettings[obj]=true; obj.Enabled=false end
            elseif obj:IsA("Decal") or obj:IsA("Texture") then
                origSettings[obj]=obj.Transparency; obj.Transparency=1
            end
        end
        fpsBoostBtn.Text = T("fps_boost")..": "..T("on")
        fpsBoostBtn.BackgroundColor3 = Color3.fromRGB(0,200,80)
        showNotify(T("fps_boost")..": "..T("on"), Color3.fromRGB(0,255,100))
    else
        pcall(function()
            settings().Rendering.QualityLevel = 7
            settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level04
        end)
        for obj,val in pairs(origSettings) do
            if obj and obj.Parent then
                if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
                    obj.Enabled=true
                elseif obj:IsA("Decal") or obj:IsA("Texture") then
                    obj.Transparency=val
                end
            end
        end
        origSettings = {}
        fpsBoostBtn.Text = T("fps_boost")..": "..T("off")
        fpsBoostBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
        showNotify(T("fps_boost")..": "..T("off"), Color3.fromRGB(255,80,80))
    end
end)

fastClickEnabled = false
clickDelay = 0.001
fastClickBtn = Instance.new("TextButton")
fastClickBtn.Size = UDim2.new(1,-20,0,48)
fastClickBtn.Position = UDim2.fromOffset(5,270)
fastClickBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
fastClickBtn.Text = T("fast_click_off")
fastClickBtn.TextColor3 = Color3.new(1,1,1)
fastClickBtn.TextSize = 15
fastClickBtn.Font = Enum.Font.GothamBold
fastClickBtn.Parent = miscScroll
Instance.new("UICorner",fastClickBtn).CornerRadius = UDim.new(0,11)
fastClickBtn.MouseButton1Click:Connect(function()
    fastClickEnabled = not fastClickEnabled
    fastClickBtn.Text = fastClickEnabled and T("fast_click_on") or T("fast_click_off")
    fastClickBtn.BackgroundColor3 = fastClickEnabled and Color3.fromRGB(0,200,80) or Color3.fromRGB(80,80,80)
    showNotify(fastClickEnabled and T("fast_click_on") or T("fast_click_off"), fastClickEnabled and Color3.fromRGB(0,255,100) or Color3.fromRGB(255,80,80))
end)

clickDelayBtn = Instance.new("TextButton")
clickDelayBtn.Size = UDim2.new(1,-20,0,44)
clickDelayBtn.Position = UDim2.fromOffset(5,324)
clickDelayBtn.BackgroundColor3 = Color3.fromRGB(28,28,35)
clickDelayBtn.Text = T("click_delay")..": 0.001"
clickDelayBtn.TextColor3 = Color3.new(1,1,1)
clickDelayBtn.TextSize = 15
clickDelayBtn.Font = Enum.Font.GothamBold
clickDelayBtn.Parent = miscScroll
Instance.new("UICorner",clickDelayBtn).CornerRadius = UDim.new(0,11)
clickDelayBtn.MouseButton1Click:Connect(function()
    showPopup(T("click_delay").." (1-100)","1",function(v)
        clickDelay = math.clamp(v/1000, 0.001, 0.1)
        clickDelayBtn.Text = T("click_delay")..": "..string.format("%.3f", clickDelay)
    end)
end)

task.spawn(function()
    while true do
        if fastClickEnabled then
            pcall(function()
                VIM:SendMouseButtonEvent(0,0,0,true,game,0)
                task.wait(0.0001)
                VIM:SendMouseButtonEvent(0,0,0,false,game,0)
            end)
            task.wait(clickDelay)
        else
            task.wait(0.1)
        end
    end
end)

spinBotEnabled = false
spinSpeed = 15
spinConn = nil

spinBotBtn = Instance.new("TextButton")
spinBotBtn.Size = UDim2.new(1,-20,0,48)
spinBotBtn.Position = UDim2.fromOffset(5,378)
spinBotBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
spinBotBtn.Text = T("spin_bot")..": "..T("off")
spinBotBtn.TextColor3 = Color3.new(1,1,1)
spinBotBtn.TextSize = 15
spinBotBtn.Font = Enum.Font.GothamBold
spinBotBtn.Parent = miscScroll
Instance.new("UICorner",spinBotBtn).CornerRadius = UDim.new(0,11)
spinBotBtn.MouseButton1Click:Connect(function()
    spinBotEnabled = not spinBotEnabled
    if spinBotEnabled then
        local char = player.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then hum.AutoRotate = false end
        spinConn = RunService.Heartbeat:Connect(function()
            local c = player.Character
            if not c then return end
            local hrp = c:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            local h = c:FindFirstChildOfClass("Humanoid")
            if h then h.AutoRotate = false end
            hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(spinSpeed), 0)
        end)
        spinBotBtn.Text = T("spin_bot")..": "..T("on")
        spinBotBtn.BackgroundColor3 = Color3.fromRGB(0,200,80)
        showNotify(T("spin_bot")..": "..T("on"), Color3.fromRGB(0,255,100))
    else
        if spinConn then spinConn:Disconnect(); spinConn = nil end
        local char = player.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then hum.AutoRotate = true end
        spinBotBtn.Text = T("spin_bot")..": "..T("off")
        spinBotBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
        showNotify(T("spin_bot")..": "..T("off"), Color3.fromRGB(255,80,80))
    end
end)

bunnyHopEnabled = false
bunnyHopConn = nil

bunnyHopBtn = Instance.new("TextButton")
bunnyHopBtn.Size = UDim2.new(1,-20,0,48)
bunnyHopBtn.Position = UDim2.fromOffset(5,432)
bunnyHopBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
bunnyHopBtn.Text = T("bunny_hop")..": "..T("off")
bunnyHopBtn.TextColor3 = Color3.new(1,1,1)
bunnyHopBtn.TextSize = 15
bunnyHopBtn.Font = Enum.Font.GothamBold
bunnyHopBtn.Parent = miscScroll
Instance.new("UICorner",bunnyHopBtn).CornerRadius = UDim.new(0,11)
bunnyHopBtn.MouseButton1Click:Connect(function()
    bunnyHopEnabled = not bunnyHopEnabled
    if bunnyHopEnabled then
        bunnyHopConn = RunService.Heartbeat:Connect(function()
            local char = player.Character
            if not char then return end
            local hum = char:FindFirstChildOfClass("Humanoid")
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hum or not hrp then return end
            local state = hum:GetState()
            if state == Enum.HumanoidStateType.Running or state == Enum.HumanoidStateType.Landed then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
            end
            if state == Enum.HumanoidStateType.Freefall then
                local moveDir = hum.MoveDirection
                if moveDir.Magnitude > 0.1 then
                    hrp.Velocity = Vector3.new(moveDir.X * 25, hrp.Velocity.Y, moveDir.Z * 25)
                end
            end
        end)
        bunnyHopBtn.Text = T("bunny_hop")..": "..T("on")
        bunnyHopBtn.BackgroundColor3 = Color3.fromRGB(0,200,80)
        showNotify(T("bunny_hop")..": "..T("on"), Color3.fromRGB(0,255,100))
    else
        if bunnyHopConn then bunnyHopConn:Disconnect(); bunnyHopConn = nil end
        bunnyHopBtn.Text = T("bunny_hop")..": "..T("off")
        bunnyHopBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
        showNotify(T("bunny_hop")..": "..T("off"), Color3.fromRGB(255,80,80))
    end
end)

-- ========== TP TO PLAYER ==========
tpMenu, tpTitle, tpBack = createSubmenu(T("tp_player"))
tpScroll = Instance.new("ScrollingFrame")
tpScroll.Size = UDim2.new(1,-20,1,-70)
tpScroll.Position = UDim2.fromOffset(10,60)
tpScroll.BackgroundTransparency = 1
tpScroll.BorderSizePixel = 0
tpScroll.ScrollBarThickness = 5
tpScroll.ScrollBarImageColor3 = Color3.fromRGB(80,80,110)
tpScroll.CanvasSize = UDim2.new(0,0,0,0)
tpScroll.Parent = tpMenu

function refreshTPList()
    for _,c in ipairs(tpScroll:GetChildren()) do
        if c:IsA("TextButton") or c:IsA("TextLabel") then c:Destroy() end
    end
    local y, count = 0, 0
    for _,p in ipairs(Players:GetPlayers()) do
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
                        showNotify("TP: "..p.Name, Color3.fromRGB(0,255,100))
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
settingsMenu, settingsTitle, settingsBack = createSubmenu(T("settings"))

currentLangLabel = Instance.new("TextLabel")
currentLangLabel.Size = UDim2.new(1,-30,0,40)
currentLangLabel.Position = UDim2.fromOffset(15,65)
currentLangLabel.BackgroundTransparency = 1
currentLangLabel.Text = (currentLang=="EN") and "Current language: EN" or "Текущий язык: RU"
currentLangLabel.TextColor3 = Color3.new(1,1,1)
currentLangLabel.TextSize = 16
currentLangLabel.Font = Enum.Font.GothamBold
currentLangLabel.TextXAlignment = Enum.TextXAlignment.Left
currentLangLabel.Parent = settingsMenu

langENBtn = Instance.new("TextButton")
langENBtn.Size = UDim2.new(1,-30,0,55)
langENBtn.Position = UDim2.fromOffset(15,115)
langENBtn.BackgroundColor3 = (currentLang=="EN") and Color3.fromRGB(0,150,80) or Color3.fromRGB(35,35,45)
langENBtn.Text = "English"
langENBtn.TextColor3 = Color3.new(1,1,1)
langENBtn.TextSize = 18
langENBtn.Font = Enum.Font.GothamBold
langENBtn.Parent = settingsMenu
Instance.new("UICorner",langENBtn).CornerRadius = UDim.new(0,11)

langRUBtn = Instance.new("TextButton")
langRUBtn.Size = UDim2.new(1,-30,0,55)
langRUBtn.Position = UDim2.fromOffset(15,180)
langRUBtn.BackgroundColor3 = (currentLang=="RU") and Color3.fromRGB(0,150,80) or Color3.fromRGB(35,35,45)
langRUBtn.Text = "Русский"
langRUBtn.TextColor3 = Color3.new(1,1,1)
langRUBtn.TextSize = 18
langRUBtn.Font = Enum.Font.GothamBold
langRUBtn.Parent = settingsMenu
Instance.new("UICorner",langRUBtn).CornerRadius = UDim.new(0,11)

settingsInfo = Instance.new("TextLabel")
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

function applyLanguage()
    for _,obj in ipairs(gui:GetDescendants()) do
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
    visibleBtn.Text = T("visible_check")..": "..(aimbotVisibleCheck and T("on") or T("off"))
    noclipBtn.Text = T("noclip")..": "..(noclipEnabled and T("on") or T("off"))
    fullbrightBtn.Text = T("fullbright")..": "..(fullbrightEnabled and T("on") or T("off"))
    tpPlayerBtn.Text = T("tp_player")
    antiAfkBtn.Text = T("anti_afk")..": "..(antiAfkEnabled and T("on") or T("off"))
    fpsBoostBtn.Text = T("fps_boost")..": "..(fpsBoostEnabled and T("on") or T("off"))
    fastClickBtn.Text = fastClickEnabled and T("fast_click_on") or T("fast_click_off")
    clickDelayBtn.Text = T("click_delay")..": "..string.format("%.3f", clickDelay)
    spinBotBtn.Text = T("spin_bot")..": "..(spinBotEnabled and T("on") or T("off"))
    bunnyHopBtn.Text = T("bunny_hop")..": "..(bunnyHopEnabled and T("on") or T("off"))
    popupOk.Text = T("ok")
    popupBox.PlaceholderText = T("enter_value")
    title.Text = T("title")
    playerTitle.Text = T("player")
    aimbotTitle.Text = T("aimbot")
    miscTitle.Text = T("misc")
    settingsTitle.Text = T("settings")
    tpTitle.Text = T("tp_player")
    if currentLangLabel then
        currentLangLabel.Text = (currentLang=="EN") and "Current language: EN" or "Текущий язык: RU"
    end
    if langENBtn then langENBtn.BackgroundColor3 = (currentLang=="EN") and Color3.fromRGB(0,150,80) or Color3.fromRGB(35,35,45) end
    if langRUBtn then langRUBtn.BackgroundColor3 = (currentLang=="RU") and Color3.fromRGB(0,150,80) or Color3.fromRGB(35,35,45) end
end
langENBtn.MouseButton1Click:Connect(function() currentLang="EN"; applyLanguage(); showNotify("Language: EN", Color3.fromRGB(255,220,0)) end)
langRUBtn.MouseButton1Click:Connect(function() currentLang="RU"; applyLanguage(); showNotify("Язык: RU", Color3.fromRGB(255,220,0)) end)

-- ========== SPEED FIX ==========
RunService.Heartbeat:Connect(function()
    local char = player.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    if hum.WalkSpeed ~= currentSpeed then hum.WalkSpeed = currentSpeed end
end)

-- ========== НАВИГАЦИЯ ==========
function backToMain(f)
    closeFrame(f)
    task.wait(.05)
    openMain()
end
function openSub(f,w,h)
    menu.Visible = false
    openFrame(f,w,h)
end

espBack.Activated:Connect(function() backToMain(espMenu) end)
playerBack.Activated:Connect(function() backToMain(playerMenu) end)
flyBack.Activated:Connect(function() setFly(false); backToMain(flyMenu) end)
aimbotBack.Activated:Connect(function() backToMain(aimbotMenu) end)
miscBack.Activated:Connect(function() backToMain(miscMenu) end)
tpBack.Activated:Connect(function() backToMain(tpMenu) end)
settingsBack.Activated:Connect(function() backToMain(settingsMenu) end)
close.Activated:Connect(hideMain)

mainButtons[1].Activated:Connect(function() openSub(espMenu,340,290) end)
mainButtons[2].Activated:Connect(function() openSub(playerMenu,340,280) end)
mainButtons[3].Activated:Connect(function() openSub(aimbotMenu,340,370) end)
mainButtons[4].Activated:Connect(function() openSub(miscMenu,340,340) end)
mainButtons[5].Activated:Connect(function() openSub(settingsMenu,340,340) end)

flyBtn.Activated:Connect(function()
    closeFrame(playerMenu)
    task.wait(.05)
    openFrame(flyMenu,340,200)
end)
tpPlayerBtn.Activated:Connect(function()
    refreshTPList()
    closeFrame(miscMenu)
    task.wait(.05)
    openFrame(tpMenu,260,340)
end)

-- ========== DRAG ==========
function makeDraggable(frame, dragArea)
    local dragging, startPos, startAbs = false,nil,nil
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
            frame.Position = UDim2.fromOffset(startAbs.X+d.X, startAbs.Y+d.Y)
        end
    end)
    UIS.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.Touch or inp.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

makeDraggable(menu,title)
makeDraggable(espMenu,espTitle)
makeDraggable(playerMenu,playerTitle)
makeDraggable(flyMenu,flyTitle)
makeDraggable(aimbotMenu,aimbotTitle)
makeDraggable(miscMenu,miscTitle)
makeDraggable(tpMenu,tpTitle)
makeDraggable(settingsMenu,settingsTitle)
makeDraggable(inputPopup,popupTitle)

-- ========== DRAG ИКОНКИ + ОТКРЫТИЕ ==========
iDrag, iStartPos, iStartPosPos = false,nil,nil
iMoved = false
iDownTime = 0
icon.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.Touch or inp.UserInputType == Enum.UserInputType.MouseButton1 then
        iDrag = true
        iMoved = false
        iStartPos = inp.Position
        iStartPosPos = icon.Position
        iDownTime = tick()
    end
end)
UIS.InputChanged:Connect(function(inp)
    if iDrag and (inp.UserInputType == Enum.UserInputType.Touch or inp.UserInputType == Enum.UserInputType.MouseMovement) then
        local d = inp.Position - iStartPos
        if d.Magnitude > 5 then iMoved = true end
        icon.Position = UDim2.new(iStartPosPos.X.Scale, iStartPosPos.X.Offset+d.X, iStartPosPos.Y.Scale, iStartPosPos.Y.Offset+d.Y)
    end
end)
UIS.InputEnded:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.Touch or inp.UserInputType == Enum.UserInputType.MouseButton1 then
        iDrag = false
        if not iMoved and (tick()-iDownTime) < 0.5 then
            if menu.Visible then hideMain() else openMain() end
        end
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
print("† PART 2/2 LOADED — ALL SYSTEMS GO †")
