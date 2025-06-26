local Player = game:GetService("Players").LocalPlayer
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

-- ===== CONFIGURAÇÃO DO TEMA CIANO E PRETO =====
local Theme = {
    Background = Color3.fromRGB(15, 15, 15),
    Primary = Color3.fromRGB(0, 255, 255),
    Secondary = Color3.fromRGB(0, 150, 150),
    Accent = Color3.fromRGB(200, 200, 200),
    Text = Color3.fromRGB(255, 255, 255),
    Error = Color3.fromRGB(255, 50, 50),
    ButtonHover = Color3.fromRGB(40, 40, 40),
    ButtonBackground = Color3.fromRGB(25, 25, 25)
}

-- Chave correta
local CorrectKey = "Dr4gonX" -- <-- A CHAVE FOI DEFINIDA AQUI

-- URL do Discord para o botão Get Key
local DiscordUrl = "https://discord.gg/PvssedzXpT"

-- URLs de fallback para o script do Hub
local scriptUrls = {
    -- 1ª TENTATIVA: Link do GitHub (seu link primário)
    "https://raw.githubusercontent.com/Dr4gonScripts/Muscles-project/refs/heads/main/RoblokiHub.lua",
    -- 2ª TENTATIVA: Link do Pastebin (o backup que você forneceu)
    "https://pastebin.com/raw/dLBQU8pn"
}

-- Funções auxiliares
local function Notify(title, text, duration)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title or "Notificação", Text = text or "Operação concluída",
        Duration = duration or 3
    })
end

local function loadScriptFromUrl(url)
    local success, content = pcall(function()
        return game:HttpGet(url .. "?" .. tick(), true) -- Adiciona o cache-busting
    end)
    
    if success and content and #content > 10 and not content:find("404: Not Found") then
        local ok, err = pcall(loadstring(content))
        if not ok then warn("Failed to execute script from URL: " .. url .. "\nError: " .. tostring(err)) end
        return ok
    end
    return false
end

-- Cria a interface
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RoblokiKeySystem"
ScreenGui.Parent = CoreGui

-- Frame principal
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 350, 0, 260) -- Aumentei a altura para os novos botões
Frame.Position = UDim2.new(0.5, -175, 0.5, -130)
Frame.BackgroundColor3 = Theme.Background
Frame.BackgroundTransparency = 0.2
Frame.BorderColor3 = Theme.Primary
Frame.BorderSizePixel = 1
Frame.Parent = ScreenGui
Frame.Active = true

-- Sistema de arrastar
local dragStartPos
local dragStartInputPos
local dragging = false

Frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStartPos = Frame.Position
        dragStartInputPos = input.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
        local delta = input.Position - dragStartInputPos
        Frame.Position = UDim2.new(dragStartPos.X.Scale, dragStartPos.X.Offset + delta.X, dragStartPos.Y.Scale, dragStartPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)


-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 10)
Title.Text = "Robloki Hub"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24
Title.TextColor3 = Theme.Primary
Title.BackgroundTransparency = 1
Title.Parent = Frame

-- Input da chave
local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(1, -60, 0, 40)
KeyBox.Position = UDim2.new(0.5, 0, 0.5, -40)
KeyBox.AnchorPoint = Vector2.new(0.5, 0.5)
KeyBox.PlaceholderText = "INSIRA SUA KEY AQUI..."
KeyBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
KeyBox.Text = ""
KeyBox.Font = Enum.Font.Gotham
KeyBox.TextSize = 16
KeyBox.TextColor3 = Theme.Text
KeyBox.BackgroundColor3 = Theme.ButtonBackground
KeyBox.BorderSizePixel = 1
KeyBox.Parent = Frame

-- Botão de submissão
local SubmitButton = Instance.new("TextButton")
SubmitButton.Size = UDim2.new(1, -60, 0, 45)
SubmitButton.Position = UDim2.new(0.5, 0, 0.5, 10)
SubmitButton.AnchorPoint = Vector2.new(0.5, 0.5)
SubmitButton.Text = "SUBMIT"
SubmitButton.Font = Enum.Font.GothamBold
SubmitButton.TextSize = 20
SubmitButton.TextColor3 = Theme.Text
SubmitButton.BackgroundColor3 = Theme.ButtonBackground
SubmitButton.Parent = Frame

