# 🐺 Framework Support

```
███████████████████████████████████████████████████████████████████████████████
█      ███████╗██████╗  █████╗ ███╗   ███╗███████╗██╗    ██╗ ██████╗ ██████╗ █
█      ██╔════╝██╔══██╗██╔══██╗████╗ ████║██╔════╝██║    ██║██╔═══██╗██╔══██╗█
█      █████╗  ██████╔╝███████║██╔████╔██║█████╗  ██║ █╗ ██║██║   ██║██████╔╝█
█      ██╔══╝  ██╔══██╗██╔══██║██║╚██╔╝██║██╔══╝  ██║███╗██║██║   ██║██╔══██╗█
█      ██║     ██║  ██║██║  ██║██║ ╚═╝ ██║███████╗╚███╔███╔╝╚██████╔╝██║  ██║█
█      ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝ ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝█
███████████████████████████████████████████████████████████████████████████████
```

**The Land of Wolves** - Multi-Framework Architecture

This document explains how LXR Weapon Cleaner achieves compatibility with multiple RedM frameworks through its unified adapter layer.

---

## 📋 Supported Frameworks

### Primary Frameworks (Best Support)

#### 1. LXR-Core ⭐
- **Status**: Primary Framework
- **Resource Name**: `lxr-core`
- **Support Level**: Full
- **Features**:
  - Native event integration
  - Notification system
  - Inventory management
  - Player management
  - Automatic detection

#### 2. RSG-Core ⭐
- **Status**: Primary Framework
- **Resource Name**: `rsg-core`
- **Support Level**: Full
- **Features**:
  - QBCore-style API
  - Complete inventory integration
  - Notification support
  - Player data access
  - Automatic detection

### Supported Frameworks

#### 3. VORP Core ✅
- **Status**: Supported / Legacy
- **Resource Names**: `vorp_core`, `vorp_inventory`
- **Support Level**: Full
- **Features**:
  - Legacy event compatibility
  - VORP Inventory API
  - TipRight notifications
  - User system integration
  - Automatic detection

### Optional Frameworks (Basic Support)

#### 4. RedEM:RP
- **Status**: Optional
- **Resource Name**: `redem_roleplay`
- **Support Level**: Basic
- **Features**:
  - Player management
  - Inventory system
  - Notification support
  - Automatic detection

#### 5. QBR-Core
- **Status**: Optional
- **Resource Name**: `qbr-core`
- **Support Level**: Basic
- **Features**:
  - QBCore API compatibility
  - Standard inventory
  - Notification system

#### 6. QR-Core
- **Status**: Optional
- **Resource Name**: `qr-core`
- **Support Level**: Basic
- **Features**:
  - QBCore API compatibility
  - Standard inventory
  - Notification system

### Standalone Mode

#### 7. Standalone ⚙️
- **Status**: Fallback
- **Support Level**: Minimal
- **Features**:
  - No framework required
  - Chat-based notifications
  - Admin commands work
  - No inventory integration

---

## 🔍 Auto-Detection System

The resource automatically detects which framework is running on your server.

### Detection Order

```lua
1. lxr-core       -- Checked first (highest priority)
2. rsg-core       -- Checked second
3. vorp_core      -- Checked third
4. redem_roleplay -- Checked fourth
5. qbr-core       -- Checked fifth
6. qr-core        -- Checked sixth
7. standalone     -- Fallback (no framework)
```

### How Detection Works

1. **Resource State Check**: Checks if framework resource is started
2. **Core Object Access**: Attempts to access framework core object
3. **Validation**: Verifies the framework is functional
4. **Fallback**: Falls back to next framework if current fails

### Console Output

When the resource starts, you'll see:
```
[LXR-CleanGun] Detected framework: LXR-Core
```

---

## 🛠️ Framework Adapter Layer

The adapter layer (`shared/framework.lua`) provides a unified interface for all frameworks.

### Key Components

#### Framework Detection
```lua
Framework.DetectFramework()
```
Automatically detects which framework is running.

#### Unified Functions

##### Notifications
```lua
Framework.Notify(source, message, type, duration)
```
Sends notifications regardless of framework.

**Example**:
```lua
Framework.Notify(source, 'Weapon cleaned!', 'success', 5000)
```

##### Inventory Management (Server-Side)
```lua
Framework.RemoveItem(source, item, amount)
Framework.AddItem(source, item, amount, metadata)
Framework.RegisterUsableItem(item, callback)
```

**Example**:
```lua
Framework.RemoveItem(source, 'cleanshort', 1)
Framework.AddItem(source, 'cleankit', 1)
```

##### Player Management (Server-Side)
```lua
Framework.GetPlayer(source)
Framework.GetIdentifier(source)
```

