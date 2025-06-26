local Player = game:GetService("Players").LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- Cria a interface
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RoblokiKeySystem"
ScreenGui.Parent = CoreGui

-- Frame principal
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 450, 0, 250)
Frame.Position = UDim2.new(0.5, -225, 0.5, -125)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.BorderColor3 = Color3.fromRGB(0, 255, 255)
Frame.BorderSizePixel = 2
Frame.Parent = ScreenGui

-- Cabeçalho
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 40)
Header.Position = UDim2.new(0, 0, 0, 0)
Header.BackgroundColor3 = Color3.fromRGB(0, 40, 40)
Header.BorderSizePixel = 0
Header.Parent = Frame

local HeaderText = Instance.new("TextLabel")
HeaderText.Size = UDim2.new(1, 0, 1, 0)
HeaderText.Text = "ROBLOKI KEY"
HeaderText.TextColor3 = Color3.fromRGB(0, 255, 255)
HeaderText.BackgroundTransparency = 1
HeaderText.Font = Enum.Font.GothamBold
HeaderText.TextSize = 20
HeaderText.Parent = Header

-- Divisão esquerda (botões)
local LeftPanel = Instance.new("Frame")
LeftPanel.Size = UDim2.new(0.45, 0, 0.7, 0)
LeftPanel.Position = UDim2.new(0.05, 0, 0.2, 0)
LeftPanel.BackgroundTransparency = 1
LeftPanel.Parent = Frame

-- Botão Get Key
local GetKeyButton = Instance.new("TextButton")
GetKeyButton.Size = UDim2.new(1, 0, 0.45, 0)
GetKeyButton.Position = UDim2.new(0, 0, 0, 0)
GetKeyButton.Text = "GET KEY"
GetKeyButton.TextColor3 = Color3.new(1, 1, 1)
GetKeyButton.BackgroundColor3 = Color3.fromRGB(0, 80, 80)
GetKeyButton.BorderColor3 = Color3.fromRGB(0, 200, 200)
GetKeyButton.Font = Enum.Font.GothamBold
GetKeyButton.TextSize = 16
GetKeyButton.Parent = LeftPanel

-- Efeitos de hover nos botões
GetKeyButton.MouseEnter:Connect(function()
    GetKeyButton.BackgroundColor3 = Color3.fromRGB(0, 100, 100)
end)

GetKeyButton.MouseLeave:Connect(function()
    GetKeyButton.BackgroundColor3 = Color3.fromRGB(0, 80, 80)
end)

-- Divisão direita (inserir key)
local RightPanel = Instance.new("Frame")
RightPanel.Size = UDim2.new(0.45, 0, 0.7, 0)
RightPanel.Position = UDim2.new(0.5, 0, 0.2, 0)
RightPanel.BackgroundTransparency = 1
RightPanel.Parent = Frame

local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(1, 0, 0.6, 0)
TextBox.Position = UDim2.new(0, 0, 0, 0)
TextBox.PlaceholderText = "Insira sua key aqui..."
TextBox.Text = ""
TextBox.TextColor3 = Color3.new(1, 1, 1)
TextBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TextBox.BorderColor3 = Color3.fromRGB(0, 150, 150)
TextBox.Font = Enum.Font.Gotham
TextBox.TextSize = 14
TextBox.Parent = RightPanel

local SubmitButton = Instance.new("TextButton")
SubmitButton.Size = UDim2.new(1, 0, 0.35, 0)
SubmitButton.Position = UDim2.new(0, 0, 0.65, 0)
SubmitButton.Text = "INSERIR KEY"
SubmitButton.BackgroundColor3 = Color3.fromRGB(0, 100, 100)
SubmitButton.BorderColor3 = Color3.fromRGB(0, 200, 200)
SubmitButton.TextColor3 = Color3.new(1, 1, 1)
SubmitButton.Font = Enum.Font.GothamBold
SubmitButton.TextSize = 16
SubmitButton.Parent = RightPanel

-- Efeitos de hover no botão de submit
SubmitButton.MouseEnter:Connect(function()
    SubmitButton.BackgroundColor3 = Color3.fromRGB(0, 120, 120)
end)

SubmitButton.MouseLeave:Connect(function()
    SubmitButton.BackgroundColor3 = Color3.fromRGB(0, 100, 100)
end)

-- Função para copiar o link do Discord
GetKeyButton.MouseButton1Click:Connect(function()
    local HttpService = game:GetService("HttpService")
    if setclipboard then
        setclipboard("https://discord.gg/wxBpSfkJRp")
        GetKeyButton.Text = "LINK COPIADO!"
        wait(1.5)
        GetKeyButton.Text = "GET KEY"
    else
        GetKeyButton.Text = "ERRO AO COPIAR"
        wait(1.5)
        GetKeyButton.Text = "GET KEY"
    end
end)

-- Função para verificar a key
SubmitButton.MouseButton1Click:Connect(function()
    if TextBox.Text == "Dr4gonX" then
        ScreenGui:Destroy() -- Remove a interface
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Dr4gonScripts/Key/refs/heads/main/22robloki.lua"))()
    else
        -- Key incorreta - kicka o jogador
        Player:Kick("Key incorreta! Acesso negado.")
    end
end)

-- Efeito de sombra no frame principal
local Shadow = Instance.new("ImageLabel")
Shadow.Name = "Shadow"
Shadow.Image = "rbxassetid://1316045217"
Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
Shadow.ImageTransparency = 0.7
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(10, 10, 118, 118)
Shadow.Size = UDim2.new(1, 10, 1, 10)
Shadow.Position = UDim2.new(0, -5, 0, -5)
Shadow.BackgroundTransparency = 1
Shadow.Parent = Frame
