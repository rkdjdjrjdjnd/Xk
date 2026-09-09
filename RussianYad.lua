--==================================================
-- AD MENU v6.0
-- PART 1/2
-- Roblox Studio / LocalScript
--==================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

--==================================================
-- GUI
--==================================================

local gui = Instance.new("ScreenGui")
gui.Name = "ADMenu"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = playerGui

--==================================================
-- LOADING SCREEN
--==================================================

local loading = Instance.new("Frame")
loading.Name = "Loading"
loading.Size = UDim2.fromScale(1, 1)
loading.BackgroundColor3 = Color3.fromRGB(8, 8, 10)
loading.BorderSizePixel = 0
loading.Parent = gui

local loadingScale = Instance.new("UIScale")
loadingScale.Scale = 1
loadingScale.Parent = loading

local loadingTitle = Instance.new("TextLabel")
loadingTitle.Size = UDim2.new(0, 300, 0, 45)
loadingTitle.Position = UDim2.new(0.5, -150, 0.5, -65)
loadingTitle.BackgroundTransparency = 1
loadingTitle.Text = "AD MENU"
loadingTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
loadingTitle.TextSize = 30
loadingTitle.Font = Enum.Font.GothamBold
loadingTitle.Parent = loading

local loadingText = Instance.new("TextLabel")
loadingText.Size = UDim2.new(0, 300, 0, 30)
loadingText.Position = UDim2.new(0.5, -150, 0.5, -20)
loadingText.BackgroundTransparency = 1
loadingText.Text = "LOADING 0%"
loadingText.TextColor3 = Color3.fromRGB(180, 180, 180)
loadingText.TextSize = 15
loadingText.Font = Enum.Font.Gotham
loadingText.Parent = loading

local barBack = Instance.new("Frame")
barBack.Size = UDim2.new(0, 260, 0, 5)
barBack.Position = UDim2.new(0.5, -130, 0.5, 25)
barBack.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
barBack.BorderSizePixel = 0
barBack.Parent = loading

local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(1, 0)
barCorner.Parent = barBack

local bar = Instance.new("Frame")
bar.Size = UDim2.new(0, 0, 1, 0)
bar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
bar.BorderSizePixel = 0
bar.Parent = barBack

local barCorner2 = Instance.new("UICorner")
barCorner2.CornerRadius = UDim.new(1, 0)
barCorner2.Parent = bar

--==================================================
-- MAIN MENU
--==================================================

local menu = Instance.new("Frame")
menu.Name = "MainMenu"
menu.Size = UDim2.fromOffset(300, 310)
menu.Position = UDim2.new(0.5, -150, 0.5, -155)
menu.BackgroundColor3 = Color3.fromRGB(14, 14, 17)
menu.BorderSizePixel = 0
menu.Visible = false
menu.ClipsDescendants = true
menu.Parent = gui

local menuCorner = Instance.new("UICorner")
menuCorner.CornerRadius = UDim.new(0, 14)
menuCorner.Parent = menu

local menuStroke = Instance.new("UIStroke")
menuStroke.Color = Color3.fromRGB(55, 55, 60)
menuStroke.Thickness = 1
menuStroke.Transparency = 0.2
menuStroke.Parent = menu

local menuScale = Instance.new("UIScale")
menuScale.Scale = 0.75
menuScale.Parent = menu

--==================================================
-- HEADER
--==================================================

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 52)
header.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
header.BorderSizePixel = 0
header.Parent = menu

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, -105, 1, 0)
title.Position = UDim2.fromOffset(52, 0)
title.BackgroundTransparency = 1
title.Text = "AD MENU"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 18
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

-- Settings
local settings = Instance.new("TextButton")
settings.Name = "Settings"
settings.Size = UDim2.fromOffset(42, 42)
settings.Position = UDim2.fromOffset(5, 5)
settings.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
settings.Text = "⚙"
settings.TextColor3 = Color3.fromRGB(255, 255, 255)
settings.TextSize = 22
settings.Font = Enum.Font.GothamBold
settings.AutoButtonColor = false
settings.Parent = header

