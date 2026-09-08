-- // RUSSIAN YAD v33.0 // МЕНЮ С ВКЛАДКАМИ //
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

-- // ========== ИКОНКА (КАК У ПОПУЛЯРНЫХ ХАКЕРОВ) ========== //
local IconButton = Instance.new("ImageButton")
IconButton.Parent = ScreenGui
IconButton.Size = UDim2.new(0, 65, 0, 65)
IconButton.Position = UDim2.new(0.85, -32, 0.85, -32)
IconButton.BackgroundColor3 = Color3.fromRGB(10, 0, 25)
IconButton.BorderSizePixel = 0
IconButton.Image = "rbxassetid://123456789"
IconButton.ImageColor3 = Color3.fromRGB(255, 50, 150)
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
iconGlow.ImageColor3 = Color3.fromRGB(255, 50, 150)
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
        TweenService:Create(IconButton, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 70, 0, 70)}):Play()
        wait(0.6)
        TweenService:Create(IconButton, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 60, 0, 60)}):Play()
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
        local newX = math.clamp(iconStartPos.X.Offset + delta.X, 0, UIS:GetMouseLocation().X - 65)
        local newY = math.clamp(iconStartPos.Y.Offset + delta.Y, 0, UIS:GetMouseLocation().Y - 65)
        IconButton.Position = UDim2.new(0, newX, 0, newY)
    end
end)

-- // ========== ОСНОВНОЕ МЕНЮ (БОЛЬШОЕ) ========== //
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 400, 0, 350)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(8, 0, 18)
MainFrame.BackgroundTransparency = 0.08
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.ZIndex = 5

local mainCorner = Instance.new("UICorner")
mainCorner.Parent = MainFrame
mainCorner.CornerRadius = UDim.new(0, 25)

-- Неоновая рамка
local borderGlow = Instance.new("ImageLabel")
borderGlow.Parent = MainFrame
borderGlow.Size = UDim2.new(1.1, 0, 1.1, 0)
borderGlow.Position = UDim2.new(-0.05, 0, -0.05, 0)
borderGlow.BackgroundTransparency = 1
borderGlow.Image = "rbxassetid://13158748277"
borderGlow.ImageColor3 = Color3.fromRGB(255, 50, 150)
borderGlow.ImageTransparency = 0.4
borderGlow.ZIndex = 0
borderGlow.Name = "BorderGlow"

-- Анимация рамки
spawn(function()
    while borderGlow and borderGlow.Parent do
        for i = 0.3, 0.7, 0.02 do wait(0.02) borderGlow.ImageTransparency = i end
        for i = 0.7, 0.3, -0.02 do wait(0.02) borderGlow.ImageTransparency = i end
    end
end)

-- Заголовок
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "☠ RUSSIAN YAD"
Title.TextColor3 = Color3.fromRGB(255, 80, 150)
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true
Title.ZIndex = 3

-- Крестик
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = MainFrame
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -40, 0, 8)
CloseBtn.Text = "✖"
CloseBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
CloseBtn.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
CloseBtn.BackgroundTransparency = 0.4
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
TabFrame.Position = UDim2.new(0, 0, 0, 50)
TabFrame.BackgroundTransparency = 1

local tabs = {"Движение", "Игроки", "Визуал", "Настройки"}
local tabButtons = {}
local contentFrames = {}

for i, name in ipairs(tabs) do
    local btn = Instance.new("TextButton")
    btn.Parent = TabFrame
    btn.Size = UDim2.new(0, 100, 1, 0)
    btn.Position = UDim2.new((i-1) * 0.25, 0, 0, 0)
    btn.Text = name
    btn.BackgroundColor3 = i == 1 and Color3.fromRGB(255, 50, 150) or Color3.fromRGB(20, 0, 40)
    btn.BackgroundTransparency = 0.3
    btn.BorderSizePixel = 0
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
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
    content.Position = UDim2.new(0, 5, 0, 85)
    content.BackgroundTransparency = 1
    content.Visible = (i == 1)
    contentFrames[i] = content
end

-- // ========== ФУНКЦИЯ ПЕРЕКЛЮЧЕНИЯ ВКЛАДОК ========== //
local function switchTab(index)
    for i, btn in ipairs(tabButtons) do
        btn.BackgroundColor3 = (i == index) and Color3.fromRGB(255, 50, 150) or Color3.fromRGB(20, 0, 40)
        contentFrames[i].Visible = (i == index)
    end
end

for i, btn in ipairs(tabButtons) do
    btn.MouseButton1Click:Connect(function() switchTab(i) end)
    btn.TouchTap:Connect(function() switchTab(i) end)
end

