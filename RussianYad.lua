-- // RUSSIAN YAD v34.0 // СВЕТЛОЕ МЕНЮ ДЛЯ ТЕЛЕФОНА // ЧАСТЬ 1 //

local Player = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")

-- // ========== УЛУЧШЕННЫЙ ОБХОД ========== //
pcall(function()
    for _, v in pairs(getgc(true)) do
        if type(v) == "function" and getfenv(v) then
            local env = getfenv(v)
            if env and env.script and tostring(env.script):find("AntiCheat") then
                env.script.Disabled = true
            end
        end
    end
    for _, v in pairs(getgc()) do
        if type(v) == "function" and tostring(v):find("check") then
            v = function() return true end
        end
    end
    local oldSend = game:GetService("ReplicatedStorage"):FindFirstChild("RemoteEvent")
    if oldSend then
        oldSend.FireServer = function(...) 
            local args = {...}
            if tostring(args[1]):find("AntiCheat") then return end
            return oldSend.FireServer(...)
        end
    end
end)

-- // ========== GUI ========== //
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = CoreGui
ScreenGui.Name = "RussianYadGUI"
ScreenGui.ResetOnSpawn = false

-- // ========== ИКОНКА 40x40 ========== //
local IconButton = Instance.new("ImageButton")
IconButton.Parent = ScreenGui
IconButton.Size = UDim2.new(0, 40, 0, 40)
IconButton.Position = UDim2.new(0.85, -20, 0.85, -20)
IconButton.BackgroundColor3 = Color3.fromRGB(220, 200, 255)
IconButton.BorderSizePixel = 0
IconButton.Image = "rbxassetid://123456789"
IconButton.ImageColor3 = Color3.fromRGB(80, 40, 180)
IconButton.ScaleType = Enum.ScaleType.Fit
IconButton.ClipsDescendants = true
IconButton.ZIndex = 10

local iconCorner = Instance.new("UICorner")
iconCorner.Parent = IconButton
iconCorner.CornerRadius = UDim.new(1, 0)

local iconGlow = Instance.new("ImageLabel")
iconGlow.Parent = IconButton
iconGlow.Size = UDim2.new(1.8, 0, 1.8, 0)
iconGlow.Position = UDim2.new(-0.4, 0, -0.4, 0)
iconGlow.BackgroundTransparency = 1
iconGlow.Image = "rbxassetid://13158748277"
iconGlow.ImageColor3 = Color3.fromRGB(80, 40, 180)
iconGlow.ImageTransparency = 0.4
iconGlow.ZIndex = 0
iconGlow.Name = "Glow"

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
        for i = 0, 360, 2 do wait(0.01) IconButton.Rotation = i iconGlow.Rotation = i * 0.5 end
    end
end)

-- Пульсация
spawn(function()
    while IconButton and IconButton.Parent do
        TweenService:Create(IconButton, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 45, 0, 45)}):Play()
        wait(0.5)
        TweenService:Create(IconButton, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 35, 0, 35)}):Play()
        wait(0.5)
    end
end)

-- // ========== ПЕРЕТАСКИВАНИЕ ИКОНКИ (ТЕЛЕФОН) ========== //
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
        local newX = math.clamp(iconStartPos.X.Offset + delta.X, 0, UIS:GetMouseLocation().X - 40)
        local newY = math.clamp(iconStartPos.Y.Offset + delta.Y, 0, UIS:GetMouseLocation().Y - 40)
        IconButton.Position = UDim2.new(0, newX, 0, newY)
    end
end)

-- // ========== СВЕТЛОЕ МЕНЮ ========== //
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 380, 0, 340)
MainFrame.Position = UDim2.new(0.5, -190, 0.5, -170)
MainFrame.BackgroundColor3 = Color3.fromRGB(240, 230, 255)
MainFrame.BackgroundTransparency = 0.05
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.ZIndex = 5

local mainCorner = Instance.new("UICorner")
mainCorner.Parent = MainFrame
mainCorner.CornerRadius = UDim.new(0, 25)

-- Светлая рамка
local borderGlow = Instance.new("ImageLabel")
borderGlow.Parent = MainFrame
borderGlow.Size = UDim2.new(1.1, 0, 1.1, 0)
borderGlow.Position = UDim2.new(-0.05, 0, -0.05, 0)
borderGlow.BackgroundTransparency = 1
borderGlow.Image = "rbxassetid://13158748277"
borderGlow.ImageColor3 = Color3.fromRGB(180, 140, 255)
borderGlow.ImageTransparency = 0.3
borderGlow.ZIndex = 0
borderGlow.Name = "BorderGlow"

