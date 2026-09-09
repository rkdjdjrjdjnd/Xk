local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local lp = Players.LocalPlayer
local gui = lp:WaitForChild("PlayerGui")

-- НАСТРОЙКИ
local ESP = false
local NAME = true
local DIST = true
local BOX = false
local HEALTH = true

local data = {}

local function removeESP(p)
	if data[p] then
		for _,v in pairs(data[p]) do
			if typeof(v) == "Instance" then
				v:Destroy()
			end
		end
		data[p] = nil
	end
end

local function createESP(p)
	if p == lp or not p.Character then return end
	removeESP(p)

	local char = p.Character
	local head = char:FindFirstChild("Head")
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not head or not hum then return end

	local objects = {}

	-- ПОДСВЕТКА
	local highlight = Instance.new("Highlight")
	highlight.Name = "AD_ESP"
	highlight.FillTransparency = .65
	highlight.OutlineTransparency = 0
	highlight.Parent = char
	objects.highlight = highlight

	-- ИМЯ + DISTANCE + HP
	local bill = Instance.new("BillboardGui")
	bill.Name = "AD_Info"
	bill.Adornee = head
	bill.Size = UDim2.fromOffset(180,70)
	bill.StudsOffset = Vector3.new(0,3,0)
	bill.AlwaysOnTop = true
	bill.Parent = head
	objects.bill = bill

	local text = Instance.new("TextLabel")
	text.Size = UDim2.fromScale(1,1)
	text.BackgroundTransparency = 1
	text.TextColor3 = Color3.new(1,1,1)
	text.TextStrokeTransparency = 0
	text.Font = Enum.Font.GothamBold
	text.TextSize = 14
	text.Parent = bill
	objects.text = text

	-- BOX
	local box = Instance.new("SelectionBox")
	box.Name = "AD_Box"
	box.Adornee = char
	box.LineThickness = .025
	box.SurfaceTransparency = 1
	box.Color3 = Color3.new(1,1,1)
	box.Parent = char
	objects.box = box

	data[p] = objects
end

local function updateESP()
	for _,p in ipairs(Players:GetPlayers()) do
		if p ~= lp and p.Character then
			if ESP then
				if not data[p] then
					createESP(p)
				end

				local d = data[p]
				local char = p.Character
				local hum = char:FindFirstChildOfClass("Humanoid")
				local root = char:FindFirstChild("HumanoidRootPart")

				if d.highlight then
					d.highlight.Enabled = ESP
				end

				if d.box then
					d.box.Visible = ESP and BOX
				end

				if d.text and hum and root then
					local myRoot = lp.Character
						and lp.Character:FindFirstChild("HumanoidRootPart")

					local dist = myRoot
						and math.floor((root.Position-myRoot.Position).Magnitude)
						or 0

					local text = ""

					if NAME then
						text = p.DisplayName
					end

					if DIST then
						text = text..(text ~= "" and "\n" or "")
							..dist.." studs"
					end

					if HEALTH then
						text = text..(text ~= "" and "\n" or "")
							.."HP: "..math.floor(hum.Health)
							.."/"..math.floor(hum.MaxHealth)
					end

					d.text.Text = text
					d.text.Visible = ESP
				end
			end
		end
	end
end

local function clearAll()
	for p in pairs(data) do
		removeESP(p)
	end
end

Players.PlayerRemoving:Connect(removeESP)

Players.PlayerAdded:Connect(function(p)
	p.CharacterAdded:Connect(function()
		task.wait(.5)
		if ESP then createESP(p) end
	end)
end)

RunService.RenderStepped:Connect(function()
	if ESP then
		updateESP()
	else
		clearAll()
	end
end)

-- ФУНКЦИИ ДЛЯ КНОПОК ТВОЕГО МЕНЮ

function SetESP(value)
	ESP = value
end

function SetName(value)
	NAME = value
end

function SetDistance(value)
	DIST = value
end

function SetBox(value)
	BOX = value
end

function SetHealth(value)
	HEALTH = value
end
