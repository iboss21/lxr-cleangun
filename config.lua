--[[
███████████████████████████████████████████████████████████████████████████████
█                                                                             █
█      ██╗     ██╗  ██╗██████╗        ██████╗██╗     ███████╗ █████╗ ███╗   █
█      ██║     ╚██╗██╔╝██╔══██╗      ██╔════╝██║     ██╔════╝██╔══██╗████╗  █
█      ██║      ╚███╔╝ ██████╔╝█████╗██║     ██║     █████╗  ███████║██╔██╗ █
█      ██║      ██╔██╗ ██╔══██╗╚════╝██║     ██║     ██╔══╝  ██╔══██║██║╚██╗█
█      ███████╗██╔╝ ██╗██║  ██║      ╚██████╗███████╗███████╗██║  ██║██║ ╚███
█      ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝       ╚═════╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚══
█      ██╗    ██╗███████╗ █████╗ ██████╗  ██████╗ ███╗   ██╗                █
█      ██║    ██║██╔════╝██╔══██╗██╔══██╗██╔═══██╗████╗  ██║                █
█      ██║ █╗ ██║█████╗  ███████║██████╔╝██║   ██║██╔██╗ ██║                █
█      ██║███╗██║██╔══╝  ██╔══██║██╔═══╝ ██║   ██║██║╚██╗██║                █
█      ╚███╔███╔╝███████╗██║  ██║██║     ╚██████╔╝██║ ╚████║                █
█       ╚══╝╚══╝ ╚══════╝╚═╝  ╚═╝╚═╝      ╚═════╝ ╚═╝  ╚═══╝                █
█       ██████╗██╗     ███████╗ █████╗ ███╗   ██╗███████╗██████╗            █
█      ██╔════╝██║     ██╔════╝██╔══██╗████╗  ██║██╔════╝██╔══██╗           █
█      ██║     ██║     █████╗  ███████║██╔██╗ ██║█████╗  ██████╔╝           █
█      ██║     ██║     ██╔══╝  ██╔══██║██║╚██╗██║██╔══╝  ██╔══██╗           █
█      ╚██████╗███████╗███████╗██║  ██║██║ ╚████║███████╗██║  ██║           █
█       ╚═════╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝           █
█                                                                             █
███████████████████████████████████████████████████████████████████████████████
                                                                              
    🐺 WEAPON CLEANING & INSPECTION SYSTEM - Configuration
    
    A comprehensive weapon maintenance system for RedM, allowing players to
    clean and inspect their weapons with immersive animations and camera work.
    Features multi-framework support with automatic detection for LXR-Core,
    RSG-Core, and VORP Core, ensuring broad compatibility across servers.
    
    ═══════════════════════════════════════════════════════════════════════
    SERVER INFORMATION
    ═══════════════════════════════════════════════════════════════════════
    Server:        The Land of Wolves 🐺
    Tagline:       Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!
    Description:   ისტორია ცოცხლდება აქ! (History Lives Here!)
    Type:          Serious Hardcore Roleplay
    Access:        Discord & Whitelisted
    Website:       https://www.wolves.land
    Discord:       https://discord.gg/CrKcWdfd3A
    GitHub:        https://github.com/iBoss21
    Store:         https://theluxempire.tebex.io
    Listing:       https://servers.redm.net/servers/detail/8gj7eb
    Developer:     iBoss21 / The Lux Empire
    Tags:          RedM, Georgian, SeriousRP, Whitelist, Economy, RPG
    
    ═══════════════════════════════════════════════════════════════════════
    RESOURCE INFORMATION
    ═══════════════════════════════════════════════════════════════════════
    Version:       2.0.0
    Target:        RedM (RDR3)
    Performance:   Optimized - 0.00ms idle, <0.02ms active
    Tags:          Weapons, Cleaning, Inspection, Maintenance, Roleplay
    
    ═══════════════════════════════════════════════════════════════════════
    FRAMEWORK SUPPORT
    ═══════════════════════════════════════════════════════════════════════
    Primary:       LXR-Core, RSG-Core
    Supported:     VORP Core
    Optional:      RedEM:RP, QBR-Core, QR-Core, Standalone
    
    Framework Priority (Auto-Detection Order):
    1. LXR-Core    - Primary framework for The Lux Empire
    2. RSG-Core    - Primary RedM framework support
    3. VORP Core   - Legacy/Supported framework
    4. RedEM:RP    - Optional support
    5. QBR-Core    - Optional support
    6. QR-Core     - Optional support
    7. Standalone  - Fallback mode
    
    ═══════════════════════════════════════════════════════════════════════
    CREDITS
    ═══════════════════════════════════════════════════════════════════════
    Original:      Le Bookmaker & Alphatule (bookat_cleangun for RedEM:RP)
    VORP Rework:   Darky_13 (vorp_cleangun V1.3)
    LXR Conversion: iBoss21 / The Lux Empire
    Organization:  wolves.land - The Land of Wolves
    
    Copyright © 2026 The Lux Empire. All rights reserved.
    
███████████████████████████████████████████████████████████████████████████████
]]

