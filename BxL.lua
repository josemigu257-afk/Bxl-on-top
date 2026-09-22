-- ============================================================
-- Bxl — HUB COMPLETO + ESTILO OASIS 🎮
-- ============================================================
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local LP = Players.LocalPlayer

-- ============== CONFIGURACIÓN ==============
local velocidadNormal = 16
local velocidadRapida = 35
local velocidadActual = velocidadNormal
local laggerActivo = false
local antiRagdoll = false
local autoBat = false
local autoIzquierda = false
local autoDerecha = false
local bypass = false
local tpAbajo = false
local invisible = false
local velocidadExtra = false

-- ============== BLOQUEAR COLISIÓN ==============
RunService.Stepped:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            for _, parte in pairs(p.Character:GetChildren()) do
                if parte:IsA("BasePart") then
                    parte.CanCollide = false
                end
            end
        end
    end
end)

-- ============== SISTEMA DE VELOCIDAD ==============
RunService.RenderStepped:Connect(function()
    local c = LP.Character
    if not c then return end
    local hrp = c:FindFirstChild("HumanoidRootPart")
    local hum = c:FindFirstChild("Humanoid")
    if not hrp or not hum then return end

    -- Calcular velocidad
    if laggerActivo then
        velocidadActual = 8
    elseif velocidadExtra then
        velocidadActual = 50
    else
        velocidadActual = velocidadRapida
    end

    -- Aplicar velocidad
    if hum.MoveDirection.Magnitude > 0 then
        hrp.Velocity = Vector3.new(
            hum.MoveDirection.X * velocidadActual,
            hrp.Velocity.Y,
            hum.MoveDirection.Z * velocidadActual
        )
    end
end)

-- ============== MENÚ ESTILO OASIS ==============
local Gui = Instance.new("ScreenGui")
Gui.Name = "Bxl_Oasis"
Gui.Parent = LP:WaitForChild("PlayerGui")

-- FONDO PRINCIPAL
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 280, 0, 450)
Main.Position = UDim2.new(0.02, 0, 0.1, 0)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 20)
Main.CornerRadius = UDim.new(0, 14)
Main.Parent = Gui

-- BORDE BRILLANTE
local Borde = Instance.new("UIStroke")
Borde.Thickness = 2
Borde.Color = Color3.fromRGB(0, 210, 255)
Borde.Transparency = 0.3
Borde.Parent = Main

-- TÍTULO
local Titulo = Instance.new("Frame")
Titulo.Size = UDim2.new(1, 0, 0, 65)
Titulo.BackgroundColor3 = Color3.fromRGB(18, 18, 30)
Titulo.CornerRadius = UDim.new(0, 14)
Titulo.Parent = Main

local TextoTitulo = Instance.new("TextLabel")
TextoTitulo.Size = UDim2.new(1, 0, 1, 0)
TextoTitulo.BackgroundTransparency = 1
TextoTitulo.Text = "🖤 Bxl — HUB"
TextoTitulo.TextColor3 = Color3.fromRGB(0, 230, 255)
TextoTitulo.Font = Enum.Font.GothamBold
TextoTitulo.TextSize = 30
TextoTitulo.Parent = Titulo

-- ESTADO
local Estado = Instance.new("TextLabel")
Estado.Size = UDim2.new(0.9, 0, 0, 25)
Estado.Position = UDim2.new(0.05, 0, 0, 75)
Estado.BackgroundTransparency = 1
Estado.Text = "✅ Todo listo — Selecciona una opción"
Estado.TextColor3 = Color3.fromRGB(150, 255, 180)
Estado.Font = Enum.Font.Gotham
Estado.TextSize = 12
Estado.Parent = Main

-- ============== FUNCIÓN BOTÓN ==============
local function Boton(texto, y, color, funcion)
    local Cont = Instance.new("Frame")
    Cont.Size = UDim2.new(0.9, 0, 0, 44)
    Cont.Position = UDim2.new(0.05, 0, 0, y)
    Cont.BackgroundColor3 = Color3.fromRGB(28, 28, 42)
    Cont.CornerRadius = UDim.new(0, 10)
    Cont.Parent = Main

    local BordeBtn = Instance.new("UIStroke")
    BordeBtn.Thickness = 1
    BordeBtn.Color = color
    BordeBtn.Transparency = 0.5
    BordeBtn.Parent = Cont

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = texto
    btn.TextColor3 = Color3.fromRGB(245, 245, 245)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 15
    btn.Parent = Cont

    -- Efecto al pasar el cursor
    btn.MouseEnter:Connect(function()
        TweenService:Create(Cont, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 60)}):Play()
        BordeBtn.Transparency = 0
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(Cont, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(28, 28, 42)}):Play()
        BordeBtn.Transparency = 0.5
    end)

    btn.MouseButton1Click:Connect(funcion)
