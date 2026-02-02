# 🐺 Client Scripts

```
███████████████████████████████████████████████████████████████████████████████
█       ██████╗██╗     ██╗███████╗███╗   ██╗████████╗                        █
█      ██╔════╝██║     ██║██╔════╝████╗  ██║╚══██╔══╝                        █
█      ██║     ██║     ██║█████╗  ██╔██╗ ██║   ██║                           █
█      ██║     ██║     ██║██╔══╝  ██║╚██╗██║   ██║                           █
█      ╚██████╗███████╗██║███████╗██║ ╚████║   ██║                           █
█       ╚═════╝╚══════╝╚═╝╚══════╝╚═╝  ╚═══╝   ╚═╝                           █
███████████████████████████████████████████████████████████████████████████████
```

**The Land of Wolves** - Client-Side Logic

This directory contains all client-side scripts for the weapon cleaning and inspection system.

---

## 📁 Files

### main.lua
**Purpose**: Main client-side logic

**Responsibilities**:
- Weapon cleaning animations
- Camera control and transitions
- Weapon inspection UI
- Key press detection
- Weapon type validation
- Network event handlers

**Key Functions**:
- `GetWeaponType(weaponHash)` - Identifies weapon category
- `StartWeaponCleaning()` - Initiates cleaning sequence
- `InspectWeapon()` - Shows weapon inspection UI
- `EndCam()` - Cleanup camera resources
- `ShowWeaponStats()` - Displays weapon stats UI

---

## 🎮 Client Responsibilities

### 1. User Input Handling
- Detects Middle Mouse Button (MMB) for inspection
- Processes command inputs (`/inspect`, `/cleanweap`)
- Manages key release detection for camera exit

### 2. Visual Effects
- Creates and manages cleaning animations
- Controls cinematic camera movements
- Renders weapon stats UI
- Handles prop spawning (cleaning cloth)

### 3. Weapon Management
- Validates equipped weapons
- Checks weapon types
- Updates weapon condition (dirt, degradation)
- Interfaces with native weapon functions

### 4. State Management
- Tracks camera mode state
- Monitors inspection status
- Manages animation states

---

## 🔧 Client Configuration

Client behavior is controlled by `config.lua`:

```lua
Config.General = {
    enableInspection = true,      -- Enable MMB inspection
    enableAdminCommands = true,   -- Enable commands
    enableCamera = true           -- Enable camera animations
}

Config.Keys = {
    inspect = 0xF09866F3,         -- Middle Mouse Button
    exitCamera1 = 0xCEFD9220,     -- E key
    exitCamera2 = 0xD9D0E1C0,     -- Spacebar
    exitCamera3 = 0xB2F377E8      -- F key
}
```

---

## 📡 Network Events

### Incoming Events (Server → Client)

#### lxr-cleangun:client:startCleaning
Triggers weapon cleaning animation and camera sequence.

#### lxr-cleangun:client:inspectWeapon
Triggers weapon inspection UI and animation.

#### cleaning:startcleaningshort (Legacy)
VORP compatibility event for weapon cleaning.

---

## 🎯 Performance Considerations

### Optimizations

1. **Smart Threading**
   - 500ms sleep when idle
   - 0ms sleep when in camera mode
   - Automatic state detection

2. **Event-Driven**
   - No constant polling
   - Responds only to events
   - Minimal CPU usage

3. **Resource Cleanup**
   - Destroys cameras after use
   - Removes temporary props
   - Cleans up on resource stop

### Performance Metrics

- **Idle**: 0.00ms
- **Active**: 0.01-0.02ms
- **Peak**: 0.03ms (during animation)

---

## 🐛 Common Issues

### Camera Not Working
**Solution**: Check `Config.General.enableCamera = true`

### Inspection Not Triggering
**Solution**: Verify MMB key hash in `Config.Keys.inspect`

### Animation Not Playing
**Solution**: Ensure weapon is equipped before using item

### Stats UI Not Showing
**Solution**: Check `Config.WeaponMaintenance.showStatsUI = true`

---

## 🛠️ Customization

### Change Inspection Key

```lua
-- In config.lua
Config.Keys.inspect = 0x8AAA0AD4  -- Change to different key
```

### Disable Camera Animation

```lua
Config.General.enableCamera = false
```

### Adjust Camera Timing

```lua
Config.General.cameraTransitionTime = 2000  -- 2 seconds
Config.General.cameraWaitTime = 500         -- 0.5 seconds
```

---

## 🔗 Related Files

- `config.lua` - Client configuration
- `shared/framework.lua` - Framework adapter
- `locales/language.lua` - Client notifications
- `server/main.lua` - Server validation

---

## 📚 Documentation

- [Events & API](../docs/events.md)
- [Configuration Guide](../docs/configuration.md)
- [Performance](../docs/performance.md)

---

**🐺 The Land of Wolves - Georgian RP - wolves.land**
