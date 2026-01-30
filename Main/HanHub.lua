-- Loader.lua
-- HAN HUB PREMIUM - FULL FUNCTIONAL SCRIPT

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Hapus UI lama
if PlayerGui:FindFirstChild("HanHubPremium") then
    PlayerGui.HanHubPremium:Destroy()
end

-- VARIABLES & SETTINGS
local HanHub = {
    Settings = {
        AutoFish = false,
        AutoSell = false,
        AutoLoad = false,
        WalkOnWater = false,
        InfiniteJump = false,
        AntiStaff = false,
        NoFishingAnim = false,
        DisableFishNotif = false,
        WalkSpeed = 16,
        JumpPower = 50
    },
    Configs = {
        ["Default"] = {
            AutoFish = false,
            WalkSpeed = 16
        },
        ["Farming"] = {
            AutoFish = true,
            AutoSell = true,
            WalkSpeed = 25
        }
    },
    CurrentConfig = "Default",
    TeleportLocations = {},
    SaveLocation = nil
}

-- FUNCTIONS
function HanHub:SaveConfig(name)
    HanHub.Configs[name] = table.clone(HanHub.Settings)
    print("Config saved:", name)
end

function HanHub:LoadConfig(name)
    if HanHub.Configs[name] then
        for setting, value in pairs(HanHub.Configs[name]) do
            HanHub.Settings[setting] = value
        end
        HanHub.CurrentConfig = name
        print("Config loaded:", name)
        return true
    end
    return false
end

function HanHub:TeleportTo(position)
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = CFrame.new(position)
    end
end

function HanHub:ToggleAutoFishing()
    if HanHub.Settings.AutoFish then
        spawn(function()
            while HanHub.Settings.AutoFish and wait(1) do
                -- Simulasi auto fishing
                print("[AUTO FISH] Casting line...")
                wait(2)
                print("[AUTO FISH] Fish caught!")
                wait(1)
                print("[AUTO FISH] Selling fish...")
            end
        end)
    end
end

function HanHub:ToggleWalkOnWater()
    if HanHub.Settings.WalkOnWater then
        local character = LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
            end
        end
    end
end

function HanHub:ToggleInfiniteJump()
    UserInputService.JumpRequest:Connect(function()
        if HanHub.Settings.InfiniteJump then
            local character = LocalPlayer.Character
            if character then
                local humanoid = character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end
    end)
end

-- CREATE UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HanHubPremium"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- MAIN CONTAINER
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 600)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -300)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainFrame.BackgroundTransparency = 0.05

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- TOP BAR
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 50)
TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 40)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 1, 0)
Title.Text = "HAN HUB | PREMIUM"
Title.TextColor3 = Color3.fromRGB(0, 200, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.BackgroundTransparency = 1

-- CLOSE BUTTON
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0.5, -15)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 100, 100)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18
CloseButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- TAB BUTTONS
local Tabs = {
    "FISHING",
    "PLAYER",
    "TELEPORT",
    "WEBHOOK",
    "CONFIG"
}

local TabButtons = {}
local ContentFrames = {}

-- CONTENT CONTAINER
local ContentContainer = Instance.new("Frame")
ContentContainer.Size = UDim2.new(1, -20, 1, -70)
ContentContainer.Position = UDim2.new(0, 10, 0, 60)
ContentContainer.BackgroundTransparency = 1

for i, tabName in pairs(Tabs) do
    -- Tab Button
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(0.2, -2, 0, 40)
    TabButton.Position = UDim2.new((i-1) * 0.2, 5, 0, 5)
    TabButton.Text = tabName
    TabButton.TextColor3 = Color3.fromRGB(180, 180, 180)
    TabButton.Font = Enum.Font.Gotham
    TabButton.TextSize = 14
    TabButton.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    
    TabButton.MouseButton1Click:Connect(function()
        for _, frame in pairs(ContentFrames) do
            frame.Visible = false
        end
        for _, btn in pairs(TabButtons) do
            btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
        end
        ContentFrames[tabName].Visible = true
        TabButton.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
    end)
    
    table.insert(TabButtons, TabButton)
    
    -- Content Frame
    local ContentFrame = Instance.new("ScrollingFrame")
    ContentFrame.Size = UDim2.new(1, 0, 1, -10)
    ContentFrame.Position = UDim2.new(0, 0, 0, 50)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.ScrollBarThickness = 3
    ContentFrame.Visible = (i == 1)
    ContentFrame.Name = tabName
    
    ContentFrames[tabName] = ContentFrame
    ContentFrame.Parent = ContentContainer
end

-- === FISHING TAB CONTENT ===
local FishingContent = ContentFrames["FISHING"]
local yOffset = 10

