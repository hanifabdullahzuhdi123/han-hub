-- 🎣 FISH IT! - HAN HUB FINAL
print("[HAN HUB] Loading Fish It! Automation...")

-- ===== VARIABLES =====
local AutoCast = false
local AutoReel = false
local AutoSell = false
local FishDelay = 1.5

-- ===== HAPUS UI LAMA =====
if game:GetService("CoreGui"):FindFirstChild("HanHubUI") then
    game:GetService("CoreGui").HanHubUI:Destroy()
end

-- ===== BUAT UI HAN HUB =====
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HanHubUI"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Window
local MainWindow = Instance.new("Frame")
MainWindow.Name = "MainWindow"
MainWindow.Size = UDim2.new(0, 320, 0, 450)
MainWindow.Position = UDim2.new(0.05, 0, 0.3, 0)
MainWindow.BackgroundColor3 = Color3.fromRGB(20, 25, 35)
MainWindow.BackgroundTransparency = 0.1
MainWindow.BorderSizePixel = 0
MainWindow.Parent = ScreenGui

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BackgroundColor3 = Color3.fromRGB(30, 35, 50)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainWindow

-- LOGO HAN HUB (Untuk Minimized Mode)
local LogoFrame = Instance.new("Frame")
LogoFrame.Name = "LogoFrame"
LogoFrame.Size = UDim2.new(0, 28, 0, 28)
LogoFrame.Position = UDim2.new(0, 8, 0, 3)
LogoFrame.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
LogoFrame.Visible = false
LogoFrame.Parent = TopBar

local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(0, 6)
LogoCorner.Parent = LogoFrame

local LogoText = Instance.new("TextLabel")
LogoText.Text = "H"
LogoText.Size = UDim2.new(1, 0, 1, 0)
LogoText.BackgroundTransparency = 1
LogoText.TextColor3 = Color3.fromRGB(255, 255, 255)
LogoText.Font = Enum.Font.GothamBlack
LogoText.TextSize = 16
LogoText.Parent = LogoFrame

-- Title
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Text = "🎣 FISH IT! | HAN HUB"
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(0, 200, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

-- Minimize Button
local MinBtn = Instance.new("TextButton")
MinBtn.Text = "_"
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -65, 0, 2)
MinBtn.BackgroundColor3 = Color3.fromRGB(50, 55, 70)
MinBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 16
MinBtn.Parent = TopBar

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Text = "✕"
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -30, 0, 2)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
CloseBtn.Parent = TopBar

-- Content Area
local Content = Instance.new("ScrollingFrame")
Content.Name = "Content"
Content.Size = UDim2.new(1, -10, 1, -45)
Content.Position = UDim2.new(0, 5, 0, 40)
Content.BackgroundTransparency = 1
Content.ScrollBarThickness = 4
Content.CanvasSize = UDim2.new(0, 0, 0, 600)
Content.Parent = MainWindow

-- ===== 🎣 FISHING SECTION =====
local FishingHeader = Instance.new("TextLabel")
FishingHeader.Text = "🎣 FISHING AUTOMATION"
FishingHeader.Size = UDim2.new(1, 0, 0, 35)
FishingHeader.BackgroundTransparency = 1
FishingHeader.TextColor3 = Color3.fromRGB(0, 180, 255)
FishingHeader.Font = Enum.Font.GothamBold
FishingHeader.TextSize = 16
FishingHeader.TextXAlignment = Enum.TextXAlignment.Left
FishingHeader.Parent = Content

local AutoCastBtn = Instance.new("TextButton")
AutoCastBtn.Text = "Auto Cast Rod [OFF]"
AutoCastBtn.Size = UDim2.new(1, 0, 0, 35)
AutoCastBtn.Position = UDim2.new(0, 0, 0, 40)
AutoCastBtn.BackgroundColor3 = Color3.fromRGB(40, 45, 60)
AutoCastBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
AutoCastBtn.Font = Enum.Font.Gotham
AutoCastBtn.TextSize = 13
AutoCastBtn.Parent = Content

local AutoReelBtn = Instance.new("TextButton")
AutoReelBtn.Text = "Auto Reel Fish [OFF]"
AutoReelBtn.Size = UDim2.new(1, 0, 0, 35)
AutoReelBtn.Position = UDim2.new(0, 0, 0, 85)
AutoReelBtn.BackgroundColor3 = Color3.fromRGB(40, 45, 60)
AutoReelBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
AutoReelBtn.Font = Enum.Font.Gotham
AutoReelBtn.TextSize = 13
AutoReelBtn.Parent = Content

