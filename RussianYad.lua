local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Tween = game:GetService("TweenService")

local LP = Players.LocalPlayer
local PG = LP:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui")
gui.Name = "ADMenu"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = PG

-- LOADING
local loading = Instance.new("TextLabel", gui)
loading.Size = UDim2.fromOffset(180,50)
loading.Position = UDim2.new(.5,-90,.5,-25)
loading.BackgroundTransparency = 1
loading.TextColor3 = Color3.new(1,1,1)
loading.TextSize = 20
loading.Font = Enum.Font.GothamBold
loading.Text = "LOADING 0%"

task.spawn(function()
	for i = 0,100,10 do
		loading.Text = "LOADING "..i.."%"
		task.wait(.06)
	end

	Tween:Create(loading,TweenInfo.new(.25),{
		TextTransparency = 1
	}):Play()

	task.wait(.3)
	loading:Destroy()
end)

-- AD BUTTON
local icon = Instance.new("TextButton",gui)
icon.Name = "ADButton"
icon.Size = UDim2.fromOffset(64,64)
icon.Position = UDim2.new(.5,-32,.5,-32)
icon.BackgroundColor3 = Color3.fromRGB(8,8,8)
icon.Text = "AD"
icon.TextColor3 = Color3.new(1,1,1)
icon.TextSize = 21
icon.Font = Enum.Font.GothamBold
icon.AutoButtonColor = false
icon.Visible = false

local ic = Instance.new("UICorner",icon)
ic.CornerRadius = UDim.new(1,0)

local stroke = Instance.new("UIStroke",icon)
stroke.Thickness = 2
stroke.Color = Color3.new(1,1,1)

local dot = Instance.new("Frame",icon)
dot.Size = UDim2.fromOffset(10,10)
dot.Position = UDim2.new(1,-13,0,4)
dot.BackgroundColor3 = Color3.fromRGB(255,40,40)

local dc = Instance.new("UICorner",dot)
dc.CornerRadius = UDim.new(1,0)

task.delay(1,function()
	icon.Visible = true
end)

-- MAIN MENU
local menu = Instance.new("Frame",gui)
menu.Size = UDim2.fromOffset(300,310)
menu.Position = UDim2.new(.5,-150,.5,-155)
menu.BackgroundColor3 = Color3.fromRGB(12,12,16)
menu.Visible = false

local mc = Instance.new("UICorner",menu)
mc.CornerRadius = UDim.new(0,16)

local title = Instance.new("TextLabel",menu)
title.Size = UDim2.new(1,-100,0,50)
title.Position = UDim2.fromOffset(50,5)
title.BackgroundTransparency = 1
title.Text = "AD MENU"
title.TextColor3 = Color3.new(1,1,1)
title.TextSize = 20
title.Font = Enum.Font.GothamBold

-- SETTINGS
local settings = Instance.new("TextButton",menu)
settings.Size = UDim2.fromOffset(40,40)
settings.Position = UDim2.fromOffset(8,10)
settings.BackgroundColor3 = Color3.fromRGB(30,30,36)
settings.Text = "SET"
settings.TextColor3 = Color3.new(1,1,1)
settings.TextSize = 12
settings.Font = Enum.Font.GothamBold

Instance.new("UICorner",settings).CornerRadius = UDim.new(0,10)

-- CLOSE
local close = Instance.new("TextButton",menu)
close.Size = UDim2.fromOffset(40,40)
close.Position = UDim2.new(1,-48,0,10)
close.BackgroundColor3 = Color3.fromRGB(30,30,36)
close.Text = "X"
close.TextColor3 = Color3.new(1,1,1)
close.TextSize = 18
close.Font = Enum.Font.GothamBold

Instance.new("UICorner",close).CornerRadius = UDim.new(0,10)

-- MENU BUTTON
local function makeButton(text,y)
	local b = Instance.new("TextButton",menu)
	b.Size = UDim2.new(1,-30,0,50)
	b.Position = UDim2.fromOffset(15,y)
	b.BackgroundColor3 = Color3.fromRGB(27,27,34)
	b.Text = text
	b.TextColor3 = Color3.new(1,1,1)
	b.TextSize = 15
	b.Font = Enum.Font.GothamSemibold

	Instance.new("UICorner",b).CornerRadius = UDim.new(0,10)

	return b
end

local espOpen = makeButton("ESP",65)
local playerOpen = makeButton("PLAYER",125)
local visualOpen = makeButton("VISUALS",185)
local aboutOpen = makeButton("ABOUT",245)

-- ESP MENU
local espMenu = Instance.new("Frame",gui)
espMenu.Size = menu.Size
espMenu.Position = menu.Position
espMenu.BackgroundColor3 = Color3.fromRGB(12,12,16)
espMenu.Visible = false

Instance.new("UICorner",espMenu).CornerRadius = UDim.new(0,16)

