--[[
    Script de Key para Robloki Hub
    Modelo: Baseado na imagem fornecida pelo usuário
    Tema: Ciano e Preto com transparência
    Funcionalidades:
        - Campo de chave
        - Botão SUBMIT
        - Botão GET KEY (abre o link do Discord)
        - Botão CLOSE
        - Sistema de arrastar
        - Carregamento do Hub com fallback (GitHub > Pastebin)
    Chave: Dr4gonX
    CORREÇÃO FINAL: Solucionado o problema de ZIndex e tela transparente cobrindo a interface.
]]--

local Player = game:GetService("Players").LocalPlayer
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- ===== CONFIGURAÇÃO DE CORES E TEMA (Ciano e Preto com Transparência) =====
local Theme = {
    MainColor = Color3.fromRGB(0, 255, 255), -- Ciano
    SecondaryColor = Color3.fromRGB(0, 200, 200), -- Ciano mais escuro
    TextColor = Color3.fromRGB(255, 255, 255), -- Branco
    BackgroundColor = Color3.fromRGB(20, 20, 20), -- Preto escuro
    ErrorColor = Color3.fromRGB(255, 50, 50), -- Vermelho para erros
    BackgroundTransparency = 0.4, -- Transparência para o frame
    ButtonTransparency = 0.5 -- Transparência para os botões
}

-- ===== CONFIGURAÇÕES DO SCRIPT =====
local CorrectKey = "Dr4gonX" -- A chave correta para o Hub
local DiscordUrl = "https://discord.gg/PvssedzXpT" -- Link para o Discord
local ScriptUrls = {
    -- 1ª TENTATIVA: Link do GitHub
    "https://raw.githubusercontent.com/Dr4gonScripts/Muscles-project/refs/heads/main/RoblokiHub.lua",
    -- 2ª TENTATIVA: Link do Pastebin (como backup)
    "https://pastebin.com/raw/dLBQU8pn"
}

-- ===== FUNÇÕES AUXILIARES =====
local function Notify(title, text, duration)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = duration or 3
    })
end

local function LoadScriptFromUrl(url)
    local success, content = pcall(function()
        return game:HttpGet(url .. "?" .. tick(), true) -- Adiciona um parâmetro de cache-busting
    end)
    
    if success and content and #content > 10 and not content:find("404: Not Found") then
        local loadSuccess, err = pcall(loadstring(content))
        if not loadSuccess then warn("Failed to execute script from URL: " .. url .. "\nError: " .. tostring(err)) end
        return loadSuccess
    end
    return false
end

-- ===== CRIAÇÃO DA INTERFACE GRÁFICA =====
-- Remova qualquer ScreenGui existente para evitar duplicação
if CoreGui:FindFirstChild("RoblokiKeySystem") then
    CoreGui.RoblokiKeySystem:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RoblokiKeySystem"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global -- Garante que a UI esteja acima de todos os elementos

-- Frame Principal (fundo)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
MainFrame.BackgroundColor3 = Theme.BackgroundColor
MainFrame.BackgroundTransparency = Theme.BackgroundTransparency
MainFrame.BorderColor3 = Theme.MainColor
MainFrame.BorderSizePixel = 2
MainFrame.Parent = ScreenGui
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ZIndex = 10 -- Define um ZIndex alto para garantir que ele esteja na frente

-- Cantos arredondados
local FrameCorner = Instance.new("UICorner")
FrameCorner.CornerRadius = UDim.new(0, 15)
FrameCorner.Parent = MainFrame

-- Título
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 50)
TitleLabel.Position = UDim2.new(0, 0, 0, 15)
TitleLabel.Text = "Robloki Hub"
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 30
TitleLabel.TextColor3 = Theme.MainColor
TitleLabel.BackgroundTransparency = 1
TitleLabel.ZIndex = 11 -- Acima do frame principal
TitleLabel.Parent = MainFrame

-- Subtítulo
local SubtitleLabel = Instance.new("TextLabel")
SubtitleLabel.Size = UDim2.new(1, 0, 0, 20)
SubtitleLabel.Position = UDim2.new(0, 0, 0, 60)
SubtitleLabel.Text = "Insira sua key para continuar"
SubtitleLabel.Font = Enum.Font.Gotham
SubtitleLabel.TextSize = 16
SubtitleLabel.TextColor3 = Theme.TextColor
SubtitleLabel.BackgroundTransparency = 1
SubtitleLabel.ZIndex = 11
SubtitleLabel.Parent = MainFrame

-- TextBox para a chave
local KeyTextBox = Instance.new("TextBox")
KeyTextBox.Size = UDim2.new(0.8, 0, 0, 45)
KeyTextBox.Position = UDim2.new(0.5, 0, 0.5, -45)
KeyTextBox.AnchorPoint = Vector2.new(0.5, 0.5)
KeyTextBox.PlaceholderText = "Cole sua key aqui..."
KeyTextBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
KeyTextBox.Text = ""
KeyTextBox.Font = Enum.Font.Gotham
KeyTextBox.TextSize = 18
KeyTextBox.TextColor3 = Theme.TextColor
KeyTextBox.BackgroundColor3 = Theme.BackgroundColor
KeyTextBox.BackgroundTransparency = Theme.ButtonTransparency
KeyTextBox.BorderSizePixel = 1
KeyTextBox.BorderColor3 = Theme.SecondaryColor
KeyTextBox.ClearTextOnFocus = false
KeyTextBox.ZIndex = 11
KeyTextBox.Parent = MainFrame

