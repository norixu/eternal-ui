local colorSettings = {
	["Main"] = {
		["HeaderColor"] = Color3.fromRGB(22, 22, 22),
		["HeaderShadingColor"] = Color3.fromRGB(15, 15, 15),
		["HeaderTextColor"] = Color3.fromRGB(240, 240, 240),
		["MainBackgroundColor"] = Color3.fromRGB(18, 18, 18),
		["InfoScrollingFrameBgColor"] = Color3.fromRGB(18, 18, 18),
		["ScrollBarImageColor"] = Color3.fromRGB(255, 255, 255)
	},
	["RemoteButtons"] = {
		["BorderColor"] = Color3.fromRGB(45, 45, 45),
		["BackgroundColor"] = Color3.fromRGB(28, 28, 28),
		["TextColor"] = Color3.fromRGB(230, 230, 230),
		["NumberTextColor"] = Color3.fromRGB(200, 200, 200)
	},
	["MainButtons"] = {
		["BorderColor"] = Color3.fromRGB(45, 45, 45),
		["BackgroundColor"] = Color3.fromRGB(28, 28, 28),
		["TextColor"] = Color3.fromRGB(230, 230, 230)
	},
	['Code'] = {
		['BackgroundColor'] = Color3.fromRGB(20, 20, 20),
		['TextColor'] = Color3.fromRGB(230, 230, 230),
		['CreditsColor'] = Color3.fromRGB(110, 110, 110)
	},
}

local settings = {
	["Keybind"] = "F4"
}

function Parent(GUI)
	if syn and syn.protect_gui then
		syn.protect_gui(GUI)
		GUI.Parent = game:GetService("CoreGui")
	elseif PROTOSMASHER_LOADED then
		GUI.Parent = get_hidden_gui()
	else
		GUI.Parent = game:GetService("CoreGui")
	end
end

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

game.StarterGui.ResetPlayerGuiOnSpawn = false

local mouse = game.Players.LocalPlayer:GetMouse()

if game.CoreGui:FindFirstChild("TurtleSpyGUI") then
	game.CoreGui.TurtleSpyGUI:Destroy()
end

local Turtle = {}