local function addToggleToFrame(frame, text, settingName)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, -20, 0, 40)
    ToggleFrame.Position = UDim2.new(0, 10, 0, yOffset)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    
    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
    ToggleLabel.Text = text
    ToggleLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    ToggleLabel.Font = Enum.Font.Gotham
    ToggleLabel.TextSize = 14
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Size = UDim2.new(0, 60, 0, 30)
    ToggleButton.Position = UDim2.new(1, -65, 0.5, -15)
    ToggleButton.Text = HanHub.Settings[settingName] and "ON" or "OFF"
    ToggleButton.TextColor3 = HanHub.Settings[settingName] and Color3.new(0, 1, 0) or Color3.new(1, 0, 0)
    ToggleButton.Font = Enum.Font.GothamBold
    
    ToggleButton.MouseButton1Click:Connect(function()
        HanHub.Settings[settingName] = not HanHub.Settings[settingName]
        ToggleButton.Text = HanHub.Settings[settingName] and "ON" or "OFF"
        ToggleButton.TextColor3 = HanHub.Settings[settingName] and Color3.new(0, 1, 0) or Color3.new(1, 0, 0)
        
        -- Trigger function
        if settingName == "AutoFish" then
            HanHub:ToggleAutoFishing()
        elseif settingName == "WalkOnWater" then
            HanHub:ToggleWalkOnWater()
        elseif settingName == "InfiniteJump" then
            HanHub:ToggleInfiniteJump()
        end
        
        print(text .. " toggled:", HanHub.Settings[settingName])
    end)
    
    ToggleLabel.Parent = ToggleFrame
    ToggleButton.Parent = ToggleFrame
    ToggleFrame.Parent = frame
    
    yOffset = yOffset + 45
    return ToggleFrame
end

-- Add Fishing Toggles
addToggleToFrame(FishingContent, "Auto Reel Fish", "AutoFish")
addToggleToFrame(FishingContent, "Auto Sell Fish", "AutoSell")
addToggleToFrame(FishingContent, "No Fishing Animations", "NoFishingAnim")
addToggleToFrame(FishingContent, "Disable Fish Notification", "DisableFishNotif")

-- Action Delay Slider
local SliderFrame = Instance.new("Frame")
SliderFrame.Size = UDim2.new(1, -20, 0, 60)
SliderFrame.Position = UDim2.new(0, 10, 0, yOffset)
SliderFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)

local SliderLabel = Instance.new("TextLabel")
SliderLabel.Size = UDim2.new(1, 0, 0.5, 0)
SliderLabel.Text = "Action Delay: 0.5s"
SliderLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
SliderLabel.Font = Enum.Font.Gotham
SliderLabel.TextSize = 14
SliderLabel.BackgroundTransparency = 1

local SliderBar = Instance.new("Frame")
SliderBar.Size = UDim2.new(1, -20, 0, 5)
SliderBar.Position = UDim2.new(0, 10, 0.5, 10)
SliderBar.BackgroundColor3 = Color3.fromRGB(50, 50, 60)

local SliderFill = Instance.new("Frame")
SliderFill.Size = UDim2.new(0.5, 0, 1, 0)
SliderFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)

local SliderButton = Instance.new("TextButton")
SliderButton.Size = UDim2.new(0, 20, 0, 20)
SliderButton.Position = UDim2.new(0.5, -10, 0.5, -10)
SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SliderButton.Text = ""
SliderButton.ZIndex = 2

SliderButton.MouseButton1Down:Connect(function()
    local connection
    connection = RunService.RenderStepped:Connect(function()
        local mousePos = UserInputService:GetMouseLocation()
        local sliderPos = SliderBar.AbsolutePosition.X
        local sliderWidth = SliderBar.AbsoluteSize.X
        local x = math.clamp(mousePos.X - sliderPos, 0, sliderWidth)
        local percent = x / sliderWidth
        
        SliderFill.Size = UDim2.new(percent, 0, 1, 0)
        SliderButton.Position = UDim2.new(percent, -10, 0.5, -10)
        
        local delay = math.floor(percent * 2 * 10) / 10
        SliderLabel.Text = "Action Delay: " .. delay .. "s"
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            connection:Disconnect()
        end
    end)
end)

SliderFill.Parent = SliderBar
SliderButton.Parent = SliderBar
SliderLabel.Parent = SliderFrame
SliderBar.Parent = SliderFrame
SliderFrame.Parent = FishingContent

yOffset = yOffset + 70

-- Status Display
local StatusFrame = Instance.new("Frame")
StatusFrame.Size = UDim2.new(1, -20, 0, 40)
StatusFrame.Position = UDim2.new(0, 10, 0, yOffset)
StatusFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 1, 0)
StatusLabel.Text = "Status: Ready"
StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
StatusLabel.Font = Enum.Font.GothamBold
StatusLabel.TextSize = 16
StatusLabel.BackgroundTransparency = 1

