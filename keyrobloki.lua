local Player = game:GetService("Players").LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- Cria a interface
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = CoreGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 300, 0, 150)
Frame.Position = UDim2.new(0.5, -150, 0.5, -75)
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local TextLabel = Instance.new("TextLabel")
TextLabel.Size = UDim2.new(0, 280, 0, 40)
TextLabel.Position = UDim2.new(0, 10, 0, 10)
TextLabel.Text = "Digite a Key correta para entrar:"
TextLabel.TextColor3 = Color3.new(1, 1, 1)
TextLabel.BackgroundTransparency = 1
TextLabel.Font = Enum.Font.SourceSansBold
TextLabel.TextSize = 18
TextLabel.Parent = Frame

local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(0, 280, 0, 40)
TextBox.Position = UDim2.new(0, 10, 0, 60)
TextBox.PlaceholderText = "Insira a key aqui..."
TextBox.Text = ""
TextBox.TextColor3 = Color3.new(0, 0, 0)
TextBox.BackgroundColor3 = Color3.new(1, 1, 1)
TextBox.Parent = Frame

local SubmitButton = Instance.new("TextButton")
SubmitButton.Size = UDim2.new(0, 280, 0, 30)
SubmitButton.Position = UDim2.new(0, 10, 0, 110)
SubmitButton.Text = "Enviar"
SubmitButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
SubmitButton.TextColor3 = Color3.new(1, 1, 1)
SubmitButton.Parent = Frame

-- Função para verificar a key
SubmitButton.MouseButton1Click:Connect(function()
    if TextBox.Text == "Dr4gonX" then
        ScreenGui:Destroy() -- Remove a interface
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Dr4gonScripts/Muscles-project/refs/heads/main/robloki.lua"))()
    else
        -- Key incorreta - kicka o jogador
        Player:Kick("Key incorreta! Acesso negado.")
    end
end)
