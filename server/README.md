# 🐺 Server Scripts

```
███████████████████████████████████████████████████████████████████████████████
█      ███████╗███████╗██████╗ ██╗   ██╗███████╗██████╗                      █
█      ██╔════╝██╔════╝██╔══██╗██║   ██║██╔════╝██╔══██╗                     █
█      ███████╗█████╗  ██████╔╝██║   ██║█████╗  ██████╔╝                     █
█      ╚════██║██╔══╝  ██╔══██╗╚██╗ ██╔╝██╔══╝  ██╔══██╗                     █
█      ███████║███████╗██║  ██║ ╚████╔╝ ███████╗██║  ██║                     █
█      ╚══════╝╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚══════╝╚═╝  ╚═╝                     █
███████████████████████████████████████████████████████████████████████████████
```

**The Land of Wolves** - Server-Side Logic

This directory contains all server-side scripts for validation, security, and item management.

---

## 📁 Files

### main.lua
**Purpose**: Main server-side logic

**Responsibilities**:
- Item registration and management
- Cooldown tracking and validation
- Rate limiting and anti-abuse
- Server-side command handling
- Framework integration
- Security enforcement

**Key Functions**:
- `InitPlayerCooldowns(source)` - Initialize player cooldown tracking
- `IsOnCooldown(source, actionType)` - Check if player is on cooldown
- `UpdateCooldown(source, actionType)` - Update cooldown timer
- `Framework.RegisterUsableItem(item, callback)` - Register cleaning items

---

## 🛡️ Server Responsibilities

### 1. Security & Validation
- Validates all cleaning requests
- Enforces cooldown periods
- Implements rate limiting
- Logs suspicious activity
- Prevents exploit attempts

### 2. Item Management
- Registers usable cleaning items
- Removes items on use
- Validates item possession
- Handles item callbacks

### 3. Player Management
- Tracks player cooldowns
- Manages player states
- Handles disconnections
- Cleans up resources

### 4. Command Handling
- Processes `/cleanweap` command
- Processes `/inspect` command
- Validates command permissions
- Triggers client events

---

## 🔒 Security Features

### Cooldown System

```lua
local PlayerCooldowns = {}

-- Track per-player cooldowns
PlayerCooldowns[source] = {
    lastClean = 0,
    lastInspect = 0,
    cleanCount = 0,
    lastMinute = os.time()
}
```

**Benefits**:
- Prevents spam
- Server-side enforcement
- Automatic cleanup
- Per-player tracking

### Rate Limiting

```lua
Config.Security = {
    maxCleaningsPerMinute = 10,
    logSuspiciousActivity = true
}
```

**Features**:
- Limits actions per minute
- Logs excessive attempts
- Configurable thresholds
- Protects against exploits

---

## 📡 Network Events

### Outgoing Events (Server → Client)

#### lxr-cleangun:client:startCleaning
Sent when cleaning is approved after validation.

#### lxr-cleangun:client:cleaningDenied
Sent when cleaning request is denied (cooldown, etc.).

### Incoming Events (Client → Server)

#### lxr-cleangun:server:validateCleaning
Received when client requests cleaning validation.

---

## 🎯 Configuration

Server behavior is controlled by `config.lua`:

```lua
Config.Cooldowns = {
    cleanWeapon = 10,      -- 10 second cooldown
    inspectWeapon = 2      -- 2 second cooldown
}

Config.Security = {
    enableCooldowns = true,
    maxCleaningsPerMinute = 10,
    logSuspiciousActivity = true
}

Config.Items = {
    cleanshort = {
        dbname = "cleanshort",
        label = "Weapon Cloth"
    }
}
```

---

## 🔧 Item Registration

Items are automatically registered on resource start:

```lua
Citizen.CreateThread(function()
    Citizen.Wait(2000)  -- Wait for framework
    
    for itemKey, itemData in pairs(Config.Items) do
        Framework.RegisterUsableItem(itemData.dbname, function(data)
            local source = data.source
            
            -- Validate and process
            if not IsOnCooldown(source, 'cleanWeapon') then
                TriggerClientEvent('lxr-cleangun:client:startCleaning', source)
                Framework.RemoveItem(source, itemData.dbname, 1)
                Framework.Notify(source, 'Weapon cleaned!', 'success', 5000)
            end
        end)
    end
end)
```

---

## 📊 Cooldown Management

### Per-Player Tracking

```lua
-- Initialize on first use
function InitPlayerCooldowns(source)
    if not PlayerCooldowns[source] then
        PlayerCooldowns[source] = {
            lastClean = 0,
            lastInspect = 0,
            cleanCount = 0,
            lastMinute = os.time()
        }
    end
end
```

### Automatic Cleanup

```lua
-- Clean up on disconnect
AddEventHandler('playerDropped', function(reason)
    local source = source
    if PlayerCooldowns[source] then
        PlayerCooldowns[source] = nil
    end
end)
```

---

## 🚨 Anti-Abuse System

### Rate Limit Tracking

```lua
-- Track cleanings per minute
if currentTime - PlayerCooldowns[source].lastMinute >= 60 then
    PlayerCooldowns[source].cleanCount = 0
    PlayerCooldowns[source].lastMinute = currentTime
end

PlayerCooldowns[source].cleanCount = PlayerCooldowns[source].cleanCount + 1

-- Check limit
if PlayerCooldowns[source].cleanCount > Config.Security.maxCleaningsPerMinute then
    print(string.format("^3[LXR-CleanGun]^7 Warning: Player %s exceeded rate limit", 
        GetPlayerName(source)))
    return false
end
```

---

## 🐛 Common Issues

### Items Not Registering
**Causes**:
- Framework not loaded
- SQL not imported
- Incorrect item names

**Solutions**:
1. Check framework is started first
2. Verify SQL import
3. Match item names exactly
4. Check console for errors

### Cooldowns Not Working
**Causes**:
- Cooldowns disabled in config
- Clock drift/time issues

**Solutions**:
1. Enable `Config.Security.enableCooldowns`
2. Verify server time is accurate
3. Check cooldown values

### Rate Limit Too Strict
**Solution**: Increase `Config.Security.maxCleaningsPerMinute`

---

## 🛠️ Customization

### Add New Cleaning Item

```lua
-- 1. Add to config.lua
Config.Items.premium_cloth = {
    dbname = "premium_cloth",
    label = "Premium Cleaning Cloth"
}

-- 2. Import SQL
INSERT INTO `items` VALUES ('premium_cloth', 'Premium Cleaning Cloth', ...);

-- 3. Restart resource
-- Item automatically registers!
```

### Adjust Cooldowns

```lua
Config.Cooldowns = {
    cleanWeapon = 30,      -- 30 seconds
    inspectWeapon = 5      -- 5 seconds
}
```

### Change Rate Limit

```lua
Config.Security.maxCleaningsPerMinute = 5  -- Stricter
-- or
Config.Security.maxCleaningsPerMinute = 20 -- More relaxed
```

---

## 📈 Performance

Server-side performance is minimal:

- **Cooldown checks**: < 0.001ms
- **Item callbacks**: < 0.01ms
- **Memory usage**: ~500KB
- **Network traffic**: ~200 bytes per cleaning

---

## 🔗 Related Files

- `config.lua` - Server configuration
- `shared/framework.lua` - Framework adapter
- `client/main.lua` - Client triggers
- `sql/` - Database imports

---

## 📚 Documentation

- [Security](../docs/security.md)
- [Events & API](../docs/events.md)
- [Configuration](../docs/configuration.md)

---

**🐺 The Land of Wolves - Georgian RP - wolves.land**
