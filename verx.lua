-- Verx Hub v1.0
-- UI: Fluent | Engine: internal

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

-- load engine dalam background, closet true so notif diorang tak keluar
task.spawn(function()
    loadstring(game:HttpGet("https://api.catvape.dev/script?key=Xw9cTW4SsWuilqTDivA9LlaaO659OXjJQnuADfeXTtFHTAYD"))({
        Closet = true,
    })
end)

-- bagi masa engine load
task.wait(4)

-- Verx UI
local Window = Fluent:CreateWindow({
    Title = "Verx Hub",
    SubTitle = "v1.0",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightShift
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "home" }),
    Combat = Window:AddTab({ Title = "Combat", Icon = "sword" }),
    Visuals = Window:AddTab({ Title = "Visuals", Icon = "eye" }),
    Player = Window:AddTab({ Title = "Player", Icon = "user" }),
    Misc = Window:AddTab({ Title = "Misc", Icon = "settings" }),
}

-- Main
Tabs.Main:AddParagraph({
    Title = "Verx Hub",
    Content = "Welcome chef. Engine loaded."
})

-- Combat
Tabs.Combat:AddSection("Aimbot")

local AimbotFOV = 150
local AimbotEnabled = false

Tabs.Combat:AddToggle("Aimbot", {
    Title = "Aimbot",
    Description = "Lock onto nearest player",
    Default = false,
    Callback = function(Value)
        AimbotEnabled = Value
        -- hook into catvape aimbot via getgenv
        if getgenv().vape and getgenv().vape.Aimbot then
            getgenv().vape.Aimbot.Enabled = Value
        end
    end
})

Tabs.Combat:AddSlider("FOV", {
    Title = "Aimbot FOV",
    Default = 150,
    Min = 1,
    Max = 500,
    Rounding = 0,
    Callback = function(Value)
        AimbotFOV = Value
        if getgenv().vape and getgenv().vape.Aimbot then
            getgenv().vape.Aimbot.FOV = Value
        end
    end
})

Tabs.Combat:AddToggle("SilentAim", {
    Title = "Silent Aim",
    Default = false,
    Callback = function(Value)
        if getgenv().vape and getgenv().vape.SilentAim then
            getgenv().vape.SilentAim.Enabled = Value
        end
    end
})

-- Visuals
Tabs.Visuals:AddSection("ESP")

Tabs.Visuals:AddToggle("ESP", {
    Title = "Player ESP",
    Default = false,
    Callback = function(Value)
        if getgenv().vape and getgenv().vape.ESP then
            getgenv().vape.ESP.Enabled = Value
        end
    end
})

Tabs.Visuals:AddColorpicker("ESPColor", {
    Title = "ESP Color",
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(Value)
        if getgenv().vape and getgenv().vape.ESP then
            getgenv().vape.ESP.Color = Value
        end
    end
})

Tabs.Visuals:AddToggle("Chams", {
    Title = "Chams",
    Default = false,
    Callback = function(Value)
        if getgenv().vape and getgenv().vape.Chams then
            getgenv().vape.Chams.Enabled = Value
        end
    end
})

-- Player
Tabs.Player:AddSection("Movement")

Tabs.Player:AddSlider("WalkSpeed", {
    Title = "Walk Speed",
    Default = 16,
    Min = 16,
    Max = 500,
    Rounding = 0,
    Callback = function(Value)
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = Value
        end
    end
})

Tabs.Player:AddSlider("JumpPower", {
    Title = "Jump Power",
    Default = 50,
    Min = 50,
    Max = 500,
    Rounding = 0,
    Callback = function(Value)
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.JumpPower = Value
        end
    end
})

Tabs.Player:AddToggle("InfJump", {
    Title = "Infinite Jump",
    Default = false,
    Callback = function(Value)
        game:GetService("UserInputService").JumpRequest:Connect(function()
            if Value then
                game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
            end
        end)
    end
})

-- Misc
Tabs.Misc:AddSection("Misc")

Tabs.Misc:AddToggle("NoClip", {
    Title = "No Clip",
    Default = false,
    Callback = function(Value)
        local NoClipLoop
        if Value then
            NoClipLoop = game:GetService("RunService").Stepped:Connect(function()
                local char = game.Players.LocalPlayer.Character
                if char then
                    for _, part in ipairs(char:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        else
            if NoClipLoop then NoClipLoop:Disconnect() end
        end
    end
})

-- SaveManager
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetFolder("VerxHub")
SaveManager:SetFolder("VerxHub/configs")
InterfaceManager:BuildInterfacePage(Tabs.Misc)
SaveManager:BuildConfigPage(Tabs.Misc)
SaveManager:LoadAutoLoad()

Window:SelectTab(Tabs.Main)

Fluent:Notify({
    Title = "Verx Hub",
    Content = "Loaded!",
    Duration = 3
})
