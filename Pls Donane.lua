--[[https://discord.gg/w26VGWmMPb]]--
--khoitongdz on top !
-- Script by khoitongdz
-- Create UI khoitongdz
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local LogoButton = Instance.new("ImageButton")
local TabBar = Instance.new("Frame")
local StatusTab = Instance.new("TextButton")
local ErrorTab = Instance.new("TextButton")
local MainTab = Instance.new("TextButton")
local AutoFarmTab = Instance.new("TextButton") -- Tab Auto Farm
local TabContainer = Instance.new("Frame")
local StatusContainer = Instance.new("Frame")
local ErrorContainer = Instance.new("Frame")
local MainContainer = Instance.new("Frame")
local AutoFarmContainer = Instance.new("Frame") -- Container for Auto Farm

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
LogoButton.Image = "http://www.roblox.com/asset/?id=6537589785" -- Kirito image ID
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
local AutoFarmTab = createTab("AutoFarmTab", "Auto Farm", 400) -- New Auto Farm Tab

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
local AutoFarmContainer = createContainer("AutoFarmContainer") -- Auto Farm Container

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

-- Auto Farm Tab - Farming Setup
local AutoFarmToggle = Instance.new("TextButton")
AutoFarmToggle.Parent = AutoFarmContainer
AutoFarmToggle.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
AutoFarmToggle.Position = UDim2.new(0.1, 0, 0.2, 0)
AutoFarmToggle.Size = UDim2.new(0.8, 0, 0.1, 0)
AutoFarmToggle.Font = Enum.Font.SourceSansBold
AutoFarmToggle.Text = "Bắt Đầu Auto Farm"
AutoFarmToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoFarmToggle.TextSize = 18

-- Auto Farm Logic
local function startAutoFarm()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    
    -- Tìm quái gần nhất
    local closestEnemy
    local shortestDistance = math.huge
    for _, enemy in pairs(workspace:GetChildren()) do
        if enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") then
            local distance = (humanoidRootPart.Position - enemy.HumanoidRootPart.Position).Magnitude
            if distance < shortestDistance then
                closestEnemy = enemy
                shortestDistance = distance
            end
        end
    end
    
    -- Bay đến quái
    if closestEnemy then
        -- Tạo hàm bay đến quái
        while humanoidRootPart.Position ~= closestEnemy.HumanoidRootPart.Position do
            humanoidRootPart.CFrame = CFrame.new(closestEnemy.HumanoidRootPart.Position)
            wait(1)
        end
        
        -- Tự động đánh quái bằng Melee
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid and closestEnemy:FindFirstChild("Humanoid") then
            -- Kiểm tra vũ khí melee và kích hoạt đánh nhanh
            local meleeWeapon = character:FindFirstChild("MeleeWeapon") -- Thay đổi tên nếu cần
            if meleeWeapon then
                -- Sử dụng melee đánh nhanh
                humanoid:MoveTo(closestEnemy.HumanoidRootPart.Position)
                -- Giả lập đánh nhanh
                while closestEnemy:FindFirstChild("Humanoid") do
                    -- Thực hiện đánh vào quái
                    closestEnemy.Humanoid:TakeDamage(10) -- Chỉnh sửa damage nếu cần
                    wait(0.1) -- Giảm thời gian giữa các đòn đánh
                end
            end
        end
    end
end

AutoFarmToggle.MouseButton1Click:Connect(function()
    startAutoFarm()
end)

-- Tabs Functionality
local function switchTab(tabName)
    StatusContainer.Visible = tabName == "Status"
    ErrorContainer.Visible = tabName == "Error"
    MainContainer.Visible = tabName == "Main"
    AutoFarmContainer.Visible = tabName == "AutoFarm"
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

AutoFarmTab.MouseButton1Click:Connect(function()
    switchTab("AutoFarm")
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


