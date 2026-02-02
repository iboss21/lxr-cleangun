--[[
███████████████████████████████████████████████████████████████████████████████
█                                                                             █
█      ██╗     ██╗  ██╗██████╗        ██████╗██╗     ███████╗ █████╗ ███╗   █
█      ██║     ╚██╗██╔╝██╔══██╗      ██╔════╝██║     ██╔════╝██╔══██╗████╗  █
█      ██║      ╚███╔╝ ██████╔╝█████╗██║     ██║     █████╗  ███████║██╔██╗ █
█      ██║      ██╔██╗ ██╔══██╗╚════╝██║     ██║     ██╔══╝  ██╔══██║██║╚██╗█
█      ███████╗██╔╝ ██╗██║  ██║      ╚██████╗███████╗███████╗██║  ██║██║ ╚███
█      ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝       ╚═════╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚══
█                                                                             █
███████████████████████████████████████████████████████████████████████████████

    🐺 WEAPON CLEANING SYSTEM - Server Logic
    
    Server-side validation, cooldown management, and item registration
    for the weapon cleaning and inspection system.
    
    For: The Land of Wolves - wolves.land
    By: iBoss21 / The Lux Empire
    
    Copyright © 2026 The Lux Empire. All rights reserved.

███████████████████████████████████████████████████████████████████████████████
]]

-- ═════════════════════════════════════════════════════════════════════════
-- █████ COOLDOWN TRACKING
-- ═════════════════════════════════════════════════════════════════════════

local PlayerCooldowns = {}

-- Initialize cooldown tracking for a player
local function InitPlayerCooldowns(source)
    if not PlayerCooldowns[source] then
        PlayerCooldowns[source] = {
            lastClean = 0,
            lastInspect = 0,
            cleanCount = 0,
            lastMinute = os.time()
        }
    end
end

-- Check if player is on cooldown
local function IsOnCooldown(source, actionType)
    if not Config.Security.enableCooldowns then
        return false
    end
    
    InitPlayerCooldowns(source)
    
    local currentTime = os.time()
    local cooldownTime = Config.Cooldowns[actionType] or 10
    local lastAction = PlayerCooldowns[source]['last' .. actionType:gsub("^%l", string.upper):gsub("Weapon", "")] or 0
    
    return (currentTime - lastAction) < cooldownTime
end

-- Update player cooldown
local function UpdateCooldown(source, actionType)
    InitPlayerCooldowns(source)
    
    local currentTime = os.time()
    PlayerCooldowns[source]['last' .. actionType:gsub("^%l", string.upper):gsub("Weapon", "")] = currentTime
    
    -- Track cleaning rate for anti-abuse
    if actionType == 'cleanWeapon' then
        if currentTime - PlayerCooldowns[source].lastMinute >= 60 then
            PlayerCooldowns[source].cleanCount = 0
            PlayerCooldowns[source].lastMinute = currentTime
        end
        PlayerCooldowns[source].cleanCount = PlayerCooldowns[source].cleanCount + 1
        
        -- Rate limit check
        if PlayerCooldowns[source].cleanCount > Config.Security.maxCleaningsPerMinute then
            if Config.Security.logSuspiciousActivity then
                print(string.format("^3[LXR-CleanGun]^7 Warning: Player %s exceeded cleaning rate limit (%d/min)", 
                    GetPlayerName(source), PlayerCooldowns[source].cleanCount))
            end
            return false
        end
    end
    
    return true
end

-- Cleanup cooldowns when player disconnects
AddEventHandler('playerDropped', function(reason)
    local source = source
    if PlayerCooldowns[source] then
        PlayerCooldowns[source] = nil
    end
end)

-- ═════════════════════════════════════════════════════════════════════════
-- █████ ITEM REGISTRATION
-- ═════════════════════════════════════════════════════════════════════════

