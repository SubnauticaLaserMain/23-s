shared.VapeIndependent = true
shared.CustomSaveVape = "BreakInStory2Save"
local GuiLibrary = loadstring(game:HttpGet('https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua', true))();

local ReplicatedStorage = game:GetService('ReplicatedStorage')
local UserInputService = game:GetService('UserInputService')
local StarterPlayer = game:GetService('StarterPlayer')
local LightingService = game:GetService('Lighting')
local TweenService = game:GetService('TweenService')
local Workspace = game:GetService('Workspace')
local Players = game:GetService('Players')
local CoreGui = game:GetService('CoreGui')

local lplr = Players.LocalPlayer or Players:GetPlayers()[1]

local function calculateDistance(pos1, pos2)
    return (pos1 - pos2).Magnitude
end

local function findNearestEntity(playerPosition, entityList)
    local nearestEntity = nil
    local nearestDistance = math.huge

    for _, entity in ipairs(entityList) do
        local entityPosition = entity.Position
        local dist = calculateDistance(playerPosition, entityPosition)
        if dist < nearestDistance then
            nearestEntity = entity
            nearestDistance = dist
        end
    end

    return nearestEntity, nearestDistance
end

local function FetchPlayerCharacter()
    local Character = nil
    local AllowedAttempts = 1000;
    local Attempts = 0


    while Character == nil do
        if Attempts > AllowedAttempts then
            warn('Attempts are too big')
            return
        end

        Character = lplr.Character or lplr.CharacterAdded:Wait()
        Attempts = Attempts + 1;

        task.wait(1)
    end

    if Character then
        return Character
    end
end


local function fetchPlayerHumanoidRootPart(player)
    if not player.Character then
        player.CharacterAdded:Wait()
    end
    return player.Character:WaitForChild("HumanoidRootPart")
end


local function findAndPrintNearestEntity()
    local character = FetchPlayerCharacter()
    local HRP = fetchPlayerHumanoidRootPart(lplr)
    local playerPosition = HRP.Position

    local entityList = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= lplr then
            local entityHRP = fetchPlayerHumanoidRootPart(player)
            table.insert(entityList, entityHRP)
        end
    end

    local nearestEntity, nearestDistance = findNearestEntity(playerPosition, entityList)

    if nearestEntity then
        print("Nearest entity found:", nearestEntity.Parent.Name, "at position", nearestEntity.Position)
        print("Distance to nearest entity:", nearestDistance)

        return nearestEntity
    else
        print("No entities found")
    end
end


local Combat = GuiLibrary.ObjectsThatCanBeSaved.CombatWindow.Api
local Blatant = GuiLibrary.ObjectsThatCanBeSaved.BlatantWindow.Api
local Render = GuiLibrary.ObjectsThatCanBeSaved.RenderWindow.Api
local Utility = GuiLibrary.ObjectsThatCanBeSaved.UtilityWindow.Api
local World = GuiLibrary.ObjectsThatCanBeSaved.WorldWindow.Api


local enabled = false




local function SetDropdownItem(DropdownObject, Item)
    DropdownObject.Value = Item
end




