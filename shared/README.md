# 🐺 Shared Scripts

```
███████████████████████████████████████████████████████████████████████████████
█      ███████╗██╗  ██╗ █████╗ ██████╗ ███████╗██████╗                       █
█      ██╔════╝██║  ██║██╔══██╗██╔══██╗██╔════╝██╔══██╗                      █
█      ███████╗███████║███████║██████╔╝█████╗  ██║  ██║                      █
█      ╚════██║██╔══██║██╔══██║██╔══██╗██╔══╝  ██║  ██║                      █
█      ███████║██║  ██║██║  ██║██████╔╝███████╗██████╔╝                      █
█      ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚═════╝                       █
███████████████████████████████████████████████████████████████████████████████
```

**The Land of Wolves** - Shared Framework Layer

This directory contains scripts that are loaded by both client and server, providing unified framework integration.

---

## 📁 Files

### framework.lua
**Purpose**: Multi-framework compatibility adapter

**Responsibilities**:
- Auto-detect active framework
- Provide unified API for all frameworks
- Abstract framework-specific differences
- Handle notifications across frameworks
- Manage inventory operations
- Player management functions

**Supported Frameworks**:
- ✅ LXR-Core (Primary)
- ✅ RSG-Core (Primary)
- ✅ VORP Core (Supported)
- ⚠️ RedEM:RP (Optional)
- ⚠️ QBR-Core (Optional)
- ⚠️ QR-Core (Optional)
- ⚙️ Standalone (Fallback)

---

## 🎯 Framework Adapter Purpose

### The Problem
Different RedM frameworks have different:
- API structures
- Event names
- Function signatures
- Notification systems
- Inventory methods

### The Solution
A unified adapter layer that:
- Detects which framework is running
- Translates function calls to framework-specific code
- Provides consistent API regardless of framework
- Handles fallbacks gracefully

---

## 🔧 Key Functions

### Framework Detection

```lua
Framework.DetectFramework()
```

**What it does**:
- Checks for framework resources
- Loads framework core object
- Sets `Framework.Type` variable
- Returns detected framework name

**Example**:
```lua
-- Automatically called on resource start
-- Result stored in Framework.Type
if Framework.Type == 'LXR' then
    print('Using LXR-Core')
end
```

---

### Unified Notification

```lua
Framework.Notify(source, message, type, duration)
```

**Parameters**:
- `source` (number/nil): Player ID (server) or nil (client)
- `message` (string): Notification text
- `type` (string): 'success', 'error', 'warning', 'info'
- `duration` (number): Duration in milliseconds

**What it does**:
- Detects current framework
- Calls appropriate notification function
- Handles framework-specific formatting
- Falls back to chat if needed

**Framework-Specific Implementations**:
```lua
-- LXR-Core
TriggerClientEvent('lxr-core:client:notify', source, {
    text = message,
    type = type,
    duration = duration
})

-- RSG-Core
TriggerClientEvent('rsg-core:client:notify', source, message, type, duration)

-- VORP
TriggerClientEvent('vorp:TipRight', source, message, duration)

-- Standalone
TriggerClientEvent('chat:addMessage', source, {
    args = {"LXR-CleanGun", message}
})
```

---

### Inventory Management (Server-Side)

#### Remove Item
```lua
Framework.RemoveItem(source, item, amount)
```

**Returns**: `boolean` - Success status

#### Add Item
```lua
Framework.AddItem(source, item, amount, metadata)
```

**Returns**: `boolean` - Success status

#### Register Usable Item
```lua
Framework.RegisterUsableItem(item, callback)
```

**Callback receives**: `data` table with `source` field

---

### Player Management (Server-Side)

#### Get Player Object
```lua
local Player = Framework.GetPlayer(source)
```

**Returns**: Framework-specific player object or `nil`

#### Get Player Identifier
```lua
local identifier = Framework.GetIdentifier(source)
```

**Returns**: Player's unique identifier (license, citizenid, etc.)

---

## 🌐 Framework-Specific Details

### LXR-Core Integration

```lua
Framework.Object = exports['lxr-core']:GetCoreObject()
```

**Features**:
- Native LXR event support
- Player management
- Inventory integration
- Notification system

---

### RSG-Core Integration

