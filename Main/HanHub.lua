-- 🎣 FISH IT! - HAN HUB FINAL (FULL FUNCTIONAL)
print("[HAN HUB] Loading Fish It! Automation...")

-- ===== ANTI-DUPLICATE =====
if _G.HanHubLoaded then
    print("[HAN HUB] Script already running. Restarting...")
    if _G.AutoCastLoop then _G.AutoCast = false end
    if _G.AutoReelLoop then _G.AutoReel = false end
    if _G.AutoSellLoop then _G.AutoSell = false end
    wait(0.5)
end

_G.HanHubLoaded = true

-- ===== VARIABLES =====
_G.AutoCast = false
_G.AutoReel = false
_G.AutoSell = false
local FishDelay = 1.5
local IsCasting = false

-- ===== HAPUS UI LAMA =====
if game:GetService("CoreGui"):FindFirstChild("HanHubUI") then
    game:GetService("CoreGui").HanHubUI:Destroy()
end

-- ===== FISHING FUNCTIONS =====
local function CastRod()
    local Player = game.Players.LocalPlayer
    if not Player then return end
    
    -- Cari FishingRod
    local Rod = Player.Backpack:FindFirstChild("FishingRod") or 
                Player.Character:FindFirstChild("FishingRod")
    
    if Rod then
        -- Pastikan rod di tangan
        if Rod.Parent == Player.Backpack then
            Rod.Parent = Player.Character
            wait(0.1)
        end
        
        -- Cari event cast
        local events = {
            "CastRod",
            "castRod",
            "Cast",
            "FishingCast",
            "FishCast",
            "BeginFishing"
        }
        
        for _, eventName in pairs(events) do
            local Event = game:GetService("ReplicatedStorage"):FindFirstChild(eventName) or
                         game:GetService("ReplicatedStorage").Remotes:FindFirstChild(eventName) or
                         game:GetService("ReplicatedStorage"):FindFirstChild("Events"):FindFirstChild(eventName)
            
            if Event then
                pcall(function()
                    Event:FireServer()
                    print("[CAST] Rod casted via " .. eventName)
                    IsCasting = true
                    return true
                end)
            end
        end
    else
        print("[ERROR] No FishingRod found!")
    end
    return false
end

local function ReelFish()
    local events = {
        "ReelFish",
        "reelFish",
        "Reel",
        "CatchFish",
        "FishCatch",
        "FinishFishing"
    }
    
    for _, eventName in pairs(events) do
        local Event = game:GetService("ReplicatedStorage"):FindFirstChild(eventName) or
                     game:GetService("ReplicatedStorage").Remotes:FindFirstChild(eventName) or
                     game:GetService("ReplicatedStorage"):FindFirstChild("Events"):FindFirstChild(eventName)
        
        if Event then
            pcall(function()
                Event:FireServer()
                print("[REEL] Fish reeled via " .. eventName)
                IsCasting = false
                return true
            end)
        end
    end
    return false
end

local function SellAllFish()
    local events = {
        "SellFish",
        "sellFish",
        "SellAll",
        "SellAllFish",
        "SellInventory",
        "AutoSell"
    }
    
    for _, eventName in pairs(events) do
        local Event = game:GetService("ReplicatedStorage"):FindFirstChild(eventName) or
                     game:GetService("ReplicatedStorage").Remotes:FindFirstChild(eventName) or
                     game:GetService("ReplicatedStorage"):FindFirstChild("Events"):FindFirstChild(eventName)
        
        if Event then
            pcall(function()
                Event:FireServer()
                print("[SELL] Fish sold via " .. eventName)
                return true
            end)
        end
    end
    return false
end

