-- Tin nhắn muốn gửi (Chỉ cần chỉnh sửa dòng này)
local messageToSend = "Please donate robux to me i am afk if you donate to me i would really thank you!"

-- Thời gian giữa mỗi tin nhắn (50 giây)
local interval = 50

-- Cài đặt chống AFK
local VirtualUser = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new(0, 0)) -- Mô phỏng nhấn chuột phải để ngăn bị kick vì không hoạt động
end)

-- Hàm gửi tin nhắn
local function autoChat()
    while true do
        -- Kiểm tra nếu `SayMessageRequest` tồn tại
        local ChatService = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")
        if ChatService then
            local ChatFunction = ChatService:FindFirstChild("SayMessageRequest")
            if ChatFunction and messageToSend and messageToSend ~= "" then
                ChatFunction:FireServer(messageToSend, "All") -- Gửi tin nhắn vào kênh "All"
            end
        end
        wait(interval)
    end
end

-- Chạy hàm auto chat
autoChat()-- Tin nhắn muốn gửi (Chỉ cần chỉnh sửa dòng này)
local messageToSend = "Please donate robux to me i am afk if you donate to me i would really thank you!"

-- Thời gian giữa mỗi tin nhắn (50 giây)
local interval = 50

-- Cài đặt chống AFK
local VirtualUser = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new(0, 0)) -- Mô phỏng nhấn chuột phải để ngăn bị kick vì không hoạt động
end)

-- Hàm gửi tin nhắn
local function autoChat()
    while true do
        -- Kiểm tra nếu `SayMessageRequest` tồn tại
        local ChatService = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")
        if ChatService then
            local ChatFunction = ChatService:FindFirstChild("SayMessageRequest")
            if ChatFunction and messageToSend and messageToSend ~= "" then
                ChatFunction:FireServer(messageToSend, "All") -- Gửi tin nhắn vào kênh "All"
            end
        end
        wait(interval)
    end
end

-- Chạy hàm auto chat
autoChat()