function Turtle:Window(Text)
	local LEFT_PANEL_WIDTH = 220
	local RIGHT_PANEL_WIDTH = 360
	local EXPANDED_WIDTH = LEFT_PANEL_WIDTH + RIGHT_PANEL_WIDTH
	local HEADER_HEIGHT = 42
	local CONTENT_HEIGHT = 310

	local buttonOffset = 0

	local TurtleSpyGUI = Instance.new("ScreenGui")
	local mainFrame = Instance.new("Frame")
	local Header = Instance.new("Frame")
	local HeaderShading = Instance.new("Frame")
	local HeaderTextLabel = Instance.new("TextLabel")
	local RemoteScrollFrame = Instance.new("ScrollingFrame")
	local RemoteButton = Instance.new("TextButton")
	local RemoteName = Instance.new("TextLabel")
	local InfoFrame = Instance.new("Frame")
	local InfoFrameHeader = Instance.new("Frame")
	local InfoTitleShading = Instance.new("Frame")
	local InfoHeaderText = Instance.new("TextLabel")
	local CloseInfoFrame = Instance.new("TextButton")
	local OpenInfoFrame = Instance.new("TextButton")
	local Minimize = Instance.new("TextButton")

	TurtleSpyGUI.Name = "TurtleSpyGUI"
	Parent(TurtleSpyGUI)

	mainFrame.Name = "mainFrame"
	mainFrame.Parent = TurtleSpyGUI
	mainFrame.BackgroundColor3 = colorSettings["Main"]["MainBackgroundColor"]
	mainFrame.BorderSizePixel = 0
	mainFrame.Position = UDim2.new(0.1, 0, 0.2, 0)
	mainFrame.Size = UDim2.new(0, LEFT_PANEL_WIDTH, 0, HEADER_HEIGHT)
	mainFrame.ZIndex = 8
	mainFrame.Active = true
	mainFrame.Draggable = true

	local mainCorner = Instance.new("UICorner")
	mainCorner.CornerRadius = UDim.new(0, 16)
	mainCorner.Parent = mainFrame

	UserInputService.InputBegan:Connect(function(input)
		if input.KeyCode == Enum.KeyCode[settings["Keybind"]] then
			TurtleSpyGUI.Enabled = not TurtleSpyGUI.Enabled
		end
	end)

	Header.Name = "Header"
	Header.Parent = mainFrame
	Header.BackgroundColor3 = colorSettings["Main"]["HeaderColor"]
	Header.BorderSizePixel = 0
	Header.Size = UDim2.new(1, 0, 0, 32)
	Header.ZIndex = 9

	local headerCorner = Instance.new("UICorner")
	headerCorner.CornerRadius = UDim.new(0, 16)
	headerCorner.Parent = Header

	HeaderShading.Name = "HeaderShading"
	HeaderShading.Parent = Header
	HeaderShading.BackgroundColor3 = colorSettings["Main"]["HeaderShadingColor"]
	HeaderShading.BorderSizePixel = 0
	HeaderShading.Position = UDim2.new(0, 0, 0.3, 0)
	HeaderShading.Size = UDim2.new(1, 0, 0, 28)
	HeaderShading.ZIndex = 8

	local shadingCorner = Instance.new("UICorner")
	shadingCorner.CornerRadius = UDim.new(0, 16)
	shadingCorner.Parent = HeaderShading

	HeaderTextLabel.Name = "HeaderTextLabel"
	HeaderTextLabel.Parent = HeaderShading
	HeaderTextLabel.BackgroundTransparency = 1
	HeaderTextLabel.Position = UDim2.new(0.02, 0, 0.05, 0)
	HeaderTextLabel.Size = UDim2.new(0.95, 0, 0.9, 0)
	HeaderTextLabel.ZIndex = 10
	HeaderTextLabel.Font = Enum.Font.GothamBold
	HeaderTextLabel.Text = Text
	HeaderTextLabel.TextColor3 = colorSettings["Main"]["HeaderTextColor"]
	HeaderTextLabel.TextSize = 18
	HeaderTextLabel.TextXAlignment = Enum.TextXAlignment.Left

	RemoteScrollFrame.Name = "RemoteScrollFrame"
	RemoteScrollFrame.Parent = mainFrame
	RemoteScrollFrame.Active = true
	RemoteScrollFrame.BackgroundColor3 = colorSettings["Main"]["MainBackgroundColor"]
	RemoteScrollFrame.BorderSizePixel = 0
	RemoteScrollFrame.Position = UDim2.new(0, 0, 1, 5)
	RemoteScrollFrame.Size = UDim2.new(1, 0, 0, CONTENT_HEIGHT)
	RemoteScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
	RemoteScrollFrame.ScrollBarThickness = 3
	RemoteScrollFrame.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right
	RemoteScrollFrame.ScrollBarImageColor3 = colorSettings["Main"]["ScrollBarImageColor"]
	RemoteScrollFrame.ScrollBarImageTransparency = 0.4

	local scrollCorner = Instance.new("UICorner")
	scrollCorner.CornerRadius = UDim.new(0, 16)
	scrollCorner.Parent = RemoteScrollFrame

	RemoteButton.Name = "RemoteButton"
	RemoteButton.Parent = RemoteScrollFrame
	RemoteButton.BackgroundColor3 = colorSettings["RemoteButtons"]["BackgroundColor"]
	RemoteButton.BorderSizePixel = 0
	RemoteButton.Position = UDim2.new(0, 12, 0, 12)
	RemoteButton.Size = UDim2.new(1, -24, 0, 32)
	RemoteButton.Font = Enum.Font.Gotham
	RemoteButton.Text = ""
	RemoteButton.TextColor3 = colorSettings["RemoteButtons"]["TextColor"]
	RemoteButton.TextSize = 15
	RemoteButton.TextXAlignment = Enum.TextXAlignment.Left
	RemoteButton.Visible = false

	local remoteCorner = Instance.new("UICorner")
	remoteCorner.CornerRadius = UDim.new(0, 10)
	remoteCorner.Parent = RemoteButton

	RemoteName.Name = "RemoteName"
	RemoteName.Parent = RemoteButton
	RemoteName.BackgroundTransparency = 1
	RemoteName.Position = UDim2.new(0, 16, 0, 0)
	RemoteName.Size = UDim2.new(1, -40, 1, 0)
	RemoteName.Font = Enum.Font.Gotham
	RemoteName.Text = "Tab"
	RemoteName.TextColor3 = colorSettings["RemoteButtons"]["TextColor"]
	RemoteName.TextSize = 15
	RemoteName.TextXAlignment = Enum.TextXAlignment.Left

	InfoFrame.Name = "InfoFrame"
	InfoFrame.Parent = mainFrame
	InfoFrame.BackgroundColor3 = colorSettings["Main"]["MainBackgroundColor"]
	InfoFrame.BorderSizePixel = 0
	InfoFrame.Position = UDim2.new(1, 10, 0, 0)
	InfoFrame.Size = UDim2.new(0, RIGHT_PANEL_WIDTH, 0, HEADER_HEIGHT + CONTENT_HEIGHT)
	InfoFrame.Visible = false
	InfoFrame.ZIndex = 6

	local infoCorner = Instance.new("UICorner")
	infoCorner.CornerRadius = UDim.new(0, 16)
	infoCorner.Parent = InfoFrame

	InfoFrameHeader.Name = "InfoFrameHeader"
	InfoFrameHeader.Parent = InfoFrame
	InfoFrameHeader.BackgroundColor3 = colorSettings["Main"]["HeaderColor"]
	InfoFrameHeader.BorderSizePixel = 0
	InfoFrameHeader.Size = UDim2.new(1, 0, 0, 32)
	InfoFrameHeader.ZIndex = 14

	local infoHeaderCorner = Instance.new("UICorner")
	infoHeaderCorner.CornerRadius = UDim.new(0, 16)
	infoHeaderCorner.Parent = InfoFrameHeader

	InfoTitleShading.Name = "InfoTitleShading"
	InfoTitleShading.Parent = InfoFrame
	InfoTitleShading.BackgroundColor3 = colorSettings["Main"]["HeaderShadingColor"]
	InfoTitleShading.BorderSizePixel = 0
	InfoTitleShading.Position = UDim2.new(0, 0, 0, 0)
	InfoTitleShading.Size = UDim2.new(1, 0, 0, 32)
	InfoTitleShading.ZIndex = 13

	local titleShadingCorner = Instance.new("UICorner")
	titleShadingCorner.CornerRadius = UDim.new(0, 16)
	titleShadingCorner.Parent = InfoTitleShading

	InfoHeaderText.Name = "InfoHeaderText"
	InfoHeaderText.Parent = InfoFrame
	InfoHeaderText.BackgroundTransparency = 1
	InfoHeaderText.Position = UDim2.new(0.04, 0, 0.05, 0)
	InfoHeaderText.Size = UDim2.new(0.92, 0, 0.8, 0)
	InfoHeaderText.ZIndex = 18
	InfoHeaderText.Font = Enum.Font.GothamBold
	InfoHeaderText.Text = "Tab Name"
	InfoHeaderText.TextColor3 = colorSettings["Main"]["HeaderTextColor"]
	InfoHeaderText.TextSize = 18
	InfoHeaderText.TextXAlignment = Enum.TextXAlignment.Left

	local InfoFrameOpen = false

	CloseInfoFrame.Name = "CloseInfoFrame"
	CloseInfoFrame.Parent = InfoFrame
	CloseInfoFrame.BackgroundColor3 = colorSettings["Main"]["HeaderColor"]
	CloseInfoFrame.BorderSizePixel = 0
	CloseInfoFrame.Position = UDim2.new(1, -36, 0, 5)
	CloseInfoFrame.Size = UDim2.new(0, 26, 0, 26)
	CloseInfoFrame.ZIndex = 18
	CloseInfoFrame.Font = Enum.Font.Gotham
	CloseInfoFrame.Text = "✕"
	CloseInfoFrame.TextColor3 = Color3.fromRGB(200, 200, 200)
	CloseInfoFrame.TextSize = 18

	local closeCorner = Instance.new("UICorner")
	closeCorner.CornerRadius = UDim.new(0, 8)
	closeCorner.Parent = CloseInfoFrame

	CloseInfoFrame.MouseButton1Click:Connect(function()
		InfoFrame.Visible = false
		InfoFrameOpen = false
		TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, LEFT_PANEL_WIDTH, 0, HEADER_HEIGHT)}):Play()
	end)

	OpenInfoFrame.Name = "OpenInfoFrame"
	OpenInfoFrame.Parent = mainFrame
	OpenInfoFrame.BackgroundColor3 = colorSettings["Main"]["HeaderColor"]
	OpenInfoFrame.BorderSizePixel = 0
	OpenInfoFrame.Position = UDim2.new(1, -40, 0, 8)
	OpenInfoFrame.Size = UDim2.new(0, 26, 0, 26)
	OpenInfoFrame.ZIndex = 18
	OpenInfoFrame.Font = Enum.Font.Gotham
	OpenInfoFrame.Text = "›"
	OpenInfoFrame.TextColor3 = Color3.fromRGB(200, 200, 200)
	OpenInfoFrame.TextSize = 20

	local openCorner = Instance.new("UICorner")
	openCorner.CornerRadius = UDim.new(0, 8)
	openCorner.Parent = OpenInfoFrame

	OpenInfoFrame.MouseButton1Click:Connect(function()
		InfoFrame.Visible = not InfoFrame.Visible
		InfoFrameOpen = not InfoFrameOpen
		if InfoFrame.Visible then
			TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, EXPANDED_WIDTH, 0, HEADER_HEIGHT + CONTENT_HEIGHT)}):Play()
			OpenInfoFrame.Text = "‹"
		else
			TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, LEFT_PANEL_WIDTH, 0, HEADER_HEIGHT + CONTENT_HEIGHT)}):Play()
			OpenInfoFrame.Text = "›"
		end
	end)

	Minimize.Name = "Minimize"
	Minimize.Parent = mainFrame
	Minimize.BackgroundColor3 = colorSettings["Main"]["HeaderColor"]
	Minimize.BorderSizePixel = 0
	Minimize.Position = UDim2.new(1, -70, 0, 8)
	Minimize.Size = UDim2.new(0, 26, 0, 26)
	Minimize.ZIndex = 18
	Minimize.Font = Enum.Font.Gotham
	Minimize.Text = "–"
	Minimize.TextColor3 = Color3.fromRGB(200, 200, 200)
	Minimize.TextSize = 20

	local minCorner = Instance.new("UICorner")
	minCorner.CornerRadius = UDim.new(0, 8)
	minCorner.Parent = Minimize

	Minimize.MouseButton1Click:Connect(function()
		if RemoteScrollFrame.Visible then
			TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, LEFT_PANEL_WIDTH, 0, HEADER_HEIGHT)}):Play()
			InfoFrame.Visible = false
			RemoteScrollFrame.Visible = false
		else
			RemoteScrollFrame.Visible = true
			if InfoFrameOpen then
				TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, EXPANDED_WIDTH, 0, HEADER_HEIGHT + CONTENT_HEIGHT)}):Play()
				InfoFrame.Visible = true
			else
				TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, LEFT_PANEL_WIDTH, 0, HEADER_HEIGHT + CONTENT_HEIGHT)}):Play()
			end
		end
	end)

	local function addHoverEffect(element, normal, hover)
		element.MouseEnter:Connect(function()
			TweenService:Create(element, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = hover}):Play()
		end)
		element.MouseLeave:Connect(function()
			TweenService:Create(element, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundColor3 = normal}):Play()
		end)
	end

	addHoverEffect(CloseInfoFrame, colorSettings["Main"]["HeaderColor"], Color3.fromRGB(35, 35, 35))
	addHoverEffect(OpenInfoFrame, colorSettings["Main"]["HeaderColor"], Color3.fromRGB(35, 35, 35))
	addHoverEffect(Minimize, colorSettings["Main"]["HeaderColor"], Color3.fromRGB(35, 35, 35))

	local activeContent = nil

	local Window = {}

	function Window:Tab(name)
		local rButton = RemoteButton:Clone()
		rButton.Parent = RemoteScrollFrame
		rButton.Visible = true
		rButton.RemoteName.Text = name
		buttonOffset = buttonOffset + 42
		rButton.Position = UDim2.new(0, 12, 0, buttonOffset)
		RemoteScrollFrame.CanvasSize = UDim2.new(0, 0, 0, buttonOffset + 50)

		local tabButtonsScroll = Instance.new("ScrollingFrame")
		tabButtonsScroll.Name = "TabContent_" .. name
		tabButtonsScroll.Parent = InfoFrame
		tabButtonsScroll.Active = true
		tabButtonsScroll.BackgroundColor3 = colorSettings["Main"]["MainBackgroundColor"]
		tabButtonsScroll.BorderSizePixel = 0
		tabButtonsScroll.Position = UDim2.new(0, 18, 0, 48)
		tabButtonsScroll.Size = UDim2.new(1, -36, 1, -60)
		tabButtonsScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
		tabButtonsScroll.ScrollBarThickness = 3
		tabButtonsScroll.ScrollBarImageColor3 = colorSettings["Main"]["ScrollBarImageColor"]
		tabButtonsScroll.ScrollBarImageTransparency = 0.4
		tabButtonsScroll.Visible = false

		local tabScrollCorner = Instance.new("UICorner")
		tabScrollCorner.CornerRadius = UDim.new(0, 14)
		tabScrollCorner.Parent = tabButtonsScroll

		rButton.MouseButton1Click:Connect(function()
			if activeContent then activeContent.Visible = false end
			tabButtonsScroll.Visible = true
			activeContent = tabButtonsScroll
			InfoHeaderText.Text = name
		end)

		if not activeContent then
			tabButtonsScroll.Visible = true
			activeContent = tabButtonsScroll
		end

		local Tab = {}
		local tabButtonOffset = 12

		local function updateCanvas()
			tabButtonsScroll.CanvasSize = UDim2.new(0, 0, 0, tabButtonOffset + 20)
		end

		function Tab:Button(text, callback)
			local btn = Instance.new("TextButton")
			btn.Name = "Button"
			btn.Parent = tabButtonsScroll
			btn.BackgroundColor3 = colorSettings["MainButtons"]["BackgroundColor"]
			btn.BorderSizePixel = 0
			btn.Position = UDim2.new(0, 0, 0, tabButtonOffset)
			btn.Size = UDim2.new(1, 0, 0, 38)
			btn.Font = Enum.Font.Gotham
			btn.Text = text
			btn.TextColor3 = colorSettings["MainButtons"]["TextColor"]
			btn.TextSize = 15

			local btnCorner = Instance.new("UICorner")
			btnCorner.CornerRadius = UDim.new(0, 10)
			btnCorner.Parent = btn

			btn.MouseButton1Click:Connect(callback or function() end)
			addHoverEffect(btn, colorSettings["MainButtons"]["BackgroundColor"], Color3.fromRGB(38, 38, 38))

			tabButtonOffset = tabButtonOffset + 48
			updateCanvas()
			return btn
		end

		function Tab:Toggle(text, default, callback)
			local toggled = default or false
			local toggleFrame = Instance.new("Frame")
			toggleFrame.Name = "Toggle"
			toggleFrame.Parent = tabButtonsScroll
			toggleFrame.BackgroundTransparency = 1
			toggleFrame.Position = UDim2.new(0, 0, 0, tabButtonOffset)
			toggleFrame.Size = UDim2.new(1, 0, 0, 38)

			local label = Instance.new("TextLabel")
			label.Parent = toggleFrame
			label.BackgroundTransparency = 1
			label.Position = UDim2.new(0, 12, 0, 0)
			label.Size = UDim2.new(0.7, 0, 1, 0)
			label.Font = Enum.Font.Gotham
			label.Text = text
			label.TextColor3 = colorSettings["RemoteButtons"]["TextColor"]
			label.TextSize = 15
			label.TextXAlignment = Enum.TextXAlignment.Left

			local switch = Instance.new("Frame")
			switch.Name = "Switch"
			switch.Parent = toggleFrame
			switch.BackgroundColor3 = toggled and Color3.fromRGB(60, 180, 60) or Color3.fromRGB(50, 50, 50)
			switch.Position = UDim2.new(1, -60, 0.5, -11)
			switch.Size = UDim2.new(0, 52, 0, 22)

			local switchCorner = Instance.new("UICorner")
			switchCorner.CornerRadius = UDim.new(1, 0)
			switchCorner.Parent = switch

			local knob = Instance.new("Frame")
			knob.Name = "Knob"
			knob.Parent = switch
			knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			knob.Position = toggled and UDim2.new(1, -18, 0, 2) or UDim2.new(0, 2, 0, 2)
			knob.Size = UDim2.new(0, 18, 0, 18)

			local knobCorner = Instance.new("UICorner")
			knobCorner.CornerRadius = UDim.new(1, 0)
			knobCorner.Parent = knob

			switch.MouseButton1Click:Connect(function()
				toggled = not toggled
				TweenService:Create(switch, TweenInfo.new(0.2), {BackgroundColor3 = toggled and Color3.fromRGB(60, 180, 60) or Color3.fromRGB(50, 50, 50)}):Play()
				TweenService:Create(knob, TweenInfo.new(0.2), {Position = toggled and UDim2.new(1, -18, 0, 2) or UDim2.new(0, 2, 0, 2)}):Play()
				callback(toggled)
			end)

			tabButtonOffset = tabButtonOffset + 48
			updateCanvas()
			return toggleFrame
		end

		function Tab:Box(text, callback)
			local box = Instance.new("TextBox")
			box.Name = "Box"
			box.Parent = tabButtonsScroll
			box.BackgroundColor3 = colorSettings["RemoteButtons"]["BackgroundColor"]
			box.BorderSizePixel = 0
			box.Position = UDim2.new(0, 0, 0, tabButtonOffset)
			box.Size = UDim2.new(1, 0, 0, 38)
			box.Font = Enum.Font.Gotham
			box.PlaceholderText = text
			box.Text = ""
			box.TextColor3 = colorSettings["RemoteButtons"]["TextColor"]
			box.TextSize = 15
			box.ClearTextOnFocus = false

			local boxCorner = Instance.new("UICorner")
			boxCorner.CornerRadius = UDim.new(0, 10)
			boxCorner.Parent = box

			box.FocusLost:Connect(function(enterPressed)
				callback(box.Text, true)
			end)

			tabButtonOffset = tabButtonOffset + 48
			updateCanvas()
			return box
		end

		function Tab:Label(text, color)
			local label = Instance.new("TextLabel")
			label.Name = "Label"
			label.Parent = tabButtonsScroll
			label.BackgroundTransparency = 1
			label.Position = UDim2.new(0, 12, 0, tabButtonOffset)
			label.Size = UDim2.new(1, -24, 0, 28)
			label.Font = Enum.Font.Gotham
			label.Text = text
			label.TextColor3 = color or colorSettings["RemoteButtons"]["TextColor"]
			label.TextSize = 15
			label.TextXAlignment = Enum.TextXAlignment.Left

			tabButtonOffset = tabButtonOffset + 38
			updateCanvas()

			local api = {}
			function api:Text(newText)
				label.Text = newText
			end
			function api:Color(newColor)
				label.TextColor3 = newColor
			end
			return api
		end

		function Tab:Dropdown(text, options, callback, selective)
			local dropdown = Instance.new("TextButton")
			dropdown.Name = "Dropdown"
			dropdown.Parent = tabButtonsScroll
			dropdown.BackgroundColor3 = colorSettings["RemoteButtons"]["BackgroundColor"]
			dropdown.BorderSizePixel = 0
			dropdown.Position = UDim2.new(0, 0, 0, tabButtonOffset)
			dropdown.Size = UDim2.new(1, 0, 0, 38)
			dropdown.Font = Enum.Font.Gotham
			dropdown.Text = text
			dropdown.TextColor3 = colorSettings["RemoteButtons"]["TextColor"]
			dropdown.TextSize = 15
			dropdown.TextXAlignment = Enum.TextXAlignment.Left

			local ddCorner = Instance.new("UICorner")
			ddCorner.CornerRadius = UDim.new(0, 10)
			ddCorner.Parent = dropdown

			local arrow = Instance.new("TextLabel")
			arrow.Parent = dropdown
			arrow.BackgroundTransparency = 1
			arrow.Position = UDim2.new(1, -30, 0.5, -10)
			arrow.Size = UDim2.new(0, 20, 0, 20)
			arrow.Font = Enum.Font.Gotham
			arrow.Text = "▼"
			arrow.TextColor3 = Color3.fromRGB(180, 180, 180)
			arrow.TextSize = 14

			local list = Instance.new("ScrollingFrame")
			list.Name = "List"
			list.Parent = dropdown
			list.BackgroundColor3 = colorSettings["RemoteButtons"]["BackgroundColor"]
			list.BorderSizePixel = 0
			list.Position = UDim2.new(0, 0, 1, 6)
			list.Size = UDim2.new(1, 0, 0, 0)
			list.CanvasSize = UDim2.new(0, 0, 0, 0)
			list.ScrollBarThickness = 3
			list.Visible = false

			local listCorner = Instance.new("UICorner")
			listCorner.CornerRadius = UDim.new(0, 10)
			listCorner.Parent = list

			local listLayout = Instance.new("UIListLayout")
			listLayout.Parent = list
			listLayout.Padding = UDim.new(0, 4)
			listLayout.SortOrder = Enum.SortOrder.LayoutOrder

			dropdown.MouseButton1Click:Connect(function()
				list.Visible = not list.Visible
				arrow.Text = list.Visible and "▲" or "▼"
				if list.Visible then
					local height = 0
					for _, child in pairs(list:GetChildren()) do
						if child:IsA("TextButton") then
							height = height + 38
						end
					end
					TweenService:Create(list, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {Size = UDim2.new(1, 0, 0, math.min(height, 180))}):Play()
				else
					TweenService:Create(list, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 0)}):Play()
				end
			end)

			local function createOption(optText)
				local optBtn = Instance.new("TextButton")
				optBtn.Parent = list
				optBtn.BackgroundColor3 = colorSettings["RemoteButtons"]["BackgroundColor"]
				optBtn.BorderSizePixel = 0
				optBtn.Size = UDim2.new(1, 0, 0, 34)
				optBtn.Font = Enum.Font.Gotham
				optBtn.Text = optText
				optBtn.TextColor3 = colorSettings["RemoteButtons"]["TextColor"]
				optBtn.TextSize = 14
				optBtn.TextXAlignment = Enum.TextXAlignment.Left

				local optCorner = Instance.new("UICorner")
				optCorner.CornerRadius = UDim.new(0, 8)
				optCorner.Parent = optBtn

				optBtn.MouseButton1Click:Connect(function()
					callback(optText)
					if selective then
						dropdown.Text = optText
					end
					list.Visible = false
					arrow.Text = "▼"
				end)

				addHoverEffect(optBtn, colorSettings["RemoteButtons"]["BackgroundColor"], Color3.fromRGB(38, 38, 38))
				return optBtn
			end

			for _, opt in pairs(options or {}) do
				createOption(opt)
			end

			local ddApi = {}
			function ddApi:Button(newOpt)
				createOption(newOpt)
				local h = 0
				for _, c in pairs(list:GetChildren()) do
					if c:IsA("TextButton") then h = h + 38 end
				end
				list.CanvasSize = UDim2.new(0, 0, 0, h)
			end

			tabButtonOffset = tabButtonOffset + 48
			updateCanvas()
			return ddApi
		end

		function Tab:Slider(text, minVal, maxVal, defaultVal, callback)
			local value = defaultVal or minVal
			local sliderFrame = Instance.new("Frame")
			sliderFrame.Name = "Slider"
			sliderFrame.Parent = tabButtonsScroll
			sliderFrame.BackgroundTransparency = 1
			sliderFrame.Position = UDim2.new(0, 0, 0, tabButtonOffset)
			sliderFrame.Size = UDim2.new(1, 0, 0, 54)

			local desc = Instance.new("TextLabel")
			desc.Parent = sliderFrame
			desc.BackgroundTransparency = 1
			desc.Position = UDim2.new(0, 12, 0, 0)
			desc.Size = UDim2.new(1, -24, 0, 20)
			desc.Font = Enum.Font.Gotham
			desc.Text = text
			desc.TextColor3 = colorSettings["RemoteButtons"]["TextColor"]
			desc.TextSize = 15
			desc.TextXAlignment = Enum.TextXAlignment.Left

			local track = Instance.new("Frame")
			track.Name = "Track"
			track.Parent = sliderFrame
			track.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
			track.Position = UDim2.new(0, 12, 0, 28)
			track.Size = UDim2.new(1, -24, 0, 6)

			local trackCorner = Instance.new("UICorner")
			trackCorner.CornerRadius = UDim.new(1, 0)
			trackCorner.Parent = track

			local fill = Instance.new("Frame")
			fill.Name = "Fill"
			fill.Parent = track
			fill.BackgroundColor3 = Color3.fromRGB(80, 180, 255)
			fill.Size = UDim2.new((value - minVal) / (maxVal - minVal), 0, 1, 0)

			local fillCorner = Instance.new("UICorner")
			fillCorner.CornerRadius = UDim.new(1, 0)
			fillCorner.Parent = fill

			local knob = Instance.new("Frame")
			knob.Name = "Knob"
			knob.Parent = track
			knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			knob.Position = UDim2.new((value - minVal) / (maxVal - minVal), -8, 0.5, -8)
			knob.Size = UDim2.new(0, 16, 0, 16)

			local knobCorner = Instance.new("UICorner")
			knobCorner.CornerRadius = UDim.new(1, 0)
			knobCorner.Parent = knob

			local valLabel = Instance.new("TextLabel")
			valLabel.Parent = sliderFrame
			valLabel.BackgroundTransparency = 1
			valLabel.Position = UDim2.new(1, -50, 0, 28)
			valLabel.Size = UDim2.new(0, 40, 0, 20)
			valLabel.Font = Enum.Font.Gotham
			valLabel.Text = tostring(math.floor(value))
			valLabel.TextColor3 = colorSettings["RemoteButtons"]["TextColor"]
			valLabel.TextSize = 14

			local dragging = false

			local function updateSlider(x)
				local pos = math.clamp((x - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
				local newVal = minVal + (maxVal - minVal) * pos
				value = math.floor(newVal)
				fill.Size = UDim2.new(pos, 0, 1, 0)
				knob.Position = UDim2.new(pos, -8, 0.5, -8)
				valLabel.Text = tostring(value)
				callback(value)
			end

			track.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = true
					mainFrame.Active = false
					updateSlider(input.Position.X)
				end
			end)

			track.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = false
					mainFrame.Active = true
				end
			end)

			UserInputService.InputChanged:Connect(function(input)
				if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
					updateSlider(input.Position.X)
				end
			end)

			tabButtonOffset = tabButtonOffset + 64
			updateCanvas()

			local sliderApi = {}
			function sliderApi:SetValue(newVal)
				value = math.clamp(newVal, minVal, maxVal)
				local pos = (value - minVal) / (maxVal - minVal)
				fill.Size = UDim2.new(pos, 0, 1, 0)
				knob.Position = UDim2.new(pos, -8, 0.5, -8)
				valLabel.Text = tostring(math.floor(value))
			end
			return sliderApi
		end

		return Tab
	end

	local mobileGui = Instance.new("ScreenGui")
	Parent(mobileGui)
	local mobileToggle = Instance.new("TextButton")
	mobileToggle.Name = "MobileToggle"
	mobileToggle.Parent = mobileGui
	mobileToggle.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	mobileToggle.BackgroundTransparency = 0.9
	mobileToggle.Position = UDim2.new(1, -50, 1, -50)
	mobileToggle.Size = UDim2.new(0, 40, 0, 40)
	mobileToggle.Text = "≡"
	mobileToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
	mobileToggle.Font = Enum.Font.GothamBold
	mobileToggle.TextSize = 22
	mobileToggle.ZIndex = 999

	local mtCorner = Instance.new("UICorner")
	mtCorner.CornerRadius = UDim.new(0, 12)
	mtCorner.Parent = mobileToggle

	mobileToggle.MouseButton1Click:Connect(function()
		TurtleSpyGUI.Enabled = not TurtleSpyGUI.Enabled
	end)

	return Window
end

return Turtle