-- ═════════════════════════════════════════════════════════════════════════
-- █████ RESOURCE NAME PROTECTION
-- ═════════════════════════════════════════════════════════════════════════

local REQUIRED_RESOURCE_NAME = "lxr-cleangun"
local currentResourceName = GetCurrentResourceName()

if currentResourceName ~= REQUIRED_RESOURCE_NAME then
    error(string.format([[
    
    ╔════════════════════════════════════════════════════════════════════╗
    ║                                                                    ║
    ║    🐺 RESOURCE NAME VIOLATION - The Land of Wolves                ║
    ║                                                                    ║
    ║    This resource MUST be named exactly: %s              ║
    ║    Current name: %-46s║
    ║                                                                    ║
    ║    Please rename this resource folder to match the required       ║
    ║    name and restart the resource.                                 ║
    ║                                                                    ║
    ║    This protection ensures compatibility and prevents conflicts.  ║
    ║                                                                    ║
    ╚════════════════════════════════════════════════════════════════════╝
    
    ]], REQUIRED_RESOURCE_NAME, currentResourceName))
end

-- ═════════════════════════════════════════════════════════════════════════
-- █████ CONFIGURATION INITIALIZATION
-- ═════════════════════════════════════════════════════════════════════════

Config = {}

-- ═════════════════════════════════════════════════════════════════════════
-- █████ SERVER INFORMATION
-- ═════════════════════════════════════════════════════════════════════════

Config.ServerInfo = {
    name          = 'The Land of Wolves 🐺',
    tagline       = 'Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!',
    description   = 'ისტორია ცოცხლდება აქ!', -- History Lives Here!
    type          = 'Serious Hardcore Roleplay',
    access        = 'Discord & Whitelisted',
    website       = 'https://www.wolves.land',
    discord       = 'https://discord.gg/CrKcWdfd3A',
    github        = 'https://github.com/iBoss21',
    store         = 'https://theluxempire.tebex.io',
    serverListing = 'https://servers.redm.net/servers/detail/8gj7eb',
    developer     = 'iBoss21 / The Lux Empire',
    tags          = {'RedM','Georgian','SeriousRP','Whitelist','Economy','RPG'}
}

-- ═════════════════════════════════════════════════════════════════════════
-- █████ FRAMEWORK CONFIGURATION
-- ═════════════════════════════════════════════════════════════════════════

-- Framework Selection
-- Options: 'auto', 'LXR', 'RSG', 'VORP', 'RedEM', 'QBR', 'QR', 'Standalone'
-- Recommended: 'auto' for automatic detection
Config.Framework = 'auto'