local espTitle = Instance.new("TextLabel",espMenu)
espTitle.Size = UDim2.new(1,-70,0,50)
espTitle.Position = UDim2.fromOffset(15,5)
espTitle.BackgroundTransparency = 1
espTitle.Text = "ESP"
espTitle.TextColor3 = Color3.new(1,1,1)
espTitle.TextSize = 20
espTitle.Font = Enum.Font.GothamBold
espTitle.TextXAlignment = Enum.TextXAlignment.Left

local espBack = Instance.new("TextButton",espMenu)
espBack.Size = UDim2.fromOffset(40,40)
espBack.Position = UDim2.new(1,-48,0,10)
espBack.BackgroundColor3 = Color3.fromRGB(30,30,36)
espBack.Text = "<"
espBack.TextColor3 = Color3.new(1,1,1)
espBack.TextSize = 20

Instance.new("UICorner",espBack).CornerRadius = UDim.new(0,10)

-- ESP SETTINGS
local ESP = false
local NAME = true
local DISTANCE = true
local BOX = false
local HEALTH = true

local function espButton(text,y,state)
	local b = Instance.new("TextButton",espMenu)
	b.Size = UDim2.new(1,-30,0,42)
	b.Position = UDim2.fromOffset(15,y)
	b.BackgroundColor3 = Color3.fromRGB(27,27,34)
	b.TextColor3 = Color3.new(1,1,1)
	b.TextSize = 14
	b.Font = Enum.Font.GothamSemibold
	b.Text = text..": "..(state and "ON" or "OFF")

	Instance.new("UICorner",b).CornerRadius = UDim.new(0,9)

	return b
end

local bESP = espButton("ESP",60,ESP)
local bNAME = espButton("NAME",108,NAME)
local bDIST = espButton("DISTANCE",156,DISTANCE)
local bBOX = espButton("BOX",204,BOX)
local bHP = espButton("HEALTH",252,HEALTH)

local function toggle(button,name,value)
	value = not value
	button.Text = name..": "..(value and "ON" or "OFF")
	return value
end
bESP.Activated:Connect(function()
	ESP = toggle(bESP,"ESP",ESP)
end)

bNAME.Activated:Connect(function()
	NAME = toggle(bNAME,"NAME",NAME)
end)

bDIST.Activated:Connect(function()
	DISTANCE = toggle(bDIST,"DISTANCE",DISTANCE)
end)

bBOX.Activated:Connect(function()
	BOX = toggle(bBOX,"BOX",BOX)
end)

bHP.Activated:Connect(function()
	HEALTH = toggle(bHP,"HEALTH",HEALTH)
end)

-- SETTINGS
local settingsMenu = Instance.new("Frame",gui)
settingsMenu.Size = menu.Size
settingsMenu.Position = menu.Position
settingsMenu.BackgroundColor3 = Color3.fromRGB(12,12,16)
settingsMenu.Visible = false

Instance.new("UICorner",settingsMenu).CornerRadius = UDim.new(0,16)

local st = Instance.new("TextLabel",settingsMenu)
st.Size = UDim2.new(1,-70,0,50)
st.Position = UDim2.fromOffset(15,5)
st.BackgroundTransparency = 1
st.Text = "SETTINGS"
st.TextColor3 = Color3.new(1,1,1)
st.TextSize = 20
st.Font = Enum.Font.GothamBold

local sb = Instance.new("TextButton",settingsMenu)
sb.Size = UDim2.fromOffset(40,40)
sb.Position = UDim2.new(1,-48,0,10)
sb.BackgroundColor3 = Color3.fromRGB(30,30,36)
sb.Text = "<"
sb.TextColor3 = Color3.new(1,1,1)
sb.TextSize = 20

Instance.new("UICorner",sb).CornerRadius = UDim.new(0,10)

local lt = Instance.new("TextLabel",settingsMenu)
lt.Size = UDim2.new(1,-30,0,40)
lt.Position = UDim2.fromOffset(15,65)
lt.BackgroundTransparency = 1
lt.Text = "LANGUAGE"
lt.TextColor3 = Color3.new(1,1,1)
lt.TextSize = 16
lt.Font = Enum.Font.GothamBold

local ru = Instance.new("TextButton",settingsMenu)
ru.Size = UDim2.new(.45,-10,0,50)
ru.Position = UDim2.fromOffset(15,115)
ru.BackgroundColor3 = Color3.fromRGB(35,35,43)
ru.Text = "Русский"
ru.TextColor3 = Color3.new(1,1,1)
ru.TextSize = 14

Instance.new("UICorner",ru).CornerRadius = UDim.new(0,10)

local en = ru:Clone()
en.Parent = settingsMenu
en.Position = UDim2.new(.55,0,0,115)
en.Text = "English"