-- ===== BUAT UI HAN HUB =====
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HanHubUI"
ScreenGui.Parent = game:GetService("CoreGui")

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
AutoCastBtn.Name = "AutoCastBtn"
AutoCastBtn.Text = "Auto Cast Rod [OFF]"
AutoCastBtn.Size = UDim2.new(1, 0, 0, 35)
AutoCastBtn.Position = UDim2.new(0, 0, 0, 40)
AutoCastBtn.BackgroundColor3 = Color3.fromRGB(40, 45, 60)
AutoCastBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
AutoCastBtn.Font = Enum.Font.Gotham
AutoCastBtn.TextSize = 13
AutoCastBtn.Parent = Content

local AutoReelBtn = Instance.new("TextButton")
AutoReelBtn.Name = "AutoReelBtn"
AutoReelBtn.Text = "Auto Reel Fish [OFF]"
AutoReelBtn.Size = UDim2.new(1, 0, 0, 35)
AutoReelBtn.Position = UDim2.new(0, 0, 0, 85)
AutoReelBtn.BackgroundColor3 = Color3.fromRGB(40, 45, 60)
AutoReelBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
AutoReelBtn.Font = Enum.Font.Gotham
AutoReelBtn.TextSize = 13
AutoReelBtn.Parent = Content

-- Manual Fishing Buttons
local CastBtn = Instance.new("TextButton")
CastBtn.Text = "🎣 Cast Once"
CastBtn.Size = UDim2.new(0.48, 0, 0, 30)
CastBtn.Position = UDim2.new(0, 0, 0, 130)
CastBtn.BackgroundColor3 = Color3.fromRGB(50, 100, 200)
CastBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CastBtn.Font = Enum.Font.Gotham
CastBtn.TextSize = 12
CastBtn.Parent = Content

local ReelBtn = Instance.new("TextButton")
ReelBtn.Text = "🐟 Reel Once"
ReelBtn.Size = UDim2.new(0.48, 0, 0, 30)
ReelBtn.Position = UDim2.new(0.52, 0, 0, 130)
ReelBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 50)
ReelBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ReelBtn.Font = Enum.Font.Gotham
ReelBtn.TextSize = 12
ReelBtn.Parent = Content

-- ===== 📦 INVENTORY SECTION =====
local InvHeader = Instance.new("TextLabel")
InvHeader.Text = "📦 INVENTORY & SELLING"
InvHeader.Size = UDim2.new(1, 0, 0, 35)
InvHeader.Position = UDim2.new(0, 0, 0, 175)
InvHeader.BackgroundTransparency = 1
InvHeader.TextColor3 = Color3.fromRGB(255, 180, 0)
InvHeader.Font = Enum.Font.GothamBold
InvHeader.TextSize = 16
InvHeader.TextXAlignment = Enum.TextXAlignment.Left
InvHeader.Parent = Content

local AutoSellBtn = Instance.new("TextButton")
AutoSellBtn.Name = "AutoSellBtn"
AutoSellBtn.Text = "Auto Sell Fish [OFF]"
AutoSellBtn.Size = UDim2.new(1, 0, 0, 35)
AutoSellBtn.Position = UDim2.new(0, 0, 0, 215)
AutoSellBtn.BackgroundColor3 = Color3.fromRGB(40, 45, 60)
AutoSellBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
AutoSellBtn.Font = Enum.Font.Gotham
AutoSellBtn.TextSize = 13
AutoSellBtn.Parent = Content

local SellOnceBtn = Instance.new("TextButton")
SellOnceBtn.Text = "💰 Sell Once"
SellOnceBtn.Size = UDim2.new(1, 0, 0, 30)
SellOnceBtn.Position = UDim2.new(0, 0, 0, 260)
SellOnceBtn.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
SellOnceBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SellOnceBtn.Font = Enum.Font.Gotham
SellOnceBtn.TextSize = 12
SellOnceBtn.Parent = Content

