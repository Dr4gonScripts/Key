-- UI Preta/Vermelha com Sistema de Key
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

-- Criar GUI
local ScreenGui = Instance.new("ScreenGui", Player:WaitForChild("PlayerGui"))
ScreenGui.Name = "KeySystem"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Janela Principal
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 350, 0, 220)
Frame.Position = UDim2.new(0.5, -175, 0.5, -110)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.BorderSizePixel = 0
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 10)

-- Título
local Title = Instance.new("TextLabel", Frame)
Title.Text = "🔐 Key System"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 0, 0)
Title.TextSize = 24
Title.Font = Enum.Font.GothamBold

-- Caixa de texto
local TextBox = Instance.new("TextBox", Frame)
TextBox.PlaceholderText = "Digite sua key aqui"
TextBox.Size = UDim2.new(0.9, 0, 0, 35)
TextBox.Position = UDim2.new(0.05, 0, 0.35, 0)
TextBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
TextBox.Font = Enum.Font.Gotham
TextBox.TextSize = 18
TextBox.ClearTextOnFocus = false
Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0, 8)

-- Botão "Verificar Key"
local Button = Instance.new("TextButton", Frame)
Button.Size = UDim2.new(0.6, 0, 0, 35)
Button.Position = UDim2.new(0.2, 0, 0.6, 0)
Button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Button.Text = "Verificar Key"
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.Font = Enum.Font.GothamBold
Button.TextSize = 18
Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 8)

-- Botão "Get Key"
local GetKey = Instance.new("TextButton", Frame)
GetKey.Size = UDim2.new(0.4, 0, 0, 30)
GetKey.Position = UDim2.new(0.3, 0, 0.85, 0)
GetKey.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
GetKey.Text = "🔗 Get Key"
GetKey.TextColor3 = Color3.fromRGB(255, 0, 0)
GetKey.Font = Enum.Font.GothamBold
GetKey.TextSize = 16
Instance.new("UICorner", GetKey).CornerRadius = UDim.new(0, 8)

-- Key correta
local KeyCorreta = "ROBLOKI-982299999144" -- ALTERE aqui para a sua key real

-- Verificar a key
Button.MouseButton1Click:Connect(function()
    if TextBox.Text == KeyCorreta then
        Title.Text = "✅ Key correta!"
        Title.TextColor3 = Color3.fromRGB(0, 255, 0)
        wait(1)
        ScreenGui:Destroy()
        -- Executar seu script externo
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Dr4gonScripts/Syteam-keys/refs/heads/main/D4gonHub.lua"))()
    else
        Title.Text = "❌ Key inválida!"
        Title.TextColor3 = Color3.fromRGB(255, 0, 0)
    end
end)

-- Botão "Get Key" copia o link do Discord
GetKey.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/UjHzT4mj")
    Title.Text = "🔗 Link copiado!"
    Title.TextColor3 = Color3.fromRGB(255, 255, 0)
end)