-- Framework-Specific Settings
Config.FrameworkSettings = {
    -- Detection order for auto mode (priority)
    detectionOrder = {
        'lxr-core',      -- LXR-Core (Primary)
        'rsg-core',      -- RSG-Core (Primary)
        'vorp_core',     -- VORP Core (Supported)
        'redem_roleplay', -- RedEM:RP (Optional)
        'qbr-core',      -- QBR-Core (Optional)
        'qr-core'        -- QR-Core (Optional)
    },
    
    -- LXR-Core Configuration
    LXR = {
        resource = 'lxr-core',
        events = {
            notify = 'lxr-core:client:notify',
            useItem = 'lxr-core:server:useItem'
        }
    },
    
    -- RSG-Core Configuration
    RSG = {
        resource = 'rsg-core',
        events = {
            notify = 'rsg-core:client:notify',
            useItem = 'rsg-core:server:useItem'
        }
    },
    
    -- VORP Core Configuration
    VORP = {
        resource = 'vorp_core',
        inventory = 'vorp_inventory',
        events = {
            notify = 'vorp:TipRight',
            closeInv = 'vorp_inventory:CloseInv'
        }
    }
}

-- ═════════════════════════════════════════════════════════════════════════
-- █████ LANGUAGE & LOCALIZATION
-- ═════════════════════════════════════════════════════════════════════════

-- Language Selection
-- Options: 'en', 'fr', 'es', 'de', 'ka' (Georgian)
Config.Lang = 'en'

-- ═════════════════════════════════════════════════════════════════════════
-- █████ GENERAL SETTINGS
-- ═════════════════════════════════════════════════════════════════════════

Config.General = {
    -- Enable weapon inspection via middle mouse button (weapon wheel)
    enableInspection = true,
    
    -- Enable admin commands (/inspect, /cleanweap)
    enableAdminCommands = true,
    
    -- Enable camera animation during cleaning
    enableCamera = true,
    
    -- Camera settings
    cameraTransitionTime = 1500, -- milliseconds
    cameraWaitTime = 1000,       -- milliseconds before camera activates
    
    -- Weapon types that can be cleaned
    supportedWeaponTypes = {
        'SHORTARM',  -- Pistols, Revolvers
        'LONGARM',   -- Rifles, Repeaters
        'SHOTGUN',   -- Shotguns
        'MELEE',     -- Melee weapons
        'BOW'        -- Bows
    }
}

-- ═════════════════════════════════════════════════════════════════════════
-- █████ KEYBINDS
-- ═════════════════════════════════════════════════════════════════════════

Config.Keys = {
    -- Weapon inspection key (default: Middle Mouse Button)
    -- Hash: 0xF09866F3 = Middle Mouse Button
    inspect = 0xF09866F3,
    
    -- Exit camera mode (default: E key)
    exitCamera1 = 0xCEFD9220, -- E key
    
    -- Alternative exit (default: Spacebar)
    exitCamera2 = 0xD9D0E1C0, -- Spacebar
    
    -- Secondary exit (default: F key)
    exitCamera3 = 0xB2F377E8  -- F key
}

-- ═════════════════════════════════════════════════════════════════════════
-- █████ CLEANING ITEMS
-- ═════════════════════════════════════════════════════════════════════════

-- Items that can be used to clean weapons
-- Add more items following this format:
-- itemName = { dbname = "database_item_name", label = "Display Name" }

Config.Items = {
    cleanshort = {
        dbname = "cleanshort",
        label = "Weapon Cloth"
    },
    -- Example additional items:
    -- cleankit = {
    --     dbname = "cleankit",
    --     label = "Weapon Cleaning Kit"
    -- },
    -- oilcan = {
    --     dbname = "oilcan",
    --     label = "Gun Oil"
    -- }
}

-- ═════════════════════════════════════════════════════════════════════════
-- █████ COOLDOWNS & TIMING
-- ═════════════════════════════════════════════════════════════════════════