if game.PlaceId == 13864667823 then
    local function getBadGuysFolder()
        local Folder = Workspace:WaitForChild('BadGuys', 60)

        return Folder
    end

    local function getBadGuysFolderFrontDoor()
        local Folder = Workspace:WaitForChild('BadGuysFront', 60)

        return Folder
    end

    local function getBadGuysFolderBoss()
        local Folder = Workspace:WaitForChild('BadGuysBoss', 60)

        return Folder
    end




    local function GetEventsFolder()
        return ReplicatedStorage:WaitForChild('Events', 60)
    end


    local function Train(Ability)
        return GetEventsFolder():WaitForChild('RainbowWhatStat'):FireServer(Ability)
    end




    local function SendNotitfication(title, text, delay)
        local suc, res = pcall(function()
            local frame = GuiLibrary.CreateNotification(title, text, delay)

            return frame
        end)

        return (suc and res)
    end


    local function SendWarningNotification(title, text, delay)
        local suc, res = pcall(function()
            local frame = GuiLibrary.CreateNotification(title, text, delay, 'assets/WarningNotification.png')
            
            frame.Frame.Frame.ImageColor3 = Color3.fromRGB(236, 129, 44)

            return frame
        end)

        return (suc and res)
    end







    local function GiveItem(Item)
        local Events = GetEventsFolder()

        if Item == "Armor" then
            Events:WaitForChild("Vending"):FireServer(3, "Armor2", "Armor", tostring(LocalPlayer), 1)
        elseif Item == "Crowbar 1" or Item == "Crowbar 2" or Item == "Bat" or Item == "Pitchfork" or Item == "Hammer" or Item == "Wrench" or Item == "Broom" then
            Events.Vending:FireServer(3, tostring(Item:gsub(" ", "")), "Weapons", LocalPlayer.Name, 1)
        else
            Events:WaitForChild("GiveTool"):FireServer(tostring(Item:gsub(" ", "")))
        end
    end




    local function TeleportTo(CFrameArg)
        fetchPlayerHumanoidRootPart(lplr).CFrame = CFrameArg
    end




    local function GetDog()
        for i, v in pairs(lplr:WaitForChild('PlayerGui', 60).Assets:WaitForChild('Note', 60):WaitForChild('Note', 60):WaitForChild('Note', 60):GetChildren()) do
            if v.Name:match('Circle') and v.Visible == true then
                GiveItem(tostring(v.Name:gsub('Circle', '')))
                task.wait(.1)
                lplr:WaitForChild('Backpack'):WaitForChild(tostring(v.Name:gsub('Circle', ''))).Parent = FetchPlayerCharacter()
                TeleportTo(CFrame.new(-257.56839, 29.4499969, -910.452637, -0.238445505, 7.71292363e-09, 0.971155882, 1.2913591e-10, 1, -7.91029819e-09, -0.971155882, -1.76076387e-09, -0.238445505))
                task.wait(.5)
                GetEventsFolder():WaitForChild('CatFed', 60):FireServer(tostring(v.Name:gsub('Circle', '')))
            end
        end
        task.wait(2)
        for i = 1, 3 do
            TeleportTo(CFrame.new(-203.533081, 30.4500484, -790.901428, -0.0148558766, 8.85941187e-09, -0.999889672, 2.65695732e-08, 1, 8.46563175e-09, 0.999889672, -2.64408779e-08, -0.0148558766) + Vector3.new(0, 5, 0))
            task.wait(.1)
        end
    end


    local Events = GetEventsFolder()

    local function GetAgent()
        GiveItem("Louise")
        task.wait(.1)
        lplr.Backpack:WaitForChild("Louise").Parent = lplr.Character
        Events:WaitForChild("LouiseGive"):FireServer(2)
    end


    local LocalPlayer = lplr


    local function GetUncle()
        GiveItem("Key")
        task.wait(.1)
        lplr.Backpack:WaitForChild("Key").Parent = lplr.Character
        wait(.5)
        Events.KeyEvent:FireServer()
    end

    local function ClickPete()
        fireclickdetector(game:GetService("Workspace").UnclePete.ClickDetector)
    end


    local function CollectCash()
        for i, v in pairs(game:GetService("Workspace"):GetChildren()) do
            if v.Name == "Part" and v:FindFirstChild("TouchInterest") and v:FindFirstChild("Weld") and v.Transparency == 1 then
                firetouchinterest(v, lplr.Character.HumanoidRootPart, 0)
            end
        end
    end


    local function GetAllOutsideItems()
        TeleportTo(CFrame.new(-199.240555, 30.0009422, -790.182739, 0.08340507, 2.48169538e-08, 0.996515751, -2.7112752e-09, 1, -2.46767993e-08, -0.996515751, -6.43658127e-10, 0.08340507))
        for i, v in pairs(game:GetService("Workspace").OutsideParts:GetChildren()) do
            fireclickdetector(v.ClickDetector)
        end
        LocalPlayer.Character.Humanoid:MoveTo(LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(-10, 0, 0))
    end

    local function BringAllEnemies()
        pcall(function()
            for i, v in pairs(game:GetService("Workspace").BadGuys:GetChildren()) do
                v.HumanoidRootPart.Anchored = true
                v.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -4)
            end
            for i, v in pairs(game:GetService("Workspace").BadGuysBoss:GetChildren()) do
                v.HumanoidRootPart.Anchored = true
                v.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -4)
            end
            
            for i, v in pairs(game:GetService("Workspace").BadGuysFront:GetChildren()) do
                v.HumanoidRootPart.Anchored = true
                v.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -4)
            end
        end)
    end



    local SecretEndingTable = {
        "HatCollected",
        "MaskCollected",
        "CrowbarCollected"
    }


    local function GetSecretEnding()
        for i, v in next, SecretEndingTable do
            Events.LarryEndingEvent:FireServer(v, true)
        end
    end

    local function GetGAppleBadge()
        if game:GetService("Workspace"):FindFirstChild("FallenTrees") then
            for i, v in pairs(game:GetService("Workspace").FallenTrees:GetChildren()) do
                for i = 1, 20 do
                    if v:FindFirstChild("TreeHitPart") then
                        Events.RoadMissionEvent:FireServer(1, v.TreeHitPart, 5)
                    end
                end
            end
            task.wait(1)
            TeleportTo(CFrame.new(61.8781624, 29.4499969, -534.381165, -0.584439218, -1.05103076e-07, 0.811437488, -3.12853778e-08, 1, 1.06993674e-07, -0.811437488, 3.71451705e-08, -0.584439218))
            task.wait(.5)
            fireclickdetector(game:GetService("Workspace").GoldenApple.ClickDetector)
        else
            SendWarningNotification('Golden Apple', 'Golden Apple Has Not Spawned Yet, Please Wait Until the First Wave.', 7)
        end
    end



    local function Delete(Instance)
        pcall(function()
            Events:WaitForChild("OnDoorHit"):FireServer(Instance)
        end)
    end




    local function AntiMud(Touchable)
        for i, v in pairs(game:GetService("Workspace").BogArea.Bog:GetDescendants()) do
            if v.Name == "Mud" and v:IsA("Part") then
                if Touchable == true then
                    v.CanTouch = false
                else 
                    v.CanTouch = false
                end
            end
        end
    end




    local Others = {
        ['Damage'] = 3
    }


    local function hitNearestBadGuy(maxRange)
        local Players = game:GetService("Players")
        local lplr = Players.LocalPlayer
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local HitBadguyEvent = ReplicatedStorage:WaitForChild("Events"):WaitForChild("HitBadguy")

        local character = lplr.Character or lplr.CharacterAdded:Wait()
        local HRP = character:WaitForChild("HumanoidRootPart")
        local playerPosition = HRP.Position

        local badGuysFolder = getBadGuysFolder()
        local badGuysFrontFolder = getBadGuysFolderFrontDoor()
        local badGuysBossFolder = getBadGuysFolderBoss()
        local badGuyModels = badGuysFolder:GetChildren()
        local badGuyFrontModels = badGuysFrontFolder:GetChildren()
        local badGuyBossModels = badGuysBossFolder:GetChildren()

        local badGuyEntities = {}
        for _, badGuy in ipairs(badGuyModels) do
            if badGuy and badGuy and badGuy:IsA("Model") and badGuy.Name == " " and badGuy:FindFirstChild("HumanoidRootPart") then
                table.insert(badGuyEntities, badGuy:FindFirstChild("HumanoidRootPart"))
            end
        end

        for _, BadGuyFront in ipairs(badGuyFrontModels) do
            if badGuyFront and badGuyFront and badGuyFront:IsA("Model") and BadGuyFront.Name == " " and BadGuyFront:FindFirstChild("HumanoidRootPart") then
                table.insert(badGuyEntities, BadGuyFront:FindFirstChild("HumanoidRootPart"))
            end
        end

        for _, badGuyBoss in ipairs(badGuyBossModels) do
            if badGuyBoss and badGuyBoss:IsA('Model') and badGuyBoss.Name == ' ' and badGuyBoss:FindFirstChild('HumanoidRootPart') then
                table.insert(badGuyEntities, badGuyBoss:FindFirstChild('HumanoidRootPart'))
            end
        end


        if (Workspace:FindFirstChild('BadGuyBrute') and Workspace:FindFirstChild('BadGuyBrute'):FindFirstChild('HumanoidRootPart')) then
            table.insert(badGuyEntities, Workspace:FindFirstChild('BadGuyBrute'):FindFirstChild('HumanoidRootPart'))
        end

        if (Workspace:FindFirstChild('PizzaBossAlec') and Workspace:FindFirstChild('PizzaBossAlec'):FindFirstChild('BadGuyPizza') and Workspace:FindFirstChild('PizzaBossAlec'):FindFirstChild('BadGuyPizza'):FindFirstChild('HumanoidRootPart')) then
            table.insert(badGuyEntities, Workspace:FindFirstChild('PizzaBossAlec'):FindFirstChild('BadGuyPizza'):FindFirstChild('HumanoidRootPart'))
        end


        
        local function calculateDistance(pos1, pos2)
            return (pos1 - pos2).Magnitude
        end


        local function findNearestEntity(playerPosition, entityList)
            local nearestEntity = nil
            local nearestDistance = math.huge

            for _, entity in ipairs(entityList) do
                local entityPosition = entity.Position
                local dist = calculateDistance(playerPosition, entityPosition)
                if dist < nearestDistance then
                    nearestEntity = entity
                    nearestDistance = dist
                end
            end

            return nearestEntity, nearestDistance
        end

        local nearestBadGuy, nearestDistance = findNearestEntity(playerPosition, badGuyEntities)

        if nearestBadGuy and nearestDistance <= maxRange then
            local args = {
                [1] = nearestBadGuy.Parent,
                [2] = Others['Damage'],
                [3] = 1
            }
            HitBadguyEvent:FireServer(unpack(args))

            if (badGuy and badGuy.Parent) then
                local Hum = badGuy.Parent:FindFirstChild('Humanoid')

                if Hum then
                    if Hum.Health == 5 then
                        local args = {
                            [1] = badGuy.Parent,
                            [2] = 996
                        }
                        
                        HitBadguyEvent:FireServer(unpack(args))
                    end
                end
            end
        else
        end
    end






    local function hitMultipleBadGuys(maxRange)
        local Players = game:GetService("Players")
        local lplr = Players.LocalPlayer
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local HitBadguyEvent = ReplicatedStorage:WaitForChild("Events"):WaitForChild("HitBadguy")

        local character = lplr.Character or lplr.CharacterAdded:Wait()
        local HRP = fetchPlayerHumanoidRootPart(lplr)
        local playerPosition = HRP.Position

        local badGuysFolder = getBadGuysFolder()
        local badGuysFrontFolder = getBadGuysFolderFrontDoor()
        local badGuyModels = badGuysFolder:GetChildren()
        local badGuyFrontModels = badGuysFrontFolder:GetChildren()

        local badGuyEntities = {}
        for _, badGuy in ipairs(badGuyModels) do
            if badGuy and badGuy:IsA("Model") and badGuy.Name == " " and badGuy:FindFirstChild("HumanoidRootPart") then
                table.insert(badGuyEntities, badGuy:FindFirstChild("HumanoidRootPart"))
            end
        end

        for _, badGuyFront in ipairs(badGuyFrontModels) do
            if badGuyFront and badGuyFront:IsA("Model") and badGuyFront.Name == " " and badGuyFront:FindFirstChild("HumanoidRootPart") then
                table.insert(badGuyEntities, badGuyFront:FindFirstChild("HumanoidRootPart"))
            end
        end

        if (Workspace:FindFirstChild('BadGuyBrute') and Workspace:FindFirstChild('BadGuyBrute'):FindFirstChild('HumanoidRootPart')) then
            table.insert(badGuyEntities, Workspace:FindFirstChild('BadGuyBrute'):FindFirstChild('HumanoidRootPart'))
        end

        if (Workspace:FindFirstChild('PizzaBossAlec') and Workspace:FindFirstChild('PizzaBossAlec'):FindFirstChild('BadGuyPizza') and Workspace:FindFirstChild('PizzaBossAlec'):FindFirstChild('BadGuyPizza'):FindFirstChild('HumanoidRootPart')) then
            table.insert(badGuyEntities, Workspace:FindFirstChild('PizzaBossAlec'):FindFirstChild('BadGuyPizza'):FindFirstChild('HumanoidRootPart'))
        end



        --[[ Iterate through all bad guys and hit those within range ]]
        for _, badGuy in ipairs(badGuyEntities) do
            local distance = calculateDistance(playerPosition, badGuy.Position)
            if distance <= maxRange then
                local args = {
                    [1] = badGuy.Parent,
                    [2] = Others['Damage'],
                    [3] = 1
                }
                HitBadguyEvent:FireServer(unpack(args))
                -- [[ Print for debugging ]]
    --[[            print("Hitting bad guy:", badGuy.Parent.Name, "at distance:", distance) ]]

                if (badGuy and badGuy.Parent) then
                    local Hum = badGuy.Parent:FindFirstChild('Humanoid')

                    if Hum then
                        if Hum.Health == 5 then
                            local args = {
                                [1] = badGuy.Parent,
                                [2] = 996
                            }
                            
                            HitBadguyEvent:FireServer(unpack(args))
                        end
                    end
                end
            end
        end
    end



    --[[

    local args = {
        [1] = 3,
        [2] = "Armor2",
        [3] = "Armor",
        [4] = "RobloxScripts_CoreG",
        [6] = 12
    }

    game:GetService("ReplicatedStorage").Events.Vending:FireServer(unpack(args))
    ]]

    --[[
    local args = {
        [1] = workspace.BadGuyBrute,
        [2] = 6,
        [3] = 2
    }

    game:GetService("ReplicatedStorage").Events.HitBadguy:FireServer(unpack(args))
    ]]




    local function FetchHumanoid()
        local Character = FetchPlayerCharacter()


        return Character:WaitForChild('Humanoid', 60)
    end



    local KillAuraSettings = {
        ['Range'] = 10;
        ['HitsPerSecond'] = 2;
        ['WaitTime'] = 0.3;
        ['AnimationTurn'] = 1,
        ['DoingSwingAnimation'] = false;
        ['Multi-Aura'] = false;
    }



    local KillAura = Combat.CreateOptionsButton({
        Name = 'KillAura',
        Function = function(Callback)
            enabled = Callback
            if Callback then
                while true do
                    if enabled then
                        if KillAuraSettings['Multi-Aura'] == true then
                            hitMultipleBadGuys(KillAuraSettings['Range'])
                            hitNearestBadGuy(KillAuraSettings['Range'])
                        else
                            hitNearestBadGuy(KillAuraSettings['Range'])
                        end
                    end

                    --[[ If the swing animation setting is enabled, handle the animation ]]
                    if KillAuraSettings['DoingSwingAnimation'] == true then
                        local Turn = KillAuraSettings['AnimationTurn']
                        local Humanoid = FetchHumanoid()
                        local Weapon = FetchPlayerCharacter():FindFirstChildOfClass('Tool')
                        if Weapon then
                            local oldWeapon = Weapon
                            Weapon = Weapon:FindFirstChild('Level41') 
                                or Weapon:FindFirstChild('Level42') 
                                or Weapon:FindFirstChild('Level51') 
                                or Weapon:FindFirstChild('Level52')

                            if Weapon then
                                if Turn == 1 then
                                    KillAuraSettings['AnimationTurn'] = 2
                                    local FirstAnimation = oldWeapon:WaitForChild('Level42')
                                    local track = Humanoid:LoadAnimation(FirstAnimation)
                                    track:Play()
                                else
                                    KillAuraSettings['AnimationTurn'] = 1
                                    local SecondAnimation = oldWeapon:WaitForChild('Level52')
                                    local track = Humanoid:LoadAnimation(SecondAnimation)
                                    track:Play()
                                end
                            end
                        end    
                    end

                    --[[ If KillAura is disabled, exit the loop ]]
                    if not enabled then
                        return
                    end

                    --[[ Wait for the specified time before the next iteration ]]
                    task.wait(KillAuraSettings['WaitTime'])
                end
            end
        end
    })




    KillAura.CreateSlider({
        Name = 'Wait Time',
        Min = 1,
        Max = 10,
        Function = function(val) 
            KillAuraSettings['WaitTime'] = val / 10
        end,
        HoverText = 'How many miliseconds it takes before another hit.',
        Default = 3,
        Double = 1 
    })


    KillAura.CreateSlider({
        Name = 'Range',
        Min = 10,
        Max = 150,
        Function = function(val)
            KillAuraSettings['Range'] = val
        end,
        HoverText = 'The Range of the KillAura.',
        Default = 10,
        Double = 1
    })


    KillAura.CreateSlider({
        Name = 'Damage',
        Min = 1,
        Max = 100,
        HoverText = 'The Damage that the KillAura will do. For each enemy. That the KillAura attacks.',
        Function = function(val)
            Others['Damage'] = val
        end,
        Default = 3,
        Double = 1
    })


    KillAura.CreateToggle({
        Name = 'Swing',
        HoverText = 'Makes your Weapon swing when the KillAura kills an Enemy.',
        Function = function(val)
            KillAuraSettings['DoingSwingAnimation'] = val
        end
    })


    KillAura.CreateToggle({
        Name = 'Multi-Aura',
        HoverText = 'Should target more than 1 bad guy at once.',
        Function = function(val)
            KillAuraSettings['Multi-Aura'] = val
        end
    })




    local ena = false

    local SpeedSettings = {
        ['Speed'] = 24
    }

    local Speed = Blatant.CreateOptionsButton({
        Name = 'Speed',
        Function = function(Callback)
            ena = Callback
            if Callback then
                while ena do
                    local Character = FetchPlayerCharacter()
                    local Humanoid = FetchHumanoid()

                    if Humanoid.Health > 0 then
                        Humanoid.WalkSpeed = SpeedSettings['Speed']
                    end


                    if ena == false then
                        return
                    end

                    task.wait(0.1)
                end
            else
                local Humanoid = FetchHumanoid()


                if Humanoid.Health > 0 and (Humanoid.WalkSpeed ~= StarterPlayer.CharacterWalkSpeed or Humanoid.WalkSpeed ~= 16) then
                    Humanoid.WalkSpeed = (StarterPlayer.CharacterWalkSpeed or 16)
                end
            end
        end
    })


    Speed.CreateSlider({
        Name = 'WalkSpeed',
        Min = 0,
        Max = 200,
        Function = function(val)
            SpeedSettings['Speed'] = val
        end,
        HoverText = 'The Speed when Speed is Enabled.',
        Default = FetchHumanoid().WalkSpeed,
        Double = 1
    })



    local enab = false

    local AutoLooter = Utility.CreateOptionsButton({
        Name = 'AutoLooter',
        Function = function(Callback)
            enab = Callback
            if Callback then
                while Callback do
                    task.wait(1)
                end
            end
        end
    })






    local oldclickdetector = fireclickdetector

    local function fireclickdetector(clickdetector)
        if clickdetector then
            local partToTP_To = clickdetector.Parent
            local OldPosition = fetchPlayerHumanoidRootPart(lplr).Position
            local newPosition = partToTP_To.Position
            local Character = FetchPlayerCharacter()


            Character:MoveTo(newPosition)

            
            repeat
                task.wait(1 + 0.1)
            until (3)
        end
    end

    local AutoPickupMoney = Utility.CreateOptionsButton({
        Name = 'Auto PickupMoney',
        Function = function(Callback)
            repeat
                CollectCash()
                task.wait(0.5)
            until (not Callback)
        end
    })


    --[[game:GetService("ReplicatedStorage").Events.LightFlipped:FireServer()]]



    local RemoveFog = Utility.CreateOptionsButton({
        Name = 'RemoveFog',
        Function = function(Callback)
            repeat
                local args = {
                    [1] = lplr
                }
                    
                game:GetService("ReplicatedStorage").Events.DeleteFogPart:FireServer(unpack(args))

                task.wait(1)
            until (not Callback)           
        end
    })




    local FoodsForSale = {
        'Apple',
        'Cookie',
        'Bloxy Cola',
        'Pizza',
        'Golden Apple',
        'Golden Pizza',
        'Rainbow Pizza',
        'Lollipop',
        'Chips',
    }



    local Foods = {
        ['Apple'] = 'Apple',
        ['Cookie'] = 'Cookie',
        ['Bloxy Cola'] = 'BloxyCola',
        ['Golden Apple'] = 'GoldenApple',
        ['Golden Pizza'] = 'GoldenPizza',
        ['Rainbow Pizza'] = 'RainbowPizza',
        ['Lollipop'] = 'Lollipop',
        ['Chips'] = 'Chips',
    }





    local AutoConsumeFoodsSettings = {
        ['SecondsBeforeNextConsume'] = 1,
        ['Item'] = 'Apple'
    }


    local function CheckIfPlayerHasItemInBackpackIfSoReturnItemAsync(itemName)
        local Backpack = lplr:WaitForChild('Backpack', 60)
        local Humanoid = FetchHumanoid()


        if Backpack and Workspace then
            local WorkspacePlayer = FetchPlayerCharacter(lplr)

            if WorkspacePlayer and (WorkspacePlayer:FindFirstChild(itemName) and WorkspacePlayer:FindFirstChild(itemName):IsA('Tool')) then
                return WorkspacePlayer:FindFirstChild(itemName)
            elseif Backpack and (Backpack:FindFirstChild(itemName) and Backpack:FindFirstChild(itemName):IsA('Tool')) then
                local Item = (Backpack:FindFirstChild(itemName))
                Humanoid:EquipTool(Item)

                return Item
            end
        end
    end


    local EnergyItemsTable = {
        ['Apple'] = 15,
        ['Cookie'] = 15,
        ['BloxyCola'] = 15,
        ['Chips'] = 5,
        ['Lollipop'] = 10,
        ['Golden Pizza'] = 75,
        ['Rainbow Pizza'] = 25,
    }


    local AutoConsumeFoods = Utility.CreateOptionsButton({
        Name = 'AutoConsume',
        Function = function(Callback)
            getgenv().IsAutoConsumeEnabled = Callback
            if Callback then
                repeat
                    local Item = CheckIfPlayerHasItemInBackpackIfSoReturnItemAsync(Foods[AutoConsumeFoodsSettings['Item']])
                    

                    if Item then
                        if Item.Name == 'GoldenApple' then
                            local EatRemote = Item:WaitForChild('HealTheNoobs')

                            if EatRemote then
                                EatRemote:FireServer()
                            end
                        else
                            local args = {
                                [1] = EnergyItemsTable[Item.Name],
                                [2] = Item.Name
                            }

                            ReplicatedStorage:WaitForChild('Events', 60):WaitForChild('Energy', 60):FireServer(unpack(args))
                        end
                    end

                    task.wait(AutoConsumeFoodsSettings['SecondsBeforeNextConsume'])
                until (not IsAutoConsumeEnabled)
            else

            end
        end
    })



    AutoConsumeFoods.CreateDropdown({
        Name = 'Food',
        List = FoodsForSale,
        Function = function(val)
            AutoConsumeFoodsSettings['Item'] = val
        end
    })


    AutoConsumeFoods.CreateSlider({
        Name = 'Wait Time',
        Min = 1,
        Max = 120,
        Function = function(val)
            AutoConsumeFoodsSettings['SecondsBeforeNextConsume'] = val / 10
        end,
        Double = 1,
        HoverText = 'Wait time in miliseconds.'
    })






    local AutoGiveItemSettings = {
        ['ItemSelected'] = 'Apple',
        ['Amount'] = 1,
        ['CatagorySelected'] = 'Foods'
    }







    local AutoGiveItem = {['Enabled'] = false}




    local WeaponsTable = {
        ['Bat'] = 'Bat',
        ['Pitchfork'] = 'Pitchfork',
        ['Wrench'] = 'Wrench',
        ['Broom'] = 'Broom',
    }



    AutoGiveItem = Blatant.CreateOptionsButton({
        Name = 'GiveItem',
        Function = function(Callback)
            if Callback then
                local Button = AutoGiveItem


                if type(AutoGiveItemSettings['CatagorySelected']) == 'string' and AutoGiveItemSettings['CatagorySelected'] == 'Foods' then
                    if type(AutoGiveItemSettings['Amount']) == 'number' and AutoGiveItemSettings['Amount'] > 1 then
                        for i = 0, (AutoGiveItemSettings['Amount'] - 1) do
                            local args = {
                                [1] = AutoGiveItemSettings['ItemSelected']
                            }

                            ReplicatedStorage:WaitForChild('Events', 60):WaitForChild('GiveTool', 60):FireServer(unpack(args))
                        end
                    else
                        local args = {
                            [1] = AutoGiveItemSettings['ItemSelected']
                        }

                        ReplicatedStorage:WaitForChild('Events', 60):WaitForChild('GiveTool', 60):FireServer(unpack(args))
                    end
                end

                if type(AutoGiveItemSettings['CatagorySelected']) == 'string' and AutoGiveItemSettings['CatagorySelected'] == 'Weapons' then
                    local ItemName = AutoGiveItemSettings['ItemSelected']

                    GiveItem(ItemName)
                end

                Button['ToggleButton'](false)
            end
        end
    })



    local FoodCatagory = AutoGiveItem.CreateDropdown({
        Name = 'Foods',
        List = FoodsForSale,
        Function = function(val)
            local decoded = Foods[val]

            AutoGiveItemSettings['ItemSelected'] = decoded
        end,
        Default = 'Apple'
    })


    local WeaponCatagory = AutoGiveItem.CreateDropdown({
        Name = 'Weapons',
        List = {
            'Bat',
            'Pitchfork',
            'Hammer',
            'Broom',
            'Wrench'
        },
        Function = function(val)
            AutoGiveItemSettings['ItemSelected'] = val;
        end
    })


    local AmountSlider = {}


    AutoGiveItem.CreateDropdown({
        Name = 'Catagory',
        List = {'Foods', 'Weapons', 'Other'},
        Function = function(val)
            if val == 'Foods' then
                FoodCatagory.Object.Visible = true
                WeaponCatagory.Object.Visible = false
                AmountSlider.Object.Visible = true
            end

            if val == 'Weapons' then
                FoodCatagory.Object.Visible = false
                WeaponCatagory.Object.Visible = true
                AmountSlider.Object.Visible = false
            end
        

            AutoGiveItemSettings['CatagorySelected'] = val
        end
    })


    AmountSlider = AutoGiveItem.CreateSlider({
        Name = 'Amount',
        Min = 1,
        Max = 50,
        Function = function(val)
            AutoGiveItemSettings['Amount'] = val
        end,
        HoverText = 'The amount of the item you will recive.',
        Default = 1,
        Double = 1
    })




    WeaponCatagory.Object.Visible = false






    local GetBestTool = {['Enabled'] = false}


    GetBestTool = Utility.CreateOptionsButton({
        Name = 'GetBestWeapon',
        Function = function(Callback)
            if Callback then

            end
        end
    })





    local StatsTable = {
        ['Ability'] = 'Speed',
        ['Times'] = 1
    }


    local GetStatTo = {['Enabled'] = false}

    GetStatTo = Utility.CreateOptionsButton({
        Name = 'Get Stat',
        Function = function(Callback)
            if Callback then
                if StatsTable['Times'] > 1 then
                    for i = 0, (StatsTable['Times'] - 1) do
                        Train(StatsTable['Ability'])
                    end
                else
                    Train(StatsTable['Ability'])
                end

                GetStatTo['ToggleButton'](false)
            end
        end
    })


    GetStatTo.CreateDropdown({
        Name = 'Ability',
        List = {
            'Speed',
            'Strength'
        },
        HoverText = 'The Stat you want to level up on.',
        Function = function(val)
            StatsTable['Ability'] = val
        end
    })


    GetStatTo.CreateSlider({
        Name = 'Times',
        HoverText = 'How many times this function will run.',
        Min = 1,
        Max = 5,
        Function = function(val)
            StatsTable['Times'] = val
        end
    })




    local GetNPC_OnTeam = {['Enabled'] = false}

    local SettingsForNPC_Team = {
        ['NPC'] = 'All'
    }



    GetNPC_OnTeam = Utility.CreateOptionsButton({
        Name = 'GetNPC_Team',
        Function = function(Callback)
            if Callback then
                local Settings = SettingsForNPC_Team

                if Settings['NPC'] == 'Dog' then
                    GetDog()
                elseif Settings['NPC'] == 'Uncle Pete' then
                    GetUncle()
                elseif Settings['NPC'] == 'Agent Bradley' then
                    GetAgent()
                elseif Settings['NPC'] == 'All' then
                    GetDog()
                    task.wait(5)
                    GetAgent()
                    task.wait(1)
                    GetUncle()
                end

                GetNPC_OnTeam['ToggleButton'](false)
            end
        end
    })


    GetNPC_OnTeam.CreateDropdown({
        Name = 'NPC Option',
        List = {
            'All',
            'Dog',
            'Agent Bradley',
            'Uncle Pete'
        },
        Function = function(val)
            SettingsForNPC_Team['NPC'] = val
        end,
        Default = 'All'
    })



    local function UnequipAllTools()
        for i, v in pairs(LocalPlayer.Character:GetChildren()) do
            if v:IsA("Tool") then
                v.Parent = LocalPlayer.Backpack
            end
        end
    end



    local function HealAllPlayers()
        UnequipAllTools()
        task.wait(.2)
        GiveItem("Golden Apple")
        task.wait(.5)
        LocalPlayer.Backpack:WaitForChild("GoldenApple").Parent = LocalPlayer.Character
        task.wait(.5)
        Events:WaitForChild("HealTheNoobs"):FireServer()
    end





    local HealAllTable = {
        ['IsDoingLoop'] = false
    }


    local AutoHealAll = Utility.CreateOptionsButton({
        Name = 'HealAll',
        Function = function(Value)
            getgenv().HealAllLoop = (HealAllTable['IsDoingLoop'] == true) and (Value == true)

            HealAllPlayers()

            task.wait(3)

            if not HealAllLoop then
                AutoHealAll['ToggleButton'](false)
                return
            end

            while (HealAllLoop == true) do
                HealAllPlayers()
                task.wait(3)
            end

            AutoHealAll['ToggleButton'](false)
        end
    })



    AutoHealAll.CreateToggle({
        Name = 'Loop',
        HoverText = 'When this is enabled, the HealAll will loop until this toggle is disabled or if the HealAll Options Button is disabled.',
        Function = function(val)
            HealAllTable['IsDoingLoop'] = val
        end,
        Default = false
    })






    local AutoConsumeV2 = {['Enabled'] = false}


    local AutoConsumeV2Table = {
        [1] = 'Apple',
        [2] = 1,
    }



    local FoodTable = {
        'Apple',
        'Cookie',
        'Bloxy Cola',
        'Pizza',
        'Golden Apple',
        'Golden Pizza',
        'Rainbow Pizza',
        'Lollipop',
        'Chips',
    }



    local Foods = {
        ['Apple'] = 'Apple',
        ['Cookie'] = 'Cookie',
        ['Bloxy Cola'] = 'BloxyCola',
        ['Golden Apple'] = 'GoldenApple',
        ['Golden Pizza'] = 'GoldenPizza',
        ['Rainbow Pizza'] = 'RainbowPizza',
        ['Lollipop'] = 'Lollipop',
        ['Chips'] = 'Chips',
    }



    AutoConsumeV2 = Utility.CreateOptionsButton({
        Name = 'AutoConsumeV2',
        Function = function(Callback)
            getgenv().IsAutoConsumeV2Enabled = Callback


            while IsAutoConsumeV2Enabled do
                UnequipAllTools()
                task.wait(.1)
                GiveItem(Foods[AutoConsumeV2Table[1]])
                task.wait(.5)
                local Backpack = lplr:WaitForChild('Backpack', 60)
                local Item = CheckIfPlayerHasItemInBackpackIfSoReturnItemAsync(Foods[AutoConsumeV2Table[1]])
                

                if Item then
                    if Item.Name == 'GoldenApple' then
                        local EatRemote = Item:WaitForChild('HealTheNoobs')

                        if EatRemote then
                            EatRemote:FireServer()
                        end
                    else
                        local args = {
                            [1] = EnergyItemsTable[Item.Name],
                            [2] = Item.Name
                        }

                        ReplicatedStorage:WaitForChild('Events', 60):WaitForChild('Energy', 60):FireServer(unpack(args))
                    end
                end

                task.wait(AutoConsumeV2Table[2])
            end
        end
    })



    AutoConsumeV2.CreateDropdown({
        Name = 'Foods',
        List = FoodTable,
        Function = function(val)
            AutoConsumeV2Table[1] = val
        end
    })

    AutoConsumeV2.CreateSlider({
        Name = 'Seconds',
        Min = 2,
        Max = 10,
        Function = function(val)
            AutoConsumeV2Table[2] = val
        end,
        Default = 3
    })
    local ClickUncolePeteQuest = {
        ['Enabled'] = false
    }
    ClickUncolePeteQuest = Utility.CreateOptionsButton({
        Name = 'Click UncolePete',
        Function = function(Callback)
            if Callback then
                ClickPete()

                ClickUncolePeteQuest['ToggleButton'](false)
            end
        end
    }) 
    local SpawnFoodOnTable = {['Enabled'] = false}

    local SpawnFoodTable = {
        ['Slot'] = 1,
        ['Type'] = 'Pizza',
    }



    SpawnFoodOnTable = Utility.CreateOptionsButton({
        Name = 'Kitchen Food',
        Function = function(Callback)
            Events:WaitForChild('OutsideFood', 60):FireServer(6, {
                ['item2'] = SpawnFoodTable['Type'],
                ['placement'] = SpawnFoodTable['Slot']
            })


            SpawnFoodOnTable['ToggleButton'](false)
        end
    })




    SpawnFoodOnTable.CreateDropdown({
        Name = 'Type',
        List = {
            'Pizza Box',
            'Bloxy Cola'
        },
        Function = function(selected)
            if selected == 'Pizza Box' then
                SpawnFoodTable['Type'] = 'Pizza'
            elseif selected == 'Bloxy Cola' then
                SpawnFoodTable['Type'] = 'BloxyPack'
            end
        end
    })


    SpawnFoodOnTable.CreateSlider({
        Name = 'Table Food Slot',
        Min = 1,
        Max = 4,
        Double = 1,
        Default = 1,
        Function = function(val)
            SpawnFoodTable['Slot'] = val
        end
    })






    local GetEnding = {['Enabled'] = false}


    GetEnding = Utility.CreateOptionsButton({
        Name = 'GetEndings',
        Function = function(Callback)
            if Callback then
                GetSecretEnding()

                GetEnding['ToggleButton'](false)
            end
        end
    })



    local GetGoldenAppleBadge = {['Enabled'] = false}



    GetGoldenAppleBadge = Utility.CreateOptionsButton({
        Name = 'GetGoldenAppleBadge',
        Function = function(Callback)
            if Callback then
                GetGAppleBadge()

                GetGoldenAppleBadge['ToggleButton'](false)
            end
        end
    })

