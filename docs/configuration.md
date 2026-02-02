# 🐺 Configuration Guide

```
███████████████████████████████████████████████████████████████████████████████
█       ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗                        █
█      ██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝                        █
█      ██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗                       █
█      ██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║                       █
█      ╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝                       █
█       ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝                        █
███████████████████████████████████████████████████████████████████████████████
```

**The Land of Wolves** - Configuration Options

This guide explains all available configuration options in `config.lua`.

---

## 📋 Table of Contents

1. [Server Information](#server-information)
2. [Framework Configuration](#framework-configuration)
3. [Language & Localization](#language--localization)
4. [General Settings](#general-settings)
5. [Keybinds](#keybinds)
6. [Cleaning Items](#cleaning-items)
7. [Cooldowns & Timing](#cooldowns--timing)
8. [Weapon Maintenance](#weapon-maintenance)
9. [Security & Anti-Abuse](#security--anti-abuse)
10. [Notifications](#notifications)
11. [Performance Optimization](#performance-optimization)
12. [Debug Configuration](#debug-configuration)

---

## 🏢 Server Information

```lua
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
```

**Purpose**: Server branding information (informational only, not used functionally).

---

## 🔧 Framework Configuration

```lua
Config.Framework = 'auto'
```

**Options**:
- `'auto'` - Automatic framework detection (recommended)
- `'LXR'` - Force LXR-Core
- `'RSG'` - Force RSG-Core
- `'VORP'` - Force VORP Core
- `'RedEM'` - Force RedEM:RP
- `'QBR'` - Force QBR-Core
- `'QR'` - Force QR-Core
- `'Standalone'` - Force standalone mode

### Framework Settings

```lua
Config.FrameworkSettings = {
    detectionOrder = {
        'lxr-core',
        'rsg-core',
        'vorp_core',
        'redem_roleplay',
        'qbr-core',
        'qr-core'
    }
}
```

**Purpose**: Defines the order in which frameworks are detected when using `auto` mode.

---

## 🌍 Language & Localization

```lua
Config.Lang = 'en'
```

**Available Languages**:
- `'en'` - English
- `'fr'` - French
- `'es'` - Spanish
- `'de'` - German
- `'ka'` - Georgian

**To add a new language**: Edit `locales/language.lua` and add translations.

---

## ⚙️ General Settings

```lua
Config.General = {
    enableInspection = true,      -- Enable weapon inspection via MMB
    enableAdminCommands = true,   -- Enable /inspect and /cleanweap commands
    enableCamera = true,          -- Enable camera animation during cleaning
    cameraTransitionTime = 1500,  -- Camera transition time (milliseconds)
    cameraWaitTime = 1000,        -- Wait time before camera activates (ms)
    
    supportedWeaponTypes = {
        'SHORTARM',  -- Pistols, Revolvers
        'LONGARM',   -- Rifles, Repeaters
        'SHOTGUN',   -- Shotguns
        'MELEE',     -- Melee weapons
        'BOW'        -- Bows
    }
}
```

**Options Explained**:
- `enableInspection`: Allow players to inspect weapons with MMB
- `enableAdminCommands`: Allow `/inspect` and `/cleanweap` console commands
- `enableCamera`: Show cinematic camera during weapon cleaning
- `cameraTransitionTime`: How long camera takes to zoom/rotate
- `cameraWaitTime`: Delay before camera starts moving
- `supportedWeaponTypes`: Weapon categories that can be cleaned

---

## 🎮 Keybinds

```lua
Config.Keys = {
    inspect = 0xF09866F3,       -- Middle Mouse Button
    exitCamera1 = 0xCEFD9220,   -- E key
    exitCamera2 = 0xD9D0E1C0,   -- Spacebar
    exitCamera3 = 0xB2F377E8    -- F key
}
```

**Purpose**: Define key hashes for various actions.

**Common Key Hashes**:
- `0xF09866F3` - Middle Mouse Button (MMB)
- `0xCEFD9220` - E key
- `0xD9D0E1C0` - Spacebar
- `0xB2F377E8` - F key

Find more keys: [RedM Controls Documentation](https://docs.fivem.net/docs/game-references/controls/)

---

## 🧼 Cleaning Items

```lua
Config.Items = {
    cleanshort = {
        dbname = "cleanshort",
        label = "Weapon Cloth"
    }
}
```

**To add more items**:

```lua
Config.Items = {
    cleanshort = {
        dbname = "cleanshort",
        label = "Weapon Cloth"
    },
    cleankit = {
        dbname = "cleankit",
        label = "Advanced Cleaning Kit"
    },
    oilcan = {
        dbname = "oilcan",
        label = "Gun Oil"
    }
}
```

**Important**: 
1. Add item to database first
2. Restart resource after adding items
3. `dbname` must match database item name exactly

---

## ⏱️ Cooldowns & Timing

```lua
Config.Cooldowns = {
    cleanWeapon = 10,           -- Cooldown between cleanings (seconds)
    inspectWeapon = 2,          -- Cooldown between inspections (seconds)
    cleaningAnimation = 15000,  -- Animation duration (milliseconds)
    cameraAnimation = 1500      -- Camera animation duration (ms)
}
```

**Recommended Values**:
- `cleanWeapon`: 5-30 seconds (prevents spam)
- `inspectWeapon`: 1-5 seconds (prevents abuse)
- `cleaningAnimation`: 10000-20000ms (matches native animation)
- `cameraAnimation`: 1000-2000ms (smooth camera movement)

---

## 🔫 Weapon Maintenance

```lua
Config.WeaponMaintenance = {
    resetDegradation = true,     -- Reset weapon degradation to 0
    resetDirt = true,            -- Reset weapon dirt to 0
    minimumDirtToClean = 0.1,    -- Minimum dirt level (0.0-1.0)
    showStatsUI = true           -- Show weapon stats UI on inspection
}
```

**Options Explained**:
- `resetDegradation`: Set weapon condition to perfect
- `resetDirt`: Remove all dirt from weapon
- `minimumDirtToClean`: Only allow cleaning if weapon has this much dirt (not implemented yet)
- `showStatsUI`: Display native weapon stats UI during inspection

---

## 🛡️ Security & Anti-Abuse

```lua
Config.Security = {
    enableCooldowns = true,          -- Enable server-side cooldowns
    enableDistanceCheck = false,     -- Not applicable for this resource
    logSuspiciousActivity = true,    -- Log suspicious behavior
    maxCleaningsPerMinute = 10,      -- Rate limit (cleanings per minute)
    banThreshold = 0                 -- Not implemented
}
```

**Security Features**:
- **Server-side cooldowns**: Prevent players from spamming cleanings
- **Rate limiting**: Limit cleanings per minute
- **Logging**: Console warnings for suspicious activity
- **Validation**: All cleanings are server-validated

**Recommended Settings**:
- `enableCooldowns`: Always `true` for production
- `maxCleaningsPerMinute`: 5-15 (depending on server population)
- `logSuspiciousActivity`: `true` to monitor for exploits

---

## 📢 Notifications

```lua
Config.Notifications = {
    duration = 5000,  -- Notification duration (milliseconds)
    
    types = {
        cleanSuccess = 'success',
        cleanFailed = 'error',
        onCooldown = 'warning',
        invalidWeapon = 'error',
        noWeapon = 'warning'
    }
}
```

**Notification Types**:
- `success` - Green/positive notification
- `error` - Red/negative notification
- `warning` - Yellow/caution notification
- `info` - Blue/informational notification

---

## ⚡ Performance Optimization

```lua
Config.Performance = {
    idleThreadSleep = 500,      -- Thread sleep when idle (ms)
    activeThreadSleep = 0,      -- Thread sleep when active (ms)
    debugMode = false,          -- Disable for production
    cacheWeaponData = true      -- Cache weapon data to reduce natives
}
```

**Performance Tips**:
- **idleThreadSleep**: Higher = better performance, lower = more responsive
- **activeThreadSleep**: Keep at 0 for smooth camera control
- **debugMode**: Always `false` in production
- **cacheWeaponData**: Keep `true` for better performance

**Expected Performance**:
- Idle: 0.00ms
- Active: < 0.02ms
- Peak: < 0.05ms

---

## 🐛 Debug Configuration

```lua
Config.Debug = {
    enabled = false,               -- Enable debug mode
    printFrameworkInfo = true,     -- Print framework detection
    printItemRegistration = true,  -- Print item registration
    printPlayerActions = false,    -- Print player actions
    printCameraStates = false      -- Print camera state changes
}
```

**Debug Features**:
- `enabled`: Master debug toggle
- `printFrameworkInfo`: Show which framework was detected
- `printItemRegistration`: Show items being registered
- `printPlayerActions`: Log every cleaning/inspection
- `printCameraStates`: Log camera state machine changes

**Important**: Disable all debug options in production for best performance.

---

## 💡 Configuration Examples

### High-Security Server
```lua
Config.Cooldowns.cleanWeapon = 30
Config.Security.enableCooldowns = true
Config.Security.maxCleaningsPerMinute = 5
Config.Security.logSuspiciousActivity = true
```

### Casual Roleplay Server
```lua
Config.Cooldowns.cleanWeapon = 5
Config.Security.maxCleaningsPerMinute = 15
Config.General.enableAdminCommands = true
```

### Performance-Focused Server
```lua
Config.Performance.idleThreadSleep = 1000
Config.Performance.cacheWeaponData = true
Config.Debug.enabled = false
```

---

## 📝 Notes

- Always restart the resource after changing `config.lua`
- Some settings require server restart to take effect
- Test configuration changes on a development server first
- Keep backups of your config before major changes

---

**🐺 The Land of Wolves - Georgian RP - wolves.land**
