-- ============================================================
-- Bxl — HUB COMPLETO
-- ============================================================
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LP = Players.LocalPlayer

local velocidadRapida = 35
local velocidadActual = 16
local laggerActivo = false

-- BLOQUEAR COLISIÓN CON OTROS
RunService.Stepped:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            for _, parte in pairs(p.Character:GetChildren()) do
                if parte:IsA("BasePart") then parte.CanCollide = false end
            end
        end
    end
end)

-- SISTEMA DE MOVIMIENTO
RunService.RenderStepped:Connect(function()
    local c = LP.Character
    if not c then return end
    local hrp = c:FindFirstChild("HumanoidRootPart")
    local hum = c:FindFirstChild("Humanoid")
    if not hrp or not hum then return end
    
    if laggerActivo then velocidadActual = 8
    else velocidadActual = velocidadRapida end
    
    if hum.MoveDirection.Magnitude > 0 then
        hrp.Velocity = Vector3.new(
            hum.MoveDirection.X * velocidadActual,
            hrp.Velocity.Y,
            hum.MoveDirection.Z * velocidadActual
        )
    end
end)

-- ============================================================
-- MENÚ
-- ============================================================
local Gui = Instance.new("ScreenGui")
Gui.Name = "Bxl_Hub"
Gui.Parent = LP:WaitForChild("PlayerGui")

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 240, 0, 380)
Main.Position = UDim2.new(0.02, 0, 0.1, 0)
Main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Main.BorderSizePixel = 2
Main.BorderColor3 = Color3.fromRGB(70, 70, 70)
Main.Parent = Gui

local Titulo = Instance.new("TextLabel")
Titulo.Size = UDim2.new(1, 0, 0, 50)
Titulo.BackgroundTransparency = 1
Titulo.Text = "🖤 Bxl — HUB"
Titulo.TextColor3 = Color3.fromRGB(255, 255, 255)
Titulo.Font = Enum.Font.GothamBold
Titulo.TextSize = 26
Titulo.Parent = Main

local function Boton(texto, y, funcion)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    btn.Text = texto
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Gotham
    btn.Parent = Main
    btn.MouseButton1Click:Connect(funcion)
end

Boton("⚡ Velocidad Rápida", 70, function() velocidadActual = 35 end)
Boton("🐢 Modo Lagger", 120, function() laggerActivo = not laggerActivo end)
Boton("⬇️ Bajar al Suelo", 170, function()
    local c = LP.Character
    if c and c:FindFirstChild("HumanoidRootPart") then
        c.HumanoidRootPart.CFrame = CFrame.new(c.HumanoidRootPart.Position.X, -50, c.HumanoidRootPart.Position.Z)
    end
end)
Boton("❌ Cerrar", 220, function() Gui:Destroy() end)

print("[Bxl] ✅ Cargado correctamente")
