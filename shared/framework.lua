--[[
    ██╗     ██╗  ██╗██████╗        ██████╗██╗     ███████╗ █████╗ ███╗   ██╗
    ██║     ╚██╗██╔╝██╔══██╗      ██╔════╝██║     ██╔════╝██╔══██╗████╗  ██║
    ██║      ╚███╔╝ ██████╔╝█████╗██║     ██║     █████╗  ███████║██╔██╗ ██║
    ██║      ██╔██╗ ██╔══██╗╚════╝██║     ██║     ██╔══╝  ██╔══██║██║╚██╗██║
    ███████╗██╔╝ ██╗██║  ██║      ╚██████╗███████╗███████╗██║  ██║██║ ╚████║
    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝       ╚═════╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝
                    ███████╗██████╗  █████╗ ███╗   ███╗███████╗              
                    ██╔════╝██╔══██╗██╔══██╗████╗ ████║██╔════╝              
                    █████╗  ██████╔╝███████║██╔████╔██║█████╗                
                    ██╔══╝  ██╔══██╗██╔══██║██║╚██╔╝██║██╔══╝                
                    ██║     ██║  ██║██║  ██║██║ ╚═╝ ██║███████╗              
                    ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝              
                                                                              
    🐺 FRAMEWORK ADAPTER - Multi-Framework Compatibility Layer
    
    This adapter provides a unified interface for interacting with different
    RedM frameworks, allowing seamless operation across LXR-Core, RSG-Core,
    VORP, and other supported frameworks.
    
    ═══════════════════════════════════════════════════════════════════════════════
    SERVER INFORMATION
    ═══════════════════════════════════════════════════════════════════════════════
    Server:     The Land of Wolves 🐺
    Tagline:    Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!
    Discord:    https://discord.gg/CrKcWdfd3A
    Website:    https://www.wolves.land
    Developer:  iBoss21 / The Lux Empire
    
    ═══════════════════════════════════════════════════════════════════════════════
    RESOURCE INFORMATION
    ═══════════════════════════════════════════════════════════════════════════════
    Version:    1.0.0
    Target:     RedM (RDR3)
    Performance: Optimized - 0.00ms idle, <0.01ms active
    Tags:       Framework, Adapter, Multi-Core, LXR, RSG, VORP
    
    ═══════════════════════════════════════════════════════════════════════════════
    FRAMEWORK SUPPORT
    ═══════════════════════════════════════════════════════════════════════════════
    Primary:    LXR-Core, RSG-Core
    Supported:  VORP Core
    Optional:   RedEM:RP, QBR, QR, Standalone
    
    ═══════════════════════════════════════════════════════════════════════════════
    CREDITS
    ═══════════════════════════════════════════════════════════════════════════════
    Created by: iBoss21
    Organization: The Lux Empire
    For: wolves.land - The Land of Wolves
    
    © 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved
]]

Framework = {}
Framework.Type = nil
Framework.Object = nil

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ FRAMEWORK DETECTION ███████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████

function Framework.DetectFramework()
    local detectionOrder = Config.FrameworkSettings.detectionOrder or {
        'lxr-core',
        'rsg-core', 
        'vorp_core',
        'redem_roleplay',
        'qbr-core',
        'qr-core'
    }
    
    for _, framework in ipairs(detectionOrder) do
        if GetResourceState(framework) == 'started' then
            if framework == 'lxr-core' then
                Framework.Type = 'LXR'
                if IsDuplicityVersion() then
                    Framework.Object = exports['lxr-core']:GetCoreObject()
                else
                    Framework.Object = exports['lxr-core']:GetCoreObject()
                end
                print("^2[LXR-CleanGun]^7 🐺 Detected framework: ^3LXR-Core^7")
                return 'LXR'
            elseif framework == 'rsg-core' then
                Framework.Type = 'RSG'
                if IsDuplicityVersion() then
                    Framework.Object = exports['rsg-core']:GetCoreObject()
                else
                    Framework.Object = exports['rsg-core']:GetCoreObject()
                end
                print("^2[LXR-CleanGun]^7 🐺 Detected framework: ^3RSG-Core^7")
                return 'RSG'
            elseif framework == 'vorp_core' then
                Framework.Type = 'VORP'
                if IsDuplicityVersion() then
                    Framework.Object = exports.vorp_core:GetCore()
                else
                    Framework.Object = {}
                end
                print("^2[LXR-CleanGun]^7 🐺 Detected framework: ^3VORP Core^7")
                return 'VORP'
            elseif framework == 'redem_roleplay' then
                Framework.Type = 'RedEM'
                print("^2[LXR-CleanGun]^7 🐺 Detected framework: ^3RedEM:RP^7")
                return 'RedEM'
            elseif framework == 'qbr-core' then
                Framework.Type = 'QBR'
                if IsDuplicityVersion() then
                    Framework.Object = exports['qbr-core']:GetCoreObject()
                else
                    Framework.Object = exports['qbr-core']:GetCoreObject()
                end
                print("^2[LXR-CleanGun]^7 🐺 Detected framework: ^3QBR-Core^7")
                return 'QBR'
            elseif framework == 'qr-core' then
                Framework.Type = 'QR'
                if IsDuplicityVersion() then
                    Framework.Object = exports['qr-core']:GetCoreObject()
                else
                    Framework.Object = exports['qr-core']:GetCoreObject()
                end
                print("^2[LXR-CleanGun]^7 🐺 Detected framework: ^3QR-Core^7")
                return 'QR'
            end
        end
    end
    
    -- Standalone fallback
    Framework.Type = 'Standalone'
    print("^2[LXR-CleanGun]^7 🐺 Running in ^3Standalone^7 mode")
    return 'Standalone'
