-- سكريبت النرد المضمون والجاهز للتشغيل في Delta
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- إزالة أي نسخة قديمة لمنع التعارض
if playerGui:FindFirstChild("SimpleDiceUI") then
    playerGui.SimpleDiceUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SimpleDiceUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = playerGui

-- نافذة التحكم الرئيسية (قابلة للسحب)
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 260, 0, 220)
Frame.Position = UDim2.new(0.5, -130, 0.4, -110)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

local Corner = Instance.new("UICorner", Frame)
Corner.CornerRadius = UDim.new(0, 10)

-- عنوان القائمة
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.Text = "🎲 LUCK DICE SYSTEM"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 15
Title.Parent = Frame

-- زر الإغلاق
local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0, 25, 0, 25)
Close.Position = UDim2.new(1, -30, 0, 5)
Close.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
Close.Font = Enum.Font.GothamBold
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255, 255, 255)
Close.TextSize = 12
Close.Parent = Frame
Instance.new("UICorner", Close).CornerRadius = UDim.new(0, 5)
Close.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- مربعات النرد الأربعة (تبدأ بلون رمادي)
local Colors = {
    Color3.fromRGB(0, 85, 255),   -- أزرق
    Color3.fromRGB(230, 40, 40),  -- أحمر
    Color3.fromRGB(255, 140, 0),  -- برتقالي
    Color3.fromRGB(40, 180, 80)   -- أخضر
}

local Boxes = {}
local Positions = {15, 80, 145, 210}

for i = 1, 4 do
    local Box = Instance.new("Frame")
    Box.Size = UDim2.new(0, 35, 0, 35)
    Box.Position = UDim2.new(0, Positions[i], 0, 50)
    Box.BackgroundColor3 = Color3.fromRGB(80, 80, 90) -- رمادي بالبداية
    Box.BorderSizePixel = 0
    Box.Parent = Frame
    Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 6)
    Boxes[i] = Box
end

-- زر الفوز المضمون
local Rigged = false
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0.88, 0, 0, 35)
ToggleBtn.Position = UDim2.new(0.06, 0, 0, 105)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40) -- أحمر (حظ عادي)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.Text = "Mode: Normal Luck (Click to Rig)"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 11
ToggleBtn.Parent = Frame
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 6)

ToggleBtn.MouseButton1Click:Connect(function()
    Rigged = not Rigged
    if Rigged then
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 180, 40) -- أخضر (فوز مضمون)
        ToggleBtn.Text = "Mode: JACKPOT WIN (All Match!)"
    else
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
        ToggleBtn.Text = "Mode: Normal Luck (Click to Rig)"
    end
end)

-- زر الرول الكبير
local RollBtn = Instance.new("TextButton")
RollBtn.Size = UDim2.new(0.88, 0, 0, 45)
RollBtn.Position = UDim2.new(0.06, 0, 0, 150)
RollBtn.BackgroundColor3 = Color3.fromRGB(255, 204, 0)
RollBtn.Font = Enum.Font.GothamBold
RollBtn.Text = "ROLL AGAIN !"
RollBtn.TextColor3 = Color3.fromRGB(30, 30, 30)
RollBtn.TextSize = 16
RollBtn.Parent = Frame
Instance.new("UICorner", RollBtn).CornerRadius = UDim.new(0, 8)

-- تنفيذ الرول
local rolling = false
RollBtn.MouseButton1Click:Connect(function()
    if rolling then return end
    rolling = true
    
    -- اهتزاز سريع للألوان للحماس
    for step = 1, 5 do
        for i = 1, 4 do
            Boxes[i].BackgroundColor3 = Colors[math.random(1, #Colors)]
        end
        task.wait(0.05)
    end
    
    -- النتيجة النهائية
    if Rigged then
        -- فوز مضمون (كل المربعات نفس اللون)
        local winColor = Colors[math.random(1, #Colors)]
        for i = 1, 4 do
            Boxes[i].BackgroundColor3 = winColor
        end
    else
        -- حظ عشوائي
        for i = 1, 4 do
            Boxes[i].BackgroundColor3 = Colors[math.random(1, #Colors)]
        end
    end
    
    rolling = false
end)
