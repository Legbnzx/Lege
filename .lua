-- NOCLIP com botão pequeno e arrastável
-- LocalScript

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local noclip = false
local connection

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "NoclipGui"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 90, 0, 35)
button.Position = UDim2.new(0.05, 0, 0.5, 0)
button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Text = "NOCLIP: OFF"
button.Font = Enum.Font.GothamBold
button.TextSize = 12
button.BorderSizePixel = 0
button.Parent = gui
button.Active = true
button.Draggable = true

-- Bordas arredondadas
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = button

-- Função Noclip
local function setNoclip(state)
	noclip = state

	if noclip then
		button.Text = "NOCLIP: ON"
		button.BackgroundColor3 = Color3.fromRGB(0, 170, 0)

		connection = RunService.Stepped:Connect(function()
			if player.Character then
				for _, part in pairs(player.Character:GetDescendants()) do
					if part:IsA("BasePart") then
						part.CanCollide = false
					end
				end
			end
		end)
	else
		button.Text = "NOCLIP: OFF"
		button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

		if connection then
			connection:Disconnect()
			connection = nil
		end
	end
end

-- Clique do botão
button.MouseButton1Click:Connect(function()
	setNoclip(not noclip)
end)
