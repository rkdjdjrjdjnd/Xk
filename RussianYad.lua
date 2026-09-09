--[[
    AD MENU v2.0 — OPTIMIZED FOR DELTA INJECTOR
    Автор: Professional Roblox Developer
    Платформа: Android (Delta Injector)
    Версия: 2.0
]]

-- СЕРВИСЫ
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Tween = game:GetService("TweenService")

-- ЛОКАЛЬНЫЙ ИГРОК
local plr = Players.LocalPlayer

-- ПРОВЕРКА НА ПОВТОРНЫЙ ЗАПУСК
if _G.ADMenuLoaded then
    return
end
_G.ADMenuLoaded = true

-- ЗАЩИТА ОТ ОШИБОК
local function safeFind(instance, name)
    local success, result = pcall(function()
        return instance:WaitForChild(name, 5)
    end)
    return success and result or nil
end

-- СОЗДАНИЕ GUI
local gui = Instance.new("ScreenGui")
gui.Name = "ADMenu"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local playerGui = safeFind(plr, "PlayerGui")
if not playerGui then
    warn("PlayerGui not found")
    return
end
gui.Parent = playerGui

-- КОНФИГУРАЦИЯ
local CONFIG = {
    Colors = {
        Background = Color3.fromRGB(12, 12, 16),
        Elements = Color3.fromRGB(27, 27, 34),
        Accent = Color3.fromRGB(30, 30, 36),
        Text = Color3.fromRGB(255, 255, 255),
        Highlight = Color3.fromRGB(255, 0, 0)
    },
    Sizes = {
        ButtonHeight = 50,
        ButtonSpacing = 60,
        CornerRadius = UDim.new(0, 10),
        MinTouchSize = 60 -- для мобильных
    },
    EspConfig = {
        Enabled = false,
        ShowName = true,
        ShowDistance = true,
        ShowBox = false,
        ShowHealth = true,
        MaxPlayers = 50,
        UpdateInterval = 0.1
    }
}

-- УТИЛИТЫ
local function createTween(obj, props, time)
    return Tween:Create(obj, TweenInfo.new(time or 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props)
end

local function setText(btn, text)
    btn.Text = text
end

-- АНИМАЦИЯ ПОЯВЛЕНИЯ
local function fadeIn(obj)
    obj.Visible = true
    obj.Position = obj.Position - UDim2.new(0, 0, 0, 20)
    createTween(obj, {Position = obj.Position + UDim2.new(0, 0, 0, 20)}, 0.3):Play()
end

-- LOADING SCREEN
local load = Instance.new("TextLabel", gui)
load.Size = UDim2.fromOffset(200, 60)
load.Position = UDim2.new(0.5, -100, 0.5, -30)
load.BackgroundTransparency = 1
load.TextColor3 = CONFIG.Colors.Text
load.TextSize = 22
load.Font = Enum.Font.GothamBold
load.Text = "LOADING 0%"

task.spawn(function()
    for i = 0, 100, 5 do
        load.Text = "LOADING "..i.."%"
        task.wait(0.05)
    end
    
    createTween(load, {TextTransparency = 1}, 0.25):Play()
    task.wait(0.3)
    load:Destroy()
    fadeIn(menu)
end)

-- ГЛАВНОЕ МЕНЮ
local menu = Instance.new("Frame", gui)
menu.Size = UDim2.fromOffset(300, 310)
menu.Position = UDim2.new(0.5, -150, 0.5, -155)
menu.BackgroundColor3 = CONFIG.Colors.Background
menu.Visible = false

Instance.new("UICorner", menu).CornerRadius = CONFIG.Sizes.CornerRadius

-- ЗАГОЛОВОК
local title = Instance.new("TextLabel", menu)
title.Size = UDim2.new(1, -100, 0, 50)
title.Position = UDim2.fromOffset(50, 5)
title.BackgroundTransparency = 1
title.Text = "AD MENU"
title.TextColor3 = CONFIG.Colors.Text
title.TextSize = 20
title.Font = Enum.Font.GothamBold

-- КНОПКА НАСТРОЕК
local settings = Instance.new("TextButton", menu)
settings.Size = UDim2.fromOffset(40, 40)
settings.Position = UDim2.fromOffset(8, 10)
settings.Text = "⚙"
settings.TextSize = 23
settings.BackgroundColor3 = CONFIG.Colors.Accent
settings.TextColor3 = CONFIG.Colors.Text
Instance.new("UICorner", settings).CornerRadius = CONFIG.Sizes.CornerRadius

-- КНОПКА ЗАКРЫТИЯ
local close = Instance.new("TextButton", menu)
close.Size = UDim2.fromOffset(40, 40)
close.Position = UDim2.new(1, -48, 0, 10)
close.Text = "X"
close.TextSize = 18
close.BackgroundColor3 = CONFIG.Colors.Accent
close.TextColor3 = CONFIG.Colors.Text
Instance.new("UICorner", close).CornerRadius = CONFIG.Sizes.CornerRadius

-- ФУНКЦИЯ СОЗДАНИЯ КНОПОК
local function createButton(parent, text, y, height)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(1, -30, 0, height or CONFIG.Sizes.ButtonHeight)
    b.Position = UDim2.fromOffset(15, y)
    b.Text = text
    b.TextColor3 = CONFIG.Colors.Text
    b.TextSize = 15
    b.Font = Enum.Font.GothamSemibold
    b.BackgroundColor3 = CONFIG.Colors.Elements
    b.AutoButtonColor = true
    
    Instance.new("UICorner", b).CornerRadius = CONFIG.Sizes.CornerRadius
    
    -- Hover эффект для тачскрина
    local originalColor = b.BackgroundColor3
    b.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            b.BackgroundColor3 = CONFIG.Colors.Accent
        end
    end)
    b.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            b.BackgroundColor3 = originalColor
        end
    end)
    
    return b