-- // ========== КОНТЕНТ ВКЛАДОК ========== //
local function createContent(parent, yStart)
    local y = yStart or 10
    local function addButton(text, color, callback)
        local btn = Instance.new("TextButton")
        btn.Parent = parent
        btn.Size = UDim2.new(0, 180, 0, 30)
        btn.Position = UDim2.new(0.05, 0, 0, y)
        btn.Text = text
        btn.BackgroundColor3 = color or Color3.fromRGB(30, 15, 50)
        btn.BackgroundTransparency = 0.3
        btn.BorderSizePixel = 1
        btn.BorderColor3 = Color3.fromRGB(255, 50, 150)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.GothamBold
        btn.TextScaled = true
        local corner = Instance.new("UICorner")
        corner.Parent = btn
        corner.CornerRadius = UDim.new(0, 10)
        btn.MouseButton1Click:Connect(callback)
        btn.TouchTap:Connect(callback)
        y = y + 38
        return btn
    end
    
    -- Вкладка "Движение"
    if parent == contentFrames[1] then
        local flyBtn = addButton("🚀 FLY", Color3.fromRGB(30, 30, 80), function() toggleFly() end)
        local noclipBtn = addButton("⬜ НОКЛИП", Color3.fromRGB(80, 30, 30), function() toggleNoclip() end)
        local speedBtn = addButton("⚡ СПИДХАК", Color3.fromRGB(50, 50, 30), function() toggleSpeed() end)
        return {flyBtn, noclipBtn, speedBtn}
    end
    
    -- Вкладка "Игроки"
    if parent == contentFrames[2] then
        local killBtn = addButton("💀 KILLALL", Color3.fromRGB(80, 0, 0), function() killAll() end)
        local tpBtn = addButton("🌀 ТЕЛЕПОРТ К СЕБЕ", Color3.fromRGB(0, 80, 80), function() teleportAll() end)
        local freezeBtn = addButton("🧊 ЗАМОРОЗИТЬ", Color3.fromRGB(0, 80, 0), function() freezeAll() end)
        return {killBtn, tpBtn, freezeBtn}
    end
    
    -- Вкладка "Визуал"
    if parent == contentFrames[3] then
        local espBtn = addButton("👁️ ESP", Color3.fromRGB(30, 50, 80), function() toggleEsp() end)
        local chamsBtn = addButton("🌈 CHAMS", Color3.fromRGB(80, 50, 80), function() toggleChams() end)
        return {espBtn, chamsBtn}
    end
    
    -- Вкладка "Настройки"
    if parent == contentFrames[4] then
        local resetBtn = addButton("🔄 СБРОСИТЬ ВСЁ", Color3.fromRGB(80, 30, 0), function() resetAll() end)
        local closeBtn = addButton("❌ ЗАКРЫТЬ МЕНЮ", Color3.fromRGB(80, 0, 0), function() MainFrame.Visible = false IconButton.Visible = true end)
        return {resetBtn, closeBtn}
    end
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

-- // ========== ФУНКЦИИ ========== //

-- FLY
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

-- НОКЛИП
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

-- СПИДХАК
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
        frame.BackgroundColor3 = Color3.fromRGB(10, 0, 20)
        frame.BorderSizePixel = 2
        frame.BorderColor3 = Color3.fromRGB(255, 50, 150)
        local corner = Instance.new("UICorner")
        corner.Parent = frame
        corner.CornerRadius = UDim.new(0, 10)
        local title = Instance.new("TextLabel")
        title.Parent = frame
        title.Size = UDim2.new(1, 0, 0, 30)
        title.Text = "⚡ ВВЕДИТЕ СКОРОСТЬ"
        title.TextColor3 = Color3.fromRGB(255, 80, 150)
        title.BackgroundTransparency = 1
        title.Font = Enum.Font.GothamBold
        title.TextScaled = true
        local input = Instance.new("TextBox")
        input.Parent = frame
        input.Size = UDim2.new(0, 150, 0, 30)
        input.Position = UDim2.new(0.5, -75, 0, 40)
        input.PlaceholderText = "16-500"
        input.BackgroundColor3 = Color3.fromRGB(30, 15, 40)
        input.BorderColor3 = Color3.fromRGB(255, 50, 150)
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
        applyBtn.Text = "OK"
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
        end)
        applyBtn.TouchTap:Connect(applyBtn.MouseButton1Click._connect)
    end
end

-- KILLALL
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

-- ТЕЛЕПОРТ ВСЕХ К СЕБЕ
function teleportAll()
    if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then return end
    local pos = Player.Character.HumanoidRootPart.Position
    for _, plr in pairs(Player:GetPlayers()) do
        if plr ~= Player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            plr.Character.HumanoidRootPart.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
        end
    end
end

-- ЗАМОРОЗКА
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

-- ESP (простейший)
function toggleEsp()
    espActive = not espActive
    if espActive then
        for _, plr in pairs(Player:GetPlayers()) do
            if plr ~= Player and plr.Character then
                for _, part in ipairs(plr.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        local hl = Instance.new("Highlight")
                        hl.Parent = part
                        hl.FillColor = Color3.fromRGB(255, 0, 0)
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

-- CHAMS (простейшие)
function toggleChams()
    chamsActive = not chamsActive
    if chamsActive then
        for _, plr in pairs(Player:GetPlayers()) do
            if plr ~= Player and plr.Character then
                for _, part in ipairs(plr.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Material = Enum.Material.Neon
                        part.Color = Color3.fromRGB(0, 255, 0)
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

-- СБРОС ВСЕГО
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

-- // ========== ИНИЦИАЛИЗАЦИЯ КНОПОК ========== //
createContent(contentFrames[1], 10)
createContent(contentFrames[2], 10)
createContent(contentFrames[3], 10)
createContent(contentFrames[4], 10)

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

-- // ========== ПАНИКА ========== //
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.P then
        ScreenGui:Destroy()
        if flyGuiInstance then flyGuiInstance:Destroy() end
        if noclipConnection then noclipConnection:Disconnect() end
        if speedConnection then speedConnection:Disconnect() end
        print("☠ ПАНИКА")
    end
end)

print("☠ RUSSIAN YAD v33.0 ЗАГРУЖЕН")
print("📌 МЕНЮ С ВКЛАДКАМИ В СТИЛЕ ПОПУЛЯРНЫХ ХАКЕРОВ")