local settingsCorner = Instance.new("UICorner")
settingsCorner.CornerRadius = UDim.new(0, 10)
settingsCorner.Parent = settings

-- Close
local close = Instance.new("TextButton")
close.Name = "Close"
close.Size = UDim2.fromOffset(42, 42)
close.Position = UDim2.new(1, -47, 0, 5)
close.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
close.Text = "X"
close.TextColor3 = Color3.fromRGB(255, 255, 255)
close.TextSize = 18
close.Font = Enum.Font.GothamBold
close.AutoButtonColor = false
close.Parent = header

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 10)
closeCorner.Parent = close

--==================================================
-- CONTENT
--==================================================

local content = Instance.new("Frame")
content.Name = "Content"
content.Size = UDim2.new(1, -20, 1, -62)
content.Position = UDim2.fromOffset(10, 57)
content.BackgroundTransparency = 1
content.Parent = menu

local function createButton(name, text, y)
	local button = Instance.new("TextButton")

	button.Name = name
	button.Size = UDim2.new(1, 0, 0, 48)
	button.Position = UDim2.fromOffset(0, y)

	button.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
	button.BorderSizePixel = 0

	button.Text = text
	button.TextColor3 = Color3.fromRGB(235, 235, 235)
	button.TextSize = 15
	button.Font = Enum.Font.GothamMedium
	button.TextXAlignment = Enum.TextXAlignment.Left

	button.AutoButtonColor = false
	button.Parent = content

	local padding = Instance.new("UIPadding")
	padding.Left = UDim.new(0, 16)
	padding.Parent = button

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 10)
	corner.Parent = button

	button.MouseEnter:Connect(function()
		TweenService:Create(
			button,
			TweenInfo.new(0.15),
			{BackgroundColor3 = Color3.fromRGB(35, 35, 42)}
		):Play()
	end)

	button.MouseLeave:Connect(function()
		TweenService:Create(
			button,
			TweenInfo.new(0.15),
			{BackgroundColor3 = Color3.fromRGB(25, 25, 30)}
		):Play()
	end)

	return button
end

local espButton = createButton("ESP", "ESP", 0)
local playerButton = createButton("PLAYER", "PLAYER", 56)
local visualsButton = createButton("VISUALS", "VISUALS", 112)
local aboutButton = createButton("ABOUT", "ABOUT", 168)

--==================================================
-- ESP PAGE
--==================================================

local espPage = Instance.new("Frame")
espPage.Name = "ESPPage"
espPage.Size = UDim2.fromScale(1, 1)
espPage.BackgroundTransparency = 1
espPage.Visible = false
espPage.Parent = content

local espBack = Instance.new("TextButton")
espBack.Size = UDim2.fromOffset(70, 35)
espBack.Position = UDim2.fromOffset(0, 0)
espBack.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
espBack.Text = "< BACK"
espBack.TextColor3 = Color3.fromRGB(255, 255, 255)
espBack.TextSize = 12
espBack.Font = Enum.Font.GothamBold
espBack.AutoButtonColor = false
espBack.Parent = espPage

local backCorner = Instance.new("UICorner")
backCorner.CornerRadius = UDim.new(0, 8)
backCorner.Parent = espBack

local espTitle = Instance.new("TextLabel")
espTitle.Size = UDim2.new(1, -80, 0, 35)
espTitle.Position = UDim2.fromOffset(80, 0)
espTitle.BackgroundTransparency = 1
espTitle.Text = "ESP"
espTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
espTitle.TextSize = 18
espTitle.Font = Enum.Font.GothamBold
espTitle.TextXAlignment = Enum.TextXAlignment.Right
espTitle.Parent = espPage

local espList = Instance.new("Frame")
espList.Size = UDim2.new(1, 0, 1, -45)
espList.Position = UDim2.fromOffset(0, 45)
espList.BackgroundTransparency = 1
espList.Parent = espPage

