local EternalUI = {}
EternalUI.__index = EternalUI

-- services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- theme
local Theme = {
BG = Color3.fromRGB(15,15,15),
Light = Color3.fromRGB(25,25,25),
Text = Color3.fromRGB(255,255,255),
Dim = Color3.fromRGB(170,170,170),
Accent = Color3.fromRGB(255,255,255)
}

-- config
local Config = {}
local ConfigFile = "EternalUI_Config.json"

-- save
function EternalUI:SaveConfig()

if writefile then
writefile(ConfigFile,HttpService:JSONEncode(Config))
end

end

-- load
function EternalUI:LoadConfig()

if readfile and isfile and isfile(ConfigFile) then

Config = HttpService:JSONDecode(readfile(ConfigFile))

end

end

-- corner
local function Corner(obj)

local c = Instance.new("UICorner")
c.CornerRadius = UDim.new(0,8)
c.Parent = obj

end

-- tween
local function Tween(obj,goal)

TweenService:Create(
obj,
TweenInfo.new(.15),
goal
):Play()

end

-- draggable
local function Drag(frame)

local drag
local start
local startpos

frame.InputBegan:Connect(function(i)

if i.UserInputType == Enum.UserInputType.MouseButton1 then

drag = true
start = i.Position
startpos = frame.Position

end

end)

frame.InputEnded:Connect(function(i)

if i.UserInputType == Enum.UserInputType.MouseButton1 then

drag = false

end

end)

UIS.InputChanged:Connect(function(i)

if drag and i.UserInputType == Enum.UserInputType.MouseMovement then

local delta = i.Position - start

frame.Position =
UDim2.new(
startpos.X.Scale,
startpos.X.Offset + delta.X,
startpos.Y.Scale,
startpos.Y.Offset + delta.Y
)

end

end)

end

-- notification
function EternalUI:Notify(text)

local Noti = Instance.new("TextLabel")
Noti.Size = UDim2.new(0,200,0,30)
Noti.Position = UDim2.new(1,-210,1,-40)
Noti.BackgroundColor3 = Theme.Light
Noti.TextColor3 = Theme.Text
Noti.Text = text
Noti.Parent = PlayerGui

Corner(Noti)

Noti.BackgroundTransparency = 1
Tween(Noti,{BackgroundTransparency=0})

task.wait(3)

Tween(Noti,{BackgroundTransparency=1})

task.wait(.2)

Noti:Destroy()

end

-- window
function EternalUI:CreateWindow(cfg)

self:LoadConfig()

local gui = Instance.new("ScreenGui")
gui.Parent = PlayerGui

local main = Instance.new("Frame")
main.Size = UDim2.new(0,500,0,400)
main.Position = UDim2.new(.5,-250,.5,-200)
main.BackgroundColor3 = Theme.BG
main.Parent = gui
Corner(main)

Drag(main)

local tabs = Instance.new("Frame")
tabs.Size = UDim2.new(0,120,1,0)
tabs.BackgroundTransparency = 1
tabs.Parent = main

local pages = Instance.new("Frame")
pages.Size = UDim2.new(1,-120,1,0)
pages.Position = UDim2.new(0,120,0,0)
pages.BackgroundTransparency = 1
pages.Parent = main

local Window = {}

function Window:CreateTab(name)

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(1,0,0,30)
btn.BackgroundColor3 = Theme.Light
btn.Text = name
btn.TextColor3 = Theme.Text
btn.Parent = tabs
Corner(btn)

local page = Instance.new("Frame")
page.Size = UDim2.new(1,0,1,0)
page.Visible = false
page.BackgroundTransparency = 1
page.Parent = pages

btn.MouseButton1Click:Connect(function()

for _,v in pairs(pages:GetChildren()) do
v.Visible = false
end

page.Visible = true

end)

local Tab = {}

-- button
function Tab:Button(text,callback)

local b = btn:Clone()
b.Parent = page
b.Text = text

b.MouseButton1Click:Connect(callback)

end

-- toggle
function Tab:Toggle(text,callback)

local state = Config[text] or false

local t = btn:Clone()
t.Parent = page

local function refresh()

t.Text =
text..": "..(state and "ON" or "OFF")

end

refresh()

t.MouseButton1Click:Connect(function()

state = not state
Config[text]=state
refresh()
callback(state)
EternalUI:SaveConfig()

end)

end

-- slider
function Tab:Slider(text,min,max,callback)

local value = Config[text] or min

local frame = Instance.new("Frame")
frame.Size = UDim2.new(1,0,0,40)
frame.BackgroundColor3 = Theme.Light
frame.Parent = page
Corner(frame)

local bar = Instance.new("Frame")
bar.Size = UDim2.new(1,0,0,4)
bar.Position = UDim2.new(0,0,1,-6)
bar.BackgroundColor3 = Theme.Dim
bar.Parent = frame
Corner(bar)

local fill = Instance.new("Frame")
fill.BackgroundColor3 = Theme.Text
fill.Size = UDim2.new((value-min)/(max-min),0,1,0)
fill.Parent = bar
Corner(fill)

frame.InputBegan:Connect(function(i)

if i.UserInputType ==
Enum.UserInputType.MouseButton1 then

local pos =
(i.Position.X - bar.AbsolutePosition.X)
/ bar.AbsoluteSize.X

value =
math.floor(min+(max-min)*pos)

Config[text]=value

fill.Size =
UDim2.new(pos,0,1,0)

callback(value)

EternalUI:SaveConfig()

end

end)

end

-- dropdown
function Tab:Dropdown(text,list,callback)

local current =
Config[text] or list[1]

local d = btn:Clone()
d.Parent = page

d.Text =
text..": "..current

d.MouseButton1Click:Connect(function()

local index =
table.find(list,current)+1

if index>#list then
index=1
end

current=list[index]

Config[text]=current

d.Text =
text..": "..current

callback(current)

EternalUI:SaveConfig()

end)

end

-- keybind
function Tab:Keybind(text,default,callback)

local key =
Config[text] or default

local k = btn:Clone()
k.Parent = page

k.Text =
text..": "..key.Name

k.MouseButton1Click:Connect(function()

k.Text="Press key..."

local input =
UIS.InputBegan:Wait()

key=input.KeyCode

Config[text]=key.Name

k.Text =
text..": "..key.Name

EternalUI:SaveConfig()

end)

UIS.InputBegan:Connect(function(i)

if i.KeyCode==key then
callback()
end

end)

end

return Tab

end

return Window

end

return EternalUI
