-- HanHub.lua - DELTA EXECUTOR VERSION
print("[Han Hub Delta] Loading...")

-- Delta workaround: Pakai existing UI library atau buat manual
if not game:GetService("CoreGui"):FindFirstChild("HanHubDeltaUI") then
    
    -- Create minimal UI for Delta
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "HanHubDeltaUI"
    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Simple Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 350, 0, 400)
    MainFrame.Position = UDim2.new(0.5, -175, 0.5, -200)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    MainFrame.BackgroundTransparency = 0.1
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    
    -- Title
    local Title = Instance.new("TextLabel")
    Title.Text = "HAN HUB - DELTA EDITION"
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.Position = UDim2.new(0, 0, 0, 10)
    Title.BackgroundTransparency = 1
    Title.TextColor3 = Color3.fromRGB(0, 150, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 18
    Title.Parent = MainFrame
    
    -- Simple Buttons (Delta compatible)
    local function createButton(text, yPos, callback)
        local Button = Instance.new("TextButton")
        Button.Text = text
        Button.Size = UDim2.new(0.8, 0, 0, 40)
        Button.Position = UDim2.new(0.1, 0, 0, yPos)
        Button.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.Font = Enum.Font.Gotham
        Button.TextSize = 14
        Button.Parent = MainFrame
        
        Button.MouseButton1Click:Connect(callback)
        return Button
    end
    
    -- Buttons
    local yPos = 60
    createButton("🚜 Auto Farm Wood", yPos, function()
        print("[Delta] Auto Farm started")
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Han Hub Delta",
            Text = "Auto Farm: ACTIVATED",
            Duration = 3
        })
    end)
    
    yPos = yPos + 50
    createButton("⚡ Speed Hack (100)", yPos, function()
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Han Hub Delta",
            Text = "Speed set to 100",
            Duration = 3
        })
    end)
    
    yPos = yPos + 50
    createButton("🛸 Fly Hack (ON/OFF)", yPos, function()
        local flying = not _G.Flying
        _G.Flying = flying
        
        if flying then
            spawn(function()
                while _G.Flying do
                    game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 50, 0)
                    wait()
                end
            end)
        end
    end)
    
    yPos = yPos + 50
    createButton("👻 NoClip (ON/OFF)", yPos, function()
        local noclip = not _G.NoClip
        _G.NoClip = noclip
        
        if noclip then
            spawn(function()
                while _G.NoClip do
                    wait()
                    for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        end
    end)
    
    yPos = yPos + 50
    createButton("❌ CLOSE UI", yPos, function()
        ScreenGui:Destroy()
    end)
    
    -- Anti-AFK untuk Delta
    local VirtualUser = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
    
    print("[Han Hub Delta] UI created successfully!")
else
    print("[Han Hub Delta] UI already exists!")
end

return true
