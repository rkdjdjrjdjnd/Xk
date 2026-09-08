--==================================================
-- SNAP-STYLE TEST GUI
-- Только интерфейс и тестовая логика
--==================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer

--==================================================
-- SETTINGS
--==================================================

local gui = Instance.new("ScreenGui")
gui.Name = "SnapStyleTestGUI"
gui.ResetOnSpawn = false
gui.Parent = Player:WaitForChild("PlayerGui")

local flyRunning = false

--==================================================
-- COLORS
--==================================================

local BG = Color3.fromRGB(12, 12, 18)
local PANEL = Color3.fromRGB(20, 20, 30)
local BUTTON = Color3.fromRGB(30, 30, 43)
local ACCENT = Color3.fromRGB(160, 80, 255)
local TEXT = Color3.fromRGB(245, 245, 250)
local SUBTEXT = Color3.fromRGB(160, 160, 175)

--==================================================
-- MAIN WINDOW
--==================================================

local Main = Instance.new("Frame")
Main.Parent = gui
Main.Size = UDim2.fromOffset(330, 330)
Main.Position = UDim2.new(0.5, -165, 0.5, -165)
Main.BackgroundColor3 = BG
Main.BorderSizePixel = 0
Main.Active = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 18)
MainCorner.Parent = Main

--==================================================
-- TOP BAR
--==================================================

local Top = Instance.new("Frame")
Top.Parent = Main
Top.Size = UDim2.new(1, 0, 0, 55)
Top.BackgroundColor3 = PANEL
Top.BorderSizePixel = 0

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 18)
TopCorner.Parent = Top

local Title = Instance.new("TextLabel")
Title.Parent = Top
Title.BackgroundTransparency = 1
Title.Position = UDim2.fromOffset(18, 7)
Title.Size = UDim2.new(1, -70, 0, 25)
Title.Text = "SNAP TEST"
Title.TextColor3 = TEXT
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left

local Subtitle = Instance.new("TextLabel")
Subtitle.Parent = Top
Subtitle.BackgroundTransparency = 1
Subtitle.Position = UDim2.fromOffset(19, 31)
Subtitle.Size = UDim2.new(1, -70, 0, 17)
Subtitle.Text = "CONTROL PANEL"
Subtitle.TextColor3 = SUBTEXT
Subtitle.TextSize = 10
Subtitle.Font = Enum.Font.Gotham

--==================================================
-- CLOSE
--==================================================

local Close = Instance.new("TextButton")
Close.Parent = Top
Close.Size = UDim2.fromOffset(34, 34)
Close.Position = UDim2.new(1, -45, 0, 10)
Close.BackgroundColor3 = Color3.fromRGB(40, 30, 45)
Close.Text = "×"
Close.TextColor3 = TEXT
Close.TextSize = 23
Close.Font = Enum.Font.GothamBold
Close.BorderSizePixel = 0

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 10)
CloseCorner.Parent = Close

Close.MouseButton1Click:Connect(function()
    Main.Visible = false
end)

--==================================================
-- TABS
--==================================================

local Tabs = Instance.new("Frame")
Tabs.Parent = Main
Tabs.Position = UDim2.fromOffset(12, 65)
Tabs.Size = UDim2.new(1, -24, 0, 38)
Tabs.BackgroundTransparency = 1

local function createTab(text, x)
    local tab = Instance.new("TextButton")

    tab.Parent = Tabs
    tab.Size = UDim2.new(0.32, -4, 1, 0)
    tab.Position = UDim2.new(x, 0, 0, 0)

    tab.BackgroundColor3 = BUTTON
    tab.Text = text
    tab.TextColor3 = TEXT
    tab.TextSize = 12
    tab.Font = Enum.Font.GothamBold
    tab.BorderSizePixel = 0

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 9)
    corner.Parent = tab

    return tab
end

local HomeTab = createTab("HOME", 0)
local PlayerTab = createTab("PLAYER", 0.34)
local InfoTab = createTab("INFO", 0.68)

--==================================================
-- CONTENT
--==================================================

local Content = Instance.new("Frame")
Content.Parent = Main
Content.Position = UDim2.fromOffset(12, 112)
Content.Size = UDim2.new(1, -24, 1, -124)
Content.BackgroundTransparency = 1

local function createAction(text, y)
    local button = Instance.new("TextButton")

    button.Parent = Content
    button.Size = UDim2.new(1, 0, 0, 45)
    button.Position = UDim2.fromOffset(0, y)

    button.BackgroundColor3 = BUTTON
    button.Text = text
    button.TextColor3 = TEXT
    button.TextSize = 15
    button.Font = Enum.Font.GothamBold
    button.BorderSizePixel = 0

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 11)
    corner.Parent = button

    return button
end

local FlyButton = createAction("FLY", 0)
local NoclipButton = createAction("NOCLIP", 55)
local SpeedButton = createAction("SPEED", 110)