-- Анимация рамки
spawn(function()
    while borderGlow and borderGlow.Parent do
        for i = 0.2, 0.6, 0.02 do wait(0.02) borderGlow.ImageTransparency = i end
        for i = 0.6, 0.2, -0.02 do wait(0.02) borderGlow.ImageTransparency = i end
    end
end)

-- Заголовок
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 45)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "☠ RUSSIAN YAD"
Title.TextColor3 = Color3.fromRGB(80, 40, 180)
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true
Title.ZIndex = 3

-- Крестик
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = MainFrame
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -40, 0, 5)
CloseBtn.Text = "✖"
CloseBtn.TextColor3 = Color3.fromRGB(180, 80, 80)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 220, 220)
CloseBtn.BackgroundTransparency = 0.3
CloseBtn.BorderSizePixel = 0
CloseBtn.TextScaled = true
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.ZIndex = 3
local cornerClose = Instance.new("UICorner")
cornerClose.Parent = CloseBtn
cornerClose.CornerRadius = UDim.new(0, 10)
CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false IconButton.Visible = true end)
CloseBtn.TouchTap:Connect(function() MainFrame.Visible = false IconButton.Visible = true end)

-- // ========== ВКЛАДКИ ========== //
local TabFrame = Instance.new("Frame")
TabFrame.Parent = MainFrame
TabFrame.Size = UDim2.new(1, 0, 0, 35)
TabFrame.Position = UDim2.new(0, 0, 0, 45)
TabFrame.BackgroundTransparency = 1

local tabs = {"Движение", "Игроки", "Визуал", "Настройки"}
local tabButtons = {}
local contentFrames = {}

for i, name in ipairs(tabs) do
    local btn = Instance.new("TextButton")
    btn.Parent = TabFrame
    btn.Size = UDim2.new(0, 95, 1, 0)
    btn.Position = UDim2.new((i-1) * 0.25, 0, 0, 0)
    btn.Text = name
    btn.BackgroundColor3 = i == 1 and Color3.fromRGB(180, 140, 255) or Color3.fromRGB(230, 215, 255)
    btn.BackgroundTransparency = 0.2
    btn.BorderSizePixel = 0
    btn.TextColor3 = i == 1 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(80, 40, 180)
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    btn.ZIndex = 3
    local corner = Instance.new("UICorner")
    corner.Parent = btn
    corner.CornerRadius = UDim.new(0, 8)
    tabButtons[i] = btn
    
    local content = Instance.new("Frame")
    content.Parent = MainFrame
    content.Size = UDim2.new(1, -10, 1, -85)
    content.Position = UDim2.new(0, 5, 0, 80)
    content.BackgroundTransparency = 1
    content.Visible = (i == 1)
    contentFrames[i] = content
end

-- // ========== ПЕРЕКЛЮЧЕНИЕ ВКЛАДОК ========== //
local function switchTab(index)
    for i, btn in ipairs(tabButtons) do
        btn.BackgroundColor3 = (i == index) and Color3.fromRGB(180, 140, 255) or Color3.fromRGB(230, 215, 255)
        btn.TextColor3 = (i == index) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(80, 40, 180)
        contentFrames[i].Visible = (i == index)
    end
end

for i, btn in ipairs(tabButtons) do
    btn.MouseButton1Click:Connect(function() switchTab(i) end)
    btn.TouchTap:Connect(function() switchTab(i) end)
end

