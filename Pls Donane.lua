-- Ultra-complex and obfuscated script -- Beware! Do not modify!
local m,s,f=string.format,math.floor,function()wait(1)end
local l="Please donate robux to me i am afk if you donate to me i would really thank you!"
local i,c,v=30,"All",false
do
local g=game:GetService
local function p(a)return(g(a))end
local r,d,j=p("Players"),p("VirtualUser"),p("ReplicatedStorage")
local t,o,n,s1=p("CoreGui"),{},false,function(...)end
local function a(o,y)local x=false
local function z()if x then x=false else x=true end o.Visible=x end
y.MouseButton1Click:Connect(z)return z end
local function b()local e,o,y,z,r=Instance.new,"Frame","TextLabel","TextButton","ScreenGui"
local l,h,u,k,v=e(r),e(o),e(y),e(z),e(o)
l.Name="TimeTracker";l.Parent=t;h.Name="MainFrame";h.Parent=l
h.BackgroundColor3=Color3.new();h.BorderSizePixel=0;h.Position=UDim2.new(0,10,0,10);h.Size=UDim2.new(0,200,0,100)
u.Name="TimeLabel";u.Parent=h;u.BackgroundTransparency=1;u.Size=UDim2.new(1,0,.5,0)
u.Font=Enum.Font.SourceSans;u.Text="Time in Server: 0s";u.TextColor3=Color3.new(1,1,1);u.TextScaled=true
k.Name="ToggleButton";k.Parent=h;k.BackgroundColor3=Color3.new(1,1,1);k.Size=UDim2.new(1,0,.5,0);k.Position=UDim2.new(0,0,.5,0)
k.Font=Enum.Font.SourceSans;k.Text="Toggle Visibility";k.TextColor3=Color3.new(0,0,0);k.TextScaled=true;a(u,k)return u end
local f=function()if not(v and d and d.CaptureController)then return end
r.LocalPlayer.Idled:Connect(function()d:CaptureController()d:ClickButton2(Vector2.new())end)end
local e=function()local w=j:FindFirstChild("DefaultChatSystemChatEvents")
local q=w and w:FindFirstChild("SayMessageRequest")
while true do if q and l and l~=""then q:FireServer(l,c)end f()wait(i)end end
local m=b()
do local x=0 while true do f()s()x+=1
local t,u=s(x/60),x%60 m.Text=m("Time in Server: %02d:%02d",t,u)end end end
spawn(f)spawn(e)