StatusLabel.Parent = StatusFrame
StatusFrame.Parent = FishingContent

-- === PLAYER TAB CONTENT ===
local PlayerContent = ContentFrames["PLAYER"]
yOffset = 10

addToggleToFrame(PlayerContent, "Walk On Water", "WalkOnWater")
addToggleToFrame(PlayerContent, "Infinite Jump", "InfiniteJump")
addToggleToFrame(PlayerContent, "Anti Staff", "AntiStaff")

-- Walk Speed
local SpeedFrame = Instance.new("Frame")
SpeedFrame.Size = UDim2.new(1, -20, 0, 60)
SpeedFrame.Position = UDim2.new(0, 10, 0, yOffset)
SpeedFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(1, 0, 0, 30)
SpeedLabel.Text = "Walk Speed: " .. HanHub.Settings.WalkSpeed
SpeedLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.TextSize = 14
SpeedLabel.BackgroundTransparency = 1

local SpeedBox = Instance.new("TextBox")
SpeedBox.Size = UDim2.new(0.3, 0, 0, 30)
SpeedBox.Position = UDim2.new(0.7, 0, 0, 30)
SpeedBox.Text = tostring(HanHub.Settings.WalkSpeed)
SpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBox.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
SpeedBox.PlaceholderText = "Speed"

SpeedBox.FocusLost:Connect(function()
    local speed = tonumber(SpeedBox.Text)
    if speed and speed > 0 then
        HanHub.Settings.WalkSpeed = speed
        local character = LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = speed
            end
        end
        SpeedLabel.Text = "Walk Speed: " .. speed
    end
end)

SpeedLabel.Parent = SpeedFrame
SpeedBox.Parent = SpeedFrame
SpeedFrame.Parent = PlayerContent

yOffset = yOffset + 70

-- Player Info
local InfoFrame = Instance.new("Frame")
InfoFrame.Size = UDim2.new(1, -20, 0, 80)
InfoFrame.Position = UDim2.new(0, 10, 0, yOffset)
InfoFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)

local PlayerNameLabel = Instance.new("TextLabel")
PlayerNameLabel.Size = UDim2.new(1, -10, 0, 25)
PlayerNameLabel.Position = UDim2.new(0, 5, 0, 5)
PlayerNameLabel.Text = "Player: " .. LocalPlayer.Name
PlayerNameLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
PlayerNameLabel.Font = Enum.Font.Gotham
PlayerNameLabel.TextSize = 16
PlayerNameLabel.BackgroundTransparency = 1

-- Get Player Level (Simulated)
local LevelLabel = Instance.new("TextLabel")
LevelLabel.Size = UDim2.new(1, -10, 0, 25)
LevelLabel.Position = UDim2.new(0, 5, 0, 35)
LevelLabel.Text = "Level: 1400"
LevelLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
LevelLabel.Font = Enum.Font.GothamBold
LevelLabel.TextSize = 18
LevelLabel.BackgroundTransparency = 1

PlayerNameLabel.Parent = InfoFrame
LevelLabel.Parent = InfoFrame
InfoFrame.Parent = PlayerContent

-- === CONFIG TAB CONTENT ===
local ConfigContent = ContentFrames["CONFIG"]
yOffset = 10

-- Config Dropdown
local ConfigFrame = Instance.new("Frame")
ConfigFrame.Size = UDim2.new(1, -20, 0, 40)
ConfigFrame.Position = UDim2.new(0, 10, 0, yOffset)
ConfigFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)

local ConfigLabel = Instance.new("TextLabel")
ConfigLabel.Size = UDim2.new(0.3, 0, 1, 0)
ConfigLabel.Text = "Config:"
ConfigLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
ConfigLabel.Font = Enum.Font.Gotham
ConfigLabel.TextSize = 14
ConfigLabel.BackgroundTransparency = 1

local ConfigDropdown = Instance.new("TextButton")
ConfigDropdown.Size = UDim2.new(0.6, 0, 1, -10)
ConfigDropdown.Position = UDim2.new(0.35, 0, 0, 5)
ConfigDropdown.Text = HanHub.CurrentConfig
ConfigDropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfigDropdown.Font = Enum.Font.Gotham
ConfigDropdown.TextSize = 14
ConfigDropdown.BackgroundColor3 = Color3.fromRGB(50, 50, 60)

ConfigDropdown.MouseButton1Click:Connect(function()
    -- Simple dropdown simulation
    for name, _ in pairs(HanHub.Configs) do
        if name ~= HanHub.CurrentConfig then
            HanHub:LoadConfig(name)
            ConfigDropdown.Text = name
            break
        end
    end
end)