end

-- ═════════════════════════════════════════════════════════════════════════
-- █████ UNIFIED NOTIFICATION SYSTEM
-- ═════════════════════════════════════════════════════════════════════════

function Framework.Notify(source, message, type, duration)
    duration = duration or 5000
    type = type or 'info'
    
    if IsDuplicityVersion() then
        -- Server-side notification
        if Framework.Type == 'LXR' then
            TriggerClientEvent('lxr-core:client:notify', source, {
                text = message,
                type = type,
                duration = duration
            })
        elseif Framework.Type == 'RSG' then
            TriggerClientEvent('rsg-core:client:notify', source, {
                text = message,
                type = type,
                duration = duration
            })
        elseif Framework.Type == 'VORP' then
            local vorpType = type == 'error' and 'error' or type == 'success' and 'success' or 'tip'
            TriggerClientEvent('vorp:TipRight', source, message, duration)
        elseif Framework.Type == 'RedEM' then
            TriggerClientEvent('redem_roleplay:NotifyLeft', source, '', message, 'generic_textures', 'tick', duration)
        elseif Framework.Type == 'QBR' or Framework.Type == 'QR' then
            TriggerClientEvent('QBCore:Notify', source, message, type, duration)
        else
            -- Standalone fallback
            TriggerClientEvent('chat:addMessage', source, {
                color = {255, 255, 255},
                multiline = true,
                args = {"LXR-CleanGun", message}
            })
        end
    else
        -- Client-side notification
        if Framework.Type == 'LXR' then
            Framework.Object.Functions.Notify({
                text = message,
                type = type,
                duration = duration
            })
        elseif Framework.Type == 'RSG' then
            Framework.Object.Functions.Notify(message, type, duration)
        elseif Framework.Type == 'VORP' then
            TriggerEvent('vorp:TipRight', message, duration)
        elseif Framework.Type == 'RedEM' then
            TriggerEvent('redem_roleplay:NotifyLeft', '', message, 'generic_textures', 'tick', duration)
        elseif Framework.Type == 'QBR' or Framework.Type == 'QR' then
            Framework.Object.Functions.Notify(message, type, duration)
        else
            -- Standalone fallback
            TriggerEvent('chat:addMessage', {
                color = {255, 255, 255},
                multiline = true,
                args = {"LXR-CleanGun", message}
            })
        end
    end
end

-- ═════════════════════════════════════════════════════════════════════════
-- █████ INVENTORY MANAGEMENT
-- ═════════════════════════════════════════════════════════════════════════

