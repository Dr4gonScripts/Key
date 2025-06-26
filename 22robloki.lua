local Player = game:GetService("Players").LocalPlayer
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

-- Cria a interface
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RoblokiKeySystem"
ScreenGui.Parent = CoreGui

-- Frame principal
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 400, 0, 280)
Frame.Position = UDim2.new(0.5, -200, 0.5, -140)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.BorderColor3 = Color3.fromRGB(0, 255, 255)
Frame.BorderSizePixel = 2
Frame.Parent = ScreenGui
Frame.Active = true
Frame.Draggable = true

-- Função para tornar arrastável (melhorada)
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

Frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Frame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

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

-- Área de inserção da key
local KeyInputFrame = Instance.new("Frame")
KeyInputFrame.Size = UDim2.new(0.9, 0, 0, 80)
KeyInputFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
KeyInputFrame.BackgroundTransparency = 1
KeyInputFrame.Parent = Frame

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
TextBox.Parent = KeyInputFrame

local SubmitButton = Instance.new("TextButton")
SubmitButton.Size = UDim2.new(1, 0, 0.35, 0)
SubmitButton.Position = UDim2.new(0, 0, 0.65, 0)
SubmitButton.Text = "INSERIR KEY"
SubmitButton.BackgroundColor3 = Color3.fromRGB(0, 100, 100)
SubmitButton.BorderColor3 = Color3.fromRGB(0, 200, 200)
SubmitButton.TextColor3 = Color3.new(1, 1, 1)
SubmitButton.Font = Enum.Font.GothamBold
SubmitButton.TextSize = 16
SubmitButton.Parent = KeyInputFrame

-- Área de botões inferiores
local ButtonsFrame = Instance.new("Frame")
ButtonsFrame.Size = UDim2.new(0.9, 0, 0, 100)
ButtonsFrame.Position = UDim2.new(0.05, 0, 0.55, 0)
ButtonsFrame.BackgroundTransparency = 1
ButtonsFrame.Parent = Frame

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
GetKeyButton.Parent = ButtonsFrame

-- Botão Fechar (opcional)
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(1, 0, 0.45, 0)
CloseButton.Position = UDim2.new(0, 0, 0.55, 0)
CloseButton.Text = "FECHAR"
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
CloseButton.BorderColor3 = Color3.fromRGB(200, 0, 0)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 16
CloseButton.Parent = ButtonsFrame

-- Efeitos de hover nos botões
local function setupButtonHover(button, normalColor, hoverColor)
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = hoverColor
    end)
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = normalColor
    end)
end

setupButtonHover(SubmitButton, Color3.fromRGB(0, 100, 100), Color3.fromRGB(0, 120, 120))
setupButtonHover(GetKeyButton, Color3.fromRGB(0, 80, 80), Color3.fromRGB(0, 100, 100))
setupButtonHover(CloseButton, Color3.fromRGB(80, 0, 0), Color3.fromRGB(100, 0, 0))

-- Função para copiar o link do Discord
GetKeyButton.MouseButton1Click:Connect(function()
    local HttpService = game:GetService("HttpService")
    if setclipboard then
        setclipboard("https://discord.gg/wxBpSfkJRp")
        local originalText = GetKeyButton.Text
        GetKeyButton.Text = "LINK COPIADO!"
        wait(1.5)
        GetKeyButton.Text = originalText
    else
        local originalText = GetKeyButton.Text
        GetKeyButton.Text = "ERRO AO COPIAR"
        wait(1.5)
        GetKeyButton.Text = originalText
    end
end)

-- Função para fechar
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Função para verificar a key (corrigida)
SubmitButton.MouseButton1Click:Connect(function()
    local key = TextBox.Text:gsub("%s+", "") -- Remove espaços
    if key == "Dr4gonX" then
        ScreenGui.Enabled = false -- Desabilita temporariamente
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Dr4gonScripts/Key/refs/heads/main/22robloki.lua", true))()
        end)
        
        if success then
            ScreenGui:Destroy() -- Remove completamente se o script carregar
        else
            ScreenGui.Enabled = true
            TextBox.Text = ""
            TextBox.PlaceholderText = "Erro ao carregar! Tente novamente."
            warn("Erro ao carregar script: " .. tostring(err))
        end
    else
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
