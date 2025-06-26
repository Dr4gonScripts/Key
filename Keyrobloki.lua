local Player = game:GetService("Players").LocalPlayer
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Chave correta
local CorrectKey = "Dr4gonX" -- <-- Defina sua chave aqui

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
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.BackgroundTransparency = 1
Title.Parent = Frame

-- Input da chave
local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(1, -60, 0, 40)
KeyBox.Position = UDim2.new(0.5, 0, 0.5, -20)
KeyBox.AnchorPoint = Vector2.new(0.5, 0.5)
KeyBox.PlaceholderText = "INSIRA SUA KEY AQUI..."
KeyBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
KeyBox.Text = ""
KeyBox.Font = Enum.Font.Gotham
KeyBox.TextSize = 16
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
KeyBox.BorderSizePixel = 1
KeyBox.Parent = Frame

-- Botão de submissão
local SubmitButton = Instance.new("TextButton")
SubmitButton.Size = UDim2.new(1, -60, 0, 45)
SubmitButton.Position = UDim2.new(0.5, 0, 0.5, 30)
SubmitButton.AnchorPoint = Vector2.new(0.5, 0.5)
SubmitButton.Text = "SUBMIT"
SubmitButton.Font = Enum.Font.GothamBold
SubmitButton.TextSize = 20
SubmitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitButton.BackgroundColor3 = Color3.fromRGB(0, 120, 120)
SubmitButton.Parent = Frame

-- Lógica de carregamento e fallback
local scriptUrls = {
    -- 1ª TENTATIVA: Link do GitHub (o link que pode estar offline)
    "https://raw.githubusercontent.com/Dr4gonScripts/Muscles-project/refs/heads/main/RoblokiHub.lua",
    -- 2ª TENTATIVA: Link do Pastebin (o backup confiável)
    "https://pastebin.com/raw/dLBQU8pn"
}

local function loadScriptFromUrl(url)
    local success, content = pcall(function()
        return game:HttpGet(url .. "?" .. tick(), true) -- Adiciona o cache-busting
    end)
    
    if success and content and #content > 10 then -- Verifica se o conteúdo é válido (não é uma página de erro 404, etc.)
        local ok, err = pcall(loadstring(content))
        if not ok then warn("Failed to execute script from URL: " .. url .. "\nError: " .. tostring(err)) end
        return ok
    end
    return false
end

-- Conectar o botão de submissão
SubmitButton.MouseButton1Click:Connect(function()
    if KeyBox.Text == CorrectKey then
        -- Chave correta, agora tenta carregar o script do Hub com fallback
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
                -- O script foi carregado com sucesso
                SubmitButton.Text = "LOADED!"
                SubmitButton.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
                task.wait(1)
                ScreenGui:Destroy() -- Remove a interface após carregar
            else
                -- Falhou ao carregar de todas as URLs
                SubmitButton.Text = "ERROR!"
                SubmitButton.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Robloki Hub",
                    Text = "Falha ao carregar o Hub de todas as fontes. Tente novamente mais tarde.",
                    Duration = 5
                })
                task.wait(2.5)
                -- Reseta o botão
                SubmitButton.Text = "SUBMIT"
                SubmitButton.BackgroundColor3 = Color3.fromRGB(0, 120, 120)
            end
        end)
    else
        -- Chave incorreta
        SubmitButton.Text = "INVALID KEY!"
        SubmitButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        task.wait(1.5)
        SubmitButton.Text = "SUBMIT"
        SubmitButton.BackgroundColor3 = Color3.fromRGB(0, 120, 120)
    end
end)

-- Efeito de sombra (melhorado para ser mais genérico)
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

-- Corner para o Frame
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = Frame
local corner_keybox = Instance.new("UICorner")
corner_keybox.CornerRadius = UDim.new(0, 6)
corner_keybox.Parent = KeyBox
local corner_submit = Instance.new("UICorner")
corner_submit.CornerRadius = UDim.new(0, 6)
corner_submit.Parent = SubmitButton
