local library = {
	Color = Color3.fromRGB(26, 255, 160),
	Key = Enum.KeyCode.L,
	LogColor = Color3.new(1, 1, 1)
}

local Main = Instance.new("ScreenGui", game.CoreGui)
local WaterMark = Instance.new("TextLabel", Main)
WaterMark .Size = UDim2.new(0, 180, 0, 20)
WaterMark .BackgroundColor3 = Color3.fromRGB(30, 30, 30)
WaterMark .TextColor3 = Color3.fromRGB(200, 200, 200)
WaterMark .MouseEnter:Connect(function()
    game:GetService("TweenService"):Create(b, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
end)

WaterMark.MouseLeave:Connect(function()
    game:GetService("TweenService"):Create(b, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
end)

game.RunService.RenderStepped:Connect(function()
WaterMark .BorderColor3 = library.Color
    WaterMark.Text = "uwuhub v1.0.0 rewrite | FPS: "..math.floor(1/wait())
end)

function library:CreateWindow(title)
	local window = {}
    title = title or "Window"
    local ColorCounterRainbow = 0
    local ColorPickerHuePosition = 0

    spawn(function()
        while wait() do
            ColorCounterRainbow = ColorCounterRainbow + 1/255
            if ColorCounterRainbow >= 1 then
                ColorCounterRainbow = 0
            end
            ColorPickerHuePosition = ColorPickerHuePosition + 1
            if ColorPickerHuePosition == 102 then
                ColorPickerHuePosition = 0
            end
        end
    end)
	
	local LIB = Instance.new("ScreenGui")
	local MainGUIHolder = Instance.new("Frame")
	local TopBar = Instance.new("Frame")
	local TabsHolder = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")
	local Title = Instance.new("TextLabel")
	local CloseButton = Instance.new("ImageButton")
	
	LIB.Name = "LIB"
	LIB.Parent = game.CoreGui
	LIB.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	
	MainGUIHolder.Name = "MainGUIHolder"
	MainGUIHolder.Parent = LIB
    MainGUIHolder.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    game:GetService("RunService").RenderStepped:Connect(function()
        MainGUIHolder.BorderColor3 = library.Color
    end)
	MainGUIHolder.ClipsDescendants = true
	MainGUIHolder.Position = UDim2.new(0.324491054, 0, 0.246928751, 0)
	MainGUIHolder.Size = UDim2.new(0, 568, 0, 412)
	
	TopBar.Name = "TopBar"
	TopBar.Parent = MainGUIHolder
	TopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	TopBar.BorderColor3 = Color3.fromRGB(13, 13, 13)
	TopBar.Size = UDim2.new(0, 568, 0, 51)
	
	TabsHolder.Name = "TabsHolder"
	TabsHolder.Parent = TopBar
	TabsHolder.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	TabsHolder.BorderColor3 = Color3.fromRGB(13, 13, 13)
	TabsHolder.Position = UDim2.new(0.267605633, 0, 0, 0)
	TabsHolder.Size = UDim2.new(0, 416, 0, 51)
	
	UIListLayout.Parent = TabsHolder
	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	
	Title.Name = "Title"
	Title.Parent = TopBar
	Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title.BackgroundTransparency = 1.000
	Title.BorderSizePixel = 0
	Title.Size = UDim2.new(0, 152, 0, 50)
	Title.Font = Enum.Font.SourceSans
    Title.Text = title
    game:GetService("RunService").RenderStepped:Connect(function()
    Title.TextColor3 = library.Color
    end)
	Title.TextSize = 16.000
	Title.TextStrokeTransparency = 0.000
	
	CloseButton.Name = "CloseButton"
	CloseButton.Parent = MainGUIHolder
	CloseButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	CloseButton.BackgroundTransparency = 1.000
	CloseButton.Position = UDim2.new(0.970070422, 0, 0.956310689, 0)
	CloseButton.Rotation = 50.000
	CloseButton.Size = UDim2.new(0, 17, 0, 17)
	CloseButton.AutoButtonColor = false
    CloseButton.Image = "rbxassetid://5238501683"
    game:GetService("RunService").RenderStepped:Connect(function()
    CloseButton.ImageColor3 = library.Color
    end)
    
    function dragify(Frame)
        dragToggle = nil
        dragSpeed = .25
        dragInput = nil
        dragStart = nil
        dragPos = nil
        
        function updateInput(input)
            Delta = input.Position - dragStart
            Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
            game:GetService("TweenService"):Create(Frame, TweenInfo.new(.25), {Position = Position}):Play()
        end
        
        Frame.InputBegan:Connect(function(input)
            if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                dragToggle = true
                dragStart = input.Position
                startPos = Frame.Position
                input.Changed:Connect(function()
                    if (input.UserInputState == Enum.UserInputState.End) then
                        dragToggle = false
                    end
                end)
            end
        end)
        
        Frame.InputChanged:Connect(function(input)
            if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                dragInput = input
            end
        end)
        
        game:GetService("UserInputService").InputChanged:Connect(function(input)
            if (input == dragInput and dragToggle) then
                updateInput(input)
            end
        end)
    end

    dragify(MainGUIHolder)
	
	local Tabs = 0
	
	function window:CreateTab(title)
		Tabs = Tabs + 1
		local tab = {}
		title = title or "Tab"
		
		local Tab = Instance.new("TextButton")
		local SectionStuffHolder = Instance.new("Frame")
		local UIPadding = Instance.new("UIPadding")
		local UIListLayout_2 = Instance.new("UIListLayout")
		
		Tab.Name = "Tab"
		Tab.Parent = TabsHolder
		Tab.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
		Tab.BorderColor3 = Color3.fromRGB(13, 13, 13)
		
		game["Run Service"].RenderStepped:Connect(function()
			Tab.Size = UDim2.new(0, TabsHolder.Size.X.Offset/Tabs, 0, 51)
		end)
		
		Tab.AutoButtonColor = false
		Tab.Font = Enum.Font.SourceSans
		Tab.Text = title
		Tab.TextColor3 = Color3.fromRGB(200, 200, 200)
		Tab.TextSize = 14.000
		Tab.TextStrokeTransparency = 0.000
		
		SectionStuffHolder.Name = "SectionStuffHolder"
		SectionStuffHolder.Parent = MainGUIHolder
		SectionStuffHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SectionStuffHolder.BackgroundTransparency = 1.000
		SectionStuffHolder.BorderSizePixel = 0
		SectionStuffHolder.Position = UDim2.new(0, 0, 0.123786405, 0)
		SectionStuffHolder.Size = UDim2.new(0, 568, 0, 361)
		SectionStuffHolder.Visible = false
		
		UIPadding.Parent = SectionStuffHolder
		UIPadding.PaddingBottom = UDim.new(0, 18)
		UIPadding.PaddingLeft = UDim.new(0, 18)
		UIPadding.PaddingTop = UDim.new(0, 18)
		
		UIListLayout_2.Parent = SectionStuffHolder
		UIListLayout_2.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_2.Padding = UDim.new(0, 24)
		
		function tab:CreateSection(title)
			local section = {}
			title = title or "Section"
			
			local Sec = Instance.new("Frame")
			local Section2 = Instance.new("ScrollingFrame")
			local UIListLayout_3 = Instance.new("UIListLayout")
			local UIPadding_2 = Instance.new("UIPadding")
			local SecT = Instance.new("TextLabel")
			
			Sec.Name = "Sec"
			Sec.Parent = SectionStuffHolder
			Sec.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Sec.BackgroundTransparency = 1.000
			Sec.BorderSizePixel = 0
			Sec.Size = UDim2.new(0, 255, 0, 325)
			
			Section2.Name = "Section2"
			Section2.Parent = Sec
			Section2.Active = true
			Section2.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
			Section2.BorderColor3 = Color3.fromRGB(13, 13, 13)
			Section2.Size = UDim2.new(0, 255, 0, 325)
			Section2.ScrollBarThickness = 0
Section2.CanvasSize = UDim2.new(0, 0, 4, 0)
			
			UIListLayout_3.Parent = Section2
			UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout_3.Padding = UDim.new(0, 4)
			
			UIPadding_2.Parent = Section2
			UIPadding_2.PaddingBottom = UDim.new(0, 8)
			UIPadding_2.PaddingLeft = UDim.new(0, 8)
			UIPadding_2.PaddingRight = UDim.new(0, 8)
			UIPadding_2.PaddingTop = UDim.new(0, 8)
			
			SecT.Name = "SecT"
			SecT.Parent = Sec
			SecT.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
			SecT.BorderSizePixel = 0
			SecT.Position = UDim2.new(0.337040871, 0, -0.0316661447, 0)
			SecT.Size = UDim2.new(0, 76, 0, 17)
			SecT.Font = Enum.Font.SourceSans
			SecT.Text = title
			SecT.TextColor3 = Color3.fromRGB(200, 200, 200)
			SecT.TextSize = 14.000
			SecT.TextStrokeTransparency = 0.000
            local Change = false
            Tab.MouseEnter:Connect(function()
                if Tab.TextColor3 ~= Color3.new(255, 255, 255) then
                    Change = true
                    game:GetService("TweenService"):Create(Tab, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                else
                    Change = false
                end
            end)

            Tab.MouseLeave:Connect(function()
                if Change then
                    game:GetService("TweenService"):Create(Tab, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
                end
            end)

            Section2.MouseEnter:Connect(function()
                game:GetService("TweenService"):Create(SecT, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
            end)

            Section2.MouseLeave:Connect(function()
                game:GetService("TweenService"):Create(SecT, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
            end)

			Tab.MouseButton1Down:Connect(function()
                if SectionStuffHolder.Visible == false then
                    game:GetService("TweenService"):Create(Tab, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
					SectionStuffHolder.Visible = true
					for i, v in pairs(MainGUIHolder:GetChildren()) do
						if v.Name:find("StuffHolder") and v ~= SectionStuffHolder then
							v.Visible = false
						end
                    end
                    
                    for i, v in pairs(TabsHolder:GetChildren()) do
                        if v:IsA("TextButton") and v ~= Tab then
                            game:GetService("TweenService"):Create(v, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()        
                        end
                    end
				end
			end)
			
			function section:CreateButton(title, func)
				local button = {}
				title = title or "Button"
				func = func or function() end
				
				local Button = Instance.new("TextButton")
				
				Button.Name = "Button"
				Button.Parent = Section2
				Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
				Button.BorderColor3 = Color3.fromRGB(13, 13, 13)
				Button.Position = UDim2.new(0.0313725509, 0, 0.0286738351, 0)
				Button.Size = UDim2.new(0, 239, 0, 25)
				Button.AutoButtonColor = false
				Button.Font = Enum.Font.SourceSans
				Button.TextColor3 = Color3.fromRGB(200, 200, 200)
				Button.TextSize = 14.000
				Button.Text = title
				Button.TextStrokeTransparency = 0.000
                
                Button.MouseEnter:Connect(function()
                    game:GetService("TweenService"):Create(Button, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                end)

                Button.MouseLeave:Connect(function()
                    game:GetService("TweenService"):Create(Button, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
                end)

				Button.MouseButton1Down:Connect(func)
				
				function button:Press()
					func()
				end
				
				return button
			end
			
			function section:CreateToggle(title, default, func)
				local toggle = {}
				title = title or "Toggle"
				if type(default) == "function" and not func then
					func = default
					default = false
				end
				
				default = default or false
				func = func or function() end
				
				toggle.Toggled = default
				
				local ToggleButton = Instance.new("TextButton")
				local ToggleTitle = Instance.new("TextLabel")
				local ToggleToggle = Instance.new("TextButton")
				
				ToggleButton.Name = "ToggleButton"
				ToggleButton.Parent = Section2
				ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
				ToggleButton.BorderColor3 = Color3.fromRGB(13, 13, 13)
				ToggleButton.Position = UDim2.new(0.0313725509, 0, 0.0286738351, 0)
				ToggleButton.Size = UDim2.new(0, 239, 0, 25)
				ToggleButton.AutoButtonColor = false
				ToggleButton.Font = Enum.Font.SourceSans
				ToggleButton.Text = ""
				ToggleButton.TextColor3 = Color3.fromRGB(200, 200, 200)
				ToggleButton.TextSize = 14.000
				ToggleButton.TextStrokeTransparency = 0.000
				
				ToggleTitle.Name = "ToggleTitle"
				ToggleTitle.Parent = ToggleButton
				ToggleTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ToggleTitle.BackgroundTransparency = 1.000
				ToggleTitle.BorderSizePixel = 0
				ToggleTitle.Position = UDim2.new(0.0251046028, 0, 0, 0)
				ToggleTitle.Size = UDim2.new(0, 233, 0, 25)
				ToggleTitle.Font = Enum.Font.SourceSans
				ToggleTitle.Text = title
				ToggleTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
				ToggleTitle.TextSize = 14.000
				ToggleTitle.TextStrokeTransparency = 0.000
				ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left
				
				ToggleToggle.Name = "ToggleToggle"
				ToggleToggle.Parent = ToggleButton
				ToggleToggle.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
				ToggleToggle.BorderColor3 = Color3.fromRGB(13, 13, 13)
				ToggleToggle.Position = UDim2.new(0.907949805, 0, 0.159999996, 0)
				ToggleToggle.Size = UDim2.new(0, 16, 0, 16)
				ToggleToggle.AutoButtonColor = false
				ToggleToggle.Font = Enum.Font.SourceSans
				ToggleToggle.Text = utf8.char(10003)
				ToggleToggle.TextTransparency = default and 0 or 1
				ToggleToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
				ToggleToggle.TextSize = 14.000
				ToggleToggle.TextYAlignment = Enum.TextYAlignment.Top	
				
				if default then
					func(default)
                end
                
                ToggleButton.MouseEnter:Connect(function()
                    game:GetService("TweenService"):Create(ToggleTitle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                end)

                ToggleButton.MouseLeave:Connect(function()
                    game:GetService("TweenService"):Create(ToggleTitle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
                end)

				ToggleButton.MouseButton1Down:Connect(function()
					if toggle.Toggled then
						toggle.Toggled = false
                        func(toggle.Toggled)
                        game:GetService("TweenService"):Create(ToggleToggle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
					else
						toggle.Toggled = true
                        func(toggle.Toggled)
                        game:GetService("TweenService"):Create(ToggleToggle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
                    end
                end)
                
                ToggleToggle.MouseEnter:Connect(function()
                    game:GetService("TweenService"):Create(ToggleTitle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                end)

                ToggleToggle.MouseLeave:Connect(function()
                    game:GetService("TweenService"):Create(ToggleTitle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
				end)
				
				ToggleToggle.MouseButton1Down:Connect(function()
					if toggle.Toggled then
						toggle.Toggled = false
						func(toggle.Toggled)
						game:GetService("TweenService"):Create(ToggleToggle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
					else
						toggle.Toggled = true
						func(toggle.Toggled)
						game:GetService("TweenService"):Create(ToggleToggle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
					end
				end)
				
				function toggle:SetToggled(toggled)
					if toggled then
						toggle.Toggled = true
						func(toggle.Toggled)
						game:GetService("TweenService"):Create(ToggleToggle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
					else
						toggle.Toggled = false
						func(toggle.Toggled)
						game:GetService("TweenService"):Create(ToggleToggle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
					end
				end
				
				return toggle
			end
			
			function section:CreateTextbox(title, placeholder, default, func)
				local textbox = {}
				if type(placeholder) == "function" and not default and not func then
					func = placeholder
					placeholder = ""
					default = ""
				end
				
				title =	title or "TextBox"
				placeholder = placeholder or ""
				default = default or ""
				func = func or function() end 
				
				
				local TextBoxBack = Instance.new("Frame")
				local TextBoxTitle = Instance.new("TextLabel")
				local TextBoxText = Instance.new("TextBox")
				
				TextBoxBack.Name = "TextBoxBack"
				TextBoxBack.Parent = Section2
				TextBoxBack.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
				TextBoxBack.BorderColor3 = Color3.fromRGB(13, 13, 13)
				TextBoxBack.Size = UDim2.new(0, 239, 0, 25)
				
				TextBoxTitle.Name = "TextBoxTitle"
				TextBoxTitle.Parent = TextBoxBack
				TextBoxTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextBoxTitle.BackgroundTransparency = 1.000
				TextBoxTitle.BorderSizePixel = 0
				TextBoxTitle.Position = UDim2.new(0.0251046028, 0, 0, 0)
				TextBoxTitle.Size = UDim2.new(0, 233, 0, 25)
				TextBoxTitle.Font = Enum.Font.SourceSans
				TextBoxTitle.Text = title
				TextBoxTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
				TextBoxTitle.TextSize = 14.000
				TextBoxTitle.TextStrokeTransparency = 0.000
				TextBoxTitle.TextXAlignment = Enum.TextXAlignment.Left
				
				TextBoxText.Name = "TextBoxText"
				TextBoxText.Parent = TextBoxBack
				TextBoxText.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
				TextBoxText.BorderColor3 = Color3.fromRGB(13, 13, 13)
				TextBoxText.Position = UDim2.new(0.424048871, 0, 0.161632076, 0)
				TextBoxText.Size = UDim2.new(0, 132, 0, 16)
				TextBoxText.ClearTextOnFocus = false
				TextBoxText.Font = Enum.Font.SourceSans
				TextBoxText.PlaceholderText = placeholder
				TextBoxText.Text = default
				TextBoxText.TextColor3 = Color3.fromRGB(200, 200, 200)
                TextBoxText.TextSize = 14.000
                
                TextBoxBack.MouseEnter:Connect(function()
                    game:GetService("TweenService"):Create(TextBoxTitle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                end)

                TextBoxBack.MouseLeave:Connect(function()
                    game:GetService("TweenService"):Create(TextBoxTitle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
                end)
				
				TextBoxText.FocusLost:Connect(function()
					func(TextBoxText.Text)
				end)
				
				function textbox:SetText(text)
					TextBoxText.Text = text
					func(text)
				end
				
				return textbox
            end

            function section:CreateKeybind(title, default, func)
                local keybind = {}
                title = title or "Keybind"
                default = default or ". . ."
                func = func or function() end

                local KeybindBack = Instance.new("Frame")
                local KeybindTitle = Instance.new("TextLabel")
                local KeybindButton = Instance.new("TextButton")

                KeybindBack.Name = "KeybindBack"
                KeybindBack.Parent = Section2
                KeybindBack.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                KeybindBack.BorderColor3 = Color3.fromRGB(13, 13, 13)
                KeybindBack.Size = UDim2.new(0, 239, 0, 25)

                KeybindTitle.Name = "KeybindTitle"
                KeybindTitle.Parent = KeybindBack
                KeybindTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                KeybindTitle.BackgroundTransparency = 1.000
                KeybindTitle.BorderSizePixel = 0
                KeybindTitle.Position = UDim2.new(0.0251046028, 0, 0, 0)
                KeybindTitle.Size = UDim2.new(0, 233, 0, 25)
                KeybindTitle.Font = Enum.Font.SourceSans
                KeybindTitle.Text = title
                KeybindTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
                KeybindTitle.TextSize = 14.000
                KeybindTitle.TextStrokeTransparency = 0.000
                KeybindTitle.TextXAlignment = Enum.TextXAlignment.Left

                KeybindButton.Name = "KeybindButton"
                KeybindButton.Parent = KeybindBack
                KeybindButton.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                KeybindButton.BorderColor3 = Color3.fromRGB(13, 13, 13)
                KeybindButton.Position = UDim2.new(0.42259413, 0, 0.200000003, 0)
                KeybindButton.Size = UDim2.new(0, 132, 0, 16)
                KeybindButton.AutoButtonColor = false
                KeybindButton.Font = Enum.Font.SourceSans
                KeybindButton.Text = tostring(default):gsub("Enum.KeyCode.", "")
                KeybindButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                KeybindButton.TextSize = 14.000

                function parse(keycode)
                    return tostring(keycode):gsub("Enum.KeyCode.", "")
                end

                local LastBindText = parse(default)
                local BindedKey = default
                local JustBinded = false

                KeybindBack.MouseEnter:Connect(function()
                    game:GetService("TweenService"):Create(KeybindTitle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                end)

                KeybindBack.MouseLeave:Connect(function()
                    game:GetService("TweenService"):Create(KeybindTitle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
                end)

                KeybindButton.MouseButton1Click:Connect(function()
                    KeybindButton.Text = ". . ."
                    IsKeyBinding = true

                    UISConnection = game:GetService("UserInputService").InputBegan:Connect(function(input)
                        BindedKey = input.KeyCode
                        KeybindButton.Text = parse(BindedKey)
                        LastBindText = KeybindButton.Text

                        JustBinded = true
                        IsKeyBinding = false
                        UISConnection:Disconnect()
                    end)
                end)

                game:GetService("UserInputService").InputBegan:Connect(function()
                    if not JustBinded then
                        func(BindedKey)
                    end

                    if JustBinded then
                        JustBinded = false
                    end
                end)

                KeybindButton.MouseLeave:Connect(function()
                    KeybindButton.Text = LastBindText
                    IsKeyBinding = false
                end)

                function keybind:SetKey(key)
                    func(key)
                    KeybindButton.Text = parse(key)
                end

                return keybind
            end

            function section:CreateSlider(title, min, max, default, round, func)
                local slider = {}
                min = min or 0
                max = max or 1
                default = default or 0
                round = round or false
                func = func or function() end

                local SliderBackFrame = Instance.new("Frame")
                local SliderTitle = Instance.new("TextLabel")
                local SliderValue = Instance.new("TextBox")
                local SliderBackButton = Instance.new("TextButton")
                local SliderHandle = Instance.new("TextButton")

                SliderBackFrame.Name = "SliderBackFrame"
                SliderBackFrame.Parent = Section2
                SliderBackFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                SliderBackFrame.BorderColor3 = Color3.fromRGB(13, 13, 13)
                SliderBackFrame.Position = UDim2.new(0.0313725509, 0, 0.0286738351, 0)
                SliderBackFrame.Size = UDim2.new(0, 239, 0, 49)

                SliderTitle.Name = "SliderTitle"
                SliderTitle.Parent = SliderBackFrame
                SliderTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderTitle.BackgroundTransparency = 1.000
                SliderTitle.BorderSizePixel = 0
                SliderTitle.Position = UDim2.new(0.0251046028, 0, 0, 0)
                SliderTitle.Size = UDim2.new(0, 233, 0, 25)
                SliderTitle.Font = Enum.Font.SourceSans
                SliderTitle.Text = title
                SliderTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
                SliderTitle.TextSize = 14.000
                SliderTitle.TextStrokeTransparency = 0.000
                SliderTitle.TextXAlignment = Enum.TextXAlignment.Left

                SliderValue.Name = "SliderValue"
                SliderValue.Parent = SliderBackFrame
                SliderValue.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                SliderValue.BorderColor3 = Color3.fromRGB(13, 13, 13)
                SliderValue.Position = UDim2.new(0.849372447, 0, 0.0816326439, 0)
                SliderValue.Size = UDim2.new(0, 30, 0, 16)
                SliderValue.ClearTextOnFocus = false
                SliderValue.Font = Enum.Font.SourceSans
                SliderValue.Text = default
                SliderValue.TextColor3 = Color3.fromRGB(200, 200, 200)
                SliderValue.TextSize = 14.000

                SliderBackButton.Name = "SliderBackButton"
                SliderBackButton.Parent = SliderBackFrame
                SliderBackButton.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                SliderBackButton.BorderColor3 = Color3.fromRGB(13, 13, 13)
                SliderBackButton.Position = UDim2.new(0.0251046028, 0, 0.755102038, 0)
                SliderBackButton.Size = UDim2.new(0, 227, 0, 7)
                SliderBackButton.AutoButtonColor = false
                SliderBackButton.Font = Enum.Font.SourceSans
                SliderBackButton.Text = ""
                SliderBackButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                SliderBackButton.TextSize = 14.000
                SliderBackButton.ClipsDescendants = true

                SliderHandle.Name = "SliderHandle"
                SliderHandle.Parent = SliderBackButton
                game:GetService("RunService").RenderStepped:Connect(function()
                SliderHandle.BackgroundColor3 = library.Color
                end)
                SliderHandle.BorderColor3 = Color3.fromRGB(13, 13, 13)
                SliderHandle.Size = UDim2.new(((default) - min) / (max - min), 0, 0, 7)
                SliderHandle.AutoButtonColor = false
                SliderHandle.Font = Enum.Font.SourceSans
                SliderHandle.Text = ""
                SliderHandle.TextColor3 = Color3.fromRGB(0, 0, 0)
                SliderHandle.TextSize = 14.000

                SliderBackFrame.MouseEnter:Connect(function()
                    game:GetService("TweenService"):Create(SliderTitle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                end)

                SliderBackFrame.MouseLeave:Connect(function()
                    game:GetService("TweenService"):Create(SliderTitle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
                end)

                func(default)

                local MouseDown = false
                local value = default
                
                function map(x, in_min, in_max, out_min, out_max)
                    return out_min + (x - in_min)*(out_max - out_min)/(in_max - in_min)
                end
                
                SliderHandle.MouseButton1Down:Connect(function()
                    MouseDown = true
                end)

                SliderBackButton.MouseButton1Down:Connect(function()
                    MouseDown = true
                end)

                game:GetService("UserInputService").InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        MouseDown = false
                    end
                end)
                
                game:GetService("RunService").RenderStepped:Connect(function()
                    local UIStart = SliderBackButton.AbsolutePosition.X
                    local UIEnd = SliderBackButton.AbsolutePosition.X + SliderBackButton.AbsoluteSize.X
                    if MouseDown then
                        local range = map(game:GetService("Players").LocalPlayer:GetMouse().X, UIStart, UIEnd, 0, 1)
                        range = math.clamp(range, 0, 1)
                        if not round then
                            value = math.floor(map(range, 0, 1, min, max) * 100) / 100
                        else
                            value = math.floor(map(range, 0, 1, min, max))
                        end
                        SliderHandle:TweenSize(UDim2.new(range,0,0,7), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, .2, true)
                        SliderValue.Text = value
                        func(value)
                    end
                end)

                function slider:SetValue(val)
                    if val > max then
                        SliderHandle.Size = UDim2.new(((max) - min) / (max - min), 0, 0, 7)
                        value = max
                        func(max)
                        SliderValue.Text = max
                    elseif val < max and val > min then
                        SliderHandle.Size = UDim2.new(((val) - min) / (max - min), 0, 0, 7)
                        value = val
                        func(val)
                    elseif val < min then
                        SliderHandle.Size = UDim2.new(((min) - min) / (max - min), 0, 0, 7)
                        value = min
                        func(min)
                        SliderValue.Text = min
                    end
                end

                local Change = false
                SliderValue.Focused:Connect(function()
                    Change = true
                end)

                SliderValue.FocusLost:Connect(function()
                    Change = false
                end)

                game:GetService("RunService").RenderStepped:Connect(function()
                    if Change then
                        slider:SetValue(tonumber(SliderValue.Text))
                    end
                end)

                return slider
            end

            function section:CreateDropdown(title, options, default, func)
                local dropdown = {}
                title = title or "Dropdown"
                options = options or {}
                default = default or 1
                func = func or function() end

                local Dropdown = Instance.new("TextButton")
                local DropdownTitle = Instance.new("TextLabel")
                local DropdownOptions = Instance.new("Frame")
                local UIListLayout_6 = Instance.new("UIListLayout")
                local UIPadding_5 = Instance.new("UIPadding")
                local DropdownToggle = Instance.new("ImageButton")

                Dropdown.Name = "Dropdown"
                Dropdown.Parent = Section2
                Dropdown.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                Dropdown.BorderColor3 = Color3.fromRGB(13, 13, 13)
                Dropdown.Position = UDim2.new(0.0313725509, 0, 0.0286738351, 0)
                Dropdown.Size = UDim2.new(0, 239, 0, 25)
                Dropdown.AutoButtonColor = false
                Dropdown.Font = Enum.Font.SourceSans
                Dropdown.Text = ""
                Dropdown.TextColor3 = Color3.fromRGB(200, 200, 200)
                Dropdown.TextSize = 14.000
                Dropdown.TextStrokeTransparency = 0.000

                DropdownTitle.Name = "DropdownTitle"
                DropdownTitle.Parent = Dropdown
                DropdownTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropdownTitle.BackgroundTransparency = 1.000
                DropdownTitle.BorderSizePixel = 0
                DropdownTitle.Position = UDim2.new(0.0251046028, 0, 0, 0)
                DropdownTitle.Size = UDim2.new(0, 233, 0, 25)
                DropdownTitle.Font = Enum.Font.SourceSans
                DropdownTitle.Text = title
                DropdownTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
                DropdownTitle.TextSize = 14.000
                DropdownTitle.TextStrokeTransparency = 0.000
                DropdownTitle.TextXAlignment = Enum.TextXAlignment.Left
                DropdownTitle.ZIndex = 9

                DropdownOptions.Name = "DropdownOptions"
                DropdownOptions.Parent = Dropdown
                DropdownOptions.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropdownOptions.BackgroundTransparency = 1.000
                DropdownOptions.BorderSizePixel = 0
                DropdownOptions.Position = UDim2.new(0, 0, 1, 0)
                DropdownOptions.Size = UDim2.new(0, 239, 0, 188)
                DropdownOptions.Visible = false
                DropdownOptions.ZIndex = 9

                UIListLayout_6.Parent = DropdownOptions
                UIListLayout_6.SortOrder = Enum.SortOrder.LayoutOrder

                UIPadding_5.Parent = DropdownOptions
                UIPadding_5.PaddingTop = UDim.new(0, 4)

                DropdownToggle.Name = "DropdownToggle"
                DropdownToggle.Parent = Dropdown
                DropdownToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropdownToggle.BackgroundTransparency = 1.000
                DropdownToggle.Position = UDim2.new(0.907308936, 0, 0.156310678, 0)
                DropdownToggle.Rotation = 90.000
                DropdownToggle.Size = UDim2.new(0, 17, 0, 17)
                DropdownToggle.AutoButtonColor = false
                DropdownToggle.Image = "rbxassetid://5238501683"
                game:GetService("RunService").RenderStepped:Connect(function()
                DropdownToggle.ImageColor3 = library.Color
                end)
                DropdownToggle.ZIndex = 9

                DropdownToggle.MouseButton1Down:Connect(function()
                    if DropdownOptions.Visible then
                        DropdownOptions.Visible = false
                        Dropdown.ZIndex = 9
                        game:GetService("TweenService"):Create(DropdownToggle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 0}):Play()
                    else
                        Dropdown.ZIndex = 2
                        DropdownOptions.Visible = true
                        game:GetService("TweenService"):Create(DropdownToggle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 90}):Play()
                    end
                end)

                Dropdown.MouseButton1Down:Connect(function()
                    if DropdownOptions.Visible then
                        DropdownOptions.Visible = false
                        game:GetService("TweenService"):Create(DropdownToggle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 0}):Play()
                    Dropdown.ZIndex = 9
                         else Dropdown.ZIndex = 2
                        DropdownOptions.Visible = true
                        game:GetService("TweenService"):Create(DropdownToggle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 90}):Play()
                    end
                end)

                Dropdown.MouseEnter:Connect(function()
                    game:GetService("TweenService"):Create(DropdownTitle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                end)

                Dropdown.MouseLeave:Connect(function()
                    game:GetService("TweenService"):Create(DropdownTitle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
                end)

                local selected

                for i, v in pairs(options) do
                    local Option = Instance.new("TextButton")
                    local OptionTitle = Instance.new("TextLabel")
                    local OptionToggle = Instance.new("TextButton")

                    Option.Name = "Option"
                    Option.Parent = DropdownOptions
                    Option.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                    Option.BorderColor3 = Color3.fromRGB(13, 13, 13)
                    Option.Position = UDim2.new(0.0313725509, 0, 0.0286738351, 0)
                    Option.Size = UDim2.new(0, 239, 0, 25)
                    Option.AutoButtonColor = false
                    Option.Font = Enum.Font.SourceSans
                    Option.Text = ""
                    Option.TextColor3 = Color3.fromRGB(200, 200, 200)
                    Option.TextSize = 14.000
                    Option.TextStrokeTransparency = 0.000
                    Option.ZIndex = 9

                    OptionTitle.Name = "OptionTitle"
                    OptionTitle.Parent = Option
                    OptionTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    OptionTitle.BackgroundTransparency = 1.000
                    OptionTitle.BorderSizePixel = 0
                    OptionTitle.Position = UDim2.new(0.0251046028, 0, 0, 0)
                    OptionTitle.Size = UDim2.new(0, 233, 0, 25)
                    OptionTitle.Font = Enum.Font.SourceSans
                    OptionTitle.Text = v
                    OptionTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
                    OptionTitle.TextSize = 14.000
                    OptionTitle.TextStrokeTransparency = 0.000
                    OptionTitle.TextXAlignment = Enum.TextXAlignment.Left
                   OptionTitle.ZIndex = 9

                    OptionToggle.Name = "OptionToggle"
                    OptionToggle.Parent = Option
                    OptionToggle.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                    OptionToggle.BorderColor3 = Color3.fromRGB(13, 13, 13)
                    OptionToggle.Position = UDim2.new(0.907949805, 0, 0.159999996, 0)
                    OptionToggle.Size = UDim2.new(0, 16, 0, 16)
                    OptionToggle.AutoButtonColor = false
                    OptionToggle.Font = Enum.Font.SourceSans
OptionToggle.ZIndex = 9
                    if default == i then
                        selected = v
                        OptionToggle.TextTransparency = 0
                    else
                        OptionToggle.TextTransparency = 1
                    end
                    OptionToggle.Text = utf8.char(10003)
                    OptionToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
                    OptionToggle.TextSize = 14.000
                    OptionToggle.TextYAlignment = Enum.TextYAlignment.Top

                    Option.MouseEnter:Connect(function()
                        game:GetService("TweenService"):Create(OptionTitle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                    end)
    
                    Option.MouseLeave:Connect(function()
                        game:GetService("TweenService"):Create(OptionTitle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
                    end)

                    Option.MouseButton1Down:Connect(function()
                        if selected ~= v then
                            selected = v
                            game:GetService("TweenService"):Create(OptionToggle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
                            for i, v in pairs(DropdownOptions:GetChildren()) do
                                if v ~= Option and v:IsA("TextButton") then
                                    game:GetService("TweenService"):Create(v.OptionToggle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
                                end
                            end
                            func(v)
                        end
                    end)

                    OptionToggle.MouseButton1Down:Connect(function()
                        if selected ~= v then
                            selected = v
                            game:GetService("TweenService"):Create(OptionToggle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
                            for i, v in pairs(DropdownOptions:GetChildren()) do
                                if v ~= Option and v:IsA("TextButton") then
                                    game:GetService("TweenService"):Create(v.OptionToggle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
                                end
                            end
                            func(v)
                        end
                    end)
                end

                function dropdown:Refresh(options)
                    for i, v in pairs(DropdownOptions:GetChildren()) do
                        if v:IsA("TextButton") then 
                            v:Destroy()
                        end
                    end

                    for i, v in pairs(options) do
                        local Option = Instance.new("TextButton")
                        local OptionTitle = Instance.new("TextLabel")
                        local OptionToggle = Instance.new("TextButton")
    
                        Option.Name = "Option"
                        Option.Parent = DropdownOptions
                        Option.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                        Option.BorderColor3 = Color3.fromRGB(13, 13, 13)
                        Option.Position = UDim2.new(0.0313725509, 0, 0.0286738351, 0)
                        Option.Size = UDim2.new(0, 239, 0, 25)
                        Option.AutoButtonColor = false
                        Option.Font = Enum.Font.SourceSans
                        Option.Text = ""
                        Option.TextColor3 = Color3.fromRGB(200, 200, 200)
                        Option.TextSize = 14.000
                        Option.TextStrokeTransparency = 0.000
                        Option.ZIndex = 9
    
                        OptionTitle.Name = "OptionTitle"
                        OptionTitle.Parent = Option
                        OptionTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        OptionTitle.BackgroundTransparency = 1.000
                        OptionTitle.BorderSizePixel = 0
                        OptionTitle.Position = UDim2.new(0.0251046028, 0, 0, 0)
                        OptionTitle.Size = UDim2.new(0, 233, 0, 25)
                        OptionTitle.Font = Enum.Font.SourceSans
                        OptionTitle.Text = v
                        OptionTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
                        OptionTitle.TextSize = 14.000
                        OptionTitle.TextStrokeTransparency = 0.000
                        OptionTitle.TextXAlignment = Enum.TextXAlignment.Left
                       OptionTitle.ZIndex = 9
    
                        OptionToggle.Name = "OptionToggle"
                        OptionToggle.Parent = Option
                        OptionToggle.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                        OptionToggle.BorderColor3 = Color3.fromRGB(13, 13, 13)
                        OptionToggle.Position = UDim2.new(0.907949805, 0, 0.159999996, 0)
                        OptionToggle.Size = UDim2.new(0, 16, 0, 16)
                        OptionToggle.AutoButtonColor = false
                        OptionToggle.Font = Enum.Font.SourceSans
    OptionToggle.ZIndex = 9
                        if default == i then
                            selected = v
                            OptionToggle.TextTransparency = 0
                        else
                            OptionToggle.TextTransparency = 1
                        end
                        OptionToggle.Text = utf8.char(10003)
                        OptionToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
                        OptionToggle.TextSize = 14.000
                        OptionToggle.TextYAlignment = Enum.TextYAlignment.Top
    
                        Option.MouseEnter:Connect(function()
                            game:GetService("TweenService"):Create(OptionTitle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                        end)
        
                        Option.MouseLeave:Connect(function()
                            game:GetService("TweenService"):Create(OptionTitle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
                        end)
    
                        Option.MouseButton1Down:Connect(function()
                            if selected ~= v then
                                selected = v
                                game:GetService("TweenService"):Create(OptionToggle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
                                for i, v in pairs(DropdownOptions:GetChildren()) do
                                    if v ~= Option and v:IsA("TextButton") then
                                        game:GetService("TweenService"):Create(v.OptionToggle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
                                    end
                                end
                                func(v)
                            end
                        end)
    
                        OptionToggle.MouseButton1Down:Connect(function()
                            if selected ~= v then
                                selected = v
                                game:GetService("TweenService"):Create(OptionToggle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
                                for i, v in pairs(DropdownOptions:GetChildren()) do
                                    if v ~= Option and v:IsA("TextButton") then
                                        game:GetService("TweenService"):Create(v.OptionToggle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
                                    end
                                end
                                func(v)
                            end
                        end)
                    end
                end

                return dropdown
            end

            function section:CreateColorPicker(title, default, func)
                local colorpicker = {}
                title = title or "Color Picker"
                default = default or Color3.new(1, 0, 0)
                func = func or function()end

                local ColorPickerButton = Instance.new("TextButton")
                local ColorPickerTitle = Instance.new("TextLabel")
                local ColorPickerFrame = Instance.new("Frame")
                local UIListLayout_4 = Instance.new("UIListLayout")
                local UIPadding_3 = Instance.new("UIPadding")
                local COlorPickerInside = Instance.new("Frame")
                local Colora = Instance.new("Frame")
                local ColorPick = Instance.new("ImageButton")
                local ColorHandle = Instance.new("ImageButton")
                local Hue = Instance.new("ImageButton")
                local HuehNadle = Instance.new("ImageButton")
                local R = Instance.new("TextBox")
                local G = Instance.new("TextBox")
                local Ba = Instance.new("TextBox")
                local Rainbow = Instance.new("TextButton")
                local Full = Instance.new("TextBox")
                local ColorPickerToggle = Instance.new("ImageButton")

                ColorPickerButton.Name = "ColorPickerButton"
                ColorPickerButton.Parent = Section2
                ColorPickerButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                ColorPickerButton.BorderColor3 = Color3.fromRGB(13, 13, 13)
                ColorPickerButton.Position = UDim2.new(0.0313725509, 0, 0.0286738351, 0)
                ColorPickerButton.Size = UDim2.new(0, 239, 0, 25)
                ColorPickerButton.AutoButtonColor = false
                ColorPickerButton.Font = Enum.Font.SourceSans
                ColorPickerButton.Text = ""
                ColorPickerButton.TextColor3 = Color3.fromRGB(200, 200, 200)
                ColorPickerButton.TextSize = 14.000
                ColorPickerButton.TextStrokeTransparency = 0.000
                ColorPickerButton.ZIndex = 2

                ColorPickerTitle.Name = "ColorPickerTitle"
                ColorPickerTitle.Parent = ColorPickerButton
                ColorPickerTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ColorPickerTitle.BackgroundTransparency = 1.000
                ColorPickerTitle.BorderSizePixel = 0
                ColorPickerTitle.Position = UDim2.new(0.0251046028, 0, 0, 0)
                ColorPickerTitle.Size = UDim2.new(0, 233, 0, 25)
                ColorPickerTitle.Font = Enum.Font.SourceSans
                ColorPickerTitle.Text = title
                ColorPickerTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                ColorPickerTitle.TextSize = 14.000
                ColorPickerTitle.TextStrokeTransparency = 0.000
                ColorPickerTitle.TextXAlignment = Enum.TextXAlignment.Left
                ColorPickerTitle.ZIndex = 9

                ColorPickerFrame.Name = "ColorPickerFrame"
                ColorPickerFrame.Parent = ColorPickerButton
                ColorPickerFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ColorPickerFrame.BackgroundTransparency = 1.000
                ColorPickerFrame.BorderSizePixel = 0
                ColorPickerFrame.Position = UDim2.new(0, 0, 1, 0)
                ColorPickerFrame.Size = UDim2.new(0, 239, 0, 130)
                ColorPickerFrame.Visible = false
                ColorPickerFrame.ZIndex = 9

                UIListLayout_4.Parent = ColorPickerFrame
                UIListLayout_4.SortOrder = Enum.SortOrder.LayoutOrder

                UIPadding_3.Parent = ColorPickerFrame
                UIPadding_3.PaddingTop = UDim.new(0, 4)

                COlorPickerInside.Name = "COlorPickerInside"
                COlorPickerInside.Parent = ColorPickerFrame
                COlorPickerInside.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                COlorPickerInside.BorderColor3 = Color3.fromRGB(13, 13, 13)
                COlorPickerInside.Position = UDim2.new(0, 0, -0.0159574468, 0)
                COlorPickerInside.Size = UDim2.new(0, 239, 0, 125)
                COlorPickerInside.ZIndex = 9

                Colora.Name = "Color"
                Colora.Parent = COlorPickerInside
                Colora.BackgroundColor3 = default
                Colora.BorderSizePixel = 0
                Colora.Position = UDim2.new(0.0251046028, 0, 0.0320000015, 0)
                Colora.Size = UDim2.new(0, 117, 0, 117)
                Colora.ZIndex = 9

                ColorPick.Name = "ColorPick"
                ColorPick.Parent = Colora
                ColorPick.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ColorPick.BackgroundTransparency = 1.000
                ColorPick.Size = UDim2.new(0, 117, 0, 117)
                ColorPick.AutoButtonColor = false
                ColorPick.Image = "rbxassetid://4805274903"
                ColorPick.ZIndex = 9

                ColorHandle.Name = "ColorHandle"
                ColorHandle.Parent = ColorPick
                ColorHandle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ColorHandle.BackgroundTransparency = 1.000
                ColorHandle.Position = UDim2.new(0.888888896, 0, -0.00854700897, 0)
                ColorHandle.Size = UDim2.new(0, 13, 0, 13)
                ColorHandle.AutoButtonColor = false
                ColorHandle.Image = "http://www.roblox.com/asset/?id=4953646208"
                ColorHandle.ZIndex = 9

                Hue.Name = "Hue"
                Hue.Parent = COlorPickerInside
                Hue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Hue.BackgroundTransparency = 1.000
                Hue.BorderSizePixel = 0
                Hue.Position = UDim2.new(0.552301228, 0, 0.0320000015, 0)
                Hue.Size = UDim2.new(0, 12, 0, 117)
                Hue.AutoButtonColor = false
                Hue.Image = "rbxassetid://4650897105"

                HuehNadle.Name = "HuehNadle"
                HuehNadle.Parent = Hue
                HuehNadle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                HuehNadle.BackgroundTransparency = 1.000
                HuehNadle.Position = UDim2.new(0, 0, 0.504273534, 0)
                HuehNadle.Size = UDim2.new(0, 12, 0, 12)
                HuehNadle.AutoButtonColor = false
                HuehNadle.Image = "http://www.roblox.com/asset/?id=4953646208"

                R.Name = "R"
                R.Parent = COlorPickerInside
                R.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                R.BorderColor3 = Color3.fromRGB(13, 13, 13)
                R.Position = UDim2.new(0.627615035, 0, 0.0416325703, 0)
                R.Size = UDim2.new(0, 82, 0, 16)
                R.ClearTextOnFocus = false
                R.Font = Enum.Font.SourceSans
                R.Text = default.R
                R.TextColor3 = Color3.fromRGB(255, 0, 0)
                R.TextSize = 14.000

                G.Name = "G"
                G.Parent = COlorPickerInside
                G.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                G.BorderColor3 = Color3.fromRGB(13, 13, 13)
                G.Position = UDim2.new(0.627615035, 0, 0.233632565, 0)
                G.Size = UDim2.new(0, 82, 0, 16)
                G.ClearTextOnFocus = false
                G.Font = Enum.Font.SourceSans
                G.Text = default.G
                G.TextColor3 = Color3.fromRGB(0, 255, 0)
                G.TextSize = 14.000

                Ba.Name = "B"
                Ba.Parent = COlorPickerInside
                Ba.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                Ba.BorderColor3 = Color3.fromRGB(13, 13, 13)
                Ba.Position = UDim2.new(0.627615035, 0, 0.433632553, 0)
                Ba.Size = UDim2.new(0, 82, 0, 16)
                Ba.ClearTextOnFocus = false
                Ba.Font = Enum.Font.SourceSans
                Ba.Text = default.B
                Ba.TextColor3 = Color3.fromRGB(0, 0, 255)
                Ba.TextSize = 14.000

                Rainbow.Name = "Rainbow"
                Rainbow.Parent = COlorPickerInside
                Rainbow.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                Rainbow.BorderColor3 = Color3.fromRGB(13, 13, 13)
                Rainbow.Position = UDim2.new(0.627615035, 0, 0.808000028, 0)
                Rainbow.Size = UDim2.new(0, 82, 0, 20)
                Rainbow.AutoButtonColor = false
                Rainbow.Font = Enum.Font.SourceSans
                Rainbow.Text = "Rainbow"
                Rainbow.TextColor3 = Color3.fromRGB(200, 200, 200)
                Rainbow.TextSize = 14.000

                Full.Name = "Full"
                Full.Parent = COlorPickerInside
                Full.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                Full.BorderColor3 = Color3.fromRGB(13, 13, 13)
                Full.Position = UDim2.new(0.627615035, 0, 0.634000003, 0)
                Full.Size = UDim2.new(0, 82, 0, 16)
                Full.ClearTextOnFocus = false
                Full.Font = Enum.Font.SourceSans
                Full.Text = tostring(default)
                Full.TextColor3 = Color3.fromRGB(200, 200, 200)
                Full.TextSize = 14.000

                ColorPickerToggle.Name = "ColorPickerToggle"
                ColorPickerToggle.Parent = ColorPickerButton
                ColorPickerToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ColorPickerToggle.BackgroundTransparency = 1.000
                ColorPickerToggle.Position = UDim2.new(0.907308936, 0, 0.156310678, 0)
                ColorPickerToggle.Rotation = 90.000
                ColorPickerToggle.Size = UDim2.new(0, 17, 0, 17)
                ColorPickerToggle.AutoButtonColor = false
                ColorPickerToggle.Image = "rbxassetid://5238501683"
                game:GetService("RunService").RenderStepped:Connect(function()
                ColorPickerToggle.ImageColor3 = library.Color
                end)

                local RAINBOWING = false

                ColorPickerButton.MouseButton1Down:Connect(function()
                    if ColorPickerFrame.Visible then
						ColorPickerButton.ZIndex = 2
                        ColorPickerFrame.Visible = false
                        game:GetService("TweenService"):Create(ColorPickerToggle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 0}):Play()
                    else
						ColorPickerButton.ZIndex = 9
                        ColorPickerFrame.Visible = true
                        for i, v in pairs(Section2:GetChildren()) do
                            if v.Name == "ColorPickerButton" and v ~= ColorPickerButton then
                                v.ColorPickerFrame.Visible = false
                                v.ZIndex = 2
                                game:GetService("TweenService"):Create(v.ColorPickerToggle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 0}):Play()
                            end
                        end
                        game:GetService("TweenService"):Create(ColorPickerToggle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 90}):Play()
                    end
                end)

                Rainbow.MouseEnter:Connect(function()
                    game:GetService("TweenService"):Create(Rainbow, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                end)

                Rainbow.MouseLeave:Connect(function()
                    game:GetService("TweenService"):Create(Rainbow, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
                end)

                Rainbow.MouseButton1Down:Connect(function()
                    RAINBOWING = true
                    spawn(function()
                        while RAINBOWING do
                            Colora.BackgroundColor3 = Color3.fromHSV(ColorCounterRainbow, 1, 1)
        
                            HuehNadle.Position = UDim2.new(0, 0, 0, ColorPickerHuePosition)
                            ColorHandle.Position = UDim2.new(0, 102, 0, 0)
        
                            func(Colora.BackgroundColor3) 
                            wait()
                        end
                    end)
                end)

                ColorPickerButton.MouseEnter:Connect(function()
                    game:GetService("TweenService"):Create(ColorPickerTitle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                end)

                ColorPickerButton.MouseLeave:Connect(function()
                    game:GetService("TweenService"):Create(ColorPickerTitle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
                end)

                local MouseDown = false

                local function map(x, in_min, in_max, out_min, out_max)
                    return out_min + (x - in_min)*(out_max - out_min)/(in_max - in_min)
                end

                local H, S, B = Color3.toHSV(default)

                local function updateColor()
                    local Color = Color3.fromHSV(H,S,B)
                    Full.Text = tostring(math.floor(Color.r * 255))..", "..tostring(math.floor(Color.g * 255))..", "..tostring(math.floor(Color.b * 255))
                    R.Text = tostring(math.floor(Color.r * 255))
                    G.Text = tostring(math.floor(Color.g * 255))
                    Ba.Text = tostring(math.floor(Color.b * 255))
                    Colora.BackgroundColor3 = Color3.fromHSV(H, 1, 1)
                    func(Color)
                end

                local UserInputService = game:GetService("UserInputService")
                local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
                local RunService = game:GetService("RunService")
                ColorPick.MouseEnter:connect(function()
                    local input = ColorPick.InputBegan:connect(function(key)
                        if key.UserInputType == Enum.UserInputType.MouseButton1 then
                            while wait() and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                                RAINBOWING = false
                                local objectPosition = Vector2.new(Mouse.X - ColorPick.AbsolutePosition.X, Mouse.Y - ColorPick.AbsolutePosition.Y);
                                local XRange = math.clamp(map(objectPosition.X, 0, 102, 0, 1), 0, 1)
                                local YRange = math.clamp(map(objectPosition.Y, 0, 102, 0, 1), 0, 1)
                                S = XRange
                                B = 1-YRange
                                ColorHandle:TweenPosition(UDim2.new(0, XRange*102, 0, YRange*102), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.1, true);
                                updateColor()
                            end
                        end
                    end)

                    local leave;
                    leave = ColorPick.MouseLeave:connect(function()
                        input:disconnect();
                        leave:disconnect();
                    end)
                end)

                Hue.InputBegan:connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        RAINBOWING = false
                        MouseDown = true
                    end
                end)

                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        MouseDown = false
                    end
                end)

                Mouse.Move:connect(function()
                    if MouseDown then
                        local range = math.clamp(map(Mouse.Y, Hue.AbsolutePosition.Y, Hue.AbsolutePosition.Y + Hue.AbsoluteSize.Y, 0, 1), 0, 1)
                        HuehNadle:TweenPosition(UDim2.new(0, 0, 0, range*102), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.1, true);
                        H = range
                        updateColor()
                    end
                end)

                RunService.RenderStepped:Connect(function()
                    if MouseDown then
                        local range = math.clamp(map(Mouse.Y, Hue.AbsolutePosition.Y, Hue.AbsolutePosition.Y + Hue.AbsoluteSize.Y, 0, 1), 0, 1)
                        HuehNadle:TweenPosition(UDim2.new(0, 0, 0, range*102), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.1, true);
                        H = range
                        updateColor()
                    end
                end)

                local Change = false
                Full.Focused:Connect(function()
                    RAINBOWING = false
                    Change = true
                end)

                Full.FocusLost:Connect(function()
                    Change = false
                end)

                game:GetService("RunService").RenderStepped:Connect(function()
                    if Change then
                        local Ra = math.floor(tonumber(Full.Text:split(",")[1]))
                        local Ga = math.floor(tonumber(Full.Text:split(",")[2]))
                        local Bb = math.floor(tonumber(Full.Text:split(",")[3]))
                        R.Text = Ra
                        G.Text = Ga
                        Ba.Text = Bb
                        Colora.BackgroundColor3 = Color3.new(Ra, Ga, Bb)
                    end
                end)

                local Change2 = false
                R.Focused:Connect(function()
                    RAINBOWING = false
                    Change2 = true
                end)

                R.FocusLost:Connect(function()
                    Change2 = false
                end)

                game:GetService("RunService").RenderStepped:Connect(function()
                    if Change2 then
                        local Ra = tonumber(R.Text)
                        Colora.BackgroundColor3 = Color3.new(Ra, Colora.BackgroundColor3.G, Colora.BackgroundColor3.B)
                    end
                end)

                local Change3 = false
                G.Focused:Connect(function()
                    RAINBOWING = false
                    Change3 = true
                end)

                G.FocusLost:Connect(function()
                    Change3 = false
                end)

                game:GetService("RunService").RenderStepped:Connect(function()
                    if Change3 then
                        local Ga = tonumber(G.Text)
                        Colora.BackgroundColor3 = Color3.new(Colora.BackgroundColor3.R, Ga, Colora.BackgroundColor3.B)
                    end
                end)

                local Change4 = false
                Ba.Focused:Connect(function()
                    RAINBOWING = false
                    Change4 = true
                end)

                Ba.FocusLost:Connect(function()
                    Change4 = false
                end)

                game:GetService("RunService").RenderStepped:Connect(function()
                    if Change4 then
                        local BB = tonumber(Ba.Text)
                        Colora.BackgroundColor3 = Color3.new(Colora.BackgroundColor3.R, Colora.BackgroundColor3.B, BB)
                    end
                end)

                return colorpicker
            end
			
			return section
		end

		return tab
    end

    --MainGUIHolder.ClipsDescendants = false

    CloseButton.MouseButton1Down:Connect(function()
        if MainGUIHolder.Size ~= UDim2.new(0, TabsHolder.Size.X.Offset + Title.Size.X.Offset, 0, TabsHolder.Size.Y.Offset) then
            for i, v in pairs(MainGUIHolder:GetChildren()) do
                if v.Name == "SectionStuffHolder" then
                    for k, x in pairs(v:GetChildren()) do
                        if x.Name == "Sec" then
                            for o, w in pairs(x:GetDescendants()) do
                                if w:IsA("Frame") and w.Name ~= "ColorPickerFrame" and w.Name ~= "DropdownOptions" then
                                    game:GetService("TweenService"):Create(w, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
                                elseif w:IsA("TextLabel") and w.Name ~= "SecT" then
                                    game:GetService("TweenService"):Create(w, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
                                elseif (w:IsA("TextButton") or w:IsA("TextBox")) and (w.Name ~= "ToggleToggle" and w.Name ~= "OptionToggle") then
                                    game:GetService("TweenService"):Create(w, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
                                    game:GetService("TweenService"):Create(w, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextStrokeTransparency = 1}):Play()
                                    game:GetService("TweenService"):Create(w, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
                                elseif w:IsA("ImageButton") then
                                    game:GetService("TweenService"):Create(w, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {ImageTransparency = 1}):Play()
                                elseif w.Name == "SecT" then
                                    game:GetService("TweenService"):Create(w, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
                                    game:GetService("TweenService"):Create(w, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
                                elseif w.Name == "ToggleToggle" or w.Name == "OptionToggle" then
                                    game:GetService("TweenService"):Create(w, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
                                end
                                game:GetService("TweenService"):Create(x.Section2, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
                            end
                        end
                    end
                end
            end
            wait(0.3)
            game:GetService("TweenService"):Create(CloseButton, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = CloseButton.Position - UDim2.new(0, 0, 0, 15)}):Play()
            game:GetService("TweenService"):Create(MainGUIHolder, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, TabsHolder.Size.X.Offset + Title.Size.X.Offset, 0, TabsHolder.Size.Y.Offset)}):Play()
        else
            game:GetService("TweenService"):Create(CloseButton, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = CloseButton.Position + UDim2.new(0, 0, 0, 15)}):Play()
            game:GetService("TweenService"):Create(MainGUIHolder, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 568, 0, 412)}):Play()
            wait(0.4)
            for i, v in pairs(MainGUIHolder:GetChildren()) do
                if v.Name == "SectionStuffHolder" then
                    for k, x in pairs(v:GetChildren()) do
                        if x.Name == "Sec" then
                            for o, w in pairs(x:GetDescendants()) do
                                if w:IsA("Frame") and w.Name ~= "ColorPickerFrame" and w.Name ~= "DropdownOptions" then
                                    game:GetService("TweenService"):Create(w, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
                                elseif w:IsA("TextLabel") and w.Name ~= "SecT" then
                                    game:GetService("TweenService"):Create(w, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
                                elseif (w:IsA("TextButton") or w:IsA("TextBox")) and (w.Name ~= "ToggleToggle" and w.Name ~= "OptionToggle") then
                                    game:GetService("TweenService"):Create(w, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
                                    game:GetService("TweenService"):Create(w, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
                                    game:GetService("TweenService"):Create(w, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextStrokeTransparency = 0}):Play()
                                elseif w:IsA("ImageButton") then
                                    game:GetService("TweenService"):Create(w, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
                                elseif w.Name == "SecT" then
                                    game:GetService("TweenService"):Create(w, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
                                    game:GetService("TweenService"):Create(w, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
                                elseif w.Name == "ToggleToggle" or w.Name == "OptionToggle" then
                                    game:GetService("TweenService"):Create(w, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
                                end
                                game:GetService("TweenService"):Create(x.Section2, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
                            end
                        end
                    end
                end
            end
        end
    end)
    --[==[
    --[[local Min = 45
    local Max = 345

    CloseButton.Changed:connect(function()
        if CloseButton.Position.X.Offset < Min and CloseButton.Position.Y.Offset < Min then
            CloseButton.Position = UDim2.new(0, Min, 0, Min)
        elseif CloseButton.Position.X.Offset < Min then
            CloseButton.Position = UDim2.new(0, Min, 0, CloseButton.Position.Y.Offset)
        elseif CloseButton.Position.Y.Offset < Min then
            CloseButton.Position = UDim2.new(0, CloseButton.Position.X.Offset, 0, Min)
        end
        if CloseButton.Position.X.Offset > Max and CloseButton.Position.Y.Offset > Max then
            CloseButton.Position = UDim2.new(0, Max, 0, Max)
        elseif CloseButton.Position.X.Offset > Max then
            CloseButton.Position = UDim2.new(0, Max, 0, CloseButton.Position.Y.Offset)
        elseif CloseButton.Position.Y.Offset > Max then
            CloseButton.Position = UDim2.new(0, CloseButton.Position.X.Offset, 0, Max)
        end
    end)]]

    local mouse = game.Players.LocalPlayer:GetMouse()
    local Pressing = false

    local RecordedLastX = nil
    local RecordedLastY = nil

    local NowPositionX = nil
    local NowPositionY = nil

    CloseButton.InputBegan:connect(function(key)
        if key.UserInputType == Enum.UserInputType.MouseButton1 then
            Pressing = true
            RecordedLastX = mouse.X
            RecordedLastY = mouse.Y
            CloseButton.InputEnded:connect(function(key2)
                if key == key2 then
                    Pressing =  false
                end
            end)
        end
    end)

    mouse.Move:connect(function()
        if Pressing == true then
            NowPositionX = mouse.x
            NowPositionY = mouse.y
                
            local ChangeX = NowPositionX - RecordedLastX
            local ChangeY = NowPositionY - RecordedLastY
                    
            RecordedLastX = mouse.X
            RecordedLastY = mouse.Y

            --[[for i, v in pairs(MainGUIHolder:GetChildren()) do
                if v.Name == "SectionStuffHolder" then
                    for k, x in pairs(v:GetChildren()) do
                        if x.Name == "Sec" then
                            x.Section2.Size = UDim2.new(0, x.Section2.Size.X.Offset + ChangeX, 0, math.clamp(x.Section2.Size.Y.Offset + ChangeY, TabsHolder.Size.Y.Offset, 325))
                        end
                    end
                end
            end]]
            CloseButton.Position = UDim2.new(0, math.clamp(CloseButton.Position.X.Offset + ChangeX, 416, 568), 0, math.clamp(CloseButton.Position.Y.Offset + ChangeY, TabsHolder.Size.Y.Offset, 412))
            MainGUIHolder.Size = UDim2.new(0, math.clamp(MainGUIHolder.Size.X.Offset + ChangeX, 416, 568), 0, math.clamp(MainGUIHolder.Size.Y.Offset + ChangeY, TabsHolder.Size.Y.Offset, 412))
        end
    end)]==]

    game:GetService("UserInputService").InputBegan:Connect(function(input)
        if input.KeyCode == library.Key then
            MainGUIHolder.Visible = not MainGUIHolder.Visible
        end
    end)
	
	return window
end

return library					
