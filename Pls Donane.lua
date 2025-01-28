--[[https://discord.gg/w26VGWmMPb]]--
--khoitongdz on top !
-- Script by khoitongdz
-- Create UI Elements
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TabBar = Instance.new("Frame")
local StatusTab = Instance.new("TextButton")
local ErrorTab = Instance.new("TextButton")
local MainTab = Instance.new("TextButton")
local TabContainer = Instance.new("Frame")
local StatusContainer = Instance.new("Frame")
local ErrorContainer = Instance.new("Frame")
local MainContainer = Instance.new("Frame")

-- Variables
local isChatEnabled = false
local chatMessage = "1 robux equals 1 jump"
local chatInterval = 50
local startTime = os.time()
local errorLog = {}

-- UI Parent
ScreenGui.Parent = game:GetService("CoreGui")

-- Main Frame
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.4, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.Active = true
MainFrame.Draggable = true

-- Tab Bar
TabBar.Name = "TabBar"
TabBar.Parent = MainFrame
TabBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TabBar.Size = UDim2.new(1, 0, 0, 40)

-- Status Tab
StatusTab.Name = "StatusTab"
StatusTab.Parent = TabBar
StatusTab.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
StatusTab.Position = UDim2.new(0, 10, 0, 5)
StatusTab.Size = UDim2.new(0, 120, 0, 30)
StatusTab.Font = Enum.Font.SourceSansBold
StatusTab.Text = "Trạng Thái"
StatusTab.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusTab.TextSize = 16

-- Error Tab
ErrorTab.Name = "ErrorTab"
ErrorTab.Parent = TabBar
ErrorTab.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
ErrorTab.Position = UDim2.new(0, 140, 0, 5)
ErrorTab.Size = UDim2.new(0, 120, 0, 30)
ErrorTab.Font = Enum.Font.SourceSansBold
ErrorTab.Text = "Lỗi Script"
ErrorTab.TextColor3 = Color3.fromRGB(255, 255, 255)
ErrorTab.TextSize = 16

-- Main Tab
MainTab.Name = "MainTab"
MainTab.Parent = TabBar
MainTab.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
MainTab.Position = UDim2.new(0, 270, 0, 5)
MainTab.Size = UDim2.new(0, 120, 0, 30)
MainTab.Font = Enum.Font.SourceSansBold
MainTab.Text = "Chính"
MainTab.TextColor3 = Color3.fromRGB(255, 255, 255)
MainTab.TextSize = 16

-- Tab Container
TabContainer.Name = "TabContainer"
TabContainer.Parent = MainFrame
TabContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TabContainer.Position = UDim2.new(0, 0, 0, 40)
TabContainer.Size = UDim2.new(1, 0, 1, -40)

-- Status Container
StatusContainer.Name = "StatusContainer"
StatusContainer.Parent = TabContainer
StatusContainer.Size = UDim2.new(1, 0, 1, 0)
StatusContainer.Visible = true

-- Status Text
local StatusText = Instance.new("TextLabel")
StatusText.Parent = StatusContainer
StatusText.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
StatusText.BorderSizePixel = 0
StatusText.Size = UDim2.new(1, 0, 1, 0)
StatusText.Font = Enum.Font.SourceSansBold
StatusText.Text = "Thời gian sử dụng: 0 giây"
StatusText.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusText.TextSize = 18

-- Error Container
ErrorContainer.Name = "ErrorContainer"
ErrorContainer.Parent = TabContainer
ErrorContainer.Size = UDim2.new(1, 0, 1, 0)
ErrorContainer.Visible = false

-- Error Log
local ErrorText = Instance.new("TextLabel")
ErrorText.Parent = ErrorContainer
ErrorText.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ErrorText.BorderSizePixel = 0
ErrorText.Size = UDim2.new(1, 0, 1, 0)
ErrorText.Font = Enum.Font.SourceSansBold
ErrorText.Text = "Không có lỗi nào được ghi nhận."
ErrorText.TextColor3 = Color3.fromRGB(255, 255, 255)
ErrorText.TextSize = 18
ErrorText.TextWrapped = true

-- Main Container
MainContainer.Name = "MainContainer"
MainContainer.Parent = TabContainer
MainContainer.Size = UDim2.new(1, 0, 1, 0)
MainContainer.Visible = false

-- Chat Message Box
local ChatBox = Instance.new("TextBox")
ChatBox.Parent = MainContainer
ChatBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ChatBox.Position = UDim2.new(0.1, 0, 0.2, 0)
ChatBox.Size = UDim2.new(0.8, 0, 0, 30)
ChatBox.Font = Enum.Font.SourceSans
ChatBox.PlaceholderText = "Nhập tin nhắn..."
ChatBox.Text = chatMessage
ChatBox.TextColor3 = Color3.fromRGB(255, 255, 255)
ChatBox.TextSize = 18

-- Interval Slider
local SliderLabel = Instance.new("TextLabel")
SliderLabel.Parent = MainContainer
SliderLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SliderLabel.Position = UDim2.new(0.1, 0, 0.35, 0)
SliderLabel.Size = UDim2.new(0.8, 0, 0, 30)
SliderLabel.Font = Enum.Font.SourceSans
SliderLabel.Text = "Thời gian chat: " .. chatInterval .. " giây"
SliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SliderLabel.TextSize = 18

-- Chat Toggle Button
local ChatToggleButton = Instance.new("TextButton")
ChatToggleButton.Parent = MainContainer
ChatToggleButton.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
ChatToggleButton.Position = UDim2.new(0.1, 0, 0.5, 0)
ChatToggleButton.Size = UDim2.new(0.8, 0, 0, 30)
ChatToggleButton.Font = Enum.Font.SourceSansBold
ChatToggleButton.Text = "Bật Chat"
ChatToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ChatToggleButton.TextSize = 18

-- Functionality
ChatToggleButton.MouseButton1Click:Connect(function()
    isChatEnabled = not isChatEnabled
    ChatToggleButton.Text = isChatEnabled and "Tắt Chat" or "Bật Chat"
end)

ChatBox:GetPropertyChangedSignal("Text"):Connect(function()
    chatMessage = ChatBox.Text
end)

-- Update Status
spawn(function()
    while wait(1) do
        local elapsedTime = os.time() - startTime
        StatusText.Text = "Thời gian sử dụng: " .. elapsedTime .. " giây"
    end
end)

print("Script đã được tải thành công!")
