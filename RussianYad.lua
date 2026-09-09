--==================================================
-- MOBILE MASTER MENU
-- Floating icon + mobile menu
--==================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

--==================================================
-- SETTINGS
--==================================================

local IMAGE_URL =
	"https://1s4oyld5dc.ucarecd.net/b9b03b9b-f787-4fe2-a3f0-24851ca65975/"

--==================================================
-- REMOVE OLD GUI
--==================================================

local old = playerGui:FindFirstChild("MobileMasterMenu")

if old then
	old:Destroy()
end

--==================================================
-- SCREEN GUI
--==================================================

local gui = Instance.new("ScreenGui")
gui.Name = "MobileMasterMenu"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = playerGui

--==================================================
-- FLOATING ICON
--==================================================

local icon = Instance.new("ImageButton")

icon.Name = "OpenMenu"
icon.Size = UDim2.fromOffset(70, 70)
icon.Position = UDim2.new(0, 20, 0.5, -35)

icon.BackgroundColor3 = Color3.fromRGB(17, 18, 26)
icon.BackgroundTransparency = 0.05

icon.AutoButtonColor = false
icon.Image = ""

icon.Parent = gui

local iconCorner = Instance.new("UICorner")
iconCorner.CornerRadius = UDim.new(1, 0)
iconCorner.Parent = icon

local iconStroke = Instance.new("UIStroke")
iconStroke.Thickness = 3
iconStroke.Transparency = 0.15
iconStroke.Parent = icon

--==================================================
-- IMAGE INSIDE ICON
--==================================================

local image = Instance.new("ImageLabel")

image.Name = "PirateImage"
image.Size = UDim2.fromScale(0.86, 0.86)
image.Position = UDim2.fromScale(0.07, 0.07)

image.BackgroundTransparency = 1
image.Image = IMAGE_URL

image.ScaleType = Enum.ScaleType.Crop

image.Parent = icon

local imageCorner = Instance.new("UICorner")
imageCorner.CornerRadius = UDim.new(1, 0)
imageCorner.Parent = image

--==================================================
-- MAIN MENU
--==================================================

local menu = Instance.new("Frame")

menu.Name = "MainMenu"

menu.Size = UDim2.fromOffset(330, 400)
menu.Position = UDim2.new(0.5, -165, 0.5, -200)

menu.BackgroundColor3 = Color3.fromRGB(13, 14, 21)
menu.BackgroundTransparency = 0.03

menu.Visible = false
menu.Parent = gui

local menuCorner = Instance.new("UICorner")
menuCorner.CornerRadius = UDim.new(0, 20)
menuCorner.Parent = menu

local menuStroke = Instance.new("UIStroke")
menuStroke.Thickness = 2
menuStroke.Transparency = 0.25
menuStroke.Parent = menu

--==================================================
-- TITLE
--==================================================

local title = Instance.new("TextLabel")

title.Size = UDim2.new(1, -75, 0, 42)
title.Position = UDim2.fromOffset(20, 10)

title.BackgroundTransparency = 1
title.Text = "MOBILE MENU"

title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 21
title.Font = Enum.Font.GothamBold

title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = menu

--==================================================
-- SUBTITLE
--==================================================

local subtitle = Instance.new("TextLabel")

subtitle.Size = UDim2.new(1, -75, 0, 22)
subtitle.Position = UDim2.fromOffset(20, 43)

subtitle.BackgroundTransparency = 1
subtitle.Text = "CONTROL PANEL"

subtitle.TextColor3 = Color3.fromRGB(145, 150, 170)
subtitle.TextSize = 11
subtitle.Font = Enum.Font.GothamMedium

subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = menu

--==================================================
-- CLOSE BUTTON
--==================================================

local close = Instance.new("TextButton")

close.Name = "Close"
close.Size = UDim2.fromOffset(44, 44)
close.Position = UDim2.new(1, -56, 0, 12)

close.BackgroundColor3 = Color3.fromRGB(35, 36, 48)

close.Text = "×"
close.TextColor3 = Color3.fromRGB(255, 255, 255)
close.TextSize = 27
close.Font = Enum.Font.GothamBold

close.AutoButtonColor = false
close.Parent = menu

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 13)
closeCorner.Parent = close

--==================================================
-- MENU BUTTON CREATOR
--==================================================

