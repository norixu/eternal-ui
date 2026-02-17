local EternalUI = {}
EternalUI.__index = EternalUI

-- services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- theme
EternalUI.Theme = {

    Background = Color3.fromRGB(15,15,15),
    Secondary = Color3.fromRGB(25,25,25),
    Element = Color3.fromRGB(35,35,35),

    Text = Color3.fromRGB(255,255,255),
    SubText = Color3.fromRGB(180,180,180),

    Accent = Color3.fromRGB(255,255,255),
    Outline = Color3.fromRGB(60,60,60)

}

-- tween helper
local function Tween(obj, time, props)

    TweenService:Create(

        obj,
        TweenInfo.new(time, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        props

    ):Play()

end

-- drag
local function MakeDraggable(frame, handle)

    handle = handle or frame

    local dragging = false
    local dragStart
    local startPos

    handle.InputBegan:Connect(function(input)

        if input.UserInputType == Enum.UserInputType.MouseButton1 then

            dragging = true
            dragStart = input.Position
            startPos = frame.Position

        end

    end)

    UIS.InputChanged:Connect(function(input)

        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then

            local delta = input.Position - dragStart

            frame.Position = UDim2.new(

                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y

            )

        end

    end)

    UIS.InputEnded:Connect(function(input)

        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end

    end)

end

-- window
function EternalUI:CreateWindow(config)

    config = config or {}

    local Window = {}
    Window.Tabs = {}

    -- gui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "EternalUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = PlayerGui

    -- main
    local Main = Instance.new("Frame")
    Main.Size = config.Size or UDim2.fromOffset(600,400)
    Main.Position = UDim2.fromScale(.5,.5)
    Main.AnchorPoint = Vector2.new(.5,.5)
    Main.BackgroundColor3 = self.Theme.Background
    Main.BorderColor3 = self.Theme.Outline
    Main.Parent = ScreenGui

    MakeDraggable(Main)

    -- title
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1,0,0,30)
    Title.BackgroundTransparency = 1
    Title.Text = config.Title or "Eternal UI"
    Title.TextColor3 = self.Theme.Text
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 14
    Title.Parent = Main

    -- tab holder
    local TabHolder = Instance.new("Frame")
    TabHolder.Size = UDim2.new(0,120,1,-30)
    TabHolder.Position = UDim2.fromOffset(0,30)
    TabHolder.BackgroundColor3 = self.Theme.Secondary
    TabHolder.Parent = Main

    -- container
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1,-120,1,-30)
    Container.Position = UDim2.fromOffset(120,30)
    Container.BackgroundTransparency = 1
    Container.Parent = Main

    -- notification
    function Window:Notify(text)

        local Notif = Instance.new("TextLabel")

        Notif.Size = UDim2.fromOffset(200,30)
        Notif.Position = UDim2.new(1,-210,1,-40)

        Notif.BackgroundColor3 = EternalUI.Theme.Element
        Notif.TextColor3 = EternalUI.Theme.Text

        Notif.Text = text
        Notif.Parent = ScreenGui

        Tween(Notif,.3,{Position = UDim2.new(1,-210,1,-80)})

        task.wait(3)

        Tween(Notif,.3,{Position = UDim2.new(1,-210,1,-40)})

        task.wait(.3)

        Notif:Destroy()

    end

    -- tab
    function Window:CreateTab(name)

        local Tab = {}
        Tab.Sections = {}

        local Button = Instance.new("TextButton")

        Button.Size = UDim2.new(1,0,0,30)
        Button.BackgroundColor3 = EternalUI.Theme.Element
        Button.TextColor3 = EternalUI.Theme.Text
        Button.Text = name

        Button.Parent = TabHolder

        local Page = Instance.new("Frame")
        Page.Size = UDim2.new(1,0,1,0)
        Page.Visible = false
        Page.Parent = Container

        Button.MouseButton1Click:Connect(function()

            for _,v in pairs(Container:GetChildren()) do
                v.Visible = false
            end

            Page.Visible = true

        end)

        -- section
        function Tab:CreateSection(name)

            local Section = {}

            local Frame = Instance.new("Frame")

            Frame.Size = UDim2.new(1,-10,0,200)
            Frame.BackgroundColor3 = EternalUI.Theme.Secondary

            Frame.Parent = Page

            local Layout = Instance.new("UIListLayout")
            Layout.Parent = Frame

            -- button
            function Section:CreateButton(text, callback)

                local Btn = Instance.new("TextButton")

                Btn.Size = UDim2.new(1,0,0,30)
                Btn.BackgroundColor3 = EternalUI.Theme.Element

                Btn.Text = text
                Btn.TextColor3 = EternalUI.Theme.Text

                Btn.Parent = Frame

                Btn.MouseButton1Click:Connect(callback)

            end

            -- toggle
            function Section:CreateToggle(text, callback)

                local State = false

                local Btn = Instance.new("TextButton")

                Btn.Size = UDim2.new(1,0,0,30)
                Btn.BackgroundColor3 = EternalUI.Theme.Element

                Btn.Text = text.." : OFF"
                Btn.TextColor3 = EternalUI.Theme.Text

                Btn.Parent = Frame

                Btn.MouseButton1Click:Connect(function()

                    State = not State

                    Btn.Text = text.." : "..(State and "ON" or "OFF")

                    callback(State)

                end)

            end

            -- textbox
            function Section:CreateTextbox(text, callback)

                local Box = Instance.new("TextBox")

                Box.Size = UDim2.new(1,0,0,30)
                Box.BackgroundColor3 = EternalUI.Theme.Element

                Box.PlaceholderText = text
                Box.TextColor3 = EternalUI.Theme.Text

                Box.Parent = Frame

                Box.FocusLost:Connect(function()

                    callback(Box.Text)

                end)

            end

            -- slider
            function Section:CreateSlider(text,min,max,callback)

                local Value = min

                local Btn = Instance.new("TextButton")

                Btn.Size = UDim2.new(1,0,0,30)
                Btn.BackgroundColor3 = EternalUI.Theme.Element

                Btn.Text = text.." : "..Value

                Btn.Parent = Frame

                Btn.MouseButton1Click:Connect(function()

                    Value += 1

                    if Value > max then
                        Value = min
                    end

                    Btn.Text = text.." : "..Value

                    callback(Value)

                end)

            end

            -- keybind
            function Section:CreateKeybind(text,key,callback)

                UIS.InputBegan:Connect(function(input)

                    if input.KeyCode == key then
                        callback()
                    end

                end)

            end

            return Section

        end

        return Tab

    end

    return Window

end

return EternalUI
