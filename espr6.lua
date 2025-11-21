-- ESP R6 (contours carrés) — LocalScript
-- Utilise SelectionBox pour dessiner des contours rectangulaires autour des parts R6
-- Placer dans StarterPlayerScripts (client-side)

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

-- Paramètres
local ESP_ENABLED = true
local COLOR_ENEMY = Color3.fromRGB(255, 60, 60) -- rouge
local COLOR_TEAM = Color3.fromRGB(60, 180, 255) -- bleu clair
local LINE_THICKNESS = 0.03 -- ajuster pour épaissir/affiner le trait
local TEAM_CHECK = false

-- Noms des parts R6 à encadrer
local R6_PART_NAMES = {
    ["Head"] = true,
    ["Torso"] = true,
    ["Left Arm"] = true,
    ["Right Arm"] = true,
    ["Left Leg"] = true,
    ["Right Leg"] = true,
}

-- Tables pour stocker connexions/objets
local selBoxConns = {}      -- key = selectionBox, value = ancestryConn
local playerConnections = {} -- key = player, value = {charAddedConn, charRemovingConn, descConn}

local function isR6(character)
    if not character then return false end
    -- repère R6 par la présence d'une part "Torso" (R15 a "UpperTorso"/"LowerTorso")
    return character:FindFirstChild("Torso") ~= nil
end

local function isSameTeam(p1, p2)
    if not p1 or not p2 then return false end
    return p1.Team ~= nil and p1.Team == p2.Team
end

local function cleanupSelectionBox(selBox)
    if not selBox then return end
    local conn = selBoxConns[selBox]
    if conn then
        pcall(function() conn:Disconnect() end)
        selBoxConns[selBox] = nil
    end
    if selBox and selBox.Parent then
        pcall(function() selBox:Destroy() end)
    end
end

local function cleanupCharacter(character)
    if not character then return end
    for _, desc in ipairs(character:GetDescendants()) do
        if desc:IsA("BasePart") then
            local sb = desc:FindFirstChild("ESP_Selection")
            if sb then
                cleanupSelectionBox(sb)
            end
        end
    end
end

local function createR6Outlines(character, player)
    if not character or not isR6(character) then return end
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") and R6_PART_NAMES[part.Name] then
            local sb = part:FindFirstChild("ESP_Selection")
            if not sb then
                sb = Instance.new("SelectionBox")
                sb.Name = "ESP_Selection"
                sb.Adornee = part
                -- Propriétés visuelles
                pcall(function()
                    -- certains environnements ont SurfaceColor3 ou Color3; on tente de définir les deux
                    if sb.LineThickness ~= nil then sb.LineThickness = LINE_THICKNESS end
                    if sb.SurfaceColor3 ~= nil then sb.SurfaceColor3 = COLOR_ENEMY end
                    if sb.Color3 ~= nil then sb.Color3 = COLOR_ENEMY end
                    -- SurfaceTransparency pour ne pas remplir (SelectionBox n'a pas de remplissage visible normalement)
                    if sb.SurfaceTransparency ~= nil then sb.SurfaceTransparency = 1 end
                end)
                sb.Parent = part

                -- Nettoyage si la part est supprimée
                local ancestryConn
                ancestryConn = part.AncestryChanged:Connect(function(_, parent)
                    if not parent then
                        cleanupSelectionBox(sb)
                    end
                end)
                selBoxConns[sb] = ancestryConn
            end

            -- Couleur selon équipe si activé
            if TEAM_CHECK and isSameTeam(LocalPlayer, player) then
                pcall(function()
                    if sb.SurfaceColor3 ~= nil then sb.SurfaceColor3 = COLOR_TEAM end
                    if sb.Color3 ~= nil then sb.Color3 = COLOR_TEAM end
                end)
            else
                pcall(function()
                    if sb.SurfaceColor3 ~= nil then sb.SurfaceColor3 = COLOR_ENEMY end
                    if sb.Color3 ~= nil then sb.Color3 = COLOR_ENEMY end
                end)
            end

            -- Visibilité globale (SelectionBox ne dispose pas forcément d'un Enabled; on détruit/crée selon l'état)
            if not ESP_ENABLED then
                cleanupSelectionBox(part:FindFirstChild("ESP_Selection"))
            end
        end
    end
end

local function setupCharacter(player, character)
    if not player or player == LocalPlayer then return end
    -- Nettoyage préalable pour éviter doublons
    cleanupCharacter(character)
    createR6Outlines(character, player)

    -- Observer nouveaux descendants (ex: accessoires) pour R6
    local descConn
    descConn = character.DescendantAdded:Connect(function(desc)
        if desc:IsA("BasePart") and R6_PART_NAMES[desc.Name] then
            createR6Outlines(character, player)
        end
    end)

    playerConnections[player] = playerConnections[player] or {}
    playerConnections[player].descConn = descConn
end

local function setupPlayer(player)
    if not player or player == LocalPlayer then return end

    if player.Character then
        setupCharacter(player, player.Character)
    end

    local charAddedConn = player.CharacterAdded:Connect(function(char)
        setupCharacter(player, char)
    end)
    local charRemovingConn = player.CharacterRemoving:Connect(function(char)
        cleanupCharacter(char)
        if playerConnections[player] and playerConnections[player].descConn then
            pcall(function() playerConnections[player].descConn:Disconnect() end)
            playerConnections[player].descConn = nil
        end
    end)

    playerConnections[player] = playerConnections[player] or {}
    playerConnections[player].charAddedConn = charAddedConn
    playerConnections[player].charRemovingConn = charRemovingConn
end

-- Nettoyage quand un joueur quitte
Players.PlayerRemoving:Connect(function(player)
    if playerConnections[player] then
        local pc = playerConnections[player]
        if pc.descConn then pcall(function() pc.descConn:Disconnect() end) end
        if pc.charAddedConn then pcall(function() pc.charAddedConn:Disconnect() end) end
        if pc.charRemovingConn then pcall(function() pc.charRemovingConn:Disconnect() end) end
        playerConnections[player] = nil
    end
    if player.Character then
        cleanupCharacter(player.Character)
    end
end)

-- Initialiser pour joueurs existants
for _, p in ipairs(Players:GetPlayers()) do
    setupPlayer(p)
end
Players.PlayerAdded:Connect(setupPlayer)

-- Toggle ESP avec F (recrée ou détruit les SelectionBox selon l'état)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.F then
        ESP_ENABLED = not ESP_ENABLED
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                if ESP_ENABLED then
                    -- recréer les outlines pour les R6
                    createR6Outlines(p.Character, p)
                else
                    -- supprimer
                    cleanupCharacter(p.Character)
                end
            end
        end
    end
end)
