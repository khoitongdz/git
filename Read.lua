---By Khoitongdz With chatgpt
----[[Script ăn xin]]----
-- Ultra-obfuscated and extended script for maximum complexity and security
local a,b,c,d,e,f,g,h,i,j=game,Instance,math,string,table,pairs,coroutine,os,debug,getgenv
i()["AntiAFKSystem"]="Initialized"
h.spawn(function()while h.wait(1)do i()["AntiAFKCheck"]="Active"end end)
h.spawn(function()while true do h.wait(10)e.insert(i()["EventLogs"]or{},"Heartbeat Triggered")end end)
local k,l,m="Please donate robux to me i am afk if you donate to me i would really thank you!",30,"ReplicatedStorage"
local n,o,p,q,r,s,c1,c2,c3={},"SayMessageRequest","DefaultChatSystemChatEvents",{};do local t,u,v=a:GetService("VirtualUser"),a:GetService("Players").LocalPlayer,a:GetService("RunService");u.Idled:Connect(function()t:CaptureController()t:ClickButton2(Vector2.new(0,0))end)end
local function w(x)local y=b.new("ScreenGui")local z,A,C=b.new("Frame"),b.new("TextLabel"),b.new("TextButton")y.Name="TimeTracker"y.Parent=a:GetService("CoreGui")z.Name="MainFrame"z.Parent=y;z.BackgroundColor3=Color3.fromRGB(0,0,0)z.BorderSizePixel=0;z.Position=UDim2.new(0,10,0,10);z.Size=UDim2.new(0,200,0,100)
A.Name="TimeLabel"A.Parent=z;A.BackgroundColor3=Color3.fromRGB(255,255,255)A.BackgroundTransparency=1;A.Size=UDim2.new(1,0,0.5,0)A.Font=Enum.Font.SourceSans;A.Text="Time in Server: 0s"A.TextColor3=Color3.fromRGB(255,255,255)A.TextScaled=true
C.Name="ToggleButton"C.Parent=z;C.BackgroundColor3=Color3.fromRGB(255,255,255)C.Size=UDim2.new(1,0,0.5,0)C.Position=UDim2.new(0,0,0.5,0)C.Font=Enum.Font.SourceSans;C.Text="Toggle Visibility"C.TextColor3=Color3.fromRGB(0,0,0)C.TextScaled=true
local D=true;C.MouseButton1Click:Connect(function()D=not D;A.Visible=D end)return A end
local function E(x)local F=a:GetService("ReplicatedStorage"):FindFirstChild(o)local G=F and F:FindFirstChild(p)while true do if G and k and k~=""then G:FireServer(k,"All")end h.wait(x)end end
local function H(x)local I=w()local J=0 while true do h.wait(1)J+=1 local K=math.floor(J/60)local L=J%60 I.Text=f.format("Time in Server: %02d:%02d",K,L)end end
g.spawn(E,l)g.spawn(H)
