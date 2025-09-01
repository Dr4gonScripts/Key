-- Sistema de Key com UI Estilizada (Preto/Vermelho)
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

-- Criar GUI
local ScreenGui = Instance.new("ScreenGui", Player:WaitForChild("PlayerGui"))
ScreenGui.Name = "KeySystem"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true

-- Fundo transparente escuro
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 420, 0, 250)
Frame.Position = UDim2.new(0.5, -210, 0.5, -125)
Frame.BackgroundColor3 = Color3.fromRGB(80, 0, 0) -- vermelho escuro
Frame.BackgroundTransparency = 0.15
Frame.BorderSizePixel = 0
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 12)

-- Borda preta
local Border = Instance.new("UIStroke", Frame)
Border.Color = Color3.fromRGB(0, 0, 0)
Border.Thickness = 2

-- Botão de Fechar (X)
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

-- Título
local Title = Instance.new("TextLabel", Frame)
Title.Text = "🔐 Robloki Hub - Key System"
Title.Size = UDim2.new(1, -50, 0, 45) -- espaço para o botão X
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 22
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Caixa de Texto (Key)
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

-- Key correta
local KeyCorreta = "ROBLOKI-123ABC456XYZ789PQ" -- altere para sua key real

-- Botão "Verificar Key"
local VerifyButton = Instance.new("TextButton", Frame)
VerifyButton.Size = UDim2.new(0, 160, 0, 38)
VerifyButton.Position = UDim2.new(1, -170, 1, -45)
VerifyButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
VerifyButton.Text = "✔ Verificar Key"
VerifyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
VerifyButton.Font = Enum.Font.GothamBold
VerifyButton.TextSize = 18
Instance.new("UICorner", VerifyButton).CornerRadius = UDim.new(0, 8)

-- Botão "Get Key"
local GetKey = Instance.new("TextButton", Frame)
GetKey.Size = UDim2.new(0, 130, 0, 32)
GetKey.Position = UDim2.new(0, 10, 1, -40)
GetKey.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
GetKey.Text = "🔗 Get Key"
GetKey.TextColor3 = Color3.fromRGB(255, 50, 50)
GetKey.Font = Enum.Font.GothamBold
GetKey.TextSize = 16
Instance.new("UICorner", GetKey).CornerRadius = UDim.new(0, 8)

-- Ação "Verificar Key"
VerifyButton.MouseButton1Click:Connect(function()
    if TextBox.Text == KeyCorreta then
        Title.Text = "✅ Key correta!"
        Title.TextColor3 = Color3.fromRGB(0, 255, 0)
        task.wait(1)
        ScreenGui:Destroy()
        -- Executar script principal
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Dr4gonScripts/Key/refs/heads/main/RoblokiKey.lua"))()
    else
        Title.Text = "❌ Key inválida!"
        Title.TextColor3 = Color3.fromRGB(255, 0, 0)
    end
end)

-- Ação "Get Key"
GetKey.MouseButton1Click:Connect(function()
    setclipboard("https://seusite.com/getkey")
    Title.Text = "🔗 Link copiado!"
    Title.TextColor3 = Color3.fromRGB(255, 255, 0)
end)