-- Botão Get Key (redireciona para o Discord)
local GetKeyButton = Instance.new("TextButton")
GetKeyButton.Size = UDim2.new(1, -60, 0, 45)
GetKeyButton.Position = UDim2.new(0.5, 0, 0.5, 60)
GetKeyButton.AnchorPoint = Vector2.new(0.5, 0.5)
GetKeyButton.Text = "GET KEY"
GetKeyButton.Font = Enum.Font.GothamBold
GetKeyButton.TextSize = 16
GetKeyButton.TextColor3 = Theme.Primary
GetKeyButton.BackgroundColor3 = Theme.ButtonBackground
GetKeyButton.Parent = Frame

-- Botão Fechar
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.AnchorPoint = Vector2.new(0.5, 0)
CloseButton.Text = "✕"
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 20
CloseButton.TextColor3 = Theme.Text
CloseButton.BackgroundColor3 = Theme.Error
CloseButton.Parent = Frame

-- Conectar o botão de submissão
SubmitButton.MouseButton1Click:Connect(function()
    if KeyBox.Text == CorrectKey then
        SubmitButton.Text = "LOADING..."
        SubmitButton.BackgroundColor3 = Color3.fromRGB(150, 150, 0)
        
        task.spawn(function()
            local success = false
            for _, url in ipairs(scriptUrls) do
                if loadScriptFromUrl(url) then
                    success = true
                    break
                end
            end
            
            if success then
                SubmitButton.Text = "LOADED!"
                SubmitButton.BackgroundColor3 = Theme.Primary
                task.wait(1)
                ScreenGui:Destroy()
            else
                SubmitButton.Text = "ERROR!"
                SubmitButton.BackgroundColor3 = Theme.Error
                Notify("Robloki Hub", "Falha ao carregar o Hub de todas as fontes. Tente novamente mais tarde.", 5)
                task.wait(2.5)
                SubmitButton.Text = "SUBMIT"
                SubmitButton.BackgroundColor3 = Theme.ButtonBackground
            end
        end)
    else
        SubmitButton.Text = "INVALID KEY!"
        SubmitButton.BackgroundColor3 = Theme.Error
        task.wait(1.5)
        SubmitButton.Text = "SUBMIT"
        SubmitButton.BackgroundColor3 = Theme.ButtonBackground
    end
end)

-- Conectar o botão Get Key para abrir o Discord
GetKeyButton.MouseButton1Click:Connect(function()
    local success = pcall(function()
        -- Tenta abrir a URL do Discord no navegador
        if syn and syn.clipboard_set then
            syn.clipboard_set(DiscordUrl)
            syn.launch_url(DiscordUrl)
        elseif setclipboard then
            setclipboard(DiscordUrl)
            -- Não há um método nativo de abrir URL no navegador para a maioria dos executors
        end
        Notify("Discord Aberto", "O link do Discord foi copiado e será aberto no seu navegador. Entre para pegar a chave!", 5)
    end)
    if not success then
        Notify("Aviso", "O executor não suporta a função de copiar/abrir URL.", 3)
    end
end)


-- Conectar o botão Fechar
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
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
Shadow.ZIndex = Frame.ZIndex - 1
Shadow.Parent = Frame

-- Cantos arredondados
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = Frame
local corner_keybox = Instance.new("UICorner")
corner_keybox.CornerRadius = UDim.new(0, 6)
corner_keybox.Parent = KeyBox
local corner_submit = Instance.new("UICorner")
corner_submit.CornerRadius = UDim.new(0, 6)
corner_submit.Parent = SubmitButton
local corner_getkey = Instance.new("UICorner")
corner_getkey.CornerRadius = UDim.new(0, 6)
corner_getkey.Parent = GetKeyButton
local corner_close = Instance.new("UICorner")
corner_close.CornerRadius = UDim.new(0, 6)
corner_close.Parent = CloseButton
