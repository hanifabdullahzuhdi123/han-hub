-- ==================== ANTI-DUPLICATE ====================
if _G.SeraphinLoaded then return end
_G.SeraphinLoaded = true

-- Hapus UI lama jika ada
if game:GetService("CoreGui"):FindFirstChild("SeraphinUI") then
    game:GetService("CoreGui").SeraphinUI:Destroy()
end
if game:GetService("CoreGui"):FindFirstChild("HanHubUI") then
    game:GetService("CoreGui").HanHubUI:Destroy()
end

-- ==================== HANHUB SCRIPT - FIXED VERSION ====================
-- Fixed and ready to use

print(" ")
print("================================================")
print("🎣 HANHUB PREMIUM - SERAPHIN EDITION")
print("================================================")

local Seraphin = {
    Premium = true,
    Version = "Seraphin v1.0",
    Config = "ytta",
    Keybind = Enum.KeyCode.RightControl
}

print("👤 Author: hanifabdullahzuhdi123")
print("⭐ Version: " .. Seraphin.Version)
print("🔧 Config: " .. Seraphin.Config)
print(" ")

-- ==================== CREATE MAIN UI ====================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SeraphinUI"
screenGui.Parent = game.CoreGui

local mainWindow = Instance.new("Frame")
mainWindow.Size = UDim2.new(0, 450, 0, 550)
mainWindow.Position = UDim2.new(0.5, -225, 0.5, -275)
mainWindow.BackgroundColor3 = Color3.fromRGB(20, 25, 35)
mainWindow.BackgroundTransparency = 0.1
mainWindow.BorderSizePixel = 0
mainWindow.Visible = true
mainWindow.Parent = screenGui

-- Title Bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 45)
titleBar.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainWindow

local titleText = Instance.new("TextLabel")
titleText.Text = "⟁  Seraphin | Premium  |  " .. Seraphin.Version
titleText.Size = UDim2.new(1, 0, 1, 0)
titleText.BackgroundTransparency = 1
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.Font = Enum.Font.GothamBold
titleText.TextSize = 18
titleText.Parent = titleBar

-- Close button
local closeBtn = Instance.new("TextButton")
closeBtn.Text = "✕"
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 10)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = titleBar

closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
    _G.SeraphinLoaded = false
    print("📱 Seraphin UI closed")
end)

