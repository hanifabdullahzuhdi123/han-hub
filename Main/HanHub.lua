elseif tabName == "Blatant" then
        local BlatantLabel = Instance.new("TextLabel")
        BlatantLabel.Text = "⚠️ BLATANT FEATURES (HIGH RISK!) ⚠️"
        BlatantLabel.Size = UDim2.new(1, 0, 0, 30)
        BlatantLabel.BackgroundTransparency = 1
        BlatantLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
        BlatantLabel.Font = Enum.Font.GothamBold
        BlatantLabel.TextSize = 16
        BlatantLabel.Parent = TabContent
        
        -- FLY HACK
        local FlyFrame = Instance.new("Frame")
        FlyFrame.Size = UDim2.new(1, 0, 0, 40)
        FlyFrame.Position = UDim2.new(0, 0, 0, 40)
        FlyFrame.BackgroundColor3 = Color3.fromRGB(60, 20, 20)
        FlyFrame.Parent = TabContent
        
        local FlyCorner = Instance.new("UICorner")
        FlyCorner.CornerRadius = UDim.new(0, 8)
        FlyCorner.Parent = FlyFrame
        
        local FlyLabel = Instance.new("TextLabel")
        FlyLabel.Text = "FLY HACK"
        FlyLabel.Size = UDim2.new(0.7, 0, 1, 0)
        FlyLabel.BackgroundTransparency = 1
        FlyLabel.TextColor3 = Color3.fromRGB(255, 150, 150)
        FlyLabel.Font = Enum.Font.GothamBold
        FlyLabel.TextSize = 14
        FlyLabel.TextXAlignment = Enum.TextXAlignment.Left
        FlyLabel.Parent = FlyFrame
        
        local FlyToggle = Instance.new("TextButton")
        FlyToggle.Text = "OFF"
        FlyToggle.Size = UDim2.new(0.2, 0, 0.7, 0)
        FlyToggle.Position = UDim2.new(0.75, 0, 0.15, 0)
        FlyToggle.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
        FlyToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
        FlyToggle.Font = Enum.Font.GothamBold
        FlyToggle.TextSize = 12
        FlyToggle.P