local function createToggle(name, text, y)
	local button = Instance.new("TextButton")

	button.Name = name
	button.Size = UDim2.new(1, 0, 0, 42)
	button.Position = UDim2.fromOffset(0, y)

	button.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
	button.BorderSizePixel = 0

	button.Text = text .. "   [ OFF ]"
	button.TextColor3 = Color3.fromRGB(220, 220, 220)
	button.TextSize = 14
	button.Font = Enum.Font.GothamMedium
	button.TextXAlignment = Enum.TextXAlignment.Left

	button.AutoButtonColor = false
	button.Parent = espList

	local padding = Instance.new("UIPadding")
	padding.Left = UDim.new(0, 14)
	padding.Parent = button

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 9)
	corner.Parent = button

	return button
end

local espToggle = createToggle("ESP", "ESP", 0)
local nameToggle = createToggle("Name", "NAME", 48)
local distanceToggle = createToggle("Distance", "DISTANCE", 96)
local boxToggle = createToggle("Box", "BOX", 144)
local healthToggle = createToggle("Health", "HEALTH", 192)

--==================================================
-- SETTINGS PAGE
--==================================================

local settingsPage = Instance.new("Frame")
settingsPage.Name = "SettingsPage"
settingsPage.Size = UDim2.fromScale(1, 1)
settingsPage.BackgroundTransparency = 1
settingsPage.Visible = false
settingsPage.Parent = content

local settingsBack = Instance.new("TextButton")
settingsBack.Size = UDim2.fromOffset(70, 35)
settingsBack.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
settingsBack.Text = "< BACK"
settingsBack.TextColor3 = Color3.fromRGB(255, 255, 255)
settingsBack.TextSize = 12
settingsBack.Font = Enum.Font.GothamBold
settingsBack.AutoButtonColor = false
settingsBack.Parent = settingsPage

local languageTitle = Instance.new("TextLabel")
languageTitle.Size = UDim2.new(1, -80, 0, 35)
languageTitle.Position = UDim2.fromOffset(80, 0)
languageTitle.BackgroundTransparency = 1
languageTitle.Text = "LANGUAGE"
languageTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
languageTitle.TextSize = 17
languageTitle.Font = Enum.Font.GothamBold
languageTitle.TextXAlignment = Enum.TextXAlignment.Right
languageTitle.Parent = settingsPage

local ruButton = createButton("Russian", "Русский", 55)
ruButton.Parent = settingsPage

local enButton = createButton("English", "English", 111)
enButton.Parent = settingsPage

--==================================================
-- FLOATING AD BUTTON
--==================================================

local icon = Instance.new("TextButton")
icon.Name = "ADButton"
icon.Size = UDim2.fromOffset(58, 58)
icon.Position = UDim2.new(0.5, -29, 0.5, -29)
icon.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
icon.Text = "AD"
icon.TextColor3 = Color3.fromRGB(255, 255, 255)
icon.TextSize = 20
icon.Font = Enum.Font.GothamBlack
icon.AutoButtonColor = false
icon.Visible = false
icon.Parent = gui

local iconCorner = Instance.new("UICorner")
iconCorner.CornerRadius = UDim.new(1, 0)
iconCorner.Parent = icon

local iconStroke = Instance.new("UIStroke")
iconStroke.Color = Color3.fromRGB(255, 255, 255)
iconStroke.Thickness = 1
iconStroke.Transparency = 0.15
iconStroke.Parent = icon

local dot = Instance.new("Frame")
dot.Size = UDim2.fromOffset(9, 9)
dot.Position = UDim2.new(1, -12, 0, 4)
dot.BackgroundColor3 = Color3.fromRGB(255, 45, 45)
dot.BorderSizePixel = 0
dot.Parent = icon

local dotCorner = Instance.new("UICorner")
dotCorner.CornerRadius = UDim.new(1, 0)
dotCorner.Parent = dot

--==================================================
-- PAGE CONTROL
--==================================================

local function showMain()
	espPage.Visible = false
	settingsPage.Visible = false

	espButton.Visible = true
	playerButton.Visible = true
	visualsButton.Visible = true
	aboutButton.Visible = true
end

local function showESP()
	espButton.Visible = false
	playerButton.Visible = false
	visualsButton.Visible = false
	aboutButton.Visible = false

	settingsPage.Visible = false
	espPage.Visible = true
end