local function createButton(name, text, y)

	local button = Instance.new("TextButton")

	button.Name = name
	button.Size = UDim2.new(1, -40, 0, 58)
	button.Position = UDim2.fromOffset(20, y)

	button.BackgroundColor3 = Color3.fromRGB(27, 29, 40)

	button.Text = text
	button.TextColor3 = Color3.fromRGB(240, 240, 245)

	button.TextSize = 16
	button.Font = Enum.Font.GothamSemibold

	button.AutoButtonColor = false
	button.Parent = menu

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 14)
	corner.Parent = button

	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 1
	stroke.Transparency = 0.65
	stroke.Parent = button

	button.Activated:Connect(function()

		TweenService:Create(
			button,
			TweenInfo.new(0.08),
			{
				Size = UDim2.new(1, -46, 0, 54)
			}
		):Play()

		task.wait(0.08)

		TweenService:Create(
			button,
			TweenInfo.new(
				0.12,
				Enum.EasingStyle.Back,
				Enum.EasingDirection.Out
			),
			{
				Size = UDim2.new(1, -40, 0, 58)
			}
		):Play()

	end

	return button
end

--==================================================
-- BUTTONS
--==================================================

local option1 = createButton(
	"Option1",
	"OPTION 1",
	82
)

local option2 = createButton(
	"Option2",
	"OPTION 2",
	150
)

local option3 = createButton(
	"Option3",
	"OPTION 3",
	218
)

local settings = createButton(
	"Settings",
	"SETTINGS",
	286
)

--==================================================
-- OPEN MENU
--==================================================

local function openMenu()

	menu.Visible = true

	menu.Size = UDim2.fromOffset(285, 345)

	TweenService:Create(
		menu,
		TweenInfo.new(
			0.25,
			Enum.EasingStyle.Back,
			Enum.EasingDirection.Out
		),
		{
			Size = UDim2.fromOffset(330, 400)
		}
	):Play()

end

--==================================================
-- CLOSE MENU
--==================================================

local function closeMenu()

	local tween = TweenService:Create(
		menu,
		TweenInfo.new(
			0.15,
			Enum.EasingStyle.Quad,
			Enum.EasingDirection.In
		),
		{
			Size = UDim2.fromOffset(285, 345)
		}
	)

	tween:Play()
	tween.Completed:Wait()

	menu.Visible = false

end

--==================================================
-- ICON TAP
--==================================================

icon.Activated:Connect(function()

	if menu.Visible then
		closeMenu()
	else
		openMenu()
	end

end)

--==================================================
-- CLOSE
--==================================================

close.Activated:Connect(function()
	closeMenu()
end)

--==================================================
-- DRAG ICON
--==================================================

local draggingIcon = false
local dragStart
local startPosition

icon.InputBegan:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.Touch
		or input.UserInputType == Enum.UserInputType.MouseButton1 then

		draggingIcon = true
		dragStart = input.Position
		startPosition = icon.Position

	end

end)

UserInputService.InputChanged:Connect(function(input)

	if not draggingIcon then
		return
	end

	if input.UserInputType ~= Enum.UserInputType.Touch
		and input.UserInputType ~= Enum.UserInputType.MouseMovement then
		return
	end

	local delta = input.Position - dragStart

	icon.Position = UDim2.new(
		startPosition.X.Scale,
		startPosition.X.Offset + delta.X,
		startPosition.Y.Scale,
		startPosition.Y.Offset + delta.Y
	)

end)

UserInputService.InputEnded:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.Touch
		or input.UserInputType == Enum.UserInputType.MouseButton1 then

		draggingIcon = false

	end

end)

--==================================================
-- DRAG MENU BY TITLE
--==================================================

local draggingMenu = false
local menuDragStart
local menuStartPosition

title.InputBegan:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.Touch
		or input.UserInputType == Enum.UserInputType.MouseButton1 then

		draggingMenu = true
		menuDragStart = input.Position
		menuStartPosition = menu.Position

	end

end)

UserInputService.InputChanged:Connect(function(input)

	if not draggingMenu then
		return
	end

	if input.UserInputType ~= Enum.UserInputType.Touch
		and input.UserInputType ~= Enum.UserInputType.MouseMovement then
		return
	end

	local delta = input.Position - menuDragStart

	menu.Position = UDim2.new(
		menuStartPosition.X.Scale,
		menuStartPosition.X.Offset + delta.X,
		menuStartPosition.Y.Scale,
		menuStartPosition.Y.Offset + delta.Y
	)

end)

UserInputService.InputEnded:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.Touch
		or input.UserInputType == Enum.UserInputType.MouseButton1 then

		draggingMenu = false

	end

end)