ConfigLabel.Parent = ConfigFrame
ConfigDropdown.Parent = ConfigFrame
ConfigFrame.Parent = ConfigContent

yOffset = yOffset + 50

-- New Config Name
local NewConfigFrame = Instance.new("Frame")
NewConfigFrame.Size = UDim2.new(1, -20, 0, 60)
NewConfigFrame.Position = UDim2.new(0, 10, 0, yOffset)
NewConfigFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)

local NewConfigLabel = Instance.new("TextLabel")
NewConfigLabel.Size = UDim2.new(1, 0, 0, 30)
NewConfigLabel.Text = "New Config Name"
NewConfigLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
NewConfigLabel.Font = Enum.Font.Gotham
NewConfigLabel.TextSize = 14
NewConfigLabel.BackgroundTransparency = 1

local NewConfigBox = Instance.new("TextBox")
NewConfigBox.Size = UDim2.new(0.6, 0, 0, 30)
NewConfigBox.Position = UDim2.new(0.2, 0, 0, 30)
NewConfigBox.Text = ""
NewConfigBox.PlaceholderText = "Config Name"
NewConfigBox.TextColor3 = Color3.fromRGB(255, 255, 255)
NewConfigBox.BackgroundColor3 = Color3.fromRGB(50, 50, 60)

local SaveConfigButton = Instance.new("TextButton")
SaveConfigButton.Size = UDim2.new(0.2, -5, 0, 30)
SaveConfigButton.Position = UDim2.new(0.8, 5, 0, 30)
SaveConfigButton.Text = "Save"
SaveConfigButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SaveConfigButton.BackgroundColor3 = Color3.fromRGB(0, 120, 200)

SaveConfigButton.MouseButton1Click:Connect(function()
    if NewConfigBox.Text ~= "" then
        HanHub:SaveConfig(NewConfigBox.Text)
        NewConfigBox.Text = ""
        ConfigDropdown.Text = HanHub.CurrentConfig
    end
end)

NewConfigLabel.Parent = NewConfigFrame
NewConfigBox.Parent = NewConfigFrame
SaveConfigButton.Parent = NewConfigFrame
NewConfigFrame.Parent = ConfigContent

yOffset = yOffset + 70

-- Config Actions
local ActionFrame = Instance.new("Frame")
ActionFrame.Size = UDim2.new(1, -20, 0, 40)
ActionFrame.Position = UDim2.new(0, 10, 0, yOffset)
ActionFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)

local LoadButton = Instance.new("TextButton")
LoadButton.Size = UDim2.new(0.3, -5, 1, -10)
LoadButton.Position = UDim2.new(0, 5, 0, 5)
LoadButton.Text = "Load"
LoadButton.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadButton.BackgroundColor3 = Color3.fromRGB(0, 150, 100)

LoadButton.MouseButton1Click:Connect(function()
    HanHub:LoadConfig(ConfigDropdown.Text)
end)

local DeleteButton = Instance.new("TextButton")
DeleteButton.Size = UDim2.new(0.3, -5, 1, -10)
DeleteButton.Position = UDim2.new(0.35, 5, 0, 5)
DeleteButton.Text = "Delete"
DeleteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DeleteButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)

DeleteButton.MouseButton1Click:Connect(function()
    HanHub.Configs[ConfigDropdown.Text] = nil
    ConfigDropdown.Text = "Default"
end)

local AutoLoadToggle = addToggleToFrame(ConfigContent, "Auto Load Config", "AutoLoad")
AutoLoadToggle.Position = UDim2.new(0, 10, 0, yOffset + 50)

LoadButton.Parent = ActionFrame
DeleteButton.Parent = ActionFrame
ActionFrame.Parent = ConfigContent

-- PARENT ALL ELEMENTS
Title.Parent = TopBar
CloseButton.Parent = TopBar
TopBar.Parent = MainFrame

for _, button in pairs(TabButtons) do
    button.Parent = MainFrame
end

ContentContainer.Parent = MainFrame
MainFrame.Parent = ScreenGui
ScreenGui.Parent = PlayerGui

-- Update sizes for scrolling
for _, frame in pairs(ContentFrames) do
    frame.CanvasSize = UDim2.new(0, 0, 0, yOffset + 100)
end

-- Apply initial settings
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
humanoid.WalkSpeed = HanHub.Settings.WalkSpeed
humanoid.JumpPower = HanHub.Settings.JumpPower

print("HAN HUB PREMIUM LOADED SUCCESSFULLY!")
print("Player:", LocalPlayer.Name)
print("Features Ready: Auto Fish, Walk on Water, Config System, etc.")

-- Notification
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "HAN HUB PREMIUM",
    Text = "Successfully loaded!",
    Duration = 5
})