local function showSettings()
	espButton.Visible = false
	playerButton.Visible = false
	visualsButton.Visible = false
	aboutButton.Visible = false

	espPage.Visible = false
	settingsPage.Visible = true
end

--==================================================
-- MENU ANIMATION
--==================================================

local menuOpen = false
local animating = false

local function openMenu()
	if animating or menuOpen then
		return
	end

	animating = true
	menuOpen = true

	menu.Visible = true
	showMain()

	menuScale.Scale = 0.75
	menu.BackgroundTransparency = 1

	TweenService:Create(
		menuScale,
		TweenInfo.new(
			0.28,
			Enum.EasingStyle.Back,
			Enum.EasingDirection.Out
		),
		{Scale = 1}
	):Play()

	local fade = TweenService:Create(
		menu,
		TweenInfo.new(0.2, Enum.EasingStyle.Quad),
		{BackgroundTransparency = 0}
	)

	fade:Play()
	fade.Completed:Wait()

	animating = false
end

local function closeMenu()
	if animating or not menuOpen then
		return
	end

	animating = true
	menuOpen = false

	local scaleTween = TweenService:Create(
		menuScale,
		TweenInfo.new(
			0.18,
			Enum.EasingStyle.Back,
			Enum.EasingDirection.In
		),
		{Scale = 0.75}
	)

	scaleTween:Play()
	scaleTween.Completed:Wait()

	menu.Visible = false
	animating = false
end

--==================================================
-- BUTTON EFFECT
--==================================================

local function pressEffect(button)
	local original = button.Size

	TweenService:Create(
		button,
		TweenInfo.new(0.07),
		{
			Size = UDim2.new(
				original.X.Scale,
				original.X.Offset - 4,
				original.Y.Scale,
				original.Y.Offset - 2
			)
		}
	):Play()

	task.delay(0.07, function()
		TweenService:Create(
			button,
			TweenInfo.new(0.09),
			{Size = original}
		):Play()
	end)
end

--==================================================
-- EVENTS
--==================================================

icon.Activated:Connect(function()
	pressEffect(icon)

	if menuOpen then
		closeMenu()
	else
		openMenu()
	end
end)

close.Activated:Connect(function()
	pressEffect(close)
	closeMenu()
end)

settings.Activated:Connect(function()
	pressEffect(settings)
	showSettings()
end)

espButton.Activated:Connect(function()
	pressEffect(espButton)
	showESP()
end)

espBack.Activated:Connect(function()
	pressEffect(espBack)
	showMain()
end)

settingsBack.Activated:Connect(function()
	pressEffect(settingsBack)
	showMain()
end)

--==================================================
-- MOBILE DRAG
--==================================================

local dragging = false
local dragStart
local startPosition
local moved = false

icon.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch
		or input.UserInputType == Enum.UserInputType.MouseButton1 then

		dragging = true
		moved = false
		dragStart = input.Position
		startPosition = icon.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if not dragging then
		return
	end

	if input.UserInputType ~= Enum.UserInputType.Touch
		and input.UserInputType ~= Enum.UserInputType.MouseMovement then
		return
	end

	local delta = input.Position - dragStart

	if math.abs(delta.X) > 8 or math.abs(delta.Y) > 8 then
		moved = true
	end

	icon.Position = UDim2.new(
		startPosition.X.Scale,
		startPosition.X.Offset + delta.X,
		startPosition.Y.Scale,
		startPosition.Y.Offset + delta.Y
	)
end)

--==================================================
-- BEAUTIFUL LOADING
--==================================================