--==================================================
-- LOADING SCREEN
--==================================================

local function showLoading()
    local Overlay = Instance.new("Frame")

    Overlay.Parent = gui
    Overlay.Size = UDim2.fromScale(1, 1)
    Overlay.BackgroundColor3 = Color3.fromRGB(5, 5, 9)
    Overlay.BackgroundTransparency = 0.08
    Overlay.ZIndex = 100

    local Box = Instance.new("Frame")
    Box.Parent = Overlay
    Box.Size = UDim2.fromOffset(240, 145)
    Box.Position = UDim2.new(0.5, -120, 0.5, -72)
    Box.BackgroundColor3 = PANEL
    Box.BorderSizePixel = 0
    Box.ZIndex = 101

    local BoxCorner = Instance.new("UICorner")
    BoxCorner.CornerRadius = UDim.new(0, 16)
    BoxCorner.Parent = Box

    local LoadingText = Instance.new("TextLabel")
    LoadingText.Parent = Box
    LoadingText.BackgroundTransparency = 1
    LoadingText.Position = UDim2.fromOffset(10, 15)
    LoadingText.Size = UDim2.new(1, -20, 0, 25)
    LoadingText.Text = "LOADING"
    LoadingText.TextColor3 = TEXT
    LoadingText.TextSize = 19
    LoadingText.Font = Enum.Font.GothamBold
    LoadingText.ZIndex = 102

    local Counter = Instance.new("TextLabel")
    Counter.Parent = Box
    Counter.BackgroundTransparency = 1
    Counter.Position = UDim2.fromOffset(10, 45)
    Counter.Size = UDim2.new(1, -20, 0, 50)
    Counter.Text = "3"
    Counter.TextColor3 = ACCENT
    Counter.TextSize = 42
    Counter.Font = Enum.Font.GothamBold
    Counter.ZIndex = 102

    local BarBackground = Instance.new("Frame")
    BarBackground.Parent = Box
    BarBackground.Position = UDim2.fromOffset(20, 108)
    BarBackground.Size = UDim2.new(1, -40, 0, 7)
    BarBackground.BackgroundColor3 = BUTTON
    BarBackground.BorderSizePixel = 0
    BarBackground.ZIndex = 102

    local BarCorner = Instance.new("UICorner")
    BarCorner.CornerRadius = UDim.new(1, 0)
    BarCorner.Parent = BarBackground

    local Bar = Instance.new("Frame")
    Bar.Parent = BarBackground
    Bar.Size = UDim2.new(0, 0, 1, 0)
    Bar.BackgroundColor3 = ACCENT
    Bar.BorderSizePixel = 0
    Bar.ZIndex = 103

    local BarCorner2 = Instance.new("UICorner")
    BarCorner2.CornerRadius = UDim.new(1, 0)
    BarCorner2.Parent = Bar

    TweenService:Create(
        Bar,
        TweenInfo.new(3, Enum.EasingStyle.Linear),
        {Size = UDim2.fromScale(1, 1)}
    ):Play()

    for i = 3, 1, -1 do
        Counter.Text = tostring(i)
        task.wait(1)
    end

    Counter.Text = "READY"

    task.wait(0.3)

    Overlay:Destroy()
end

--==================================================
-- FLY TEST BUTTON
--==================================================

FlyButton.MouseButton1Click:Connect(function()

    if not flyRunning then
        flyRunning = true

        task.spawn(function()
            showLoading()

            FlyButton.BackgroundColor3 = Color3.fromRGB(50, 35, 70)

            -- Здесь можно подключить
            -- безопасную Fly-систему твоего собственного проекта.
        end)

    else
        flyRunning = false
        FlyButton.BackgroundColor3 = BUTTON

        -- Здесь выключается Fly
        -- твоего собственного проекта.
    end
end)

--==================================================
-- NOCLIP TEST
--==================================================

local noclip = false

NoclipButton.MouseButton1Click:Connect(function()
    noclip = not noclip

    if noclip then
        NoclipButton.BackgroundColor3 = Color3.fromRGB(45, 80, 55)
    else
        NoclipButton.BackgroundColor3 = BUTTON
    end
end)

--==================================================
-- SPEED TEST
--==================================================

local speed = false

SpeedButton.MouseButton1Click:Connect(function()
    speed = not speed

    if speed then
        SpeedButton.BackgroundColor3 = Color3.fromRGB(45, 80, 55)
    else
        SpeedButton.BackgroundColor3 = BUTTON
    end
end)

--==================================================
-- DRAG
--==================================================

local dragging = false
local dragStart
local startPosition

Top.InputBegan:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseButton1 then

        dragging = true
        dragStart = input.Position
        startPosition = Main.Position
    end
end)

Top.InputEnded:Connect(function(input)

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

        local delta = input.Position - dragStart

        Main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

print("SNAP STYLE TEST GUI loaded")