-- Cantos arredondados para a TextBox
local KeyTextBoxCorner = Instance.new("UICorner")
KeyTextBoxCorner.CornerRadius = UDim.new(0, 8)
KeyTextBoxCorner.Parent = KeyTextBox

-- Botão SUBMIT
local SubmitButton = Instance.new("TextButton")
SubmitButton.Size = UDim2.new(0.8, 0, 0, 50)
SubmitButton.Position = UDim2.new(0.5, 0, 0.5, 15)
SubmitButton.AnchorPoint = Vector2.new(0.5, 0.5)
SubmitButton.Text = "SUBMIT"
SubmitButton.Font = Enum.Font.GothamBold
SubmitButton.TextSize = 22
SubmitButton.TextColor3 = Theme.TextColor
SubmitButton.BackgroundColor3 = Theme.SecondaryColor
SubmitButton.BackgroundTransparency = Theme.ButtonTransparency
SubmitButton.ZIndex = 11
SubmitButton.Parent = MainFrame

-- Cantos arredondados para o botão Submit
local SubmitButtonCorner = Instance.new("UICorner")
SubmitButtonCorner.CornerRadius = UDim.new(0, 8)
SubmitButtonCorner.Parent = SubmitButton

-- Botão GET KEY
local GetKeyButton = Instance.new("TextButton")
GetKeyButton.Size = UDim2.new(0.8, 0, 0, 30)
GetKeyButton.Position = UDim2.new(0.5, 0, 0.5, 60)
GetKeyButton.AnchorPoint = Vector2.new(0.5, 0.5)
GetKeyButton.Text = "GET KEY"
GetKeyButton.Font = Enum.Font.GothamBold
GetKeyButton.TextSize = 16
GetKeyButton.TextColor3 = Theme.MainColor
GetKeyButton.BackgroundTransparency = 1
GetKeyButton.ZIndex = 11
GetKeyButton.Parent = MainFrame

-- Botão FECHAR
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -5, 0, 5)
CloseButton.AnchorPoint = Vector2.new(1, 0)
CloseButton.Text = "✕"
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 25
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.BackgroundColor3 = Theme.ErrorColor
CloseButton.BackgroundTransparency = Theme.ButtonTransparency
CloseButton.ZIndex = 12 -- Acima de tudo
CloseButton.Parent = MainFrame

-- Cantos arredondados para o botão Fechar
local CloseButtonCorner = Instance.new("UICorner")
CloseButtonCorner.CornerRadius = UDim.new(0, 5)
CloseButtonCorner.Parent = CloseButton

-- ===== CONEXÕES DE EVENTOS =====
-- Conexão do botão SUBMIT
SubmitButton.MouseButton1Click:Connect(function()
    if KeyTextBox.Text == CorrectKey then
        SubmitButton.Text = "LOADING..."
        SubmitButton.BackgroundColor3 = Theme.SecondaryColor
        
        task.spawn(function()
            local success = false
            for _, url in ipairs(ScriptUrls) do
                if LoadScriptFromUrl(url) then
                    success = true
                    break
                end
            end
            
            if success then
                SubmitButton.Text = "LOADED!"
                SubmitButton.BackgroundColor3 = Theme.MainColor
                Notify("Robloki Hub", "Hub carregado com sucesso! A interface será removida.", 2)
                task.wait(1)
                ScreenGui:Destroy()
            else
                SubmitButton.Text = "ERROR!"
                SubmitButton.BackgroundColor3 = Theme.ErrorColor
                Notify("Robloki Hub", "Falha ao carregar o Hub de todas as fontes. Tente novamente mais tarde.", 5)
                task.wait(3)
                SubmitButton.Text = "SUBMIT"
                SubmitButton.BackgroundColor3 = Theme.SecondaryColor
            end
        end)
    else
        KeyTextBox.Text = ""
        KeyTextBox.PlaceholderText = "KEY INVÁLIDA!"
        SubmitButton.Text = "INVALID KEY!"
        SubmitButton.BackgroundColor3 = Theme.ErrorColor
        task.wait(2)
        SubmitButton.Text = "SUBMIT"
        SubmitButton.BackgroundColor3 = Theme.SecondaryColor
        KeyTextBox.PlaceholderText = "Cole sua key aqui..."
    end
end)

-- Conexão do botão GET KEY
GetKeyButton.MouseButton1Click:Connect(function()
    local success, err = pcall(function()
        if syn and syn.launch_url then
            syn.launch_url(DiscordUrl)
        elseif setclipboard then
            setclipboard(DiscordUrl)
            Notify("Discord Aberto", "O link do Discord foi copiado para sua área de transferência. Cole no navegador!", 5)
        else
            Notify("Aviso", "Seu executor não suporta abrir URLs.", 3)
        end
    end)
    if not success then
        warn("Failed to open URL or copy to clipboard: " .. tostring(err))
        Notify("Aviso", "O executor não suporta a função de copiar/abrir URL.", 3)
    end
end)

-- Conexão do botão FECHAR
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Efeito de hover nos botões
local function AddHoverEffect(button, defaultColor, hoverColor, transparency)
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = hoverColor
        button.BackgroundTransparency = transparency
    end)
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = defaultColor
        button.BackgroundTransparency = transparency
    end)
end

AddHoverEffect(SubmitButton, Theme.SecondaryColor, Theme.MainColor, Theme.ButtonTransparency)
AddHoverEffect(CloseButton, Theme.ErrorColor, Color3.fromRGB(200, 0, 0), Theme.ButtonTransparency)