task.spawn(function()

	for percent = 0, 100, 5 do

		loadingText.Text = "LOADING " .. percent .. "%"

		TweenService:Create(
			bar,
			TweenInfo.new(0.06, Enum.EasingStyle.Linear),
			{
				Size = UDim2.new(
					percent / 100,
					0,
					1,
					0
				)
			}
		):Play()

		task.wait(0.06)
	end

	task.wait(0.25)

	-- fade loading
	local objects = {
		loadingTitle,
		loadingText,
		barBack
	}

	for _, object in ipairs(objects) do
		if object:IsA("TextLabel") then
			TweenService:Create(
				object,
				TweenInfo.new(0.25),
				{TextTransparency = 1}
			):Play()
		else
			TweenService:Create(
				object,
				TweenInfo.new(0.25),
				{BackgroundTransparency = 1}
			):Play()
		end
	end

	TweenService:Create(
		loading,
		TweenInfo.new(0.3),
		{BackgroundTransparency = 1}
	):Play()

	task.wait(0.35)

	loading:Destroy()

	-- AD появляется только после загрузки
	icon.Visible = true

	icon.Size = UDim2.fromOffset(0, 0)

	TweenService:Create(
		icon,
		TweenInfo.new(
			0.35,
			Enum.EasingStyle.Back,
			Enum.EasingDirection.Out
		),
		{
			Size = UDim2.fromOffset(58, 58)
		}
	):Play()
end)

--==================================================
-- END OF PART 1/2
--==================================================
-- ==========================================
-- AD MENU v6.0
-- PART 2/2
-- ESP + SETTINGS + ANIMATIONS
-- ==========================================

local ESP_ENABLED = false
local ESP_NAME = true
local ESP_DISTANCE = true
local ESP_BOX = true
local ESP_HEALTH = true

local ESP_UPDATE_TIME = 0.15
local espCache = {}

-- ==========================================
-- ESP CREATE
-- ==========================================

local function removeESP(plr)
    local data = espCache[plr]

    if data then
        if data.highlight then
            data.highlight:Destroy()
        end

        if data.billboard then
            data.billboard:Destroy()
        end

        if data.box then
            data.box:Destroy()
        end

        espCache[plr] = nil
    end
end

local function createESP(plr)
    if plr == player then
        return
    end

    local char = plr.Character
    if not char then
        return
    end

    local root = char:FindFirstChild("HumanoidRootPart")
    local humanoid = char:FindFirstChildOfClass("Humanoid")

    if not root or not humanoid then
        return
    end

    removeESP(plr)

    local data = {}

    -- ======================================
    -- HIGHLIGHT
    -- ======================================

    local highlight = Instance.new("Highlight")
    highlight.Name = "AD_ESP_Highlight"
    highlight.Adornee = char
    highlight.FillTransparency = 0.75
    highlight.OutlineTransparency = 0
    highlight.Enabled = ESP_ENABLED
    highlight.Parent = char

    data.highlight = highlight

    -- ======================================
    -- BILLBOARD
    -- ======================================

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "AD_ESP_Info"
    billboard.Adornee = root
    billboard.Size = UDim2.fromOffset(170, 65)
    billboard.StudsOffset = Vector3.new(0, 3.2, 0)
    billboard.AlwaysOnTop = true
    billboard.Enabled = ESP_ENABLED
    billboard.Parent = root

    local text = Instance.new("TextLabel")
    text.Name = "Info"
    text.Size = UDim2.fromScale(1, 1)
    text.BackgroundTransparency = 1
    text.TextColor3 = Color3.new(1, 1, 1)
    text.TextStrokeTransparency = 0.4
    text.TextScaled = false
    text.TextSize = 14
    text.Font = Enum.Font.GothamBold
    text.Parent = billboard

    data.billboard = billboard
    data.text = text

    -- ======================================
    -- BOX
    -- ======================================

    local box = Instance.new("BoxHandleAdornment")
    box.Name = "AD_ESP_Box"
    box.Adornee = root
    box.Size = Vector3.new(4, 6, 2)
    box.Transparency = 0.75
    box.AlwaysOnTop = true
    box.ZIndex = 5
    box.Visible = ESP_ENABLED and ESP_BOX
    box.Parent = root

    data.box = box

    espCache[plr] = data
end

-- ==========================================
-- ESP UPDATE
-- ==========================================