**Example**:
```lua
local Player = Framework.GetPlayer(source)
local identifier = Framework.GetIdentifier(source)
```

---

## 🔧 Framework-Specific Implementation

### LXR-Core

**Core Object Access**:
```lua
Framework.Object = exports['lxr-core']:GetCoreObject()
```

**Notifications**:
```lua
TriggerClientEvent('lxr-core:client:notify', source, {
    text = message,
    type = type,
    duration = duration
})
```

**Inventory**:
```lua
Player.Functions.RemoveItem(item, amount)
Player.Functions.AddItem(item, amount)
```

### RSG-Core

**Core Object Access**:
```lua
Framework.Object = exports['rsg-core']:GetCoreObject()
```

**Notifications**:
```lua
TriggerClientEvent('rsg-core:client:notify', source, {
    text = message,
    type = type,
    duration = duration
})
```

**Inventory**:
```lua
Player.Functions.RemoveItem(item, amount)
Player.Functions.AddItem(item, amount)
```

### VORP Core

**Core Object Access**:
```lua
Framework.Object = exports.vorp_core:GetCore()
```

**Notifications**:
```lua
TriggerClientEvent('vorp:TipRight', source, message, duration)
```

**Inventory**:
```lua
local VORPInv = exports.vorp_inventory:vorp_inventoryApi()
VORPInv.subItem(source, item, amount)
VORPInv.addItem(source, item, amount)
```

---

## ⚙️ Manual Framework Selection

If auto-detection fails, you can manually set the framework:

```lua
-- In config.lua
Config.Framework = 'RSG'  -- Force RSG-Core
```

**Available Options**:
- `'LXR'` - LXR-Core
- `'RSG'` - RSG-Core
- `'VORP'` - VORP Core
- `'RedEM'` - RedEM:RP
- `'QBR'` - QBR-Core
- `'QR'` - QR-Core
- `'Standalone'` - No framework

---

## 🔌 Adding Framework Support

To add support for a new framework:

### 1. Update Detection Order

```lua
-- In config.lua
Config.FrameworkSettings.detectionOrder = {
    'lxr-core',
    'rsg-core',
    'vorp_core',
    'your-framework',  -- Add your framework
    'redem_roleplay'
}
```

### 2. Add Detection Logic

```lua
-- In shared/framework.lua
elseif framework == 'your-framework' then
    Framework.Type = 'YourFramework'
    Framework.Object = exports['your-framework']:GetCore()
    print("^2[LXR-CleanGun]^7 Detected framework: ^3Your Framework^7")
    return 'YourFramework'
```

### 3. Implement Adapter Functions

```lua
-- Notification
if Framework.Type == 'YourFramework' then
    TriggerClientEvent('your-framework:notify', source, message, type)
end

-- Inventory
if Framework.Type == 'YourFramework' then
    local Player = Framework.Object.GetPlayer(source)
    Player.RemoveItem(item, amount)
end
```

---

## 🧪 Testing Framework Compatibility

### Test Checklist

- [ ] Resource starts without errors
- [ ] Framework is detected correctly
- [ ] Items register successfully
- [ ] Using cleaning item works
- [ ] Notifications appear
- [ ] Item is consumed after use
- [ ] Cooldowns work properly
- [ ] Commands work (`/inspect`, `/cleanweap`)

### Debug Mode

Enable debug mode to see framework detection:

```lua
Config.Debug.enabled = true
Config.Debug.printFrameworkInfo = true
Config.Debug.printItemRegistration = true
```

---

## 🐛 Troubleshooting

### Framework Not Detected

**Problem**: Resource falls back to Standalone mode.

**Solutions**:
1. Ensure framework resource is started before `lxr-cleangun`
2. Check framework resource name matches detection list
3. Try manual framework selection
4. Check console for errors

### Items Not Registering

**Problem**: Items don't register or can't be used.

**Solutions**:
1. Verify SQL import was successful
2. Restart inventory resource
3. Check item names match exactly
4. Enable debug mode to see registration

### Notifications Not Working

**Problem**: No notifications appear.

**Solutions**:
1. Verify framework notifications work elsewhere
2. Check language configuration
3. Test with different notification types
4. Check client console for errors

---

## 📊 Comparison Table

| Feature | LXR | RSG | VORP | RedEM | QBR | QR | Standalone |
|---------|-----|-----|------|-------|-----|----|-----------| 
| Auto-Detection | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Notifications | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ⚠️ Chat |
| Inventory | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ |
| Item Registration | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ |
| Player Management | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ⚠️ Basic |
| Performance | ⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐ | ⭐⭐ | ⭐⭐ | ⭐⭐⭐ |
| Support Level | Full | Full | Full | Basic | Basic | Basic | Minimal |

---

**🐺 The Land of Wolves - Georgian RP - wolves.land**