-- ===== 📦 INVENTORY SECTION =====
local InvHeader = Instance.new("TextLabel")
InvHeader.Text = "📦 INVENTORY & SELLING"
InvHeader.Size = UDim2.new(1, 0, 0, 35)
InvHeader.Position = UDim2.new(0, 0, 0, 135)
InvHeader.BackgroundTransparency = 1
InvHeader.TextColor3 = Color3.fromRGB(255, 180, 0)
InvHeader.Font = Enum.Font.GothamBold
InvHeader.TextSize = 16
InvHeader.TextXAlignment = Enum.TextXAlignment.Left
InvHeader.Parent = Content

local AutoSellBtn = Instance.new("TextButton")
AutoSellBtn.Text = "Auto Sell Fish [OFF]"
AutoSellBtn.Size = UDim2.new(1, 0, 0, 35)
AutoSellBtn.Position = UDim2.new(0, 0, 0, 175)
AutoSellBtn.BackgroundColor3 = Color3.fromRGB(40, 45, 60)
AutoSellBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
AutoSellBtn.Font = Enum.Font.Gotham
AutoSellBtn.TextSize = 13
AutoSellBtn.Parent = Content

-- ===== ⚙️ SETTINGS SECTION =====
local SettHeader = Instance.new("TextLabel")
SettHeader.Text = "⚙️ SETTINGS"
SettHeader.Size = UDim2.new(1, 0, 0, 35)
SettHeader.Position = UDim2.new(0, 0, 0, 225)
SettHeader.BackgroundTransparency = 1
SettHeader.TextColor3 = Color3.fromRGB(150, 255, 150)
SettHeader.Font = Enum.Font.GothamBold
SettHeader.TextSize = 16
SettHeader.TextXAlignment = Enum.TextXAlignment.Left
SettHeader.Parent = Content

local DelayFrame = Instance.new("Frame")
DelayFrame.Size = UDim2.new(1, 0, 0, 40)
DelayFrame.Position = UDim2.new(0, 0, 0, 265)
DelayFrame.BackgroundColor3 = Color3.fromRGB(35, 40, 55)
DelayFrame.Parent = Content

local DelayLabel = Instance.new("TextLabel")
DelayLabel.Text = "Action Delay: 1.5s"
DelayLabel.Size = UDim2.new(0.7, 0, 1, 0)
DelayLabel.BackgroundTransparency = 1
DelayLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
DelayLabel.Font = Enum.Font.Gotham
DelayLabel.TextSize = 13
DelayLabel.TextXAlignment = Enum.TextXAlignment.Left
DelayLabel.Parent = DelayFrame

local DelayPlus = Instance.new("TextButton")
DelayPlus.Text = "+"
DelayPlus.Size = UDim2.new(0.12, 0, 0.7, 0)
DelayPlus.Position = UDim2.new(0.85, 0, 0.15, 0)
DelayPlus.BackgroundColor3 = Color3.fromRGB(60, 65, 80)
DelayPlus.TextColor3 = Color3.fromRGB(255, 255, 255)
DelayPlus.Font = Enum.Font.GothamBold
DelayPlus.TextSize = 14
DelayPlus.Parent = DelayFrame

local DelayMinus = Instance.new("TextButton")
DelayMinus.Text = "-"
DelayMinus.Size = UDim2.new(0.12, 0, 0.7, 0)
DelayMinus.Position = UDim2.new(0.73, 0, 0.15, 0)
DelayMinus.BackgroundColor3 = Color3.fromRGB(60, 65, 80)
DelayMinus.TextColor3 = Color3.fromRGB(255, 255, 255)
DelayMinus.Font = Enum.Font.GothamBold
DelayMinus.TextSize = 14
DelayMinus.Parent = DelayFrame

-- ===== ⚠️ INFO SECTION =====
local InfoHeader = Instance.new("TextLabel")
InfoHeader.Text = "⚠️ HAN HUB INFORMATION"
InfoHeader.Size = UDim2.new(1, 0, 0, 35)
InfoHeader.Position = UDim2.new(0, 0, 0, 320)
InfoHeader.BackgroundTransparency = 1
InfoHeader.TextColor3 = Color3.fromRGB(255, 100, 100)
InfoHeader.Font = Enum.Font.GothamBold
InfoHeader.TextSize = 14
InfoHeader.TextXAlignment = Enum.TextXAlignment.Left
InfoHeader.Parent = Content

local InfoText = Instance.new("TextLabel")
InfoText.Text = "HAN HUB v2.1\nMade for Fish It!\nUse at your own risk!"
InfoText.Size = UDim2.new(1, 0, 0, 60)
InfoText.Position = UDim2.new(0, 0, 0, 360)
InfoText.BackgroundTransparency = 1
InfoText.TextColor3 = Color3.fromRGB(200, 200, 200)
InfoText.Font = Enum.Font.Gotham
InfoText.TextSize = 12
InfoText.TextYAlignment = Enum.TextYAlignment.Top
InfoText.Parent = Content

