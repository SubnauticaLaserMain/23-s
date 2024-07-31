local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local camera = workspace.CurrentCamera

local function createLine()
    local line = Drawing.new("Line")
    line.Color = Color3.new(1, 0, 0)
    line.Thickness = 2
    line.Visible = false
    return line
end

local function createBox()
    return {
        Top = createLine(),
        Right = createLine(),
        Bottom = createLine(),
        Left = createLine()
    }
end

local function removeBox(box)
    for _, line in pairs(box) do
        line:Remove()
    end
end

local playerBoxes = {}

local function updateBox(character, box)
    if not character or not character.PrimaryPart then
        return
    end
    
    local primaryPart = character.PrimaryPart
    local size = primaryPart.Size

    local corners = {
        camera:WorldToViewportPoint(primaryPart.Position + Vector3.new(-size.X / 2, size.Y / 2, 0)),
        camera:WorldToViewportPoint(primaryPart.Position + Vector3.new(size.X / 2, size.Y / 2, 0)),
        camera:WorldToViewportPoint(primaryPart.Position + Vector3.new(size.X / 2, -size.Y / 2, 0)),
        camera:WorldToViewportPoint(primaryPart.Position + Vector3.new(-size.X / 2, -size.Y / 2, 0))
    }

    if corners[1].Z > 0 then
        box.Top.From = Vector2.new(corners[1].X, corners[1].Y)
        box.Top.To = Vector2.new(corners[2].X, corners[2].Y)

        box.Right.From = Vector2.new(corners[2].X, corners[2].Y)
        box.Right.To = Vector2.new(corners[3].X, corners[3].Y)

        box.Bottom.From = Vector2.new(corners[3].X, corners[3].Y)
        box.Bottom.To = Vector2.new(corners[4].X, corners[4].Y)

        box.Left.From = Vector2.new(corners[4].X, corners[4].Y)
        box.Left.To = Vector2.new(corners[1].X, corners[1].Y)

        for _, line in pairs(box) do
            line.Visible = true
        end
    else
        for _, line in pairs(box) do
            line.Visible = false
        end
    end
end

local function onCharacterAdded(character)
    local box = createBox()
    playerBoxes[character] = box

    character.AncestryChanged:Connect(function(_, parent)
        if not parent then
            removeBox(box)
            playerBoxes[character] = nil
        end
    end)
end

local function onPlayerAdded(player)
    player.CharacterAdded:Connect(onCharacterAdded)
    if player.Character then
        onCharacterAdded(player.Character)
    end
end

local function onPlayerRemoving(player)
    local character = player.Character
    if character and playerBoxes[character] then
        removeBox(playerBoxes[character])
        playerBoxes[character] = nil
    end
end

Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(onPlayerRemoving)

for _, player in pairs(Players:GetPlayers()) do
    onPlayerAdded(player)
end

RunService.RenderStepped:Connect(function()
    for character, box in pairs(playerBoxes) do
        updateBox(character, box)
    end
end)