-- ===== ⚙️ SETTINGS SECTION =====
local SettHeader = Instance.new("TextLabel")
SettHeader.Text = "⚙️ SETTINGS"
SettHeader.Size = UDim2.new(1, 0, 0, 35)
SettHeader.Position = UDim2.new(0, 0, 0, 305)
SettHeader.BackgroundTransparency = 1
SettHeader.TextColor3 = Color3.fromRGB(150, 255, 150)
SettHeader.Font = Enum.Font.GothamBold
SettHeader.TextSize = 16
SettHeader.TextXAlignment = Enum.TextXAlignment.Left
SettHeader.Parent = Content

local DelayFrame = Instance.new("Frame")
DelayFrame.Size = UDim2.new(1, 0, 0, 40)
DelayFrame.Position = UDim2.new(0, 0, 0, 345)
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

-- Status Display
local StatusFrame = Instance.new("Frame")
StatusFrame.Size = UDim2.new(1, 0, 0, 40)
StatusFrame.Position = UDim2.new(0, 0, 0, 395)
StatusFrame.BackgroundColor3 = Color3.fromRGB(40, 45, 60)
StatusFrame.Parent = Content

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Name = "StatusLabel"
StatusLabel.Text = "Status: Ready"
StatusLabel.Size = UDim2.new(1, 0, 1, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextColor3 = Color3.fromRGB(200, 255, 200)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 12
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.Parent = StatusFrame

-- ===== FUNGSI MINIMIZE DENGAN LOGO =====
local Minimized = false
local OriginalSize = MainWindow.Size

MinBtn.MouseButton1Click:Connect(function()
    Minimized = not Minimized
    if Minimized then
        MainWindow.Size = UDim2.new(0, 320, 0, 35)
        Title.Visible = false
        LogoFrame.Visible = true
        Content.Visible = false
        MinBtn.Text = "+"
    else
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
    _G.AutoCast = false
    _G.AutoReel = false
    _G.AutoSell = false
    _G.HanHubLoaded = false
    ScreenGui:Destroy()
    print("[HAN HUB] UI closed")
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

-- ===== UPDATE STATUS =====
local function UpdateStatus(text, color)
    StatusLabel.Text = "Status: " .. text
    if color == "green" then
        StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    elseif color == "yellow" then
        StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 100)
    elseif color == "red" then
        StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    else
        StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
    end
end

-- ===== MANUAL FISHING BUTTONS =====
CastBtn.MouseButton1Click:Connect(function()
    UpdateStatus("Casting rod...", "yellow")
    if CastRod() then
        UpdateStatus("Rod casted!", "green")
    else
        UpdateStatus("Failed to cast", "red")
    end
end)

ReelBtn.MouseButton1Click:Connect(function()
    UpdateStatus("Reeling fish...", "yellow")
    if ReelFish() then
        UpdateStatus("Fish reeled!", "green")
    else
        UpdateStatus("Failed to reel", "red")
    end
end)

SellOnceBtn.MouseButton1Click:Connect(function()
    UpdateStatus("Selling fish...", "yellow")
    if SellAllFish() then
        UpdateStatus("Fish sold!", "green")
    else
        UpdateStatus("Failed to sell", "red")
    end
end)

-- ===== AUTO CAST =====
AutoCastBtn.MouseButton1Click:Connect(function()
    _G.AutoCast = not _G.AutoCast
    if _G.AutoCast then
        AutoCastBtn.Text = "Auto Cast Rod [ON]"
        AutoCastBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
        UpdateStatus("Auto Cast: ON", "green")
        
        _G.AutoCastLoop = true
        spawn(function()
            while _G.AutoCast and _G.AutoCastLoop do
                UpdateStatus("Casting...", "yellow")
                CastRod()
                wait(FishDelay)
                
                -- Auto reel jika perlu
                if _G.AutoReel then
                    wait(0.5)
                    ReelFish()
                end
            end
        end)
    else
        _G.AutoCastLoop = false
        AutoCastBtn.Text = "Auto Cast Rod [OFF]"
        AutoCastBtn.BackgroundColor3 = Color3.fromRGB(40, 45, 60)
        UpdateStatus("Auto Cast: OFF", "red")
    end
end)

-- ===== AUTO REEL =====
AutoReelBtn.MouseButton1Click:Connect(function()
    _G.AutoReel = not _G.AutoReel
    if _G.AutoReel then
        AutoReelBtn.Text = "Auto Reel Fish [ON]"
        AutoReelBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
        UpdateStatus("Auto Reel: ON", "green")
        
        _G.AutoReelLoop = true
        spawn(function()
            while _G.AutoReel and _G.AutoReelLoop do
                wait(0.5)
                if IsCasting then
                    UpdateStatus("Reeling...", "yellow")
                    ReelFish()
                    wait(1) -- Delay setelah reel
                end
            end
        end)
    else
        _G.AutoReelLoop = false
        AutoReelBtn.Text = "Auto Reel Fish [OFF]"
        AutoReelBtn.BackgroundColor3 = Color3.fromRGB(40, 45, 60)
        UpdateStatus("Auto Reel: OFF", "red")
    end
end)

-- ===== AUTO SELL =====
AutoSellBtn.MouseButton1Click:Connect(function()
    _G.AutoSell = not _G.AutoSell
    if _G.AutoSell then
        AutoSellBtn.Text = "Auto Sell Fish [ON]"
        AutoSellBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
        UpdateStatus("Auto Sell: ON", "green")
        
        _G.AutoSellLoop = true
        spawn(function()
            while _G.AutoSell and _G.AutoSellLoop do
                wait(5) -- Sell setiap 5 detik
                UpdateStatus("Selling fish...", "yellow")
                SellAllFish()
                UpdateStatus("Auto Sell active", "green")
            end
        end)
    else
        _G.AutoSellLoop = false
        AutoSellBtn.Text = "Auto Sell Fish [OFF]"
        AutoSellBtn.BackgroundColor3 = Color3.fromRGB(40, 45, 60)
        UpdateStatus("Auto Sell: OFF", "red")
    end
end)

-- ===== DELAY SETTINGS =====
DelayPlus.MouseButton1Click:Connect(function()
    FishDelay = FishDelay + 0.5
    if FishDelay > 5 then FishDelay = 5 end
    DelayLabel.Text = "Action Delay: " .. FishDelay .. "s"
    UpdateStatus("Delay: " .. FishDelay .. "s", "yellow")
end)

DelayMinus.MouseButton1Click:Connect(function()
    FishDelay = FishDelay - 0.5
    if FishDelay < 0.5 then FishDelay = 0.5 end
    DelayLabel.Text = "Action Delay: " .. FishDelay .. "s"
    UpdateStatus("Delay: " .. FishDelay .. "s", "yellow")
end)

-- ===== HOTKEYS =====
game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.F then
        CastRod()
    elseif input.KeyCode == Enum.KeyCode.R then
        ReelFish()
    elseif input.KeyCode == Enum.KeyCode.S then
        SellAllFish()
    end
end)

-- ===== NOTIFICATION AWAL =====
game:GetService("StarterGui"):SetCore("SendNotification",{
    Title = "🎣 HAN HUB",
    Text = "UI Loaded! Press F=Cast, R=Reel, S=Sell",
    Duration = 5
})

-- Anti-AFK
local VirtualUser = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

-- Auto update status
spawn(function()
    while wait(1) do
        if _G.AutoCast then
            UpdateStatus("Auto Fishing Active", "green")
        elseif _G.AutoReel then
            UpdateStatus("Auto Reel Active", "green")
        elseif _G.AutoSell then
            UpdateStatus("Auto Sell Active", "green")
        else
            UpdateStatus("Ready", "yellow")
        end
    end
end)

print("[HAN HUB] UI loaded successfully!")
print("[CONTROLS] F = Cast | R = Reel | S = Sell")
print("[FEATURES] Auto Cast | Auto Reel | Auto Sell | Manual Controls")

return ScreenGui