-- ===== FUNGSI MINIMIZE DENGAN LOGO =====
local Minimized = false
local OriginalSize = MainWindow.Size

MinBtn.MouseButton1Click:Connect(function()
    Minimized = not Minimized
    if Minimized then
        -- MODE MINIMIZED: Tampilkan logo, sembunyikan konten
        MainWindow.Size = UDim2.new(0, 320, 0, 35)
        Title.Visible = false
        LogoFrame.Visible = true
        Content.Visible = false
        MinBtn.Text = "+"
    else
        -- MODE NORMAL: Tampilkan full UI
        MainWindow.Size = OriginalSize
        Title.Visible = true
        LogoFrame.Visible = false
        Content.Visible = true
        Title.Text = "🎣 FISH IT! | HAN HUB"
        MinBtn.Text = "_"
    end
end)

-- ===== FUNGSI CLOSE =====
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- ===== FUNGSI DRAGGABLE =====
local Dragging = false
local DragInput, DragStart, StartPos

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging = true
        DragStart = input.Position
        StartPos = MainWindow.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                Dragging = false
            end
        end)
    end
end)

TopBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        DragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == DragInput and Dragging then
        local Delta = input.Position - DragStart
        MainWindow.Position = UDim2.new(
            StartPos.X.Scale, StartPos.X.Offset + Delta.X,
            StartPos.Y.Scale, StartPos.Y.Offset + Delta.Y
        )
    end
end)

-- ===== FUNGSI AUTO FISHING =====
AutoCastBtn.MouseButton1Click:Connect(function()
    AutoCast = not AutoCast
    if AutoCast then
        AutoCastBtn.Text = "Auto Cast Rod [ON]"
        AutoCastBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
        spawn(function()
            while AutoCast do
                wait(FishDelay)
                local Player = game.Players.LocalPlayer
                local Rod = Player.Backpack:FindFirstChild("FishingRod") or 
                           Player.Character:FindFirstChild("FishingRod")
                if Rod and Rod.Parent == Player.Backpack then
                    Rod.Parent = Player.Character
                end
                local Event = game:GetService("ReplicatedStorage"):FindFirstChild("CastRod")
                if Event then Event:FireServer() end
            end
        end)
    else
        AutoCastBtn.Text = "Auto Cast Rod [OFF]"
        AutoCastBtn.BackgroundColor3 = Color3.fromRGB(40, 45, 60)
    end
end)

AutoReelBtn.MouseButton1Click:Connect(function()
    AutoReel = not AutoReel
    if AutoReel then
        AutoReelBtn.Text = "Auto Reel Fish [ON]"
        AutoReelBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
        spawn(function()
            while AutoReel do
                wait(FishDelay)
                local Event = game:GetService("ReplicatedStorage"):FindFirstChild("ReelFish")
                if Event then pcall(function() Event:FireServer() end) end
            end
        end)
    else
        AutoReelBtn.Text = "Auto Reel Fish [OFF]"
        AutoReelBtn.BackgroundColor3 = Color3.fromRGB(40, 45, 60)
    end
end)

AutoSellBtn.MouseButton1Click:Connect(function()
    AutoSell = not AutoSell
    if AutoSell then
        AutoSellBtn.Text = "Auto Sell Fish [ON]"
        AutoSellBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
        spawn(function()
            while AutoSell do
                wait(5)
                local Event = game:GetService("ReplicatedStorage"):FindFirstChild("SellFish")
                if Event then pcall(function() Event:FireServer() end) end
            end
        end)
    else
        AutoSellBtn.Text = "Auto Sell Fish [OFF]"
        AutoSellBtn.BackgroundColor3 = Color3.fromRGB(40, 45, 60)
    end
end)

-- ===== FUNGSI DELAY SETTINGS =====
DelayPlus.MouseButton1Click:Connect(function()
    FishDelay = FishDelay + 0.5
    if FishDelay > 5 then FishDelay = 5 end
    DelayLabel.Text = "Action Delay: " .. FishDelay .. "s"
end)

DelayMinus.MouseButton1Click:Connect(function()
    FishDelay = FishDelay - 0.5
    if FishDelay < 0.5 then FishDelay = 0.5 end
    DelayLabel.Text = "Action Delay: " .. FishDelay .. "s"
end)

-- ===== NOTIFICATION AWAL =====
game:GetService("StarterGui"):SetCore("SendNotification",{
    Title = "🎣 HAN HUB",
    Text = "UI Loaded! Drag to move, _ to minimize",
    Duration = 5
})

-- Anti-AFK
local VirtualUser = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

print("[HAN HUB] UI loaded successfully!")
return ScreenGui
