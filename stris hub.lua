-- Kenon Hub - Auto Chat Full Executor
local messages = {" please donate me some robux :( "}
local delay = 35 -- Thời gian giữa các tin nhắn (mặc định 35 giây)
local running = false
local speed = 16 -- Mặc định tốc độ nhân vật
local webhookURL = "https://discord.com/api/webhooks/1337667957655994450/SjYmmvhkszUlpmSNZel7pwYnnKHhiV4QvQuvA3Iut-Hj0vfC3VeB6xqoipFVLRLqyZUy" -- Link webhook Discord

-- Kiểm tra executor
local isSupported = (syn and syn.request) or (secure_request) or (http and http.request) or (fluxus and fluxus.request) or request
if not isSupported then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Kenon Hub",
        Text = "Executor không hỗ trợ!",
        Duration = 5
    })
    return
end

-- Gửi thông báo webhook
local function sendWebhook(message)
    if webhookURL ~= "" then
        local requestFunc = (syn and syn.request) or request or (http and http.request)
        requestFunc({
            Url = webhookURL,
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = game:GetService("HttpService"):JSONEncode({ content = message })
        })
    end
end

sendWebhook("Kenon Hub đã bắt đầu. Người dùng: " .. game.Players.LocalPlayer.Name)

-- Tạo UI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local ToggleButton = Instance.new("ImageButton")
local StatusLabel = Instance.new("TextButton")
local TimeLabel = Instance.new("TextLabel")
local MessageBox = Instance.new("TextBox")
local DelayBox = Instance.new("TextBox")
local SpeedBox = Instance.new("TextBox")
local WebhookBox = Instance.new("TextBox")

ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.Name = "KenonHubUI"

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Size = UDim2.new(0, 250, 0, 230)
MainFrame.Position = UDim2.new(0.5, -125, 0.4, -75) -- Canh giữa màn hình
MainFrame.Visible = false

ToggleButton.Parent = ScreenGui
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Position = UDim2.new(0.9, 0, 0.1, 0)
ToggleButton.BackgroundTransparency = 1
ToggleButton.Image = "rbxassetid://15377289473"

-- Cho phép kéo thả logo
local dragging, offset
ToggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        offset = input.Position - ToggleButton.AbsolutePosition
    end
end)

ToggleButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        ToggleButton.Position = UDim2.new(0, input.Position.X - offset.X, 0, input.Position.Y - offset.Y)
    end
end)

StatusLabel.Parent = MainFrame
StatusLabel.Text = "Auto Chat: OFF"
StatusLabel.Size = UDim2.new(1, 0, 0.2, 0)
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
StatusLabel.BorderSizePixel = 0

TimeLabel.Parent = MainFrame
TimeLabel.Text = "Server Time: 00:00"
TimeLabel.Size = UDim2.new(1, 0, 0.2, 0)
TimeLabel.Position = UDim2.new(0, 0, 0.2, 0)
TimeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TimeLabel.BackgroundTransparency = 1

MessageBox.Parent = MainFrame
MessageBox.PlaceholderText = "Nhập tin nhắn..."
MessageBox.Text = table.concat(messages, " | ")
MessageBox.Size = UDim2.new(1, -10, 0.2, 0)
MessageBox.Position = UDim2.new(0, 5, 0.4, 0)
MessageBox.TextColor3 = Color3.fromRGB(0, 255, 0)
MessageBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

DelayBox.Parent = MainFrame
DelayBox.PlaceholderText = "Nhập delay (giây)..."
DelayBox.Text = tostring(delay)
DelayBox.Size = UDim2.new(1, -10, 0.2, 0)
DelayBox.Position = UDim2.new(0, 5, 0.6, 0)
DelayBox.TextColor3 = Color3.fromRGB(0, 255, 255)
DelayBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

SpeedBox.Parent = MainFrame
SpeedBox.PlaceholderText = "Nhập tốc độ (1-100)..."
SpeedBox.Text = tostring(speed)
SpeedBox.Size = UDim2.new(1, -10, 0.2, 0)
SpeedBox.Position = UDim2.new(0, 5, 0.8, 0)
SpeedBox.TextColor3 = Color3.fromRGB(255, 255, 0)
SpeedBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

WebhookBox.Parent = MainFrame
WebhookBox.PlaceholderText = "Nhập webhook URL..."
WebhookBox.Text = webhookURL
WebhookBox.Size = UDim2.new(1, -10, 0.2, 0)
WebhookBox.Position = UDim2.new(0, 5, 1.0, 0)
WebhookBox.TextColor3 = Color3.fromRGB(255, 100, 100)
WebhookBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

WebhookBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        webhookURL = WebhookBox.Text
    end
end)

-- Cập nhật thời gian trong server
task.spawn(function()
    while true do
        local timeInMinutes = math.floor(workspace.DistributedGameTime / 60)
        local hours = math.floor(timeInMinutes / 60)
        local minutes = timeInMinutes % 60
        TimeLabel.Text = string.format("Server Time: %02d:%02d", hours, minutes)
        wait(1)
    end
end)

-- Tốc độ chạy nhanh
SpeedBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local newSpeed = tonumber(SpeedBox.Text)
        if newSpeed and newSpeed >= 1 and newSpeed <= 100 then
            speed = newSpeed
            local humanoid = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = speed
            end
        else
            SpeedBox.Text = tostring(speed)
        end
    end
end)
