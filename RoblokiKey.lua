-- Sistema de Key com UI Estilizada (Preto/Vermelho) + Notificação Discord
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

-- Criar GUI principal
local ScreenGui = Instance.new("ScreenGui", Player:WaitForChild("PlayerGui"))
ScreenGui.Name = "KeySystem"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true

-- Fundo da GUI
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 420, 0, 250)
Frame.Position = UDim2.new(0.5, -210, 0.5, -125)
Frame.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
Frame.BackgroundTransparency = 0.15
Frame.BorderSizePixel = 0
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 12)
local Border = Instance.new("UIStroke", Frame)
Border.Color = Color3.fromRGB(0, 0, 0)
Border.Thickness = 2

-- Botão de fechar
local CloseButton = Instance.new("TextButton", Frame)
CloseButton.Size = UDim2.new(0, 35, 0, 35)
CloseButton.Position = UDim2.new(1, -40, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 20
Instance.new("UICorner", CloseButton).CornerRadius = UDim.new(0, 8)
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Título da GUI
local Title = Instance.new("TextLabel", Frame)
Title.Text = "🔐 Robloki Hub - Key System"
Title.Size = UDim2.new(1, -50, 0, 45)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 22
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Caixa de texto para key
local TextBox = Instance.new("TextBox", Frame)
TextBox.PlaceholderText = "Digite sua key aqui..."
TextBox.Size = UDim2.new(0.9, 0, 0, 40)
TextBox.Position = UDim2.new(0.05, 0, 0.4, 0)
TextBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.PlaceholderColor3 = Color3.fromRGB(200, 200, 200)
TextBox.Font = Enum.Font.Gotham
TextBox.TextSize = 18
TextBox.ClearTextOnFocus = false
Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0, 8)

-- Lista de keys válidas
local KeysValidas = {
    "RBK-1A2B3C4D",
    "RBK-5E6F7G8H",
    "RBK-9I0J1K2L",
    "RBK-3M4N5O6P"
}

-- Botão verificar key
local VerifyButton = Instance.new("TextButton", Frame)
VerifyButton.Size = UDim2.new(0, 160, 0, 38)
VerifyButton.Position = UDim2.new(1, -170, 1, -45)
VerifyButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
VerifyButton.Text = "✔ Verificar Key"
VerifyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
VerifyButton.Font = Enum.Font.GothamBold
VerifyButton.TextSize = 18
Instance.new("UICorner", VerifyButton).CornerRadius = UDim.new(0, 8)

-- Botão get key
local GetKey = Instance.new("TextButton", Frame)
GetKey.Size = UDim2.new(0, 130, 0, 32)
GetKey.Position = UDim2.new(0, 10, 1, -40)
GetKey.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
GetKey.Text = "🔗 Get Key"
GetKey.TextColor3 = Color3.fromRGB(255, 50, 50)
GetKey.Font = Enum.Font.GothamBold
GetKey.TextSize = 16
Instance.new("UICorner", GetKey).CornerRadius = UDim.new(0, 8)

local Links = {
    "https://loot-link.com/s?CbLp4vYO",
    "https://loot-link.com/s?dcShmPHm",
    "https://loot-link.com/s?FadRVzL9",
    "https://lootdest.org/s?bMXOxqFw"
}

-- Função verificar key
VerifyButton.MouseButton1Click:Connect(function()
    local keyDigitada = TextBox.Text
    local keyValida = false
    
    for _, key in ipairs(KeysValidas) do
        if keyDigitada == key then
            keyValida = true
            break
        end
    end
    
    if keyValida then
        Title.Text = "✅ Key correta!"
        Title.TextColor3 = Color3.fromRGB(0, 255, 0)
        task.wait(1)
        ScreenGui:Destroy()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Dr4gonScripts/Key/refs/heads/main/RoblokiKey.lua"))()
    else
        Title.Text = "❌ Key inválida!"
        Title.TextColor3 = Color3.fromRGB(255, 0, 0)
    end
end)

-- Função get key aleatória
GetKey.MouseButton1Click:Connect(function()
    local linkAleatorio = Links[math.random(1, #Links)]
    setclipboard(linkAleatorio)
    Title.Text = "🔗 Link copiado!"
    Title.TextColor3 = Color3.fromRGB(255, 255, 0)
end)

-- =========================================
-- Notificação Discord flutuante
-- =========================================
local NotificationFrame = Instance.new("Frame", Player:WaitForChild("PlayerGui"))
NotificationFrame.Size = UDim2.new(0, 400, 0, 80)
NotificationFrame.Position = UDim2.new(0.5, -200, 0, 20)
NotificationFrame.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
NotificationFrame.BackgroundTransparency = 0.1
Instance.new("UICorner", NotificationFrame).CornerRadius = UDim.new(0, 12)
local Border = Instance.new("UIStroke", NotificationFrame)
Border.Color = Color3.fromRGB(0,0,0)
Border.Thickness = 2

local NotificationText = Instance.new("TextLabel", NotificationFrame)
NotificationText.Size = UDim2.new(1, -20, 0, 40)
NotificationText.Position = UDim2.new(0, 10, 0, 5)
NotificationText.BackgroundTransparency = 1
NotificationText.Text = "⚠️ Entre em nosso Discord para futuras atualizações!"
NotificationText.TextColor3 = Color3.fromRGB(255, 255, 255)
NotificationText.Font = Enum.Font.GothamBold
NotificationText.TextSize = 18
NotificationText.TextWrapped = true

-- Botão Discord
local DiscordButton = Instance.new("TextButton", NotificationFrame)
DiscordButton.Size = UDim2.new(0, 120, 0, 25)
DiscordButton.Position = UDim2.new(0.5, -60, 0, 45)
DiscordButton.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
DiscordButton.Text = "DISCORD"
DiscordButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DiscordButton.Font = Enum.Font.GothamBold
DiscordButton.TextSize = 16
Instance.new("UICorner", DiscordButton).CornerRadius = UDim.new(0, 8)

local DiscordLink = "https://discord.gg/Pnpjz36xGp"
DiscordButton.MouseButton1Click:Connect(function()
    setclipboard(DiscordLink)
    NotificationText.Text = "🔗 Link do Discord copiado!"
    NotificationText.TextColor3 = Color3.fromRGB(255, 255, 0)
end)

-- Animação de fade in
NotificationFrame.BackgroundTransparency = 1
NotificationText.TextTransparency = 1
DiscordButton.TextTransparency = 1

for i = 0, 1, 0.05 do
    NotificationFrame.BackgroundTransparency = 1 - i
    NotificationText.TextTransparency = 1 - i
    DiscordButton.TextTransparency = 1 - i
    task.wait(0.03)
end

-- Fade out após 5 segundos
task.wait(5)
for i = 0, 1, 0.05 do
    NotificationFrame.BackgroundTransparency = i
    NotificationText.TextTransparency = i
    DiscordButton.TextTransparency = i
    task.wait(0.03)
end

NotificationFrame:Destroy()