end

-- ============== BOTONES CON FUNCIÓN ==============
Boton("⚡ Velocidad Rápida", 110, Color3.fromRGB(0, 255, 140), function()
    velocidadExtra = not velocidadExtra
    Estado.Text = velocidadExtra and "⚡ Velocidad MÁXIMA ACTIVADA" or "✅ Velocidad normal"
    Estado.TextColor3 = velocidadExtra and Color3.fromRGB(255, 220, 0) or Color3.fromRGB(150, 255, 180)
end)

Boton("🐢 Modo Lagger", 164, Color3.fromRGB(255, 170, 0), function()
    laggerActivo = not laggerActivo
    Estado.Text = laggerActivo and "🐢 LAGGER ACTIVADO" or "✅ Lagger desactivado"
    Estado.TextColor3 = laggerActivo and Color3.fromRGB(255, 100, 0) or Color3.fromRGB(150, 255, 180)
end)

Boton("🛡️ Anti-Ragdoll", 218, Color3.fromRGB(0, 180, 255), function()
    antiRagdoll = not antiRagdoll
    Estado.Text = antiRagdoll and "🛡️ ANTI-RAGDOLL ON" or "✅ Anti-Ragdoll OFF"
    Estado.TextColor3 = antiRagdoll and Color3.fromRGB(0, 200, 255) or Color3.fromRGB(150, 255, 180)
end)

Boton("🏏 Auto-Bat", 272, Color3.fromRGB(255, 80, 180), function()
    autoBat = not autoBat
    Estado.Text = autoBat and "🏏 AUTO-BAT ACTIVADO" or "✅ Auto-Bat desactivado"
    Estado.TextColor3 = autoBat and Color3.fromRGB(255, 80, 180) or Color3.fromRGB(150, 255, 180)
end)

Boton("⬅️ Auto-Izquierda", 326, Color3.fromRGB(100, 140, 255), function()
    autoIzquierda = not autoIzquierda
    Estado.Text = autoIzquierda and "⬅️ AUTO-IZQUIERDA ON" or "✅ Auto-Izquierda OFF"
    Estado.TextColor3 = autoIzquierda and Color3.fromRGB(100, 140, 255) or Color3.fromRGB(150, 255, 180)
end)

Boton("➡️ Auto-Derecha", 380, Color3.fromRGB(100, 200, 255), function()
    autoDerecha = not autoDerecha
    Estado.Text = autoDerecha and "➡️ AUTO-DERECHA ON" or "✅ Auto-Derecha OFF"
    Estado.TextColor3 = autoDerecha and Color3.fromRGB(100, 200, 255) or Color3.fromRGB(150, 255, 180)
end)

Boton("⬇️ Bajar al Suelo", 434, Color3.fromRGB(160, 80, 255), function()
    local c = LP.Character
    if c and c:FindFirstChild("HumanoidRootPart") then
        c.HumanoidRootPart.CFrame = CFrame.new(c.HumanoidRootPart.Position.X, -50, c.HumanoidRootPart.Position.Z)
        Estado.Text = "⬇️ Teletransportado abajo"
        Estado.TextColor3 = Color3.fromRGB(160, 80, 255)
    end
end)

Boton("👻 Invisible", 488, Color3.fromRGB(180, 180, 180), function()
    invisible = not invisible
    local c = LP.Character
    if c then
        for _, p in pairs(c:GetChildren()) do
            if p:IsA("BasePart") then
                p.Transparency = invisible and 1 or 0
            end
        end
    end
    Estado.Text = invisible and "👻 INVISIBLE ACTIVADO" or "✅ Visible de nuevo"
    Estado.TextColor3 = invisible and Color3.fromRGB(180, 180, 180) or Color3.fromRGB(150, 255, 180)
end)

Boton("❌ Cerrar Menú", 542, Color3.fromRGB(255, 60, 60), function()
    Gui:Destroy()
end)

print("[Bxl] ✅ HUB CARGADO COMPLETO — ¡A JUGAR! 🎮")