local function updateESP()
    if not ESP_ENABLED then
        return
    end

    local myCharacter = player.Character
    local myRoot = myCharacter and
        myCharacter:FindFirstChild("HumanoidRootPart")

    if not myRoot then
        return
    end

    for _, plr in ipairs(Players:GetPlayers()) do

        if plr ~= player then

            local char = plr.Character
            local root = char and
                char:FindFirstChild("HumanoidRootPart")

            local humanoid = char and
                char:FindFirstChildOfClass("Humanoid")

            if root and humanoid and humanoid.Health > 0 then

                local data = espCache[plr]

                if not data then
                    createESP(plr)
                    data = espCache[plr]
                end

                if data then

                    -- Highlight
                    if data.highlight then
                        data.highlight.Enabled = true
                    end

                    -- Distance
                    local distance = (
                        myRoot.Position - root.Position
                    ).Magnitude

                    local text = ""

                    if ESP_NAME then
                        text = plr.DisplayName
                    end

                    if ESP_DISTANCE then
                        text = text ..
                            "\n" ..
                            math.floor(distance) ..
                            " studs"
                    end

                    if ESP_HEALTH then
                        text = text ..
                            "\nHP: " ..
                            math.floor(humanoid.Health) ..
                            "/" ..
                            math.floor(humanoid.MaxHealth)
                    end

                    if data.text then
                        data.text.Text = text
                    end

                    if data.billboard then
                        data.billboard.Enabled =
                            ESP_NAME or
                            ESP_DISTANCE or
                            ESP_HEALTH
                    end

                    if data.box then
                        data.box.Visible = ESP_BOX
                    end
                end

            else
                removeESP(plr)
            end
        end
    end
end

-- ==========================================
-- ESP OFF
-- ==========================================

local function disableESP()
    for plr in pairs(espCache) do
        removeESP(plr)
    end
end

-- ==========================================
-- PLAYERS
-- ==========================================

Players.PlayerAdded:Connect(function(plr)

    plr.CharacterAdded:Connect(function()

        if ESP_ENABLED then
            task.wait(0.5)
            createESP(plr)
        end

    end)

end)

Players.PlayerRemoving:Connect(function(plr)
    removeESP(plr)
end)

-- ==========================================
-- LOW-END UPDATE LOOP
-- ==========================================

task.spawn(function()

    while gui.Parent do

        if ESP_ENABLED then
            updateESP()
        end

        task.wait(ESP_UPDATE_TIME)

    end

end)

-- ==========================================
-- TOGGLE SYSTEM
-- ==========================================

local function setESP(value)

    ESP_ENABLED = value

    if not value then
        disableESP()
        return
    end

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= player then
            createESP(plr)
        end
    end

    updateESP()
end

-- ==========================================
-- ESP BUTTONS
-- ==========================================

espButton.Activated:Connect(function()
    setESP(not ESP_ENABLED)

    espButton.Text =
        "ESP     [" ..
        (ESP_ENABLED and "ON" or "OFF") ..
        "]"
end)

nameButton.Activated:Connect(function()

    ESP_NAME = not ESP_NAME

    nameButton.Text =
        "NAME     [" ..
        (ESP_NAME and "ON" or "OFF") ..
        "]"

end)

distanceButton.Activated:Connect(function()

    ESP_DISTANCE = not ESP_DISTANCE

    distanceButton.Text =
        "DISTANCE     [" ..
        (ESP_DISTANCE and "ON" or "OFF") ..
        "]"

end)

boxButton.Activated:Connect(function()

    ESP_BOX = not ESP_BOX

    boxButton.Text =
        "BOX     [" ..
        (ESP_BOX and "ON" or "OFF") ..
        "]"

    for _, data in pairs(espCache) do
        if data.box then
            data.box.Visible =
                ESP_ENABLED and ESP_BOX
        end
    end

end)

healthButton.Activated:Connect(function()

    ESP_HEALTH = not ESP_HEALTH

    healthButton.Text =
        "HEALTH     [" ..
        (ESP_HEALTH and "ON" or "OFF") ..
        "]"

end)

-- ==========================================
-- MENU ANIMATION
-- ==========================================

local menuOpen = false
local animationBusy = false

local menuNormalSize = UDim2.fromOffset(300, 310)

main.Size = UDim2.fromOffset(0, 0)
main.BackgroundTransparency = 1
main.Visible = false

