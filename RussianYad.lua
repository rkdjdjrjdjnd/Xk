-- // RUSSIAN YAD v5.0 // С ИКОНКОЙ И ДВИЖЕНИЕМ // ДЛЯ ТЕЛЕФОНА //
local Player = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")

-- // ========== ОБХОД АНТИЧИТА ========== //
local function bypassAntiCheat()
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
    end)
end
pcall(bypassAntiCheat)

-- // ========== СОЗДАНИЕ GUI ========== //
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = CoreGui
ScreenGui.Name = "RussianYadGUI"
ScreenGui.ResetOnSpawn = false

-- // ========== ИКОНКА (КНОПКА ОТКРЫТИЯ) ========== //
local IconButton = Instance.new("ImageButton")
IconButton.Parent = ScreenGui
IconButton.Size = UDim2.new(0, 60, 0, 60)
IconButton.Position = UDim2.new(0.85, -30, 0.85, -30)
IconButton.BackgroundColor3 = Color3.fromRGB(20, 0, 30)
IconButton.BorderColor3 = Color3.fromRGB(255, 0, 80)
IconButton.BorderSizePixel = 3
IconButton.Image = "rbxassetid://123456789" -- Иконка (можно заменить)
IconButton.ImageColor3 = Color3.fromRGB(255, 0, 80)
IconButton.ScaleType = Enum.ScaleType.Fit
IconButton.Name = "IconButton"
IconButton.ZIndex = 10

-- ЭФФЕКТ ПУЛЬСАЦИИ ИКОНКИ
spawn(function()
    while IconButton and IconButton.Parent do
        for i = 0.8, 1.2, 0.05 do
            wait(0.02)
            if IconButton then
                IconButton.Size = UDim2.new(0, 60 * i, 0, 60 * i)
            end
        end
        for i = 1.2, 0.8, -0.05 do
            wait(0.02)
            if IconButton then
                IconButton.Size = UDim2.new(0, 60 * i, 0, 60 * i)
            end
        end
    end
end)

-- ТЕКСТ НА ИКОНКЕ
local IconText = Instance.new("TextLabel")
IconText.Parent = IconButton
IconText.Size = UDim2.new(1, 0, 1, 0)
IconText.BackgroundTransparency = 1
IconText.Text = "☠"
IconText.TextColor3 = Color3.fromRGB(255, 0, 80)
IconText.TextScaled = true
IconText.Font = Enum.Font.GothamBold
IconText.ZIndex = 11

-- // ========== ОСНОВНОЕ МЕНЮ (СКРЫТО) ========== //
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 350, 0, 500)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(8, 0, 15)
MainFrame.BorderSizePixel = 3
MainFrame.BorderColor3 = Color3.fromRGB(255, 0, 60)
MainFrame.BackgroundTransparency = 0.05
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Name = "MainFrame"

-- ЗАГОЛОВОК
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundTransparency = 1
Title.Text = "☠ RUSSIAN YAD v5.0 ☠"
Title.TextScaled = true
Title.TextColor3 = Color3.fromRGB(255, 0, 80)
Title.Font = Enum.Font.GothamBold

-- КНОПКА ЗАКРЫТИЯ (крестик)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = MainFrame
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -40, 0, 5)
CloseBtn.Text = "✖"
CloseBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
CloseBtn.BorderColor3 = Color3.fromRGB(255, 0, 0)
CloseBtn.BorderSizePixel = 2
CloseBtn.TextScaled = true
CloseBtn.Font = Enum.Font.GothamBold

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    IconButton.Visible = true
end)

-- // ========== КНОПКИ ФУНКЦИЙ ========== //
local functions = {
    {"🚀 СПИДХАК x50", "speed"},
    {"💀 БЕССМЕРТИЕ", "god"},
    {"🌀 ПОЛЁТ", "fly"},
    {"⬜ НОКЛИП", "noclip"},
    {"🎯 АИМБОТ (ГОЛОВА)", "aim"},
    {"👁️ ESP", "esp"},
    {"🔫 БЕСК. ПАТРОНЫ", "ammo"},
    {"💀 КИЛЛ ВСЕХ (КРОМЕ СЕБЯ)", "killall"},
    {"🌀 ТЕЛЕПОРТ К ИГРОКУ", "tpto"},
    {"🌀 ПРИТЯНУТЬ И КРУЖИТЬ", "tpcircle"},
    {"🌊 ХОДЬБА ПО ВОДЕ", "water"},
    {"🕶️ НЕВИДИМОСТЬ", "invis"},
    {"🧊 ЗАМОРОЗКА ВРАГОВ", "freeze"},
    {"🎵 МУЗЫКА ДЛЯ ВСЕХ", "musicall"}
}

