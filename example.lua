local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/norixu/eternal-ui/refs/heads/main/source.lua"))()

local Window = UI:CreateWindow({

    Title = "Eternal UI",
    Size = UDim2.fromOffset(600,400)

})

Window:Notify("Loaded")

local Tab = Window:CreateTab("Main")

local Section = Tab:CreateSection("Player")

Section:CreateButton("Print", function()

    print("clicked")

end)

Section:CreateToggle("Godmode", function(v)

    print(v)

end)

Section:CreateTextbox("Enter Name", function(text)

    print(text)

end)

Section:CreateSlider("Speed",16,100,function(v)

    print(v)

end)

Section:CreateKeybind("Toggle UI",Enum.KeyCode.RightShift,function()

    print("pressed")

end)
