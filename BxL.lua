-- ============================================================
-- BXL — MENÚ VISIBLE 💜
-- ============================================================
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LP = Players.LocalPlayer

-- VARIABLES
local velocidadExtra = false
local laggerActivo = false
local invisible = false

-- SISTEMA DE VELOCIDAD
RunService.RenderStepped:Connect(function()
    local c = LP.Character
    if not c then return end
    local hrp = c:FindFirstChild("HumanoidRootPart")
    local hum = c:FindFirstChild("Humanoid")
    if not hrp or not hum then return end

    local vel = 16
    if velocidadExtra then vel = 55 end
    if laggerActivo then vel = 5 end

    if hum.MoveDirection.Magnitude > 0 then
        hrp.Velocity = hum.MoveDirection * vel
    end
end)

-- CREAR MENÚ
local Gui = Instance.new("ScreenGui")
Gui.Name = "Bxl_Menu"
Gui.Parent = LP:WaitForChild("PlayerGui")
Gui.ResetOnSpawn = false

-- FONDO PRINCIPAL
local Fondo = Instance.new("Frame")
Fondo.Size = UDim2.new(0, 240, 0, 420)
Fondo.Position = UDim2.new(0.02, 0, 0.05, 0)
Fondo.BackgroundColor3 = Color3.fromRGB(20, 15, 35)
Fondo.BorderSizePixel = 0
Fondo.CornerRadius = UDim.new(0, 16)
Fondo.Parent = Gui

-- TÍTULO
local Titulo = Instance.new("TextLabel")
Titulo.Size = UDim2.new(1, 0, 0, 70)
Titulo.Position = UDim2.new(0, 0, 0, 0)
Titulo.BackgroundColor3 = Color3.fromRGB(50, 25, 110)
Titulo.Text = "💜 BXL — HUB"
Titulo.TextColor3 = Color3.fromRGB(255, 255, 255)
Titulo.Font = Enum.Font.GothamBold
Titulo.TextSize = 26
Titulo.CornerRadius = UDim.new(0, 16)
Titulo.Parent = Fondo

-- FUNCIÓN BOTÓN
local function Boton(texto, posY, color, funcion)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.85, 0, 0, 55)
    btn.Position = UDim2.new(0.075, 0, 0, posY)
    btn.BackgroundColor3 = color
    btn.Text = texto
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16
    btn.CornerRadius = UDim.new(0, 12)
    btn.AutoLocalize = false
    btn.Parent = Fondo

    btn.MouseButton1Click:Connect(funcion)
end

-- BOTONES
Boton("⚡ VELOCIDAD", 85, Color3.fromRGB(90, 30, 180), function()
    velocidadExtra = not velocidadExtra
end)

Boton("🐢 LAG MODE", 150, Color3.fromRGB(110, 40, 200), function()
    laggerActivo = not laggerActivo
end)

Boton("⬇️ BAJAR", 215, Color3.fromRGB(80, 25, 160), function()
    local c = LP.Character
    if c and c:FindFirstChild("HumanoidRootPart") then
        c.HumanoidRootPart.CFrame = CFrame.new(c.HumanoidRootPart.Position.X, -50, c.HumanoidRootPart.Position.Z)
    end
end)

Boton("👻 INVISIBLE", 280, Color3.fromRGB(70, 70, 140), function()
    invisible = not invisible
    local c = LP.Character
    if c then
        for _, p in pairs(c:GetChildren()) do
            if p:IsA("BasePart") then p.Transparency = invisible and 1 or 0 end
        end
    end
end)

Boton("❌ CERRAR", 345, Color3.fromRGB(160, 30, 80), function()
    Gui:Destroy()
end)

print("[BXL] ✅ MENÚ CARGADO 💜")
