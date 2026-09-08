--// TEST GUI: FLY + NOCLIP + SPEED
--// Для собственного Roblox-проекта

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer

--==================================================
-- SETTINGS
--==================================================

local DEFAULT_SPEED = 16
local FLY_SPEED = 70

local speedEnabled = false
local noclipEnabled = false
local flyEnabled = false

local speedConnection = nil
local noclipConnection = nil
local flyConnection = nil

local flyVelocity = nil
local flyAttachment = nil

--==================================================
-- GUI
--==================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TestUtilityGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

-- Main button

local OpenButton = Instance.new("TextButton")
OpenButton.Parent = ScreenGui
OpenButton.Size = UDim2.fromOffset(60, 60)
OpenButton.Position = UDim2.new(1, -80, 1, -100)
OpenButton.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
OpenButton.Text = "☠"
OpenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenButton.TextScaled = true
OpenButton.Font = Enum.Font.GothamBold
OpenButton.BorderSizePixel = 0

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(1, 0)
OpenCorner.Parent = OpenButton

-- Main frame

local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.fromOffset(300, 250)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -125)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false

local FrameCorner = Instance.new("UICorner")
FrameCorner.CornerRadius = UDim.new(0, 16)
FrameCorner.Parent = MainFrame

--==================================================
-- TITLE
--==================================================

local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, -50, 0, 45)
Title.Position = UDim2.fromOffset(15, 5)
Title.BackgroundTransparency = 1
Title.Text = "TEST CONTROL"
Title.TextColor3 = Color3.fromRGB(255, 90, 130)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Close

local CloseButton = Instance.new("TextButton")
CloseButton.Parent = MainFrame
CloseButton.Size = UDim2.fromOffset(35, 35)
CloseButton.Position = UDim2.new(1, -42, 0, 7)
CloseButton.BackgroundColor3 = Color3.fromRGB(50, 20, 25)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 18
CloseButton.Font = Enum.Font.GothamBold
CloseButton.BorderSizePixel = 0

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseButton

--==================================================
-- BUTTON CREATOR
--==================================================

local function createButton(text, y)
    local button = Instance.new("TextButton")

    button.Parent = MainFrame
    button.Size = UDim2.new(1, -30, 0, 40)
    button.Position = UDim2.fromOffset(15, y)

    button.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)

    button.Text = text
    button.Font = Enum.Font.GothamBold
    button.TextSize = 17

    button.BorderSizePixel = 0

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = button

    return button
end

local FlyButton = createButton("FLY: OFF", 55)
local NoclipButton = createButton("NOCLIP: OFF", 102)
local SpeedButton = createButton("SPEED: OFF", 149)

--==================================================
-- SPEED
--==================================================

local function stopSpeed()
    speedEnabled = false

    if speedConnection then
        speedConnection:Disconnect()
        speedConnection = nil
    end

    local character = Player.Character

    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")

        if humanoid then
            humanoid.WalkSpeed = DEFAULT_SPEED
        end
    end

    SpeedButton.Text = "SPEED: OFF"
    SpeedButton.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
end

local function startSpeed()
    stopSpeed()

    speedEnabled = true

    SpeedButton.Text = "SPEED: ON"
    SpeedButton.BackgroundColor3 = Color3.fromRGB(30, 100, 55)

    speedConnection = RunService.Heartbeat:Connect(function()
        if not speedEnabled then
            return
        end

        local character = Player.Character

        if not character then
            return
        end

        local humanoid = character:FindFirstChildOfClass("Humanoid")

        if humanoid then
            humanoid.WalkSpeed = 40
        end
    end)
end

--==================================================
-- NOCLIP
--==================================================

local function stopNoclip()
    noclipEnabled = false

    if noclipConnection then
        noclipConnection:Disconnect()
        noclipConnection = nil
    end

    local character = Player.Character

    if character then
        for _, object in ipairs(character:GetDescendants()) do
            if object:IsA("BasePart") then
                object.CanCollide = true
            end
        end
    end

    NoclipButton.Text = "NOCLIP: OFF"
    NoclipButton.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
end