-- ОКНА
local function show(frame)
	menu.Visible = false
	espMenu.Visible = false
	settingsMenu.Visible = false
	frame.Visible = true
end

icon.Activated:Connect(function()
	menu.Visible = not menu.Visible
end)

close.Activated:Connect(function()
	menu.Visible = false
end)

espOpen.Activated:Connect(function()
	show(espMenu)
end)

espBack.Activated:Connect(function()
	show(menu)
end)

settings.Activated:Connect(function()
	show(settingsMenu)
end)

sb.Activated:Connect(function()
	show(menu)
end)

-- ЯЗЫК
ru.Activated:Connect(function()
	title.Text = "AD МЕНЮ"
	playerOpen.Text = "ИГРОК"
	visualOpen.Text = "ВИЗУАЛ"
	aboutOpen.Text = "О ПРОЕКТЕ"
	st.Text = "НАСТРОЙКИ"
	lt.Text = "ЯЗЫК"
end)

en.Activated:Connect(function()
	title.Text = "AD MENU"
	playerOpen.Text = "PLAYER"
	visualOpen.Text = "VISUALS"
	aboutOpen.Text = "ABOUT"
	st.Text = "SETTINGS"
	lt.Text = "LANGUAGE"
end)

-- ESP
local espData = {}

local function removeESP(p)
	if espData[p] then
		for _,v in pairs(espData[p]) do
			if typeof(v) == "Instance" then
				v:Destroy()
			end
		end
		espData[p] = nil
	end
end

local function createESP(p)
	if p == LP or not p.Character then return end

	removeESP(p)

	local char = p.Character
	local head = char:FindFirstChild("Head")
	if not head then return end

	local h = Instance.new("Highlight")
	h.Name = "AD_ESP"
	h.FillTransparency = .65
	h.OutlineTransparency = 0
	h.Parent = char

	local bill = Instance.new("BillboardGui")
	bill.Name = "AD_Info"
	bill.Adornee = head
	bill.Size = UDim2.fromOffset(180,70)
	bill.StudsOffset = Vector3.new(0,3,0)
	bill.AlwaysOnTop = true
	bill.Parent = head

	local text = Instance.new("TextLabel")
	text.Size = UDim2.fromScale(1,1)
	text.BackgroundTransparency = 1
	text.TextColor3 = Color3.new(1,1,1)
	text.TextStrokeTransparency = 0
	text.TextSize = 14
	text.Font = Enum.Font.GothamBold
	text.Parent = bill

	local box = Instance.new("SelectionBox")
	box.Name = "AD_BOX"
	box.Adornee = char
	box.LineThickness = .025
	box.SurfaceTransparency = 1
	box.Parent = char

	espData[p] = {
		h = h,
		bill = bill,
		text = text,
		box = box
	}
end

local function updateESP()
	for _,p in ipairs(Players:GetPlayers()) do
		if p ~= LP and p.Character then
			if ESP then
				if not espData[p] then
					createESP(p)
				end

				local d = espData[p]
				local hum = p.Character:FindFirstChildOfClass("Humanoid")
				local root = p.Character:FindFirstChild("HumanoidRootPart")
				local myRoot = LP.Character
					and LP.Character:FindFirstChild("HumanoidRootPart")

				if d and hum and root then
					d.h.Enabled = true
					d.box.Visible = BOX

					local text = ""

					if NAME then
						text = p.DisplayName
					end

					if DISTANCE and myRoot then
						local n = math.floor(
							(root.Position-myRoot.Position).Magnitude
						)

						if text ~= "" then
							text = text.."\n"
						end

						text = text..n.." studs"
					end

					if HEALTH then
						if text ~= "" then
							text = text.."\n"
						end

						text = text.."HP: "
							..math.floor(hum.Health)
							.."/"..math.floor(hum.MaxHealth)
					end

					d.text.Text = text
					d.bill.Enabled = NAME or DISTANCE or HEALTH
				end
			end
		end
	end
end

local function clearESP()
	for p in pairs(espData) do
		removeESP(p)
	end
end

Players.PlayerRemoving:Connect(removeESP)

Players.PlayerAdded:Connect(function(p)
	p.CharacterAdded:Connect(function()
		task.wait(.5)
		if ESP then
			createESP(p)
		end
	end)
end)

RunService.RenderStepped:Connect(function()
	if ESP then
		updateESP()
	else
		clearESP()
	end
end)

-- ПЕРЕТАСКИВАНИЕ
local dragging = false
local start
local startPos

icon.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch
	or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		start = input.Position
		startPos = icon.Position
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and (
		input.UserInputType == Enum.UserInputType.Touch
		or input.UserInputType == Enum.UserInputType.MouseMovement
	) then

		local d = input.Position-start

		icon.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset+d.X,
			startPos.Y.Scale,
			startPos.Y.Offset+d.Y
		)
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch
	or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)