local yPos = 50
local col = 0

for i, data in ipairs(functions) do
    local btn = Instance.new("TextButton")
    btn.Parent = MainFrame
    btn.Size = UDim2.new(0, 155, 0, 30)
    btn.Position = UDim2.new(col == 0 and 0.03 or 0.53, 0, 0, yPos)
    btn.Text = data[1]
    btn.BackgroundColor3 = Color3.fromRGB(12, 0, 18)
    btn.BorderColor3 = Color3.fromRGB(255, 0, 60)
    btn.BorderSizePixel = 1
    btn.TextColor3 = Color3.fromRGB(200, 60, 60)
    btn.Font = Enum.Font.Code
    btn.TextScaled = true
    btn.Name = data[2]
    btn.BackgroundTransparency = 0.3
    
    if col == 0 then col = 1 else col = 0 yPos = yPos + 35 end
end

-- // ========== ФУНКЦИИ ========== //

-- 1. СПИДХАК
local speedEnabled = false
MainFrame.speed.MouseButton1Click:Connect(function()
    speedEnabled = not speedEnabled
    MainFrame.speed.BackgroundColor3 = speedEnabled and Color3.fromRGB(50,0,0) or Color3.fromRGB(12,0,18)
    if speedEnabled then
        RunService.Stepped:Connect(function()
            if Player.Character and Player.Character:FindFirstChild("Humanoid") then
                Player.Character.Humanoid.WalkSpeed = 80
                Player.Character.Humanoid.JumpPower = 80
            end
        end)
    else
        if Player.Character and Player.Character:FindFirstChild("Humanoid") then
            Player.Character.Humanoid.WalkSpeed = 16
            Player.Character.Humanoid.JumpPower = 50
        end
    end
end)

-- 2. БЕССМЕРТИЕ
MainFrame.god.MouseButton1Click:Connect(function()
    if Player.Character then
        Player.Character.Humanoid.MaxHealth = math.huge
        Player.Character.Humanoid.Health = math.huge
        Player.Character.Humanoid.BreakJointsOnDeath = false
        MainFrame.god.BackgroundColor3 = Color3.fromRGB(50,0,0)
    end
end)

-- 3. ПОЛЁТ
local flying = false
local flyBV
MainFrame.fly.MouseButton1Click:Connect(function()
    flying = not flying
    MainFrame.fly.BackgroundColor3 = flying and Color3.fromRGB(50,0,0) or Color3.fromRGB(12,0,18)
    if flying then
        flyBV = Instance.new("BodyVelocity")
        flyBV.MaxForce = Vector3.new(4000, 4000, 4000)
        flyBV.Velocity = Vector3.new(0, 20, 0)
        flyBV.Parent = Player.Character.HumanoidRootPart
    else
        if flyBV then flyBV:Destroy() end
    end
end)