Citizen.CreateThread(function()
    -- Wait for framework to be ready
    Citizen.Wait(2000)
    
    -- Register all cleaning items
    for itemKey, itemData in pairs(Config.Items) do
        local itemName = itemData.dbname
        
        if Config.Debug.printItemRegistration then
            print(string.format("^2[LXR-CleanGun]^7 Registering item: ^3%s^7 (key: %s)", itemName, itemKey))
        end
        
        Framework.RegisterUsableItem(itemName, function(data)
            local source = data.source or source
            
            -- Validate player exists
            if not source then
                return
            end
            
            -- Check cooldown
            if IsOnCooldown(source, 'cleanWeapon') then
                Framework.Notify(source, 
                    Language.translate[Config.Lang]['onCooldown'] or 'Please wait before cleaning again',
                    'warning',
                    Config.Notifications.duration
                )
                return
            end
            
            -- Update cooldown
            if not UpdateCooldown(source, 'cleanWeapon') then
                Framework.Notify(source,
                    Language.translate[Config.Lang]['rateLimited'] or 'You are cleaning too frequently',
                    'error',
                    Config.Notifications.duration
                )
                return
            end
            
            -- Trigger client-side cleaning animation
            TriggerClientEvent('lxr-cleangun:client:startCleaning', source)
            
            -- Remove the cleaning item
            Framework.RemoveItem(source, itemName, 1)
            
            -- Notify success
            Framework.Notify(source,
                Language.translate[Config.Lang]['notif'] or 'You cleaned your weapon',
                Config.Notifications.types.cleanSuccess,
                Config.Notifications.duration
            )
            
            if Config.Debug.printPlayerActions then
                print(string.format("^2[LXR-CleanGun]^7 Player %s cleaned weapon with item %s", 
                    GetPlayerName(source), itemName))
            end
        end)
    end
    
    print("^2[LXR-CleanGun]^7 All cleaning items registered successfully")
end)

-- ═════════════════════════════════════════════════════════════════════════
-- █████ ADMIN COMMANDS (Server-Side Validation)
-- ═════════════════════════════════════════════════════════════════════════

if Config.General.enableAdminCommands then
    -- Admin command to force clean without item
    RegisterCommand('cleanweap', function(source, args, raw)
        if source == 0 then
            print("^3[LXR-CleanGun]^7 This command cannot be used from console")
            return
        end
        
        -- Check admin permission (implement your own permission check)
        -- For now, allow all players as per original script
        
        if IsOnCooldown(source, 'cleanWeapon') then
            Framework.Notify(source,
                Language.translate[Config.Lang]['onCooldown'] or 'Please wait before cleaning again',
                'warning',
                Config.Notifications.duration
            )
            return
        end
        
        UpdateCooldown(source, 'cleanWeapon')
        TriggerClientEvent('lxr-cleangun:client:startCleaning', source)
        
        if Config.Debug.printPlayerActions then
            print(string.format("^2[LXR-CleanGun]^7 Player %s used /cleanweap command", 
                GetPlayerName(source)))
        end
    end, false)
    
    -- Admin command to inspect weapon
    RegisterCommand('inspect', function(source, args, raw)
        if source == 0 then
            print("^3[LXR-CleanGun]^7 This command cannot be used from console")
            return
        end
        
        if IsOnCooldown(source, 'inspectWeapon') then
            return
        end
        
        UpdateCooldown(source, 'inspectWeapon')
        TriggerClientEvent('lxr-cleangun:client:inspectWeapon', source)
        
        if Config.Debug.printPlayerActions then
            print(string.format("^2[LXR-CleanGun]^7 Player %s used /inspect command", 
                GetPlayerName(source)))
        end
    end, false)
end

-- ═════════════════════════════════════════════════════════════════════════
-- █████ SERVER EVENTS
-- ═════════════════════════════════════════════════════════════════════════

-- Event for clients to request weapon cleaning validation
RegisterNetEvent('lxr-cleangun:server:validateCleaning')
AddEventHandler('lxr-cleangun:server:validateCleaning', function()
    local source = source
    
    -- Server-side validation
    if IsOnCooldown(source, 'cleanWeapon') then
        TriggerClientEvent('lxr-cleangun:client:cleaningDenied', source, 'cooldown')
        return
    end
    
    -- Additional validation can be added here
    -- (e.g., check if player has required items, permissions, etc.)
    
    TriggerClientEvent('lxr-cleangun:client:cleaningApproved', source)
end)

-- ═════════════════════════════════════════════════════════════════════════
-- █████ RESOURCE STARTUP
-- ═════════════════════════════════════════════════════════════════════════

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    
    print([[
    
    ███████████████████████████████████████████████████████████████████
    
                🐺 LXR WEAPON CLEANER - Server Started
    
              Framework: ]] .. (Framework.Type or 'Detecting...') .. [[
              
              Items Registered: ]] .. #Config.Items .. [[
              
              Cooldowns: ]] .. tostring(Config.Security.enableCooldowns) .. [[
              
              wolves.land - The Land of Wolves
    
    ███████████████████████████████████████████████████████████████████
    
    ]])
end)