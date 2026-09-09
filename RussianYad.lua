-- ══════════════════════════════════════════════════════════════
-- FULL ESP v6.0 — ALL IN ONE (Delta Mobile)
-- Иконка + Меню + ESP в одном скрипте
-- ══════════════════════════════════════════════════════════════

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local lp = Players.LocalPlayer
local playerGui = lp:WaitForChild("PlayerGui")

-- НАСТРОЙКИ ESP
local Settings = {
    Enabled = false,
    TeamCheck = true,
    MaxDistance = 500,
    UpdateRate = 0.1,
    
    Chams = true,
    Box = true,
    Name = true,
    Distance = true,
    Health = true,
    Tool = true,
    
    EnemyColor = Color3.fromRGB(255, 60, 60),
    AllyColor = Color3.fromRGB(60, 255, 60)
}

-- ХРАНИЛИЩЕ
local ESPObjects = {}
local UpdateThread = nil

-- УТИЛИТЫ
local function IsAlive(char)
    if not char or not char.Parent then return false end
    local hum = char:FindFirstChildOfClass("Humanoid")
    return hum and hum.Health > 0
end

local function GetTeamColor(p)
    if Settings.TeamCheck and lp.Team and p.Team and lp.Team == p.Team then
        return Settings.AllyColor, true
    end
    return Settings.EnemyColor, false
end

local function GetTool(char)
    for _, v in ipairs(char:GetChildren()) do
        if v:IsA("Tool") then return v.Name end
    end
    return nil
end

-- ОЧИСТКА ESP
local function ClearESP(player)
    local data = ESPObjects[player]
    if not data then return end
    for _, obj in pairs(data) do
        if typeof(obj) == "Instance" and obj.Parent then
            obj:Destroy()
        end
    end
    ESPObjects[player] = nil
end

local function ClearAll()
    for player in pairs(ESPObjects) do
        ClearESP(player)
    end
end

-- СОЗДАНИЕ ESP
local function CreateESP(player)
    if player == lp then return end
    if not IsAlive(player.Character) then return end
    
    local color, isAlly = GetTeamColor(player)
    if Settings.TeamCheck and isAlly then return end
    
    ClearESP(player)
    
    local char = player.Character
    local head = char:FindFirstChild("Head")
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    
    if not head or not root or not hum then return end
    
    local data = {}
    
    -- Chams
    if Settings.Chams then
        local highlight = Instance.new("Highlight")
        highlight.Name = "FESP"
        highlight.FillColor = color
        highlight.OutlineColor = Color3.new(1,1,1)
        highlight.FillTransparency = 0.65
        highlight.OutlineTransparency = 0
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.Parent = char
        data.chams = highlight
    end
    
    -- Info
    if Settings.Name or Settings.Distance or Settings.Health or Settings.Tool then
        local bill = Instance.new("BillboardGui")
        bill.Name = "FESP_Info"
        bill.Adornee = head
        bill.Size = UDim2.fromOffset(200, 80)
        bill.StudsOffset = Vector3.new(0, 2.5, 0)
        bill.AlwaysOnTop = true
        bill.MaxDistance = Settings.MaxDistance
        bill.Parent = head
        
        local text = Instance.new("TextLabel")
        text.Size = UDim2.fromScale(1, 1)
        text.BackgroundTransparency = 1
        text.TextColor3 = Color3.new(1,1,1)
        text.TextStrokeTransparency = 0
        text.TextStrokeColor3 = Color3.new(0,0,0)
        text.Font = Enum.Font.GothamBold
        text.TextSize = 14
        text.TextYAlignment = Enum.TextYAlignment.Top
        text.Parent = bill
        
        data.bill = bill
        data.text = text
    end
    
    -- Box
    if Settings.Box then
        local box = Instance.new("SelectionBox")
        box.Name = "FESP_Box"
        box.Adornee = char
        box.LineThickness = 0.02
        box.SurfaceTransparency = 1
        box.Color3 = color
        box.Parent = char
        data.box = box
    end
    
    ESPObjects[player] = data
end

