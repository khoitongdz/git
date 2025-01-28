--[[https://discord.gg/w26VGWmMPb]]--
--khoitongdz on top !
-- Script by khoitongdz
-- Create UI Elements
-- Create UI Elements
-- Create UI Elements
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local LogoButton = Instance.new("ImageButton")
local TabBar = Instance.new("Frame")
local StatusTab = Instance.new("TextButton")
local ErrorTab = Instance.new("TextButton")
local MainTab = Instance.new("TextButton")
local TabContainer = Instance.new("Frame")
local StatusContainer = Instance.new("Frame")
local ErrorContainer = Instance.new("Frame")
local MainContainer = Instance.new("Frame")

-- Variables
local isUIVisible = true
local isChatEnabled = false
local chatMessage = "Hello, I'm here!"
local chatInterval = 10
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

-- Logo Button
LogoButton.Name = "LogoButton"
LogoButton.Parent = ScreenGui
LogoButton.BackgroundTransparency = 1
LogoButton.Image = "http://www.roblox.com/asset/?id=6537589785" -- Replace with your anime image ID
LogoButton.Position = UDim2.new(0.05, 0, 0.05, 0)
LogoButton.Size = UDim2.new(0, 100, 0, 100)

-- Tab Bar
TabBar.Name = "TabBar"
TabBar.Parent = MainFrame
TabBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TabBar.Size = UDim2.new(1, 0, 0, 40)

-- Tabs
local function createTab(name, text, posX)
    local tab = Instance.new("TextButton")
    tab.Name = name
    tab.Parent = TabBar
    tab.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
    tab.Position = UDim2.new(0, posX, 0, 5)
    tab.Size = UDim2.new(0, 120, 0, 30)
    tab.Font = Enum.Font.SourceSansBold
    tab.Text = text
    tab.TextColor3 = Color3.fromRGB(255, 255, 255)
    tab.TextSize = 16
    return tab
end

local StatusTab = createTab("StatusTab", "Trạng Thái", 10)
local ErrorTab = createTab("ErrorTab", "Lỗi Script", 140)
local MainTab = createTab("MainTab", "Chính", 270)

-- Tab Container
TabContainer.Name = "TabContainer"
TabContainer.Parent = MainFrame
TabContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TabContainer.Position = UDim2.new(0, 0, 0, 40)
TabContainer.Size = UDim2.new(1, 0, 1, -40)

-- Containers for Tabs
local function createContainer(name)
    local container = Instance.new("Frame")
    container.Name = name
    container.Parent = TabContainer
    container.Size = UDim2.new(1, 0, 1, 0)
    container.Visible = false
    return container
end

local StatusContainer = createContainer("StatusContainer")
local ErrorContainer = createContainer("ErrorContainer")
local MainContainer = createContainer("MainContainer")

-- Show Status Container by default
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

-- Error Text
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

-- Main Tab - Chat Configuration
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

local SliderLabel = Instance.new("TextLabel")
SliderLabel.Parent = MainContainer
SliderLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SliderLabel.Position = UDim2.new(0.1, 0, 0.4, 0)
SliderLabel.Size = UDim2.new(0.8, 0, 0, 30)
SliderLabel.Font = Enum.Font.SourceSans
SliderLabel.Text = "Thời gian chat: " .. chatInterval .. " giây"
SliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SliderLabel.TextSize = 18

local StartButton = Instance.new("TextButton")
StartButton.Parent = MainContainer
StartButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
StartButton.Position = UDim2.new(0.35, 0, 0.6, 0)
StartButton.Size = UDim2.new(0.3, 0, 0.1, 0)
StartButton.Font = Enum.Font.SourceSansBold
StartButton.Text = "Bắt Đầu"
StartButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StartButton.TextSize = 18

-- Start Chat Functionality
StartButton.MouseButton1Click:Connect(function()
    chatMessage = ChatBox.Text
    if chatMessage ~= "" then
        isChatEnabled = true
        print("Tự động chat đã bật với tin nhắn: " .. chatMessage)
        spawn(function()
            while isChatEnabled do
                wait(chatInterval)
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(chatMessage, "All")
            end
        end)
    else
        print("Vui lòng nhập tin nhắn để bắt đầu!")
    end
end)

-- Tabs Functionality
local function switchTab(tabName)
    StatusContainer.Visible = tabName == "Status"
    ErrorContainer.Visible = tabName == "Error"
    MainContainer.Visible = tabName == "Main"
end

StatusTab.MouseButton1Click:Connect(function()
    switchTab("Status")
end)

ErrorTab.MouseButton1Click:Connect(function()
    switchTab("Error")
end)

MainTab.MouseButton1Click:Connect(function()
    switchTab("Main")
end)

-- Logo Button Functionality
LogoButton.MouseButton1Click:Connect(function()
    isUIVisible = not isUIVisible
    MainFrame.Visible = isUIVisible
end)

-- Status Timer
spawn(function()
    while wait(1) do
        local elapsedTime = os.time() - startTime
        StatusText.Text = "Thời gian: " .. elapsedTime .. " giây"
    end
end)

print("Script hoàn chỉnh đã được tải!")