end

local espOpen = createButton(menu, "ESP", 65)
local playerOpen = createButton(menu, "PLAYER", 125)
local visualOpen = createButton(menu, "VISUALS", 185)
local aboutOpen = createButton(menu, "ABOUT", 245)

-- ESP ОКНО
local esp = Instance.new("Frame", gui)
esp.Size = menu.Size
esp.Position = menu.Position
esp.BackgroundColor3 = CONFIG.Colors.Background
esp.Visible = false
Instance.new("UICorner", esp).CornerRadius = CONFIG.Sizes.CornerRadius

local espTitle = Instance.new("TextLabel", esp)
espTitle.Size = UDim2.new(1, -60, 0, 50)
espTitle.Position = UDim2.fromOffset(15, 5)
espTitle.BackgroundTransparency = 1
espTitle.Text = "ESP"
espTitle.TextColor3 = CONFIG.Colors.Text
espTitle.TextSize = 20
espTitle.Font = Enum.Font.GothamBold
espTitle.TextXAlignment = Enum.TextXAlignment.Left

local backBtn = Instance.new("TextButton", esp)
backBtn.Size = UDim2.fromOffset(40, 40)
backBtn.Position = UDim2.new(1, -48, 0, 10)
backBtn.Text = "←"
backBtn.TextSize = 20
backBtn.TextColor3 = CONFIG.Colors.Text
backBtn.BackgroundColor3 = CONFIG.Colors.Accent
Instance.new("UICorner", backBtn).CornerRadius = CONFIG.Sizes.CornerRadius

-- ОПЦИИ ESP
local espOptions = {
    {Name = "ESP", Config = "Enabled", Y = 60},
    {Name = "NAME", Config = "ShowName", Y = 110},
    {Name = "DISTANCE", Config = "ShowDistance", Y = 160},
    {Name = "BOX", Config = "ShowBox", Y = 210},
    {Name = "HEALTH", Config = "ShowHealth", Y = 260}
}

local espButtons = {}