-- ОБНОВЛЕНИЕ ESP
local function UpdateESP()
    if not Settings.Enabled then return end
    
    for player, data in pairs(ESPObjects) do
        if not player.Parent or not IsAlive(data.character) then
            ClearESP(player)
            continue
        end
        
        local char = data.character
        local root = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        local myRoot = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
        
        if not root or not hum or not myRoot then
            ClearESP(player)
            continue
        end
        
        local dist = (root.Position - myRoot.Position).Magnitude
        if dist > Settings.MaxDistance then
            if data.bill then data.bill.Enabled = false end
            if data.box then data.box.Visible = false end
            continue
        end
        
        local color, isAlly = GetTeamColor(player)
        if Settings.TeamCheck and isAlly then
            ClearESP(player)
            continue
        end
        
        if data.chams then
            data.chams.FillColor = color
        end
        
        if data.box then
            data.box.Color3 = color
        end
        
        if data.text then
            local lines = {}
            
            if Settings.Name then
                table.insert(lines, player.DisplayName)
            end
            
            if Settings.Distance then
                table.insert(lines, math.floor(dist) .. " studs")
            end
            
            if Settings.Health then
                local percent = math.floor((hum.Health / hum.MaxHealth) * 100)
                table.insert(lines, "HP: " .. math.floor(hum.Health) .. "/" .. math.floor(hum.MaxHealth))
                
                if percent > 60 then
                    data.text.TextColor3 = Color3.new(1,1,1)
                elseif percent > 30 then
                    data.text.TextColor3 = Color3.fromRGB(255, 200, 0)
                else
                    data.text.TextColor3 = Color3.fromRGB(255, 60, 60)
                end
            end
            
            if Settings.Tool then
                local tool = GetTool(char)
                if tool then
                    table.insert(lines, "[" .. tool .. "]")
                end
            end
            
            data.text.Text = table.concat(lines, "\n")
        end
        
        if data.bill then data.bill.Enabled = true end
        if data.box then data.box.Visible = true end
    end
    
    -- Новые игроки
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= lp and not ESPObjects[player] and IsAlive(player.Character) then
            CreateESP(player)
        end
    end
end

-- ЗАПУСК/ОСТАНОВКА
local function StartESP()
    if UpdateThread then task.cancel(UpdateThread) end
    UpdateThread = task.spawn(function()
        while Settings.Enabled do
            pcall(UpdateESP)
            task.wait(Settings.UpdateRate)
        end
        ClearAll()
    end)
end

-- ОТСЛЕЖИВАНИЕ ИГРОКОВ
local function OnPlayerAdded(player)
    player.CharacterAdded:Connect(function(char)
        task.wait(0.5)
        if Settings.Enabled then
            CreateESP(player)
        end
        local hum = char:WaitForChild("Humanoid", 3)
        if hum then
            hum.Died:Connect(function()
                ClearESP(player)
            end)
        end
    end)
    player.CharacterRemoving:Connect(function()
        ClearESP(player)
    end)
end

for _, player in ipairs(Players:GetPlayers()) do
    if player ~= lp then
        OnPlayerAdded(player)
    end
end

Players.PlayerAdded:Connect(OnPlayerAdded)
Players.PlayerRemoving:Connect(ClearESP)

-- ══════════════════════════════════════════════════════════════
-- GUI — ИКОНКА + МЕНЮ
-- ══════════════════════════════════════════════════════════════

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FESP_Menu"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = playerGui

-- ИКОНКА (плавающая кнопка)
local Icon = Instance.new("TextButton")
Icon.Name = "FESP_Icon"
Icon.Size = UDim2.fromOffset(60, 60)
Icon.Position = UDim2.new(0, 20, 0.5, -30)
Icon.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Icon.Text = "👁"
Icon.TextColor3 = Color3.new(1, 1, 1)
Icon.Font = Enum.Font.GothamBold
Icon.TextSize = 28
Icon.ZIndex = 10
Icon.Parent = ScreenGui

local IconCorner = Instance.new("UICorner")
IconCorner.CornerRadius = UDim.new(0, 30)
IconCorner.Parent = Icon

local IconStroke = Instance.new("UIStroke")
IconStroke.Color = Color3.fromRGB(255, 60, 60)
IconStroke.Thickness = 2
IconStroke.Parent = Icon

-- МЕНЮ (скрыто по умолчанию)
local Menu = Instance.new("Frame")
Menu.Name = "FESP_Panel"
Menu.Size = UDim2.fromOffset(280, 420)
Menu.Position = UDim2.new(0, 90, 0.5, -210)
Menu.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
Menu.BorderSizePixel = 0
Menu.Visible = false
Menu.ZIndex = 9
Menu.Parent = ScreenGui

local MenuCorner = Instance.new("UICorner")
MenuCorner.CornerRadius = UDim.new(0, 16)
MenuCorner.Parent = Menu

local MenuStroke = Instance.new("UIStroke")
MenuStroke.Color = Color3.fromRGB(255, 60, 60)
MenuStroke.Thickness = 2
MenuStroke.Transparency = 0.5
MenuStroke.Parent = Menu

-- Заголовок
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -50, 0, 40)
Title.Position = UDim2.new(0, 15, 0, 10)
Title.BackgroundTransparency = 1
Title.Text = "FULL ESP v6.0"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 10
Title.Parent = Menu

-- Кнопка закрытия меню
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.fromOffset(35, 35)
CloseBtn.Position = UDim2.new(1, -45, 0, 10)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 24
CloseBtn.ZIndex = 11
CloseBtn.Parent = Menu

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseBtn

-- Список кнопок
local ButtonList = Instance.new("ScrollingFrame")
ButtonList.Size = UDim2.new(1, -20, 1, -60)
ButtonList.Position = UDim2.new(0, 10, 0, 55)
ButtonList.BackgroundTransparency = 1
ButtonList.ScrollBarThickness = 4
ButtonList.ScrollBarImageColor3 = Color3.fromRGB(255, 60, 60)
ButtonList.ZIndex = 10
ButtonList.Parent = Menu

local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding = UDim.new(0, 8)
ListLayout.Parent = ButtonList

-- Функция создания переключателя
local function CreateToggle(text, settingName, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 50)
    Btn.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    Btn.TextColor3 = Color3.new(1, 1, 1)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 14
    Btn.TextXAlignment = Enum.TextXAlignment.Left
    Btn.ZIndex = 11
    Btn.Parent = ButtonList
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 10)
    BtnCorner.Parent = Btn
    
    local BtnPadding = Instance.new("UIPadding")
    BtnPadding.PaddingLeft = UDim.new(0, 15)
    BtnPadding.Parent = Btn
    
    local State = Instance.new("TextLabel")
    State.Size = UDim2.fromOffset(50, 30)
    State.Position = UDim2.new(1, -60, 0.5, -15)
    State.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    State.Text = "OFF"
    State.TextColor3 = Color3.fromRGB(150, 150, 150)
    State.Font = Enum.Font.GothamBold
    State.TextSize = 12
    State.ZIndex = 12
    State.Parent = Btn
    
    local StateCorner = Instance.new("UICorner")
    StateCorner.CornerRadius = UDim.new(0, 6)
    StateCorner.Parent = State
    
    Btn.Text = "  " .. text
    
    local enabled = Settings[settingName] or false
    
    local function UpdateVisual()
        if enabled then
            Btn.BackgroundColor3 = Color3.fromRGB(0, 120, 90)
            State.BackgroundColor3 = Color3.fromRGB(0, 200, 150)
            State.Text = "ON"
            State.TextColor3 = Color3.new(1, 1, 1)
        else
            Btn.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
            State.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
            State.Text = "OFF"
            State.TextColor3 = Color3.fromRGB(150, 150, 150)
        end
    end
    
    UpdateVisual()
    
    Btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        Settings[settingName] = enabled
        UpdateVisual()
        if callback then callback(enabled) end
        
        -- Анимация нажатия
        local tween = TweenService:Create(Btn, TweenInfo.new(0.1), {
            Size = UDim2.new(1, -4, 0, 46)
        })
        tween:Play()
        tween.Completed:Connect(function()
            TweenService:Create(Btn, TweenInfo.new(0.1), {
                Size = UDim2.new(1, 0, 0, 50)
            }):Play()
        end)
    end)
    
    return Btn
end

-- СОЗДАНИЕ КНОПОК

CreateToggle("ESP Master", "Enabled", function(v)
    if v then
        StartESP()
        IconStroke.Color = Color3.fromRGB(0, 255, 150)
    else
        IconStroke.Color = Color3.fromRGB(255, 60, 60)
    end
end)

CreateToggle("Chams", "Chams")
CreateToggle("Box", "Box")
CreateToggle("Name", "Name")
CreateToggle("Distance", "Distance")
CreateToggle("Health", "Health")
CreateToggle("Tool", "Tool")
CreateToggle("Team Check", "TeamCheck", function()
    ClearAll()
end)

-- ИНТЕРАКТИВНОСТЬ

-- Открытие/закрытие меню
Icon.MouseButton1Click:Connect(function()
    Menu.Visible = not Menu.Visible
    
    -- Анимация иконки
    local tween = TweenService:Create(Icon, TweenInfo.new(0.2, Enum.EasingStyle.Back), {
        Size = Menu.Visible and UDim2.fromOffset(70, 70) or UDim2.fromOffset(60, 60)
    })
    tween:Play()
end)

CloseBtn.MouseButton1Click:Connect(function()
    Menu.Visible = false
    TweenService:Create(Icon, TweenInfo.new(0.2), {
        Size = UDim2.fromOffset(60, 60)
    }):Play()
end)

-- ПЕРЕТАСКИВАНИЕ ИКОНКИ
local dragging = false
local dragInput, mousePos, framePos

Icon.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or 
       input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        mousePos = input.Position
        framePos = Icon.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Icon.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or
       input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - mousePos
        Icon.Position = UDim2.new(
            framePos.X.Scale, framePos.X.Offset + delta.X,
            framePos.Y.Scale, framePos.Y.Offset + delta.Y
        )
        -- Меню следует за иконкой
        Menu.Position = UDim2.new(
            0, Icon.Position.X.Offset + 70,
            0.5, -210
        )
    end
end)

-- АВТООЧИСТКА ПРИ ВЫХОДЕ
lp.CharacterRemoving:Connect(function()
    ClearAll()
end)

print("[FESP] Loaded. Tap 👁 icon to open menu")