local function openMenu()

    if animationBusy or menuOpen then
        return
    end

    animationBusy = true
    menuOpen = true

    main.Visible = true

    main.Size = UDim2.fromOffset(0, 0)
    main.BackgroundTransparency = 1

    local tween = Tween:Create(
        main,
        TweenInfo.new(
            0.28,
            Enum.EasingStyle.Back,
            Enum.EasingDirection.Out
        ),
        {
            Size = menuNormalSize,
            BackgroundTransparency = 0
        }
    )

    tween:Play()

    tween.Completed:Wait()

    animationBusy = false
end

local function closeMenu()

    if animationBusy or not menuOpen then
        return
    end

    animationBusy = true

    local tween = Tween:Create(
        main,
        TweenInfo.new(
            0.20,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.In
        ),
        {
            Size = UDim2.fromOffset(0, 0),
            BackgroundTransparency = 1
        }
    )

    tween:Play()

    tween.Completed:Wait()

    main.Visible = false
    menuOpen = false
    animationBusy = false
end

-- ==========================================
-- OPEN BUTTON
-- ==========================================

icon.Activated:Connect(function()

    if menuOpen then
        closeMenu()
    else
        openMenu()
    end

end)

-- ==========================================
-- CLOSE
-- ==========================================

closeButton.Activated:Connect(function()
    closeMenu()
end)

-- ==========================================
-- MAIN NAVIGATION
-- ==========================================

espButton.Activated:Connect(function()

    mainFrame.Visible = false
    espFrame.Visible = true
    settingsFrame.Visible = false

end)

backESP.Activated:Connect(function()

    espFrame.Visible = false
    mainFrame.Visible = true

end)

-- ==========================================
-- SETTINGS
-- ==========================================

settings.Activated:Connect(function()

    mainFrame.Visible = false
    espFrame.Visible = false
    settingsFrame.Visible = true

end)

backSettings.Activated:Connect(function()

    settingsFrame.Visible = false
    mainFrame.Visible = true

end)

-- ==========================================
-- LANGUAGE
-- ==========================================

local function setLanguageRussian()

    espButton.Text = "ESP"
    playerOpen.Text = "PLAYER"
    visualOpen.Text = "VISUALS"
    aboutOpen.Text = "ABOUT"

    backESP.Text = "BACK"

    nameButton.Text =
        "NAME     [" ..
        (ESP_NAME and "ON" or "OFF") ..
        "]"

    distanceButton.Text =
        "DISTANCE     [" ..
        (ESP_DISTANCE and "ON" or "OFF") ..
        "]"

    boxButton.Text =
        "BOX     [" ..
        (ESP_BOX and "ON" or "OFF") ..
        "]"

    healthButton.Text =
        "HEALTH     [" ..
        (ESP_HEALTH and "ON" or "OFF") ..
        "]"

    settingsTitle.Text = "SETTINGS"
    russianButton.Text = "Русский"
    englishButton.Text = "English"
    backSettings.Text = "BACK"

end

local function setLanguageEnglish()

    espButton.Text =
        "ESP     [" ..
        (ESP_ENABLED and "ON" or "OFF") ..
        "]"

    playerOpen.Text = "PLAYER"
    visualOpen.Text = "VISUALS"
    aboutOpen.Text = "ABOUT"

    backESP.Text = "BACK"

    nameButton.Text =
        "NAME     [" ..
        (ESP_NAME and "ON" or "OFF") ..
        "]"

    distanceButton.Text =
        "DISTANCE     [" ..
        (ESP_DISTANCE and "ON" or "OFF") ..
        "]"

    boxButton.Text =
        "BOX     [" ..
        (ESP_BOX and "ON" or "OFF") ..
        "]"

    healthButton.Text =
        "HEALTH     [" ..
        (ESP_HEALTH and "ON" or "OFF") ..
        "]"

    settingsTitle.Text = "SETTINGS"
    russianButton.Text = "Russian"
    englishButton.Text = "English"
    backSettings.Text = "BACK"

end

russianButton.Activated:Connect(setLanguageRussian)
englishButton.Activated:Connect(setLanguageEnglish)

-- ==========================================
-- DEFAULT STATE
-- ==========================================

mainFrame.Visible = true
espFrame.Visible = false
settingsFrame.Visible = false

-- ==========================================
-- FINISH
-- ==========================================

print("AD MENU v6.0 loaded")
