local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local Tween = game:GetService("TweenService")

local gui = Instance.new("ScreenGui")
gui.Name = "ADMenu"
gui.ResetOnSpawn = false
gui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

-- ЗАГРУЗКА
local loading = Instance.new("TextLabel")
loading.Size = UDim2.new(1,0,1,0)
loading.BackgroundColor3 = Color3.fromRGB(8,8,10)
loading.TextColor3 = Color3.new(1,1,1)
loading.TextSize = 22
loading.Font = Enum.Font.GothamBold
loading.Text = "LOADING 0%"
loading.ZIndex = 10
loading.Parent = gui

task.spawn(function()
for i = 0,100,5 do
loading.Text = "LOADING "..i.."%"
task.wait(0.15)
end
Tween:Create(loading,TweenInfo.new(.4),{
TextTransparency=1,
BackgroundTransparency=1
}):Play()
task.wait(.4)
loading:Destroy()
end)

-- ИКОНКА
local icon = Instance.new("TextButton")
icon.Size = UDim2.fromOffset(64,64)
icon.Position = UDim2.new(0,20,.5,-32)
icon.BackgroundColor3 = Color3.fromRGB(8,8,8)
icon.Text = "AD"
icon.TextColor3 = Color3.new(1,1,1)
icon.TextSize = 21
icon.Font = Enum.Font.GothamBold
icon.AutoButtonColor = false
icon.Parent = gui

local c = Instance.new("UICorner",icon)
c.CornerRadius = UDim.new(1,0)

local s = Instance.new("UIStroke",icon)
s.Thickness = 2
s.Color = Color3.fromRGB(255,255,255)

-- КРАСНАЯ ТОЧКА
local dot = Instance.new("Frame")
dot.Size = UDim2.fromOffset(10,10)
dot.Position = UDim2.new(1,-13,0,4)
dot.BackgroundColor3 = Color3.fromRGB(255,40,40)
dot.Parent = icon

local dc = Instance.new("UICorner",dot)
dc.CornerRadius = UDim.new(1,0)

-- МЕНЮ
local menu = Instance.new("Frame")
menu.Size = UDim2.fromOffset(300,300)
menu.Position = UDim2.new(.5,-150,.5,-150)
menu.BackgroundColor3 = Color3.fromRGB(12,12,16)
menu.Visible = false
menu.Parent = gui

local mc = Instance.new("UICorner",menu)
mc.CornerRadius = UDim.new(0,16)

-- ЗАГОЛОВОК
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,-60,0,50)
title.Position = UDim2.fromOffset(15,5)
title.BackgroundTransparency = 1
title.Text = "AD MENU"
title.TextColor3 = Color3.new(1,1,1)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = menu

-- КРЕСТИК
local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(40,40)
close.Position = UDim2.new(1,-48,0,10)
close.BackgroundColor3 = Color3.fromRGB(35,35,40)
close.Text = "X"
close.TextColor3 = Color3.new(1,1,1)
close.TextSize = 18
close.Font = Enum.Font.GothamBold
close.Parent = menu

local cc = Instance.new("UICorner",close)
cc.CornerRadius = UDim.new(0,10)

-- КНОПКИ
for i,text in ipairs({"OPTION 1","OPTION 2","OPTION 3"}) do
local b = Instance.new("TextButton")
b.Size = UDim2.new(1,-30,0,55)
b.Position = UDim2.fromOffset(15,65+(i-1)*65)
b.BackgroundColor3 = Color3.fromRGB(28,28,35)
b.Text = text
b.TextColor3 = Color3.new(1,1,1)
b.TextSize = 15
b.Font = Enum.Font.GothamSemibold
b.Parent = menu

local bc = Instance.new("UICorner",b)  
bc.CornerRadius = UDim.new(0,11)

end

-- ОТКРЫТИЕ
local function open()
menu.Visible = true
menu.Size = UDim2.fromOffset(270,270)

Tween:Create(menu,TweenInfo.new(.2,Enum.EasingStyle.Back),{  
	Size=UDim2.fromOffset(300,300)  
}):Play()

end

local function hide()
menu.Visible = false
end

icon.Activated:Connect(open)
close.Activated:Connect(hide)

-- ПЕРЕТАСКИВАНИЕ
local dragging,start,pos = false,nil,nil

icon.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.Touch
or input.UserInputType == Enum.UserInputType.MouseButton1 then
dragging=true
start=input.Position
pos=icon.Position
end
end)

UIS.InputChanged:Connect(function(input)
if dragging and (
input.UserInputType==Enum.UserInputType.Touch
or input.UserInputType==Enum.UserInputType.MouseMovement
) then
local d=input.Position-start

icon.Position=UDim2.new(  
		pos.X.Scale,pos.X.Offset+d.X,  
		pos.Y.Scale,pos.Y.Offset+d.Y  
	)  
end

end)

UIS.InputEnded:Connect(function(input)
if input.UserInputType==Enum.UserInputType.Touch
or input.UserInputType==Enum.UserInputType.MouseButton1 then
dragging=false
end
end)