```lua
Framework.Object = exports['rsg-core']:GetCoreObject()
```

**Features**:
- QBCore-style API
- Complete functionality
- Same patterns as LXR-Core
- Excellent compatibility

---

### VORP Core Integration

```lua
Framework.Object = exports.vorp_core:GetCore()
```

**Special Considerations**:
- Separate inventory API
- Different notification style
- Legacy event support
- User vs Player object

**Inventory Access**:
```lua
local VORPInv = exports.vorp_inventory:vorp_inventoryApi()
VORPInv.subItem(source, item, amount)
VORPInv.addItem(source, item, amount)
```

---

## 📊 Detection Order

Framework detection happens in this priority:

1. **lxr-core** (Highest priority)
2. **rsg-core**
3. **vorp_core**
4. **redem_roleplay**
5. **qbr-core**
6. **qr-core**
7. **standalone** (Fallback)

This can be customized in `config.lua`:

```lua
Config.FrameworkSettings.detectionOrder = {
    'lxr-core',
    'rsg-core',
    'vorp_core',
    -- etc...
}
```

---

## 🔄 Adding New Framework Support

### Step 1: Add Detection Logic

```lua
elseif framework == 'your-framework' then
    Framework.Type = 'YourFramework'
    Framework.Object = exports['your-framework']:GetCore()
    print("^2[LXR-CleanGun]^7 Detected framework: ^3Your Framework^7")
    return 'YourFramework'
```

### Step 2: Implement Notification

```lua
if Framework.Type == 'YourFramework' then
    -- Your framework's notification method
    TriggerClientEvent('your-framework:notify', source, message, type)
end
```

### Step 3: Implement Inventory

```lua
if Framework.Type == 'YourFramework' then
    local Player = Framework.Object.GetPlayer(source)
    Player.RemoveItem(item, amount)
    Player.AddItem(item, amount)
end
```

### Step 4: Implement Registration

```lua
if Framework.Type == 'YourFramework' then
    exports['your-framework']:RegisterUsableItem(item, callback)
end
```

---

## 🧪 Testing Framework Adapter

### Test Detection

```lua
-- Check which framework was detected
print('Framework Type:', Framework.Type)
print('Framework Object:', Framework.Object)
```

### Test Notifications

```lua
-- Server-side
Framework.Notify(source, 'Test notification', 'info', 5000)

-- Client-side
Framework.Notify('Test notification', 'success', 3000)
```

### Test Inventory

```lua
-- Remove item
local success = Framework.RemoveItem(source, 'testitem', 1)
print('Remove success:', success)

-- Add item
local success = Framework.AddItem(source, 'testitem', 1)
print('Add success:', success)
```

---

## 🎯 Benefits of Framework Adapter

### For Developers
- ✅ Write code once, works everywhere
- ✅ No framework-specific logic in main code
- ✅ Easy to add new framework support
- ✅ Cleaner, more maintainable code

### For Server Owners
- ✅ No modification needed
- ✅ Works with your framework automatically
- ✅ Easy migration between frameworks
- ✅ Future-proof

### For Players
- ✅ Consistent experience
- ✅ Works on any server
- ✅ No compatibility issues

---

## 🐛 Troubleshooting

### Framework Not Detected

**Check**:
1. Framework resource is started
2. Framework name matches detection list
3. Framework exports are available

**Debug**:
```lua
-- Enable debug mode
Config.Debug.printFrameworkInfo = true
```

### Function Not Working

**Verify**:
1. Framework type is correct
2. Function is called correctly
3. Framework API hasn't changed

**Test**:
```lua
print('Framework Type:', Framework.Type)
print('Has Notify:', Framework.Notify ~= nil)
```

---

## 📚 Related Documentation

- [Frameworks Guide](../docs/frameworks.md)
- [Events & API](../docs/events.md)
- [Configuration](../docs/configuration.md)

---

## 🔗 Framework Resources

- **LXR-Core**: (Add link)
- **RSG-Core**: https://github.com/Rexshack-RedM/rsg-core
- **VORP**: https://github.com/VORPCORE
- **RedEM:RP**: https://github.com/RedEM-RP

---

**🐺 The Land of Wolves - Georgian RP - wolves.land**

**One adapter to rule them all!**
