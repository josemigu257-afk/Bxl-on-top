-- ============================================================
-- Bxl — ESTILO FLOTANTE MORADO 💜✨
-- ============================================================
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LP = Players.LocalPlayer

-- ========== FUNCIONES ==========
local velocidadRapida = 35
local velocidadExtra = false
local laggerActivo = false
local autoBat = false
local autoIzquierda = false
local autoDerecha = false
local invisible = false

-- BLOQUEAR COLISIÓN
RunService.Stepped:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            for _, parte in pairs(p.Character:GetChildren()) do
                if parte:IsA("BasePart") then parte.CanCollide = false end
            end
        end
    end
end)

-- SISTEMA DE VELOCIDAD
RunService.RenderStepped:Connect(function()
    local c = LP.Character
    if not c then return end
    local hrp = c:FindFirstChild("HumanoidRootPart")
    local hum = c:FindFirstChild("Humanoid")
    if not hrp or not hum then return end

    local vel = 16
    if velocidadExtra then vel = 50 end
    if laggerActivo then vel = 6 end

    if hum.MoveDirection.Magnitude > 0 then
        hrp.Velocity = hum.MoveDirection * vel
    end
end)

-- ========== CREAR MENÚ FLOTANTE 💜 ==========
local Gui = Instance.new("ScreenGui")
Gui.Name = "Bxl_Menu"
Gui.Parent = LP:WaitForChild("PlayerGui")
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- FUNCIÓN BOTÓN REDONDO FLOTANTE
local function BotonFlotante(texto, posX, posY, color, funcion)
    local Btn = Instance.new("TextButton")
    Btn.Name = texto
    Btn.Size = UDim2.new(0, 100, 0, 55)
    Btn.Position = UDim2.new(posX, 0, posY, 0)
    Btn.BackgroundColor3 = color
    Btn.BackgroundTransparency = 0.15
    Btn.Text = texto
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 14
    Btn.CornerRadius = UDim.new(0, 14)
    Btn.AutoLocalize = false
    Btn.Parent = Gui

    -- EFECTO AL PASAR
    Btn.MouseEnter:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.15), {BackgroundTransparency = 0}):Play()
    end)
    Btn.MouseLeave:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.15}):Play()
    end)

    Btn.MouseButton1Click:Connect(funcion)
    return Btn
end

-- ========== BOTONES — ESTILO TU IMAGEN 💜 ==========
BotonFlotante("SPEED", 0.05, 0.15, Color3.fromRGB(90, 40, 160), function()
    velocidadExtra = not velocidadExtra
end)

BotonFlotante("LAG\nMODE", 0.82, 0.22, Color3.fromRGB(120, 50, 200), function()
    laggerActivo = not laggerActivo
end)

BotonFlotante("AUTO\nLEFT", 0.70, 0.15, Color3.fromRGB(70, 30, 140), function()
    autoIzquierda = not autoIzquierda
end)

BotonFlotante("AUTO\nRIGHT", 0.85, 0.10, Color3.fromRGB(70, 30, 140), function()
    autoDerecha = not autoDerecha
end)

BotonFlotante("AUTO\nBAT", 0.55, 0.20, Color3.fromRGB(80, 35, 150), function()
    autoBat = not autoBat
end)

BotonFlotante("TP\nBAT", 0.30, 0.25, Color3.fromRGB(60, 25, 130), function() end)

BotonFlotante("TP\nDOWN", 0.70, 0.28, Color3.fromRGB(60, 25, 130), function()
    local c = LP.Character
    if c and c:FindFirstChild("HumanoidRootPart") then
        c.HumanoidRootPart.CFrame = CFrame.new(c.HumanoidRootPart.Position.X, -50, c.HumanoidRootPart.Position.Z)
    end
end)

BotonFlotante("INVISIBLE", 0.05, 0.25, Color3.fromRGB(100, 100, 120), function()
    invisible = not invisible
    local c = LP.Character
    if c then
        for _, p in pairs(c:GetChildren()) do
            if p:IsA("BasePart") then p.Transparency = invisible and 1 or 0 end
        end
    end
end)

BotonFlotante("CARRY\nSPEED", 0.82, 0.35, Color3.fromRGB(50, 20, 110), function() end)

-- TÍTULO ARRIBA
local Titulo = Instance.new("TextLabel")
Titulo.Size = UDim2.new(0, 180, 0, 50)
Titulo.Position = UDim2.new(0.05, 0, 0.08, 0)
Titulo.BackgroundColor3 = Color3.fromRGB(45, 20, 90)
Titulo.BackgroundTransparency = 0.2
Titulo.Text = "💜 Bxl — HUB"
Titulo.TextColor3 = Color3.fromRGB(220, 180, 255)
Titulo.Font = Enum.Font.GothamBold
Titulo.TextSize = 22
Titulo.CornerRadius = UDim.new(0, 12)
Titulo.Parent = Gui

print("[Bxl] ✅ Estilo Flotante Cargado 💜✨")