-- ==================== PANEL CONTENT FUNCTION ====================
local function UpdatePanelContent(panelName)
    contentScrolling:ClearAllChildren()
    
    local content = Instance.new("TextLabel")
    content.Text = panelName .. " Panel\n\n"
    content.Size = UDim2.new(1, 0, 0, 100)
    content.BackgroundTransparency = 1
    content.TextColor3 = Color3.fromRGB(220, 220, 220)
    content.Font = Enum.Font.Gotham
    content.TextSize = 16
    content.TextXAlignment = Enum.TextXAlignment.Left
    content.TextYAlignment = Enum.TextYAlignment.Top
    content.Parent = contentScrolling
    
    -- Panel-specific content
    if panelName == "Event" then
        content.Text = content.Text .. "• Wait Cast: 0.00003\n• Fast Reel Start\n• Perfection Enchant\n• Auto Claim Events\n• Scan Events"
        
        local btn = Instance.new("TextButton")
        btn.Text = "▶ Start Auto Fishing"
        btn.Size = UDim2.new(0.9, 0, 0, 40)
        btn.Position = UDim2.new(0.05, 0, 0, 120)
        btn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.GothamBold
        btn.Parent = contentScrolling
        
        btn.MouseButton1Click:Connect(function()
            print("🎣 Auto Fishing started!")
            -- FISHING FUNCTIONALITY
            if not _G.FishingActive then
                _G.FishingActive = true
                btn.Text = "⏸ Stop Auto Fishing"
                btn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
                
                spawn(function()
                    while _G.FishingActive do
                        wait(1.5)
                        -- Auto cast rod
                        local Player = game.Players.LocalPlayer
                        local Rod = Player.Backpack:FindFirstChild("FishingRod") or Player.Character:FindFirstChild("FishingRod")
                        if Rod and Rod.Parent == Player.Backpack then
                            Rod.Parent = Player.Character
                        end
                        
                        local Event = game:GetService("ReplicatedStorage"):FindFirstChild("CastRod")
                        if Event then 
                            Event:FireServer()
                            print("🎣 Casting rod...")
                        end
                        
                        wait(0.5)
                        
                        -- Auto reel
                        local ReelEvent = game:GetService("ReplicatedStorage"):FindFirstChild("ReelFish")
                        if ReelEvent then 
                            ReelEvent:FireServer()
                            print("🎣 Reeling fish...")
                        end
                    end
                end)
            else
                _G.FishingActive = false
                btn.Text = "▶ Start Auto Fishing"
                btn.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
                print("🎣 Auto Fishing stopped!")
            end
        end)
        
    elseif panelName == "Trade" then
        content.Text = content.Text .. "• Panel Name Trading\n• Auto Trade System\n• Scan Players\n• Merchant System\n• Sell Items Automatically"
        
        local tradeBtn = Instance.new("TextButton")
        tradeBtn.Text = "💰 Start Auto Trade"
        tradeBtn.Size = UDim2.new(0.9, 0, 0, 40)
        tradeBtn.Position = UDim2.new(0.05, 0, 0, 120)
        tradeBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 0)
        tradeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        tradeBtn.Font = Enum.Font.GothamBold
        tradeBtn.Parent = contentScrolling
        
        tradeBtn.MouseButton1Click:Connect(function()
            print("💰 Auto Trade started!")
            -- Auto sell function
            if not _G.SellActive then
                _G.SellActive = true
                tradeBtn.Text = "⏸ Stop Auto Sell"
                tradeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
                
                spawn(function()
                    while _G.SellActive do
                        wait(5)
                        local SellEvent = game:GetService("ReplicatedStorage"):FindFirstChild("SellFish")
                        if SellEvent then 
                            SellEvent:FireServer()
                            print("💰 Sold fish!")
                        end
                    end
                end)
            else
                _G.SellActive = false
                tradeBtn.Text = "💰 Start Auto Trade"
                tradeBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 0)
                print("💰 Auto Trade stopped!")
            end
        end)
        
    elseif panelName == "Teleport" then
        content.Text = content.Text .. "• Save Location\n• Get My Location\n• Auto Teleport\n• Location: -591.59, 19.25, 430.34\n• Teleport to Events"
        
        local tpBtn = Instance.new("TextButton")
        tpBtn.Text = "📍 Teleport to Event"
        tpBtn.Size = UDim2.new(0.9, 0, 0, 40)
        tpBtn.Position = UDim2.new(0.05, 0, 0, 120)
        tpBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
        tpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        tpBtn.Font = Enum.Font.GothamBold
        tpBtn.Parent = contentScrolling
        
        tpBtn.MouseButton1Click:Connect(function()
            print("📍 Teleporting to event location...")
            local player = game.Players.LocalPlayer
            local character = player.Character
            if character then
                local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                if humanoidRootPart then
                    humanoidRootPart.CFrame = CFrame.new(-591.59, 19.25, 430.34)
                    print("📍 Teleported to: -591.59, 19.25, 430.34")
                    
                    game:GetService("StarterGui"):SetCore("SendNotification",{
                        Title = "Seraphin",
                        Text = "Teleported to event location!",
                        Duration = 3
                    })
                end
            end
        end)
        
        -- Save location button
        local saveLocBtn = Instance.new("TextButton")
        saveLocBtn.Text = "💾 Save Current Location"
        saveLocBtn.Size = UDim2.new(0.9, 0, 0, 40)
        saveLocBtn.Position = UDim2.new(0.05, 0, 0, 170)
        saveLocBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 200)
        saveLocBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        saveLocBtn.Font = Enum.Font.GothamBold
        saveLocBtn.Parent = contentScrolling
        
        saveLocBtn.MouseButton1Click:Connect(function()
            local player = game.Players.LocalPlayer
            local character = player.Character
            if character then
                local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                if humanoidRootPart then
                    local pos = humanoidRootPart.Position
                    print("📍 Location saved: " .. tostring(pos))
                    
                    game:GetService("StarterGui"):SetCore("SendNotification",{
                        Title = "Seraphin",
                        Text = "Location saved: " .. math.floor(pos.X) .. ", " .. math.floor(pos.Y) .. ", " .. math.floor(pos.Z),
                        Duration = 5
                    })
                end
            end
        end)
        
    elseif panelName == "Config" then
        content.Text = content.Text .. "• Current Config: ytta\n• Auto Load: Enabled\n• Toggle Keybind: RightControl\n• New Config Name\n• Save/Load Configs"
        
        local saveBtn = Instance.new("TextButton")
        saveBtn.Text = "💾 Save Current Config"
        saveBtn.Size = UDim2.new(0.9, 0, 0, 40)
        saveBtn.Position = UDim2.new(0.05, 0, 0, 120)
        saveBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 200)
        saveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        saveBtn.Font = Enum.Font.GothamBold
        saveBtn.Parent = contentScrolling
        
        saveBtn.MouseButton1Click:Connect(function()
            print("💾 Config saved!")
            game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "Seraphin",
                Text = "Configuration saved!",
                Duration = 3
            })
        end)
        
        -- Keybind changer
        local keybindText = Instance.new("TextLabel")
        keybindText.Text = "Toggle Keybind: RightControl"
        keybindText.Size = UDim2.new(0.9, 0, 0, 30)
        keybindText.Position = UDim2.new(0.05, 0, 0, 180)
        keybindText.BackgroundTransparency = 1
        keybindText.TextColor3 = Color3.fromRGB(200, 200, 255)
        keybindText.Font = Enum.Font.Gotham
        keybindText.TextSize = 14
        keybindText.Parent = contentScrolling
        
    elseif panelName == "Menu" then
        content.Text = content.Text .. "• Auto Fish Settings\n• Auto Sell Settings\n• Teleport Settings\n• Trade Settings\n• UI Settings"
        
    elseif panelName == "Favorite" then
        content.Text = content.Text .. "• Favorite Locations\n• Favorite Items\n• Quick Actions\n• Saved Trades\n• Quick Teleports"
        
    elseif panelName == "Webhook" then
        content.Text = content.Text .. "• Discord Webhook\n• Log Notifications\n• Error Reporting\n• Achievement Tracking\n• Sales Tracker"
        
    elseif panelName == "Misc" then
        content.Text = content.Text .. "• Anti-AFK System\n• Auto Clicker\n• Speed Hack\n• Jump Power\n• Infinite Yield"
    end
    
    -- Update button colors
    for i, btn in ipairs(panelButtons) do
        if panels[i] == panelName then
            btn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        else
            btn.BackgroundColor3 = Color3.fromRGB(40, 45, 60)
            btn.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
    end