if IsDuplicityVersion() then
    -- Server-side inventory functions
    
    function Framework.RemoveItem(source, item, amount)
        amount = amount or 1
        
        if Framework.Type == 'LXR' then
            local Player = Framework.Object.Functions.GetPlayer(source)
            if Player then
                return Player.Functions.RemoveItem(item, amount)
            end
        elseif Framework.Type == 'RSG' then
            local Player = Framework.Object.Functions.GetPlayer(source)
            if Player then
                return Player.Functions.RemoveItem(item, amount)
            end
        elseif Framework.Type == 'VORP' then
            local VORPInv = exports.vorp_inventory:vorp_inventoryApi()
            VORPInv.subItem(source, item, amount)
            return true
        elseif Framework.Type == 'RedEM' then
            local Player = exports.redem_roleplay:GetPlayer(source)
            if Player then
                Player.removeInventoryItem(item, amount)
                return true
            end
        elseif Framework.Type == 'QBR' or Framework.Type == 'QR' then
            local Player = Framework.Object.Functions.GetPlayer(source)
            if Player then
                return Player.Functions.RemoveItem(item, amount)
            end
        end
        
        return false
    end
    
    function Framework.AddItem(source, item, amount, metadata)
        amount = amount or 1
        
        if Framework.Type == 'LXR' then
            local Player = Framework.Object.Functions.GetPlayer(source)
            if Player then
                return Player.Functions.AddItem(item, amount, nil, metadata)
            end
        elseif Framework.Type == 'RSG' then
            local Player = Framework.Object.Functions.GetPlayer(source)
            if Player then
                return Player.Functions.AddItem(item, amount, nil, metadata)
            end
        elseif Framework.Type == 'VORP' then
            local VORPInv = exports.vorp_inventory:vorp_inventoryApi()
            VORPInv.addItem(source, item, amount, metadata)
            return true
        elseif Framework.Type == 'RedEM' then
            local Player = exports.redem_roleplay:GetPlayer(source)
            if Player then
                Player.addInventoryItem(item, amount)
                return true
            end
        elseif Framework.Type == 'QBR' or Framework.Type == 'QR' then
            local Player = Framework.Object.Functions.GetPlayer(source)
            if Player then
                return Player.Functions.AddItem(item, amount, nil, metadata)
            end
        end
        
        return false
    end
    
    function Framework.RegisterUsableItem(item, callback)
        if Framework.Type == 'LXR' then
            Framework.Object.Functions.CreateUseableItem(item, callback)
        elseif Framework.Type == 'RSG' then
            Framework.Object.Functions.CreateUseableItem(item, callback)
        elseif Framework.Type == 'VORP' then
            local VORPInv = exports.vorp_inventory:vorp_inventoryApi()
            VORPInv.RegisterUsableItem(item, callback)
        elseif Framework.Type == 'RedEM' then
            exports.redem_roleplay:RegisterUsableItem(item, callback)
        elseif Framework.Type == 'QBR' or Framework.Type == 'QR' then
            Framework.Object.Functions.CreateUseableItem(item, callback)
        end
    end
end

-- ═════════════════════════════════════════════════════════════════════════
-- █████ PLAYER MANAGEMENT
-- ═════════════════════════════════════════════════════════════════════════

if IsDuplicityVersion() then
    function Framework.GetPlayer(source)
        if Framework.Type == 'LXR' then
            return Framework.Object.Functions.GetPlayer(source)
        elseif Framework.Type == 'RSG' then
            return Framework.Object.Functions.GetPlayer(source)
        elseif Framework.Type == 'VORP' then
            return Framework.Object.getUser(source)
        elseif Framework.Type == 'RedEM' then
            return exports.redem_roleplay:GetPlayer(source)
        elseif Framework.Type == 'QBR' or Framework.Type == 'QR' then
            return Framework.Object.Functions.GetPlayer(source)
        end
        return nil
    end
    
    function Framework.GetIdentifier(source)
        if Framework.Type == 'LXR' or Framework.Type == 'RSG' or Framework.Type == 'QBR' or Framework.Type == 'QR' then
            local Player = Framework.GetPlayer(source)
            return Player and Player.PlayerData.citizenid or nil
        elseif Framework.Type == 'VORP' then
            local User = Framework.GetPlayer(source)
            return User and User.getIdentifier() or nil
        elseif Framework.Type == 'RedEM' then
            return GetPlayerIdentifiers(source)[1]
        end
        return GetPlayerIdentifiers(source)[1]
    end
end

-- ═════════════════════════════════════════════════════════════════════════
-- █████ INITIALIZATION
-- ═════════════════════════════════════════════════════════════════════════

Citizen.CreateThread(function()
    if Config.Framework == 'auto' then
        Framework.DetectFramework()
    else
        Framework.Type = Config.Framework
        print("^2[LXR-CleanGun]^7 🐺 Using manual framework: ^3" .. Config.Framework .. "^7")
    end
end)
