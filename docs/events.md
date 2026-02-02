# 🐺 Events & API Reference

```
███████████████████████████████████████████████████████████████████████████████
█      ███████╗██╗   ██╗███████╗███╗   ██╗████████╗███████╗                  █
█      ██╔════╝██║   ██║██╔════╝████╗  ██║╚══██╔══╝██╔════╝                  █
█      █████╗  ██║   ██║█████╗  ██╔██╗ ██║   ██║   ███████╗                  █
█      ██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║   ██║   ╚════██║                  █
█      ███████╗ ╚████╔╝ ███████╗██║ ╚████║   ██║   ███████║                  █
█      ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝                  █
███████████████████████████████████████████████████████████████████████████████
```

**The Land of Wolves** - Events & API Documentation

---

## 📡 Client Events

### lxr-cleangun:client:startCleaning
**Trigger**: Item use or server command  
**Direction**: Server → Client  
**Purpose**: Starts weapon cleaning animation and camera

**Example**:
```lua
-- Server-side
TriggerClientEvent('lxr-cleangun:client:startCleaning', source)
```

---

### lxr-cleangun:client:inspectWeapon
**Trigger**: `/inspect` command  
**Direction**: Server → Client  
**Purpose**: Shows weapon inspection UI and animation

**Example**:
```lua
-- Server-side
TriggerClientEvent('lxr-cleangun:client:inspectWeapon', source)
```

---

### cleaning:startcleaningshort (Legacy)
**Trigger**: VORP item use  
**Direction**: Server → Client  
**Purpose**: Legacy VORP compatibility event

**Example**:
```lua
-- Server-side (VORP)
TriggerClientEvent('cleaning:startcleaningshort', source)
```

---

## 📡 Server Events

### lxr-cleangun:server:validateCleaning
**Trigger**: Client requests validation  
**Direction**: Client → Server  
**Purpose**: Server-side validation for weapon cleaning

**Example**:
```lua
-- Client-side
TriggerServerEvent('lxr-cleangun:server:validateCleaning')
```

**Response Events**:
- `lxr-cleangun:client:cleaningApproved` - Validation passed
- `lxr-cleangun:client:cleaningDenied` - Validation failed

---

## 🔧 Framework Adapter API

### Server-Side Functions

#### Framework.Notify()
Sends a notification to a player.

**Syntax**:
```lua
Framework.Notify(source, message, type, duration)
```

**Parameters**:
- `source` (number): Player server ID
- `message` (string): Notification text
- `type` (string): 'success', 'error', 'warning', 'info'
- `duration` (number): Duration in milliseconds

**Example**:
```lua
Framework.Notify(source, 'Weapon cleaned!', 'success', 5000)
```

---

#### Framework.RemoveItem()
Removes an item from player inventory.

**Syntax**:
```lua
Framework.RemoveItem(source, item, amount)
```

**Parameters**:
- `source` (number): Player server ID
- `item` (string): Item name
- `amount` (number): Quantity to remove

**Returns**: `boolean` - Success status

**Example**:
```lua
local success = Framework.RemoveItem(source, 'cleanshort', 1)
if success then
    print('Item removed')
end
```

---

#### Framework.AddItem()
Adds an item to player inventory.

**Syntax**:
```lua
Framework.AddItem(source, item, amount, metadata)
```

**Parameters**:
- `source` (number): Player server ID
- `item` (string): Item name
- `amount` (number): Quantity to add
- `metadata` (table): Optional item metadata

**Returns**: `boolean` - Success status

**Example**:
```lua
Framework.AddItem(source, 'cleankit', 1, {quality = 100})
```

---

#### Framework.RegisterUsableItem()
Registers an item as usable.

**Syntax**:
```lua
Framework.RegisterUsableItem(item, callback)
```

**Parameters**:
- `item` (string): Item name
- `callback` (function): Function called when item is used

**Example**:
```lua
Framework.RegisterUsableItem('cleanshort', function(data)
    local source = data.source
    TriggerClientEvent('lxr-cleangun:client:startCleaning', source)
    Framework.RemoveItem(source, 'cleanshort', 1)
end)
```

---

#### Framework.GetPlayer()
Gets player object from framework.

**Syntax**:
```lua
Framework.GetPlayer(source)
```

**Parameters**:
- `source` (number): Player server ID

**Returns**: Player object or `nil`

**Example**:
```lua
local Player = Framework.GetPlayer(source)
if Player then
    -- Use player object
end
```

---

#### Framework.GetIdentifier()
Gets player identifier (license, citizenid, etc.).

**Syntax**:
```lua
Framework.GetIdentifier(source)
```

**Parameters**:
- `source` (number): Player server ID

**Returns**: `string` - Player identifier

**Example**:
```lua
local identifier = Framework.GetIdentifier(source)
print('Player ID: ' .. identifier)
```

---

### Client-Side Functions

#### Framework.Notify()
Sends a notification to local player.

**Syntax**:
```lua
Framework.Notify(message, type, duration)
```

**Parameters**:
- `message` (string): Notification text
- `type` (string): 'success', 'error', 'warning', 'info'
- `duration` (number): Duration in milliseconds

