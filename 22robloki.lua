local Player = game:GetService("Players").LocalPlayer
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

-- Cria a interface
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RoblokiKeySystem"
ScreenGui.Parent = CoreGui

-- Frame principal
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 350, 0, 220)
Frame.Position = UDim2.new(0.5, -175, 0.5, -110)
Frame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Frame.BackgroundTransparency = 0.3
Frame.BorderColor3 = Color3.fromRGB(0, 255, 255)
Frame.BorderSizePixel = 1
Frame.Parent = ScreenGui
Frame.Active = true

-- Sistema de arrastar CORRIGIDO
local dragStartPos
local dragStartInputPos
local dragging = false

Frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStartPos = Frame.Position
        dragStartInputPos = input.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
        local delta = input.Position - dragStartInputPos
        Frame.Position = UDim2.new(
            dragStartPos.X.Scale, 
            dragStartPos.X.Offset + delta.X,
            dragStartPos.Y.Scale, 
            dragStartPos.Y.Offset + delta.Y
        )
    end
end)

-- Cabeçalho
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 30)
Header.Position = UDim2.new(0, 0, 0, 0)
Header.BackgroundColor3 = Color3.fromRGB(0, 20, 20)
Header.BackgroundTransparency = 0.5
Header.BorderSizePixel = 0
Header.Parent = Frame

local HeaderText = Instance.new("TextLabel")
HeaderText.Size = UDim2.new(1, 0, 1, 0)
HeaderText.Text = "ROBLOKI KEY"
HeaderText.TextColor3 = Color3.fromRGB(0, 255, 255)
HeaderText.BackgroundTransparency = 1
HeaderText.Font = Enum.Font.GothamBold
HeaderText.TextSize = 16
HeaderText.Parent = Header

-- Campo de key
local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0.9, 0, 0, 70)
KeyFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
KeyFrame.BackgroundTransparency = 1
KeyFrame.Parent = Frame

local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(1, 0, 0.6, 0)
TextBox.Position = UDim2.new(0, 0, 0, 0)
TextBox.PlaceholderText = "Insert Key Here..."
TextBox.Text = ""
TextBox.TextColor3 = Color3.new(1, 1, 1)
TextBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TextBox.BackgroundTransparency = 0.5
TextBox.BorderColor3 = Color3.fromRGB(0, 150, 150)
TextBox.Font = Enum.Font.Code
TextBox.TextSize = 14
TextBox.Parent = KeyFrame

local SubmitButton = Instance.new("TextButton")
SubmitButton.Size = UDim2.new(1, 0, 0.35, 0)
SubmitButton.Position = UDim2.new(0, 0, 0.65, 0)
SubmitButton.Text = "INSERT KEY"
SubmitButton.BackgroundColor3 = Color3.fromRGB(0, 80, 80)
SubmitButton.BackgroundTransparency = 0.3
SubmitButton.BorderColor3 = Color3.fromRGB(0, 200, 200)
SubmitButton.TextColor3 = Color3.new(1, 1, 1)
SubmitButton.Font = Enum.Font.GothamBold
SubmitButton.TextSize = 14
SubmitButton.Parent = KeyFrame

-- Botões inferiores
local ButtonsFrame = Instance.new("Frame")
ButtonsFrame.Size = UDim2.new(0.9, 0, 0, 80)
ButtonsFrame.Position = UDim2.new(0.05, 0, 0.55, 0)
ButtonsFrame.BackgroundTransparency = 1
ButtonsFrame.Parent = Frame

local GetKeyButton = Instance.new("TextButton")
GetKeyButton.Size = UDim2.new(0.48, 0, 0.9, 0)
GetKeyButton.Position = UDim2.new(0, 0, 0, 0)
GetKeyButton.Text = "GET KEY"
GetKeyButton.TextColor3 = Color3.new(1, 1, 1)
GetKeyButton.BackgroundColor3 = Color3.fromRGB(0, 60, 60)
GetKeyButton.BackgroundTransparency = 0.3
GetKeyButton.BorderColor3 = Color3.fromRGB(0, 180, 180)
GetKeyButton.Font = Enum.Font.Gotham
GetKeyButton.TextSize = 14
GetKeyButton.Parent = ButtonsFrame

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0.48, 0, 0.9, 0)
CloseButton.Position = UDim2.new(0.52, 0, 0, 0)
CloseButton.Text = "CLOSE"
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
CloseButton.BackgroundTransparency = 0.3
CloseButton.BorderColor3 = Color3.fromRGB(180, 0, 0)
CloseButton.Font = Enum.Font.Gotham
CloseButton.TextSize = 14
CloseButton.Parent = ButtonsFrame

-- Efeitos hover
local function buttonHover(button, hoverColor)
    button.MouseEnter:Connect(function()
        button.BackgroundTransparency = 0.1
    end)
    button.MouseLeave:Connect(function()
        button.BackgroundTransparency = 0.3
    end)
end

buttonHover(SubmitButton, Color3.fromRGB(0, 120, 120))
buttonHover(GetKeyButton, Color3.fromRGB(0, 100, 100))
buttonHover(CloseButton, Color3.fromRGB(100, 0, 0))

-- Funcionalidades
GetKeyButton.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard("https://discord.gg/wxBpSfkJRp")
        local original = GetKeyButton.Text
        GetKeyButton.Text = "COPIED!"
        task.wait(1.5)
        GetKeyButton.Text = original
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Função para verificar a key CORRIGIDA
SubmitButton.MouseButton1Click:Connect(function()
    local key = TextBox.Text:gsub("%s+", "") -- Remove espaços
    if key == "Dr4gonX" then
        -- Mostra que está carregando
        SubmitButton.Text = "LOADING..."
        SubmitButton.BackgroundColor3 = Color3.fromRGB(0, 60, 60)
        
        -- Executa o script em uma nova thread para não travar a interface
        task.spawn(function()
            local success, err = pcall(function()
                -- Usando loadstring com cache busting para garantir a versão mais recente
                local scriptUrl = "https://github.com/Dr4gonScripts/Muscles-project/blob/main/robloki.lua?"..tick()
                local scriptFunc = loadstring(game:HttpGet(scriptUrl, true))()
                if scriptFunc then
                    scriptFunc()
                end
            end)
            
            if success then
                ScreenGui:Destroy() -- Remove a interface após carregar
            else
                -- Restaura o botão e mostra erro
                SubmitButton.Text = "ERROR!"
                SubmitButton.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
                task.wait(1.5)
                SubmitButton.Text = "INSERT KEY"
                SubmitButton.BackgroundColor3 = Color3.fromRGB(0, 80, 80)
                warn("Failed to load script: "..tostring(err))
            end
        end)
    else
        Player:Kick("Invalid Key!")
    end
end)

-- Efeito de sombra
local Shadow = Instance.new("ImageLabel")
Shadow.Image = "rbxassetid://1316045217"
Shadow.ImageColor3 = Color3.new(0, 0, 0)
Shadow.ImageTransparency = 0.8
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(10, 10, 118, 118)
Shadow.Size = UDim2.new(1, 10, 1, 10)
Shadow.Position = UDim2.new(0, -5, 0, -5)
Shadow.BackgroundTransparency = 1
Shadow.ZIndex = -1
Shadow.Parent = Frame