local function startNoclip()
    stopNoclip()

    noclipEnabled = true

    NoclipButton.Text = "NOCLIP: ON"
    NoclipButton.BackgroundColor3 = Color3.fromRGB(30, 100, 55)

    noclipConnection = RunService.Stepped:Connect(function()
        if not noclipEnabled then
            return
        end

        local character = Player.Character

        if not character then
            return
        end

        for _, object in ipairs(character:GetDescendants()) do
            if object:IsA("BasePart") then
                object.CanCollide = false
            end
        end
    end)
end

--==================================================
-- FLY
--==================================================

local function stopFly()
    flyEnabled = false

    if flyConnection then
        flyConnection:Disconnect()
        flyConnection = nil
    end

    if flyVelocity then
        flyVelocity:Destroy()
        flyVelocity = nil
    end

    if flyAttachment then
        flyAttachment:Destroy()
        flyAttachment = nil
    end

    FlyButton.Text = "FLY: OFF"
    FlyButton.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
end

local function startFly()
    stopFly()

    local character = Player.Character

    if not character then
        return
    end

    local root = character:FindFirstChild("HumanoidRootPart")
    local humanoid = character:FindFirstChildOfClass("Humanoid")

    if not root or not humanoid then
        return
    end

    flyEnabled = true

    FlyButton.Text = "FLY: ON"
    FlyButton.BackgroundColor3 = Color3.fromRGB(30, 100, 55)

    flyAttachment = Instance.new("Attachment")
    flyAttachment.Name = "TestFlyAttachment"
    flyAttachment.Parent = root

    flyVelocity = Instance.new("LinearVelocity")
    flyVelocity.Name = "TestFlyVelocity"
    flyVelocity.Attachment0 = flyAttachment
    flyVelocity.MaxForce = math.huge
    flyVelocity.VectorVelocity = Vector3.zero
    flyVelocity.Parent = root

    humanoid.PlatformStand = true

    flyConnection = RunService.RenderStepped:Connect(function()
        if not flyEnabled then
            return
        end

        if not root.Parent then
            return
        end

        local camera = workspace.CurrentCamera

        if not camera then
            return
        end

        local direction = Vector3.zero

        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            direction += camera.CFrame.LookVector
        end

        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            direction -= camera.CFrame.LookVector
        end

        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            direction -= camera.CFrame.RightVector
        end

        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            direction += camera.CFrame.RightVector
        end

        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            direction += Vector3.yAxis
        end

        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            direction -= Vector3.yAxis
        end

        if direction.Magnitude > 0 then
            direction = direction.Unit * FLY_SPEED
        end

        flyVelocity.VectorVelocity = direction
    end)
end

--==================================================
-- BUTTON EVENTS
--==================================================

FlyButton.MouseButton1Click:Connect(function()
    if flyEnabled then
        stopFly()
    else
        startFly()
    end
end)

NoclipButton.MouseButton1Click:Connect(function()
    if noclipEnabled then
        stopNoclip()
    else
        startNoclip()
    end
end)

SpeedButton.MouseButton1Click:Connect(function()
    if speedEnabled then
        stopSpeed()
    else
        startSpeed()
    end
end)

--==================================================
-- OPEN / CLOSE
--==================================================

OpenButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

--==================================================
-- CHARACTER RESPAWN
--==================================================

Player.CharacterAdded:Connect(function()
    stopFly()
    stopNoclip()
    stopSpeed()
end)

--==================================================
-- MOBILE DRAG
--==================================================

local dragging = false
local dragStart
local startPosition

local function updateDrag(input)
    local delta = input.Position - dragStart

    MainFrame.Position = UDim2.new(
        startPosition.X.Scale,
        startPosition.X.Offset + delta.X,
        startPosition.Y.Scale,
        startPosition.Y.Offset + delta.Y
    )
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseButton1 then

        dragging = true
        dragStart = input.Position
        startPosition = MainFrame.Position
    end
end)

MainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseButton1 then

        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if not dragging then
        return
    end

    if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseMovement then

        updateDrag(input)
    end
end)

print("TEST CONTROL GUI loaded")