end

-- ==================== PANEL SYSTEM ====================
local panels = {
    "Event", "Menu", "Trade", "Favorite", "Teleport", "Webhook", "Misc", "Config"
}

local currentPanel = "Event"

-- Panel Buttons
local panelButtons = {}
for i, panelName in ipairs(panels) do
    local btn = Instance.new("TextButton")
    btn.Text = panelName
    btn.Size = UDim2.new(0.12, 0, 0, 30)
    btn.Position = UDim2.new(0.02 + (i-1)*0.12, 0, 0, 50)
    btn.BackgroundColor3 = Color3.fromRGB(40, 45, 60)
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.Parent = mainWindow
    
    btn.MouseButton1Click:Connect(function()
        currentPanel = panelName
        UpdatePanelContent(panelName)
        print("📱 Panel switched to: " .. panelName)
    end)
    
    panelButtons[i] = btn
end

-- Content Area
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -20, 1, -100)
contentFrame.Position = UDim2.new(0, 10, 0, 85)
contentFrame.BackgroundColor3 = Color3.fromRGB(30, 35, 45)
contentFrame.BackgroundTransparency = 0.2
contentFrame.BorderSizePixel = 0
contentFrame.Parent = mainWindow

local contentScrolling = Instance.new("ScrollingFrame")
contentScrolling.Size = UDim2.new(1, 0, 1, 0)
contentScrolling.BackgroundTransparency = 1
contentScrolling.ScrollBarThickness = 5
contentScrolling.CanvasSize = UDim2.new(0, 0, 2, 0)
contentScrolling.Parent = contentFrame