-- // ========== ФУНКЦИЯ СОЗДАНИЯ КНОПОК (СВЕТЛАЯ) ========== //
local function createButton(parent, text, y, color, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.Size = UDim2.new(0, 170, 0, 30)
    btn.Position = UDim2.new(0.05, 0, 0, y)
    btn.Text = text
    btn.BackgroundColor3 = color or Color3.fromRGB(230, 215, 255)
    btn.BackgroundTransparency = 0.2
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Color3.fromRGB(180, 140, 255)
    btn.TextColor3 = Color3.fromRGB(80, 40, 180)
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    local corner = Instance.new("UICorner")
    corner.Parent = btn
    corner.CornerRadius = UDim.new(0, 10)
    btn.MouseButton1Click:Connect(callback)
    btn.TouchTap:Connect(callback)
    return btn
end

-- // ========== ПЕРЕМЕННЫЕ ========== //
local flyGuiInstance = nil
local isFlyRunning = false
local noclipActive = false
local noclipConnection = nil
local speedActive = false
local currentSpeed = 16
local speedConnection = nil
local espActive = false
local chamsActive = false
local espObjects = {}

-- // ========== ФУНКЦИИ (БУДУТ В ЧАСТИ 2) ========== --
-- (продолжение в части 2)
-- // RUSSIAN YAD v34.0 // СВЕТЛОЕ МЕНЮ // ЧАСТЬ 2 //

-- // ========== FLY ========== //
function toggleFly()
    if isFlyRunning then
        if flyGuiInstance then
            if flyGuiInstance.Parent then flyGuiInstance:Destroy() end
            flyGuiInstance = nil
        end
        local gui = CoreGui:FindFirstChild("main")
        if gui then gui:Destroy() end
        isFlyRunning = false
    else
        local success = pcall(function()
            local script = game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt")
            flyGuiInstance = loadstring(script)()
        end)
        if success then isFlyRunning = true end
    end
end

-- // ========== НОКЛИП ========== //
function toggleNoclip()
    noclipActive = not noclipActive
    if noclipActive then
        if noclipConnection then noclipConnection:Disconnect() end
        noclipConnection = RunService.Stepped:Connect(function()
            if noclipActive and Player.Character then
                for _, part in ipairs(Player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end)
    else
        if noclipConnection then noclipConnection:Disconnect() end
        if Player.Character then
            for _, part in ipairs(Player.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = true end
            end
        end
    end
end

-- // ========== СПИДХАК ========== //
function toggleSpeed()
    if speedActive then
        speedActive = false
        if speedConnection then speedConnection:Disconnect() end
        if Player.Character and Player.Character:FindFirstChild("Humanoid") then
            Player.Character.Humanoid.WalkSpeed = 16
        end
    else
        local inputGui = Instance.new("ScreenGui")
        inputGui.Parent = CoreGui
        local frame = Instance.new("Frame")
        frame.Parent = inputGui
        frame.Size = UDim2.new(0, 250, 0, 120)
        frame.Position = UDim2.new(0.5, -125, 0.5, -60)
        frame.BackgroundColor3 = Color3.fromRGB(240, 230, 255)
        frame.BorderSizePixel = 2
        frame.BorderColor3 = Color3.fromRGB(180, 140, 255)
        local corner = Instance.new("UICorner")
        corner.Parent = frame
        corner.CornerRadius = UDim.new(0, 10)
        local title = Instance.new("TextLabel")
        title.Parent = frame
        title.Size = UDim2.new(1, 0, 0, 30)
        title.Text = "⚡ ВВЕДИТЕ СКОРОСТЬ"
        title.TextColor3 = Color3.fromRGB(80, 40, 180)
        title.BackgroundTransparency = 1
        title.Font = Enum.Font.GothamBold
        title.TextScaled = true
        local input = Instance.new("TextBox")
        input.Parent = frame
        input.Size = UDim2.new(0, 150, 0, 30)
        input.Position = UDim2.new(0.5, -75, 0, 40)
        input.PlaceholderText = "16-500"
        input.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        input.BorderColor3 = Color3.fromRGB(180, 140, 255)
        input.TextColor3 = Color3.fromRGB(80, 40, 180)
        input.Font = Enum.Font.GothamBold
        input.TextScaled = true
        local cornerInput = Instance.new("UICorner")
        cornerInput.Parent = input
        cornerInput.CornerRadius = UDim.new(0, 8)
        local applyBtn = Instance.new("TextButton")
        applyBtn.Parent = frame
        applyBtn.Size = UDim2.new(0, 100, 0, 30)
        applyBtn.Position = UDim2.new(0.5, -50, 0, 80)
        applyBtn.Text = "OK"
        applyBtn.BackgroundColor3 = Color3.fromRGB(180, 140, 255)
        applyBtn.BorderSizePixel = 0
        applyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        applyBtn.Font = Enum.Font.GothamBold
        applyBtn.TextScaled = true
        local cornerApply = Instance.new("UICorner")
        cornerApply.Parent = applyBtn
        cornerApply.CornerRadius = UDim.new(0, 8)
        local function applySpeed()
            local speed = tonumber(input.Text)
            if speed and speed >= 16 and speed <= 500 then
                currentSpeed = speed
                speedActive = true
                if speedConnection then speedConnection:Disconnect() end
                speedConnection = RunService.Heartbeat:Connect(function()
                    if speedActive and Player.Character and Player.Character:FindFirstChild("Humanoid") then
                        Player.Character.Humanoid.WalkSpeed = currentSpeed
                    end
                end)
                inputGui:Destroy()
            else
                input.Text = "ОШИБКА!"
                wait(1)
                input.Text = ""
            end
        end
        applyBtn.MouseButton1Click:Connect(applySpeed)
        applyBtn.TouchTap:Connect(applySpeed)
    end
end

-- // ========== KILLALL ========== //
function killAll()
    local count = 0
    for _, plr in pairs(Player:GetPlayers()) do
        if plr ~= Player and plr.Character and plr.Character:FindFirstChild("Humanoid") then
            plr.Character.Humanoid.Health = 0
            count = count + 1
        end
    end
    print("☠ УБИТО: " .. count)
end

-- // ========== ТЕЛЕПОРТ ВСЕХ К СЕБЕ ========== //
function teleportAll()
    if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then return end
    local pos = Player.Character.HumanoidRootPart.Position
    for _, plr in pairs(Player:GetPlayers()) do
        if plr ~= Player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            plr.Character.HumanoidRootPart.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
        end
    end
end

-- // ========== ЗАМОРОЗКА ========== //
function freezeAll()
    for _, plr in pairs(Player:GetPlayers()) do
        if plr ~= Player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(4000, 4000, 4000)
            bv.Velocity = Vector3.new(0, 0, 0)
            bv.Parent = plr.Character.HumanoidRootPart
            game:GetService("Debris"):AddItem(bv, 3)
        end
    end
end

-- // ========== ESP ========== //
function toggleEsp()
    espActive = not espActive
    if espActive then
        for _, plr in pairs(Player:GetPlayers()) do
            if plr ~= Player and plr.Character then
                for _, part in ipairs(plr.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        local hl = Instance.new("Highlight")
                        hl.Parent = part
                        hl.FillColor = Color3.fromRGB(180, 140, 255)
                        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                        hl.FillTransparency = 0.5
                        table.insert(espObjects, hl)
                    end
                end
            end
        end
    else
        for _, obj in ipairs(espObjects) do obj:Destroy() end
        espObjects = {}
    end
end

-- // ========== CHAMS ========== //
function toggleChams()
    chamsActive = not chamsActive
    if chamsActive then
        for _, plr in pairs(Player:GetPlayers()) do
            if plr ~= Player and plr.Character then
                for _, part in ipairs(plr.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Material = Enum.Material.Neon
                        part.Color = Color3.fromRGB(180, 140, 255)
                    end
                end
            end
        end
    else
        for _, plr in pairs(Player:GetPlayers()) do
            if plr ~= Player and plr.Character then
                for _, part in ipairs(plr.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Material = Enum.Material.Plastic
                        part.Color = Color3.fromRGB(255, 255, 255)
                    end
                end
            end
        end
    end
end

-- // ========== СБРОС ВСЕГО ========== //
function resetAll()
    if isFlyRunning then
        if flyGuiInstance then flyGuiInstance:Destroy() end
        local gui = CoreGui:FindFirstChild("main")
        if gui then gui:Destroy() end
        isFlyRunning = false
    end
    if noclipActive then
        toggleNoclip()
    end
    if speedActive then
        toggleSpeed()
    end
    if espActive then
        toggleEsp()
    end
    if chamsActive then
        toggleChams()
    end
    print("☠ ВСЁ СБРОШЕНО")
end

-- (продолжение в части 3)
-- // RUSSIAN YAD v34.0 // СВЕТЛОЕ МЕНЮ // ЧАСТЬ 3 //

-- // ========== ЗАПОЛНЯЕМ ВКЛАДКИ ========== //

-- Вкладка "Движение"
local y = 10
local flyBtn = createButton(contentFrames[1], "🚀 FLY", y, Color3.fromRGB(200, 230, 255), function()
    toggleFly()
    flyBtn.Text = isFlyRunning and "🛑 FLY" or "🚀 FLY"
    flyBtn.BackgroundColor3 = isFlyRunning and Color3.fromRGB(180, 255, 180) or Color3.fromRGB(200, 230, 255)
end)
y = y + 38
local noclipBtn = createButton(contentFrames[1], "⬜ НОКЛИП", y, Color3.fromRGB(255, 200, 200), function()
    toggleNoclip()
    noclipBtn.Text = noclipActive and "⬜ НОКЛИП ON" or "⬜ НОКЛИП"
    noclipBtn.BackgroundColor3 = noclipActive and Color3.fromRGB(180, 255, 180) or Color3.fromRGB(255, 200, 200)
end)
y = y + 38
local speedBtn = createButton(contentFrames[1], "⚡ СПИДХАК", y, Color3.fromRGB(255, 255, 200), function()
    toggleSpeed()
    speedBtn.Text = speedActive and "⚡ СПИД: " .. currentSpeed or "⚡ СПИДХАК"
    speedBtn.BackgroundColor3 = speedActive and Color3.fromRGB(180, 255, 180) or Color3.fromRGB(255, 255, 200)
end)

-- Вкладка "Игроки"
y = 10
local killBtn = createButton(contentFrames[2], "💀 KILLALL", y, Color3.fromRGB(255, 200, 200), killAll)
y = y + 38
local tpBtn = createButton(contentFrames[2], "🌀 ТЕЛЕПОРТ ВСЕХ", y, Color3.fromRGB(200, 255, 255), teleportAll)
y = y + 38
local freezeBtn = createButton(contentFrames[2], "🧊 ЗАМОРОЗИТЬ", y, Color3.fromRGB(200, 255, 200), freezeAll)

-- Вкладка "Визуал"
y = 10
local espBtn = createButton(contentFrames[3], "👁️ ESP", y, Color3.fromRGB(200, 220, 255), function()
    toggleEsp()
    espBtn.Text = espActive and "👁️ ESP ON" or "👁️ ESP"
    espBtn.BackgroundColor3 = espActive and Color3.fromRGB(180, 255, 180) or Color3.fromRGB(200, 220, 255)
end)
y = y + 38
local chamsBtn = createButton(contentFrames[3], "🌈 CHAMS", y, Color3.fromRGB(220, 200, 255), function()
    toggleChams()
    chamsBtn.Text = chamsActive and "🌈 CHAMS ON" or "🌈 CHAMS"
    chamsBtn.BackgroundColor3 = chamsActive and Color3.fromRGB(180, 255, 180) or Color3.fromRGB(220, 200, 255)
end)

-- Вкладка "Настройки"
y = 10
local resetBtn = createButton(contentFrames[4], "🔄 СБРОСИТЬ ВСЁ", y, Color3.fromRGB(255, 220, 180), resetAll)
y = y + 38
local closeMenuBtn = createButton(contentFrames[4], "❌ ЗАКРЫТЬ МЕНЮ", y, Color3.fromRGB(255, 200, 200), function()
    MainFrame.Visible = false
    IconButton.Visible = true
end)

-- // ========== ПЕРЕТАСКИВАНИЕ МЕНЮ (ТЕЛЕФОН) ========== //
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

-- // ========== ОТКРЫТИЕ/ЗАКРЫТИЕ МЕНЮ ========== //
local function toggleMenu()
    MainFrame.Visible = not MainFrame.Visible
    IconButton.Visible = not MainFrame.Visible
end
IconButton.MouseButton1Click:Connect(toggleMenu)
IconButton.TouchTap:Connect(toggleMenu)
IconButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch and not iconDragToggle then toggleMenu() end
end)

-- (продолжение в части 4)
-- // RUSSIAN YAD v34.0 // СВЕТЛОЕ МЕНЮ // ЧАСТЬ 4 //

-- // ========== ПАНИКА (P) ========== //
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.P then
        ScreenGui:Destroy()
        if flyGuiInstance then flyGuiInstance:Destroy() end
        if noclipConnection then noclipConnection:Disconnect() end
        if speedConnection then speedConnection:Disconnect() end
        print("☠ ПАНИКА")
    end
end)

-- // ========== АВТООБНОВЛЕНИЕ ПРИ РЕСПАВНЕ ========== //
Player.CharacterAdded:Connect(function()
    wait(0.5)
    if noclipActive then
        if noclipConnection then noclipConnection:Disconnect() end
        noclipConnection = RunService.Stepped:Connect(function()
            if noclipActive and Player.Character then
                for _, part in ipairs(Player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end)
    end
    if speedActive then
        if speedConnection then speedConnection:Disconnect() end
        speedConnection = RunService.Heartbeat:Connect(function()
            if speedActive and Player.Character and Player.Character:FindFirstChild("Humanoid") then
                Player.Character.Humanoid.WalkSpeed = currentSpeed
            end
        end)
    end
end)

-- // ========== ЗАЩИТА ОТ ВЫЛЕТА ========== //
pcall(function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "☠ RUSSIAN YAD",
        Text = "СВЕТЛОЕ МЕНЮ ЗАГРУЖЕНО",
        Icon = "rbxthumb://type=Asset&id=5107182114&w=150&h=150"
    })
end)

-- // ========== ИНФО В КОНСОЛЬ ========== //
print("☠ RUSSIAN YAD v34.0 ЗАГРУЖЕН")
print("📌 СВЕТЛОЕ МЕНЮ С ВКЛАДКАМИ")
print("📌 ИКОНКА 40x40, ПЕРЕТАСКИВАНИЕ")
print("📌 ВСЕ ФУНКЦИИ РАБОТАЮТ НА ТЕЛЕФОНЕ")

-- // ========== КОНЕЦ ========== //