for i, option in pairs(espOptions) do
    local btn = createButton(esp, option.Name..": "..(CONFIG.EspConfig[option.Config] and "ON" or "OFF"), option.Y, 42)
    btn.TextSize = 14
    
    btn.Activated:Connect(function()
        local state = not CONFIG.EspConfig[option.Config]
        CONFIG.EspConfig[option.Config] = state
        btn.Text = option.Name..": "..(state and "ON" or "OFF")
    end)
    
    espButtons[i] = btn
end

-- SETTINGS ОКНО
local set = Instance.new("Frame", gui)
set.Size = menu.Size
set.Position = menu.Position
set.BackgroundColor3 = CONFIG.Colors.Background
set.Visible = false
Instance.new("UICorner", set).CornerRadius = CONFIG.Sizes.CornerRadius

local setTitle = Instance.new("TextLabel", set)
setTitle.Size = UDim2.new(1, -60, 0, 50)
setTitle.Position = UDim2.fromOffset(15, 5)
setTitle.BackgroundTransparency = 1
setTitle.Text = "SETTINGS"
setTitle.TextColor3 = CONFIG.Colors.Text
setTitle.TextSize = 20
setTitle.Font = Enum.Font.GothamBold

local setBack = Instance.new("TextButton", set)
setBack.Size = UDim2.fromOffset(40, 40)
setBack.Position = UDim2.new(1, -48, 0, 10)
setBack.Text = "←"
setBack.TextSize = 20
setBack.TextColor3 = CONFIG.Colors.Text
setBack.BackgroundColor3 = CONFIG.Colors.Accent
Instance.new("UICorner", setBack).CornerRadius = CONFIG.Sizes.CornerRadius

-- ЯЗЫКИ
local ruBtn = createButton(set, "Русский", 75, 55)
local enBtn = createButton(set, "English", 145, 55)

-- ЛОГИКА ПЕРЕКЛЮЧЕНИЯ ОКОН
local function switchWindows(from, to)
    from.Visible = false
    to.Visible = true
end

espOpen.Activated:Connect(function()
    switchWindows(menu, esp)
end)

backBtn.Activated:Connect(function()
    switchWindows(esp, menu)
end)

settings.Activated:Connect(function()
    switchWindows(menu, set)
end)

setBack.Activated:Connect(function()
    switchWindows(set, menu)
end)

close.Activated:Connect(function()
    menu.Visible = false
end)

-- ОПТИМИЗИРОВАННЫЙ ESP (только когда включен)
local lastUpdate = 0
local updateInterval = CONFIG.EspConfig.UpdateInterval

RunService.RenderStepped:Connect(function(deltaTime)
    if not CONFIG.EspConfig.Enabled then
        return
    end
    
    lastUpdate += deltaTime
    if lastUpdate < updateInterval then
        return
    end
    lastUpdate = 0
    
    local players = Players:GetPlayers()
    local playerCount = 0
    
    for _, p in pairs(players) do
        if playerCount >= CONFIG.EspConfig.MaxPlayers then
            break
        end
        
        if p ~= plr and p.Character and p.Character:FindFirstChild("Humanoid") then
            playerCount += 1
            local character = p.Character
            local highlight = character:FindFirstChild("AD_ESP")
            
            if not highlight then
                highlight = Instance.new("Highlight")
                highlight.Name = "AD_ESP"
                highlight.Parent = character
            end
            
            highlight.FillTransparency = 0.65
            highlight.OutlineColor = CONFIG.Colors.Highlight
        end
    end
end)

-- ОЧИСТКА ПРИ УДАЛЕНИИ
local function cleanup()
    for _, p in pairs(Players:GetPlayers()) do
        if p.Character then
            local highlight = p.Character:FindFirstChild("AD_ESP")
            if highlight then
                highlight:Destroy()
            end
        end
    end
end

-- ПРИВЯЗКА К ВЫХОДУ
Players.PlayerRemoving:Connect(function(player)
    if player == plr then
        cleanup()
        _G.ADMenuLoaded = nil
    end
end)

-- УВЕДОМЛЕНИЕ О ЗАГРУЗКЕ
print("AD Menu v2.0 — Successfully loaded!")
print("Optimized for Delta Injector")
print("Author: Professional Developer")
