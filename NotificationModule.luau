--[[
    NotificationModule v1.0.0
    Developed by Script-hue
    Modular UI notification system using TweenService for smooth transitions.
]]

local NotificationModule = {}

-- Services
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

-- Configuration
local DISPLAY_TIME = 5 
local TWEEN_SETTING = TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

local COLORS = {
    Success = Color3.fromRGB(46, 204, 113),
    Warning = Color3.fromRGB(241, 196, 15),
    Error   = Color3.fromRGB(231, 76, 60),
    Info    = Color3.fromRGB(52, 152, 219)
}

-- Private: Setup the UI Container
local function GetContainer()
    local player = Players.LocalPlayer
    local pGui = player:WaitForChild("PlayerGui")
    
    local gui = pGui:FindFirstChild("NotificationGui")
    if not gui then
        gui = Instance.new("ScreenGui")
        gui.Name = "NotificationGui"
        gui.ResetOnSpawn = false
        gui.Parent = pGui
        
        local container = Instance.new("Frame")
        container.Name = "Container"
        container.Size = UDim2.new(0.3, 0, 0.5, 0)
        container.Position = UDim2.new(0, 20, 0.5, 0)
        container.BackgroundTransparency = 1
        container.Parent = gui
        
        local layout = Instance.new("UIListLayout")
        layout.VerticalAlignment = Enum.VerticalAlignment.Bottom
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Padding = UDim.new(0, 8)
        layout.Parent = container
    end
    return gui.Container
end

-- Main Function: Send Notification
function NotificationModule:Send(message: string, type: string)
    local container = GetContainer()
    type = type or "Info"
    
    -- Create Frame
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 40)
    frame.BackgroundColor3 = COLORS[type]
    frame.BorderSizePixel = 0
    frame.BackgroundTransparency = 1 -- Start hidden for animation
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = frame
    
    -- Create Text
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = message
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextSize = 16
    label.Font = Enum.Font.SourceSansBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextTransparency = 1 -- Start hidden
    label.Parent = frame
    
    frame.Parent = container
    
    -- Entrance Animation
    TweenService:Create(frame, TWEEN_SETTING, {BackgroundTransparency = 0}):Play()
    TweenService:Create(label, TWEEN_SETTING, {TextTransparency = 0}):Play()
    
    -- Auto-Remove logic
    task.delay(DISPLAY_TIME, function()
        local outTween = TweenService:Create(frame, TWEEN_SETTING, {BackgroundTransparency = 1})
        TweenService:Create(label, TWEEN_SETTING, {TextTransparency = 1}):Play()
        
        outTween:Play()
        outTween.Completed:Connect(function()
            frame:Destroy()
        end)
    end)
end

return NotificationModule