Config.Cooldowns = {
    -- Cooldown between weapon cleanings (per player, in seconds)
    cleanWeapon = 10,
    
    -- Cooldown between inspections (per player, in seconds)
    inspectWeapon = 2,
    
    -- Animation duration (milliseconds)
    cleaningAnimation = 15000,
    
    -- Camera animation duration (milliseconds)
    cameraAnimation = 1500
}

-- ═════════════════════════════════════════════════════════════════════════
-- █████ WEAPON MAINTENANCE SETTINGS
-- ═════════════════════════════════════════════════════════════════════════

Config.WeaponMaintenance = {
    -- Set weapon degradation to 0 after cleaning
    resetDegradation = true,
    
    -- Set weapon dirt to 0 after cleaning
    resetDirt = true,
    
    -- Minimum dirt level required to use cleaning item (0.0 - 1.0)
    minimumDirtToClean = 0.1,
    
    -- Show weapon stats UI during inspection
    showStatsUI = true
}

-- ═════════════════════════════════════════════════════════════════════════
-- █████ SECURITY & ANTI-ABUSE
-- ═════════════════════════════════════════════════════════════════════════

Config.Security = {
    -- Enable server-side cooldown tracking
    enableCooldowns = true,
    
    -- Enable distance validation (prevent teleport abuse)
    enableDistanceCheck = false, -- Not applicable for this resource
    
    -- Log suspicious activity to console
    logSuspiciousActivity = true,
    
    -- Maximum cleaning attempts per minute (rate limit)
    maxCleaningsPerMinute = 10,
    
    -- Ban threshold for abuse (0 = disabled)
    banThreshold = 0 -- Not implemented, set to 0
}

-- ═════════════════════════════════════════════════════════════════════════
-- █████ NOTIFICATIONS
-- ═════════════════════════════════════════════════════════════════════════

Config.Notifications = {
    -- Notification duration (milliseconds)
    duration = 5000,
    
    -- Notification types: 'success', 'error', 'info', 'warning'
    types = {
        cleanSuccess = 'success',
        cleanFailed = 'error',
        onCooldown = 'warning',
        invalidWeapon = 'error',
        noWeapon = 'warning'
    }
}

-- ═════════════════════════════════════════════════════════════════════════
-- █████ PERFORMANCE OPTIMIZATION
-- ═════════════════════════════════════════════════════════════════════════

Config.Performance = {
    -- Thread sleep time when not in camera mode (milliseconds)
    idleThreadSleep = 500,
    
    -- Thread sleep time when checking for key presses (milliseconds)
    activeThreadSleep = 0,
    
    -- Enable debug logging (disable in production)
    debugMode = false,
    
    -- Cache weapon data to reduce native calls
    cacheWeaponData = true
}

-- ═════════════════════════════════════════════════════════════════════════
-- █████ DEBUG CONFIGURATION
-- ═════════════════════════════════════════════════════════════════════════

Config.Debug = {
    -- Enable debug mode (prints extra information)
    enabled = false,
    
    -- Print framework detection info
    printFrameworkInfo = true,
    
    -- Print item registration
    printItemRegistration = true,
    
    -- Print player actions
    printPlayerActions = false,
    
    -- Print camera state changes
    printCameraStates = false
}

-- ═════════════════════════════════════════════════════════════════════════
-- █████ END OF CONFIGURATION
-- ═════════════════════════════════════════════════════════════════════════

-- Boot message
if Config.Debug.enabled then
    print([[
    
    ███████████████████████████████████████████████████████████████████████
    
                    🐺 LXR WEAPON CLEANER - Configuration Loaded
    
              The Land of Wolves - Georgian RP - wolves.land
    
                        Framework: ]] .. Config.Framework .. [[
                        Language: ]] .. Config.Lang .. [[
                        Debug Mode: ]] .. tostring(Config.Debug.enabled) .. [[
    
    ███████████████████████████████████████████████████████████████████████
    
    ]])
end