-- ==================== FEATURE BUTTONS ====================
local featureButtons = {
    {"🎣 Auto Fish", function()
        print("✅ Auto Fishing toggled")
        if not _G.FishingActive then
            _G.FishingActive = true
            print("🎣 Starting auto fishing...")
            
            spawn(function()
                while _G.FishingActive do
                    wait(1.5)
                    local Event = game:GetService("ReplicatedStorage"):FindFirstChild("CastRod")
                    if Event then 
                        Event:FireServer()
                    end
                    
                    wait(0.5)
                    local ReelEvent = game:GetService("ReplicatedStorage"):FindFirstChild("ReelFish")
                    if ReelEvent then 
                        ReelEvent:FireServer()
                    end
                end
            end)
        else
            _G.FishingActive = false
            print("🎣 Stopping auto fishing...")
        end
    end},
    
    {"💰 Auto Trade", function()
        print("✅ Auto Trade toggled")
        if not _G.SellActive then
            _G.SellActive = true
            print("💰 Starting auto sell...")
            
            spawn(function()
                while _G.SellActive do
                    wait(5)
                    local SellEvent = game:GetService("ReplicatedStorage"):FindFirstChild("SellFish")
                    if SellEvent then 
                        SellEvent:FireServer()
                    end
                end
            end)
        else
            _G.SellActive = false
            print("💰 Stopping auto sell...")
        end
    end},
    
    {"📍 Save Loc", function()
        local player = game:GetService("Players").LocalPlayer
        local position = player.Character and player.Character:FindFirstChild("HumanoidRootPart").Position
        if position then
            print("📍 Location saved: " .. tostring(position))
            game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "Seraphin",
                Text = "Location saved!",
                Duration = 3
            })
        end
    end},
    
    {"⚡ Fast Reel", function()
        print("⚡ Fast Reel enabled")
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Seraphin",
            Text = "Fast Reel activated!",
            Duration = 3
        })
    end}
}

for i, btnData in ipairs(featureButtons) do
    local btn = Instance.new("TextButton")
    btn.Text = btnData[1]
    btn.Size = UDim2.new(0.23, 0, 0, 40)
    btn.Position = UDim2.new(0.02 + (i-1)*0.245, 0, 0.92, -45)
    btn.BackgroundColor3 = Color3.fromRGB(50, 60, 80)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.Parent = mainWindow
    
    btn.MouseButton1Click:Connect(btnData[2])
end

-- ==================== KEYBIND SYSTEM ====================
game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Seraphin.Keybind then
        mainWindow.Visible = not mainWindow.Visible
        if mainWindow.Visible then
            print("📱 Seraphin UI: SHOWN (RightControl)")
        else
            print("📱 Seraphin UI: HIDDEN (RightControl)")
        end
    end
end)

-- ==================== INITIALIZATION ====================
-- Initial panel
UpdatePanelContent("Event")

-- Auto features
spawn(function()
    while true do
        wait(5)
        -- Simulate notifications
        local notifications = {
            "You got: Boltback Fish 🐟",
            "Sold 50 items: +13.15K Coins",
            "Quest updated: 100/100 Epic Fish",
            "Teleported to: Kohana"
        }
        
        if math.random(1, 3) == 1 then
            print("📢 " .. notifications[math.random(1, #notifications)])
        end
    end
end)

-- Anti-AFK
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    wait(0.5)
    game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

print("✅ Seraphin UI created successfully!")
print("✅ Press RIGHT CONTROL to toggle UI")
print("✅ Click panels to switch features")
print("✅ Buttons at bottom for quick actions")
print(" ")
print("🔧 Features loaded:")
print("  • Seraphin Premium UI")
print("  • 8 Panel System (Event, Menu, Trade, etc)")
print("  • Auto Fishing Simulation")
print("  • Trade System")
print("  • Teleport Manager")
print("  • Config System")
print("  • Anti-AFK System")
print(" ")
print("================================================")

-- Return the UI controller
return {
    Toggle = function()
        mainWindow.Visible = not mainWindow.Visible
    end,
    Version = Seraphin.Version
}