-- 4. НОКЛИП
local noclip = false
MainFrame.noclip.MouseButton1Click:Connect(function()
    noclip = not noclip
    MainFrame.noclip.BackgroundColor3 = noclip and Color3.fromRGB(50,0,0) or Color3.fromRGB(12,0,18)
    if noclip then
        RunService.Stepped:Connect(function()
            if Player.Character then
                for _, part in ipairs(Player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if Player.Character then
            for _, part in ipairs(Player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end)

-- 5. АИМБОТ (ГОЛОВА)
MainFrame.aim.MouseButton1Click:Connect(function()
    local target = nil
    local minDist = math.huge
    for _, plr in pairs(Player:GetPlayers()) do
        if plr ~= Player and plr.Character and plr.Character:FindFirstChild("Head") then
            local dist = (plr.Character.Head.Position - Player.Character.Head.Position).Magnitude
            if dist < minDist then
                minDist = dist
                target = plr
            end
        end
    end
    if target and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        Player.Character.HumanoidRootPart.CFrame = CFrame.new(
            Player.Character.HumanoidRootPart.Position,
            target.Character.Head.Position
        )
        if Player.Character:FindFirstChild("Head") then
            Player.Character.Head.CFrame = CFrame.new(
                Player.Character.Head.Position,
                target.Character.Head.Position
            )
        end
        MainFrame.aim.BackgroundColor3 = Color3.fromRGB(50,0,0)
    end
end)

-- 6. ESP
MainFrame.esp.MouseButton1Click:Connect(function()
    for _, plr in pairs(Player:GetPlayers()) do
        if plr ~= Player and plr.Character then
            for _, part in ipairs(plr.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    local hl = Instance.new("Highlight")
                    hl.Parent = part
                    hl.FillColor = Color3.fromRGB(255,0,0)
                    hl.OutlineColor = Color3.fromRGB(255,0,0)
                    hl.FillTransparency = 0.5
                end
            end
        end
    end
    MainFrame.esp.BackgroundColor3 = Color3.fromRGB(50,0,0)
end)

-- 7. БЕСКОНЕЧНЫЕ ПАТРОНЫ
MainFrame.ammo.MouseButton1Click:Connect(function()
    local tool = Player.Character and Player.Character:FindFirstChildOfClass("Tool")
    if tool and tool:FindFirstChild("Ammo") then
        tool.Ammo.Value = 9999
    end
    MainFrame.ammo.BackgroundColor3 = Color3.fromRGB(50,0,0)
end)

-- 8. КИЛЛ ВСЕХ
MainFrame.killall.MouseButton1Click:Connect(function()
    local killed = 0
    for _, plr in pairs(Player:GetPlayers()) do
        if plr ~= Player and plr.Character and plr.Character:FindFirstChild("Humanoid") then
            plr.Character.Humanoid.Health = 0
            killed = killed + 1
        end
    end
    MainFrame.killall.BackgroundColor3 = Color3.fromRGB(50,0,0)
end)

-- 9. ТЕЛЕПОРТ К ИГРОКУ
local function teleportToPlayer()
    local players = {}
    for _, plr in pairs(Player:GetPlayers()) do
        if plr ~= Player and plr.Character then
            table.insert(players, plr)
        end
    end
    if #players == 0 then return end
    
    local selectGui = Instance.new("ScreenGui")
    selectGui.Parent = CoreGui
    local frame = Instance.new("Frame")
    frame.Parent = selectGui
    frame.Size = UDim2.new(0, 250, 0, 300)
    frame.Position = UDim2.new(0.5, -125, 0.5, -150)
    frame.BackgroundColor3 = Color3.fromRGB(0,0,0)
    frame.BorderColor3 = Color3.fromRGB(255,0,0)
    frame.BorderSizePixel = 2
    
    local title = Instance.new("TextLabel")
    title.Parent = frame
    title.Size = UDim2.new(1,0,0,30)
    title.Text = "ВЫБЕРИ ИГРОКА"
    title.TextColor3 = Color3.fromRGB(255,0,0)
    title.BackgroundTransparency = 1
    
    local yPos2 = 35
    for _, plr in ipairs(players) do
        local btn = Instance.new("TextButton")
        btn.Parent = frame
        btn.Size = UDim2.new(0, 230, 0, 25)
        btn.Position = UDim2.new(0.5, -115, 0, yPos2)
        btn.Text = plr.Name
        btn.BackgroundColor3 = Color3.fromRGB(20,0,20)
        btn.TextColor3 = Color3.fromRGB(200,50,50)
        btn.BorderColor3 = Color3.fromRGB(255,0,0)
        btn.MouseButton1Click:Connect(function()
            if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                Player.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0)
            end
            selectGui:Destroy()
        end)
        yPos2 = yPos2 + 30
    end
    
    local closeBtn = Instance.new("TextButton")
    closeBtn.Parent = frame
    closeBtn.Size = UDim2.new(0, 230, 0, 25)
    closeBtn.Position = UDim2.new(0.5, -115, 0, yPos2 + 5)
    closeBtn.Text = "✖ ЗАКРЫТЬ"
    closeBtn.BackgroundColor3 = Color3.fromRGB(30,0,0)
    closeBtn.TextColor3 = Color3.fromRGB(255,0,0)
    closeBtn.BorderColor3 = Color3.fromRGB(255,0,0)
    closeBtn.MouseButton1Click:Connect(function() selectGui:Destroy() end)
end
MainFrame.tpto.MouseButton1Click:Connect(teleportToPlayer)

-- 10. ПРИТЯНУТЬ И КРУЖИТЬ
local circleTargets = {}
local circling = false
MainFrame.tpcircle.MouseButton1Click:Connect(function()
    circling = not circling
    MainFrame.tpcircle.BackgroundColor3 = circling and Color3.fromRGB(50,0,0) or Color3.fromRGB(12,0,18)
    if circling then
        local center = Player.Character.HumanoidRootPart.Position
        local radius = 8
        for _, plr in pairs(Player:GetPlayers()) do
            if plr ~= Player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local angle = math.random(0, 360)
                local x = center.X + radius * math.cos(angle)
                local z = center.Z + radius * math.sin(angle)
                plr.Character.HumanoidRootPart.CFrame = CFrame.new(x, center.Y + 2, z)
                table.insert(circleTargets, {player = plr, angle = angle, radius = radius})
            end
        end
        spawn(function()
            while circling do
                for _, data in ipairs(circleTargets) do
                    if data.player.Character and data.player.Character:FindFirstChild("HumanoidRootPart") then
                        local centerPos = Player.Character.HumanoidRootPart.Position
                        data.angle = data.angle + 0.05
                        local x = centerPos.X + data.radius * math.cos(data.angle)
                        local z = centerPos.Z + data.radius * math.sin(data.angle)
                        data.player.Character.HumanoidRootPart.CFrame = CFrame.new(x, centerPos.Y + 2, z)
                    end
                end
                wait(0.05)
            end
        end)
    else
        circleTargets = {}
    end
end)

-- 11. ХОДЬБА ПО ВОДЕ
local waterWalk = false
MainFrame.water.MouseButton1Click:Connect(function()
    waterWalk = not waterWalk
    MainFrame.water.BackgroundColor3 = waterWalk and Color3.fromRGB(50,0,0) or Color3.fromRGB(12,0,18)
    if waterWalk then
        RunService.Stepped:Connect(function()
            if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = Player.Character.HumanoidRootPart
                if hrp.Position.Y < 0 then
                    hrp.CFrame = hrp.CFrame + Vector3.new(0, 5, 0)
                end
            end
        end)
    end
end)

-- 12. НЕВИДИМОСТЬ
MainFrame.invis.MouseButton1Click:Connect(function()
    if Player.Character then
        for _, part in ipairs(Player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = 1
            end
        end
        MainFrame.invis.BackgroundColor3 = Color3.fromRGB(50,0,0)
    end
end)

-- 13. ЗАМОРОЗКА
MainFrame.freeze.MouseButton1Click:Connect(function()
    for _, plr in pairs(Player:GetPlayers()) do
        if plr ~= Player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(4000, 4000, 4000)
            bv.Velocity = Vector3.new(0, 0, 0)
            bv.Parent = plr.Character.HumanoidRootPart
            game:GetService("Debris"):AddItem(bv, 5)
        end
    end
    MainFrame.freeze.BackgroundColor3 = Color3.fromRGB(50,0,0)
end)

-- 14. МУЗЫКА ДЛЯ ВСЕХ
local musicAll = false
local musicLoop
MainFrame.musicall.MouseButton1Click:Connect(function()
    musicAll = not musicAll
    MainFrame.musicall.BackgroundColor3 = musicAll and Color3.fromRGB(50,0,0) or Color3.fromRGB(12,0,18)
    if musicAll then
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://1838134491"
        sound.Volume = 0.5
        sound.Looped = true
        sound.Parent = Workspace
        local soundService = game:GetService("SoundService")
        soundService.RespectFilteringEnabled = false
        sound:Play()
        musicLoop = RunService.Heartbeat:Connect(function()
            if not musicAll then
                sound:Stop()
                sound:Destroy()
                musicLoop:Disconnect()
            end
        end)
    else
        if Workspace:FindFirstChildOfClass("Sound") then
            Workspace:FindFirstChildOfClass("Sound"):Stop()
            Workspace:FindFirstChildOfClass("Sound"):Destroy()
        end
        if musicLoop then musicLoop:Disconnect() end
    end
end)

-- // ========== ОТКРЫТИЕ/ЗАКРЫТИЕ ПО ИКОНКЕ ========== //
local menuOpen = false

IconButton.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    MainFrame.Visible = menuOpen
    IconButton.Visible = not menuOpen
    if menuOpen then
        -- Эффект появления
        MainFrame.BackgroundTransparency = 0.05
        MainFrame.Size = UDim2.new(0, 350, 0, 500)
    end
end)

-- ПЕРЕТАСКИВАНИЕ МЕНЮ (ПАЛЬЦЕМ)
local dragToggle = nil
local dragSpeed = 0.5
local dragStart = nil
local startPos = nil

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        dragToggle = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

MainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        dragToggle = false
    end
end)

UIS.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch and dragToggle then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- // ========== ПАНИКА (CTRL + P) ========== //
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.P and UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
        ScreenGui:Destroy()
        print("☠ ПАНИКА АКТИВИРОВАНА")
    end
end)

print("☠ RUSSIAN YAD v5.0 ЗАГРУЖЕН")
print("📌 НАЖМИ НА ИКОНКУ ☠ ЧТОБЫ ОТКРЫТЬ/ЗАКРЫТЬ МЕНЮ")
print("👆 ТЯНИ ПАЛЬЦЕМ ЗА ЗАГОЛОВОК ДЛЯ ПЕРЕМЕЩЕНИЯ")
