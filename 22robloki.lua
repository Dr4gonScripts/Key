local Player = game:GetService("Players").LocalPlayer
local CoreGui = game:GetService("CoreGui")
local TextService = game:GetService("TextService")

-- Cria a interface
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = CoreGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 300, 0, 190) -- Aumentei a altura para 190 para acomodar o novo botão
Frame.Position = UDim2.new(0.5, -150, 0.5, -95)
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

-- Novo botão Get Key
local GetKeyButton = Instance.new("TextButton")
GetKeyButton.Size = UDim2.new(0, 280, 0, 30)
GetKeyButton.Position = UDim2.new(0, 10, 0, 150)
GetKeyButton.Text = "Get Key (Discord)"
GetKeyButton.BackgroundColor3 = Color3.fromRGB(114, 137, 218) -- Cor do Discord
GetKeyButton.TextColor3 = Color3.new(1, 1, 1)
GetKeyButton.Parent = Frame

-- Função para copiar texto para área de transferência
local function CopyToClipboard(text)
    local clipboard = setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set)
    if clipboard then
        clipboard(text)
        return true
    else
        return false
    end
end

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

-- Função para o botão Get Key
GetKeyButton.MouseButton1Click:Connect(function()
    local discordLink = "https://discord.gg/wxBpSfkJRp"
    local success = pcall(function()
        return CopyToClipboard(discordLink)
    end)
    
    if success then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Discord",
            Text = "Link copiado! Acesse seu Discord.",
            Icon = "rbxassetid://11240648136", -- Ícone do Discord
            Duration = 5
        })
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Erro",
            Text = "Não foi possível copiar. Link: "..discordLink,
            Duration = 5
        })
    end
end)