**Example**:
```lua
Framework.Notify('Inspection complete', 'success', 3000)
```

---

## 🎯 Commands

### /cleanweap
**Side**: Client  
**Permission**: Configurable (default: all players)  
**Purpose**: Clean equipped weapon without using item

**Usage**:
```
/cleanweap
```

**Features**:
- Triggers cleaning animation
- Server-side cooldown check
- Weapon validation
- Camera animation

---

### /inspect
**Side**: Client  
**Permission**: All players  
**Purpose**: Inspect equipped weapon

**Usage**:
```
/inspect
```

**Features**:
- Shows weapon stats UI
- Inspection animation
- Works on all weapon types

---

## 🔗 Custom Integration Examples

### Example 1: Clean Weapon from Custom Script

```lua
-- Server-side
RegisterNetEvent('myresource:cleanweapon')
AddEventHandler('myresource:cleanweapon', function()
    local source = source
    
    -- Check if player has cleaning item
    -- (implement your own check based on framework)
    
    -- Trigger cleaning
    TriggerClientEvent('lxr-cleangun:client:startCleaning', source)
    
    -- Remove custom item
    Framework.RemoveItem(source, 'my_cleaning_item', 1)
    
    -- Notify player
    Framework.Notify(source, 'Weapon cleaned!', 'success', 5000)
end)
```

---

### Example 2: Check Player Cooldown

```lua
-- Server-side (add to server/main.lua or custom script)
function IsPlayerOnCleaningCooldown(source)
    if not PlayerCooldowns[source] then
        return false
    end
    
    local currentTime = os.time()
    local lastClean = PlayerCooldowns[source].lastClean or 0
    local cooldownTime = Config.Cooldowns.cleanWeapon
    
    return (currentTime - lastClean) < cooldownTime
end

-- Usage
if IsPlayerOnCleaningCooldown(source) then
    Framework.Notify(source, 'Please wait...', 'warning', 3000)
else
    -- Allow cleaning
end
```

---

### Example 3: Add Custom Cleaning Item

```lua
-- 1. Add to config.lua
Config.Items = {
    cleanshort = {
        dbname = "cleanshort",
        label = "Weapon Cloth"
    },
    premium_cloth = {
        dbname = "premium_cloth",
        label = "Premium Cleaning Cloth"
    }
}

-- 2. Add to database
INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`) 
VALUES ('premium_cloth', 'Premium Cleaning Cloth', 5, 1, 'item_standard', 1);

-- 3. Restart resource - item is automatically registered!
```

---

### Example 4: Trigger Notification from Custom Script

```lua
-- Import the adapter
-- (framework.lua is already loaded as shared_script)

-- Server-side
RegisterNetEvent('myresource:notifyplayer')
AddEventHandler('myresource:notifyplayer', function()
    local source = source
    Framework.Notify(source, 'Custom message', 'info', 5000)
end)

-- Client-side
RegisterNetEvent('myresource:localnotify')
AddEventHandler('myresource:localnotify', function()
    Framework.Notify('Local message', 'success', 3000)
end)
```

---

### Example 5: Get Framework Type

```lua
-- Check which framework is running
if Framework.Type == 'LXR' then
    print('Using LXR-Core')
elseif Framework.Type == 'RSG' then
    print('Using RSG-Core')
elseif Framework.Type == 'VORP' then
    print('Using VORP Core')
end
```

---

## 🧪 Testing Events

### Test Cleaning Event
```lua
-- In F8 console (client)
ExecuteCommand('cleanweap')

-- OR trigger from server
TriggerClientEvent('lxr-cleangun:client:startCleaning', playerId)
```

### Test Inspection Event
```lua
-- In F8 console (client)
ExecuteCommand('inspect')

-- OR trigger from server
TriggerClientEvent('lxr-cleangun:client:inspectWeapon', playerId)
```

### Test Notification
```lua
-- Server-side
Framework.Notify(playerId, 'Test notification', 'info', 5000)
```

---

## 📝 Event Flow Diagram

### Weapon Cleaning Flow

```
Player Uses Item
       ↓
Item Registered Callback (Server)
       ↓
Cooldown Check (Server)
       ↓
Validation (Server)
       ↓
Trigger Client Event → lxr-cleangun:client:startCleaning
       ↓
Client Animation & Camera
       ↓
Weapon Stats Updated (Client)
       ↓
Notification (Client)
```

### Weapon Inspection Flow

```
Player Presses MMB / Uses Command
       ↓
Key Detection (Client)
       ↓
InspectWeapon() Function
       ↓
Weapon Type Check
       ↓
Show Weapon Stats UI
       ↓
Inspection Animation
```

---

## 🔒 Security Notes

1. **Always validate server-side**: Never trust client inputs
2. **Use cooldowns**: Prevent spam and abuse
3. **Check permissions**: Implement admin checks for sensitive commands
4. **Validate weapon data**: Ensure weapon exists before cleaning
5. **Log suspicious activity**: Monitor for exploits

---

**🐺 The Land of Wolves - Georgian RP - wolves.land**