elseif game.PlaceId == 4620170611 then
    local function GetEventsFolder()
        local Folder = ReplicatedStorage:WaitForChild('RemoteEvents', 60)

        return Folder
    end


    local DoDoorRemote = function(applier)
        GetEventsFolder():WaitForChild('Door'):FireServer(table.unpack({[1] = applier}))
    end




    local AutoSkip = Utility.CreateOptionsButton({
        Name = 'AutoSkip',
        Function = function(Callback)
            getgenv().GetSkipAllowed = Callback
            if Callback then
                repeat
                    local Events = GetEventsFolder()

                    local Remote = Events:WaitForChild('SkipTele')

                    if Remote then
                        Remote:FireServer()
                    end

                    task.wait(0.1)
                until (not GetSkipAllowed)
            end
        end
    })




    local A = {[1] = 1, [2] = 'Front'}

    local AutoDoor = Utility.CreateOptionsButton({
        Name = 'AutoDoor',
        Function = function(Callback)
            getgenv().GetAutoDoorAllowed = Callback
            if Callback then
                repeat
                    DoDoorRemote(A[2])
                    task.wait(A[1])
                until (not GetAutoDoorAllowed)
            end
        end
    })


    AutoDoor.CreateSlider({
        Name = 'Wait Time',
        Min = 1,
        Max = 10,
        Default = 1,
        Function = function(Val)
            A[1] = Val / 10
        end,
        HoverText = 'Set how fast it will spam the door.'
    })

    AutoDoor.CreateDropdown({
        Name = 'Door',
        List = {
            'Front Door',
            'Basement Door'
        },
        Function = function(Val)
            A[2] = Val:gsub(' Door', '')
        end,
        HoverText = 'Wish door will be affected.'
    })


    local TurnOnBasementLights = {['Enabled'] = false}

    TurnOnBasementLights = Utility.CreateOptionsButton({
        Name = 'ActivateBasementLights',
        Function = function(Callback)
            if Callback then
                game:GetService("ReplicatedStorage").RemoteEvents.BasementMission:FireServer()

                TurnOnBasementLights['ToggleButton'](false)
            end
        end
    })

    

    local BlatantTurnOnPC = {['Enabled'] = false}

    -- game:GetService("ReplicatedStorage").RemoteEvents.BasementMission:FireServer()

    local B = {[1] = false, [2] = true}

    BlatantTurnOnPC = Blatant.CreateOptionsButton({
        Name = 'Turn on PC',
        Function = function(Callback)
            if Callback then
                if B[1] then
                    game:GetService("ReplicatedStorage").RemoteEvents.BasementMission:FireServer()
                end

                if B[2] then
                    local args = {
                        [1] = 1,
                        [2] = "Completed"
                    }
                    
                    game:GetService("ReplicatedStorage").RemoteEvents.PCCamera:FireServer(unpack(args))
                end

                BlatantTurnOnPC['ToggleButton'](false)
            end
        end
    })


    BlatantTurnOnPC.CreateToggle({
        Name = 'DoLights',
        Default = false,
        Function = function(Val)
            A[1] = Val
        end
    })

    BlatantTurnOnPC.CreateToggle({
        Name = 'TurnOnPC',
        Default = true,
        Function = function(Val)
            A[2] = Val
        end
    })


    local FoodsSale = {
        'Apple',
        'Cookie',
        'Chips',
        'Bloxy Cola',
        'Small Pizza',
        'Normal Pizza',
        'Large Pizza',
        'Lollipop'
    }


    local TranslateFoods = {
        ['Apple'] = 'Apple',
        ['Cookie'] = 'Cookie',
        ['Chips'] = 'Chips',
        ['BloxyCola'] = 'BloxyCola',
        ['Small Pizza'] = 'Pizza1',
        ['Normal Pizza'] = 'Pizza2',
        ['Large Pizza'] = 'Pizza3',
        ['Lollipop'] = 'Lollipop'
    }



    local TranslateTools = {
        ['Key'] = 'Key'
    }


    local WeaponsTrasnlate = {
        ['Bat'] = 'Bat',
        ['Wrench'] = 'Wrench',
        ['Crowbar'] = 'Crowbar',
        ['Broom'] = 'Broom',
        ['Hammer'] = 'Hammer',
        ['Pitchfork'] = 'Pitchfork',
        ['Ice Breaker'] = 'Breaker',
        ['Toy Sword'] = 'Sword',
        ['Gun'] = 'Gun',
        ['Swat Gun'] = 'SwatGun'
    }



    local GiveItemTool = {['Enabled'] = false}

    local C = {[1] = 'Apple', [2] = 1, [3] = 'Foods'}


    local function GiveFoodRemote()
        local Events = GetEventsFolder()
        local GiveTool = Events:WaitForChild('GiveTool', 60)

        return GiveTool
    end

    local function GiveWeaponRemote()
        local Events = GetEventsFolder()
        local GiveWeapon = Events:WaitForChild('BasementWeapon', 60)

        return GiveWeapon
    end


    GiveItemTool = Blatant.CreateOptionsButton({
        Name = 'GiveItem',
        Function = function(Callback)
            if Callback then
                local Remote = GiveFoodRemote()
                local WeaponR = GiveWeaponRemote()

                if (C[3] == 'Foods' or C[3] == 'Tools') then
                    if (C[2] > 1) then
                        for i = 0, (C[2] - 1) do
                            Remote:FireServer(table.unpack({
                                [1] = C[1]
                            }))
                        end
                    else
                        Remote:FireServer(table.unpack({
                            [1] = C[1]
                        }))
                    end
                elseif (C[3] == 'Weapons') then
                    if (C[1]) then
                        WeaponR:FireServer(table.unpack({
                            [1] = true,
                            [2] = C[1]
                        }))
                    end
                end

                GiveItemTool['ToggleButton'](false)
            end
        end
    })


    local Foods = GiveItemTool.CreateDropdown({
        Name = 'Foods',
        List = FoodsSale,
        HoverText = 'Select the food you want to be given.',
        Function = function(Val)
            C[1] = TranslateFoods[Val];
        end
    })


    local Tools = GiveItemTool.CreateDropdown({
        Name = 'Tools',
        List = {
            'Key',

        },
        HoverText = 'Select the tool you want to be given.',
        Function = function(Val)
            C[1] = Val
        end
    })

    local Weapons = GiveItemTool.CreateDropdown({
        Name = 'Weapons',
        List = {
            'Bat',
            'Wrench',
            'Crowbar',
            'Broom',
            'Hammer',
            'Pitchfork',
            'Ice Breaker',
            'Toy Sword',
            'Gun',
            'Swat Gun'
        },
        Default = 'Bat',
        HoverText = 'Select the weapon you want to be given.',
        Function = function(Val)
            C[1] = Val
        end
    })


    local HowManySlider = GiveItemTool.CreateSlider({
        Name = 'Amount',
        Min = 1,
        Max = 50,
        Function = function(val)
            C[2] = val;
        end,
        HoverText = 'The Amount of that item you will get.'
    })


    Tools.Object.Visible = false
    Weapons.Object.Visible = false


    local CatagoryDrop = GiveItemTool.CreateDropdown({
        Name = 'Catagory',
        List = {
            'Foods',
            'Weapons',
            'Tools'
        },
        Default = 'Foods',
        Function = function(Val)
            if Val == 'Foods' then
                Foods.Object.Visible = true
                HowManySlider.Object.Visible = true
                Weapons.Object.Visible = false
                Tools.Object.Visible = false
                SetDropdownItem(Tools, C[1])
            elseif Val == 'Weapons' then
                Foods.Object.Visible = false
                HowManySlider.Object.Visible = false
                Weapons.Object.Visible = true
                Tools.Object.Visible = false
                SetDropdownItem(Tools, C[1])
            elseif Val == 'Tools' then
                Foods.Object.Visible = false
                HowManySlider.Object.Visible = false
                Weapons.Object.Visible = false
                Tools.Object.Visible = true
                SetDropdownItem(Tools, C[1])
            end


            C[3] = Val;
        end,
        HoverText = 'Select the Catagory, you want to sort items from.'
    })




    local RemoveToolFromInventorySettings = {[1] = '', BackPack = {}, BackpackForList = {}}


    local RemoveToolFromInventory = Utility.CreateOptionsButton({
        Name = 'RemoveFromBackpack',
        Function = function()
            if RemoveToolFromInventorySettings['BackPack'][RemoveToolFromInventorySettings[1]] then
                RemoveToolFromInventorySettings['BackPack'][RemoveToolFromInventorySettings[1]]:Destroy()
                RemoveToolFromInventorySettings['BackPack'][RemoveToolFromInventorySettings[1]] = nil

                if RemoveToolFromInventorySettings['BackPack'][RemoveToolFromInventorySettings[1]] then
                    RemoveToolFromInventorySettings['BackPack'][RemoveToolFromInventorySettings[1]] = nil
                end
            end
        end
    })


    for a, b in lplr:WaitForChild('Backpack', 60):GetChildren() do
        RemoveToolFromInventorySettings.BackPack[b.Name] = b
        table.insert(RemoveToolFromInventorySettings.BackpackForList, b.Name)
    end

    print(RemoveToolFromInventory)

    local DropdownListForBackpack = RemoveToolFromInventory.CreateDropdown({
        Name = 'Backpack',
        List = RemoveToolFromInventorySettings.BackpackForList,
        Default = (function()
            for a, b in lplr:WaitForChild('Backpack', 60):GetChildren() do
                if a and b then
                    if a == 1 then
                        return b.Name
                    end
                end
            end
        end)(),
        HoverText = 'Select the item you want to remove from your inventory',
        Function = function(Val)
            RemoveToolFromInventorySettings[1] = Val
        end
    })



    local SearchForItem = RemoveToolFromInventory.CreateTextBox({
        TempText = 'Type the name of the Item you want to remove.',
        Name = 'Search',
        FocusLost = function(Val)
            RemoveToolFromInventorySettings[1] = Val
        end
    })


    SearchForItem.Object.Visible = false


    RemoveToolFromInventory.CreateDropdown({
        Name = 'Method',
        List = {
            'Dropdown',
            'SearchBar'
        },
        Function = function(Val)
            if Val == 'SearchBar' then
                SearchForItem.Object.Visible = true
                DropdownListForBackpack.Object.Visible = false
            else
                SearchForItem.Object.Visible = false
                DropdownListForBackpack.Object.Visible = true
            end
        end,
        Default = 'Dropdown'
    })


    local function UpdateBackpackPlayerList(newList)
        DropdownListForBackpack.UpdateList(newList)
    end

    UpdateBackpackPlayerList(RemoveToolFromInventorySettings.BackpackForList)

    lplr:WaitForChild('Backpack', 60).ChildAdded:Connect(function(child)
        if not RemoveToolFromInventorySettings.BackPack[child.Name] then
            RemoveToolFromInventorySettings.BackPack[child.Name] = child
            table.insert(RemoveToolFromInventorySettings.BackpackForList, child.Name)
            UpdateBackpackPlayerList(RemoveToolFromInventorySettings.BackpackForList)
        end
    end)

    lplr:WaitForChild('Backpack', 60).ChildRemoved:Connect(function(child)
        -- see if the item is still in the players inventory
        if lplr:WaitForChild('Backpack', 60):FindFirstChild(child.Name) then
            UpdateBackpackPlayerList(RemoveToolFromInventorySettings.BackpackForList)
        else
            RemoveToolFromInventorySettings.BackPack[child.Name] = nil
            UpdateBackpackPlayerList(RemoveToolFromInventorySettings.BackpackForList)
        end
    end)
end

shared.VapeManualLoad = true


--[[
local a,b = loadstring(game:HttpGet('https://raw.githubusercontent.com/SubnauticaLaserMain/23-s/main/k.lua', true))()

if a then
    a()
else
    print(b)
end
]]
--[[
for i, v in game:GetService('Workspace'):WaitForChild('TheHouse'):GetDescendants() do
    if v and v.ClassName == 'ClickDetector' then
        print(v.Name .. ' found in : ' .. tostring(v:GetFullName()))
    end
end
]]
