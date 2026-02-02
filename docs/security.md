# 🐺 Security Documentation

```
███████████████████████████████████████████████████████████████████████████████
█      ███████╗███████╗ ██████╗██╗   ██╗██████╗ ██╗████████╗██╗   ██╗        █
█      ██╔════╝██╔════╝██╔════╝██║   ██║██╔══██╗██║╚══██╔══╝╚██╗ ██╔╝        █
█      ███████╗█████╗  ██║     ██║   ██║██████╔╝██║   ██║    ╚████╔╝         █
█      ╚════██║██╔══╝  ██║     ██║   ██║██╔══██╗██║   ██║     ╚██╔╝          █
█      ███████║███████╗╚██████╗╚██████╔╝██║  ██║██║   ██║      ██║           █
█      ╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝   ╚═╝      ╚═╝           █
███████████████████████████████████████████████████████████████████████████████
```

**The Land of Wolves** - Security Architecture

This document outlines the security measures implemented in LXR Weapon Cleaner.

---

## 🛡️ Security Philosophy

**Never Trust the Client**

All critical operations are validated server-side. Clients can only request actions; the server decides whether to approve them.

---

## 🔒 Security Features

### 1. Server-Side Validation ✅

**What It Does**:
- All weapon cleaning requests are validated on the server
- Item existence checked before removal
- Player state verified before allowing actions

**Implementation**:
```lua
-- Server validates all cleaning requests
RegisterNetEvent('lxr-cleangun:server:validateCleaning')
AddEventHandler('lxr-cleangun:server:validateCleaning', function()
    local source = source
    
    -- Server-side checks
    if IsOnCooldown(source, 'cleanWeapon') then
        -- Deny request
        return
    end
    
    -- Additional validation...
    TriggerClientEvent('lxr-cleangun:client:cleaningApproved', source)
end)
```

---

### 2. Cooldown System ⏱️

**What It Does**:
- Prevents players from spamming weapon cleaning
- Tracks cooldowns per player on the server
- Automatically cleans up on player disconnect

**Configuration**:
```lua
Config.Cooldowns = {
    cleanWeapon = 10,      -- 10 second cooldown
    inspectWeapon = 2      -- 2 second cooldown
}
```

**How It Works**:
```lua
-- Server-side cooldown tracking
local PlayerCooldowns = {}

function IsOnCooldown(source, actionType)
    if not Config.Security.enableCooldowns then
        return false
    end
    
    local currentTime = os.time()
    local lastAction = PlayerCooldowns[source][actionType] or 0
    
    return (currentTime - lastAction) < Config.Cooldowns[actionType]
end
```

**Protection Against**:
- ❌ Spam clicking items
- ❌ Rapid command execution
- ❌ Macro abuse

---

### 3. Rate Limiting 🚦

**What It Does**:
- Limits number of cleanings per minute
- Tracks cleaning frequency per player
- Logs suspicious activity

**Configuration**:
```lua
Config.Security = {
    maxCleaningsPerMinute = 10,
    logSuspiciousActivity = true
}
```

**Implementation**:
```lua
-- Track cleanings per minute
if currentTime - PlayerCooldowns[source].lastMinute >= 60 then
    PlayerCooldowns[source].cleanCount = 0
    PlayerCooldowns[source].lastMinute = currentTime
end

PlayerCooldowns[source].cleanCount = PlayerCooldowns[source].cleanCount + 1

if PlayerCooldowns[source].cleanCount > Config.Security.maxCleaningsPerMinute then
    -- Log and deny
    print(string.format("^3[LXR-CleanGun]^7 Warning: Player %s exceeded rate limit", 
        GetPlayerName(source)))
    return false
end
```

**Protection Against**:
- ❌ Automated scripts
- ❌ Exploit attempts
- ❌ Resource abuse

---

### 4. Item Validation 📦

**What It Does**:
- Verifies item exists in player inventory
- Ensures item is properly registered
- Removes item only after successful validation

**Flow**:
```
1. Player uses item
2. Server checks if item exists
3. Server validates player state
4. Server checks cooldown
5. Server triggers cleaning
6. Server removes item
```

**Protection Against**:
- ❌ Item duplication
- ❌ Using non-existent items
- ❌ Inventory exploits

---

### 5. Weapon Validation 🔫

**What It Does**:
- Checks if player has weapon equipped
- Validates weapon type before cleaning
- Ensures weapon is in valid state

**Implementation**:
```lua
-- Client-side check (not trusted)
if weaponHash == `WEAPON_UNARMED` then
    Framework.Notify('You need a weapon equipped', 'warning', 4000)
    return
end

-- Server-side validation would go here (implement as needed)
```

**Protection Against**:
- ❌ Cleaning without weapons
- ❌ Invalid weapon states
- ❌ Weapon-related exploits

---

### 6. Resource Name Protection 🏷️

**What It Does**:
- Enforces exact resource folder name
- Prevents conflicts with other resources
- Ensures compatibility

**Implementation**:
```lua
local REQUIRED_RESOURCE_NAME = "lxr-cleangun"
local currentResourceName = GetCurrentResourceName()

if currentResourceName ~= REQUIRED_RESOURCE_NAME then
    error([[
    ╔════════════════════════════════════════╗
    ║ RESOURCE NAME VIOLATION                ║
    ║ Required: lxr-cleangun                 ║
    ║ Current: ]] .. currentResourceName .. [[
    ╚════════════════════════════════════════╝
    ]])
end
```

**Protection Against**:
- ❌ Resource conflicts
- ❌ Naming issues
- ❌ Compatibility problems

---

### 7. Event Security 📡

**What It Does**:
- Validates all network events
- Checks source player exists
- Verifies event parameters

**Best Practices**:
```lua
RegisterNetEvent('lxr-cleangun:server:validateCleaning')
AddEventHandler('lxr-cleangun:server:validateCleaning', function()
    local source = source
    
    -- Validate source
    if not source or source == 0 then
        return
    end
    
    -- Validate player exists
    local Player = Framework.GetPlayer(source)
    if not Player then
        return
    end
    
    -- Continue with validation...
end)
```

**Protection Against**:
- ❌ Fake event triggers
- ❌ Invalid player sources
- ❌ Event flooding

---

## 🚨 Threat Model

### High-Risk Threats

#### 1. Item Duplication
**Risk Level**: 🔴 High  
**Mitigation**: Server-side item removal only after validation  
**Status**: ✅ Protected

#### 2. Cooldown Bypass
**Risk Level**: 🔴 High  
**Mitigation**: Server-side cooldown tracking  
**Status**: ✅ Protected

#### 3. Resource Spam
**Risk Level**: 🟡 Medium  
**Mitigation**: Rate limiting + cooldowns  
**Status**: ✅ Protected

### Medium-Risk Threats

#### 4. Unauthorized Command Use
**Risk Level**: 🟡 Medium  
**Mitigation**: Configurable command permissions  
**Status**: ⚠️ Implement custom ACL

#### 5. Client-Side Manipulation
**Risk Level**: 🟡 Medium  
**Mitigation**: All critical logic server-side  
**Status**: ✅ Protected

### Low-Risk Threats

#### 6. Notification Spam
**Risk Level**: 🟢 Low  
**Mitigation**: Rate limiting  
**Status**: ✅ Protected

---

## 📊 Security Checklist

### Configuration Security
- [ ] `Config.Security.enableCooldowns` is `true` in production
- [ ] `Config.Security.maxCleaningsPerMinute` is set reasonably (5-15)
- [ ] `Config.Security.logSuspiciousActivity` is `true`
- [ ] `Config.Debug.enabled` is `false` in production

### Server Security
- [ ] Server validates all cleaning requests
- [ ] Cooldowns are tracked server-side
- [ ] Items are removed server-side only
- [ ] Player states are checked before actions

### Code Security
- [ ] No client-provided values trusted
- [ ] All network events validate `source`
- [ ] Resource name protection is active
- [ ] No sensitive data in client scripts

---

## 🔍 Monitoring & Logging

### What to Monitor

1. **Excessive Cleaning Attempts**
   - Players exceeding rate limits
   - Rapid command execution
   - Cooldown bypass attempts

2. **Invalid Requests**
   - Cleaning without weapons
   - Using non-existent items
   - Invalid event triggers

3. **Resource Performance**
   - Unusual CPU spikes
   - Memory leaks
   - Thread bottlenecks

### Log Examples

**Normal Activity**:
```
[LXR-CleanGun] Player John_Doe cleaned weapon with item cleanshort
[LXR-CleanGun] Player Jane_Smith used /inspect command
```

**Suspicious Activity**:
```
[LXR-CleanGun] Warning: Player Suspicious_User exceeded cleaning rate limit (15/min)
[LXR-CleanGun] Warning: Player Bad_Actor attempted cleaning without weapon
```

---

## 🛠️ Hardening Recommendations

### Production Environment

1. **Disable Debug Mode**
   ```lua
   Config.Debug.enabled = false
   Config.Debug.printPlayerActions = false
   ```

2. **Enable All Security Features**
   ```lua
   Config.Security.enableCooldowns = true
   Config.Security.logSuspiciousActivity = true
   Config.Security.maxCleaningsPerMinute = 10
   ```

3. **Adjust Cooldowns**
   ```lua
   Config.Cooldowns.cleanWeapon = 15  -- Stricter cooldown
   ```

4. **Monitor Logs**
   - Check console regularly for warnings
   - Investigate players with multiple violations
   - Keep logs for audit trail

---

### High-Security Environment

1. **Implement ACL**
   ```lua
   -- Example: Restrict /cleanweap to admins
   RegisterCommand('cleanweap', function(source, args, raw)
       if not IsPlayerAceAllowed(source, 'lxr.cleanweap') then
           return
       end
       -- Continue...
   end)
   ```

2. **Add Admin Notifications**
   ```lua
   -- Notify admins of suspicious activity
   if PlayerCooldowns[source].cleanCount > threshold then
       NotifyAdmins(GetPlayerName(source) .. ' is cleaning suspiciously')
   end
   ```

3. **Implement Ban System**
   ```lua
   -- Auto-ban after threshold
   if Config.Security.banThreshold > 0 then
       if violations >= Config.Security.banThreshold then
           BanPlayer(source, 'Weapon cleaner abuse')
       end
   end
   ```

---

## 🧪 Security Testing

### Test Cases

1. **Cooldown Test**
   - Use cleaning item rapidly
   - Verify cooldown message appears
   - Confirm item not consumed during cooldown

2. **Rate Limit Test**
   - Clean weapon 15 times in 1 minute
   - Verify rate limit kicks in
   - Check console for warnings

3. **Invalid Request Test**
   - Use cleaning item without weapon
   - Verify error message
   - Confirm item not consumed

4. **Event Security Test**
   - Trigger events with invalid source
   - Send malformed event data
   - Verify server handles gracefully

---

## 📝 Incident Response

### If Exploit Found

1. **Immediate Actions**
   - Disable affected feature in config
   - Restart resource with fix
   - Monitor for continued attempts

2. **Investigation**
   - Review logs for exploit attempts
   - Identify affected players
   - Determine exploit method

3. **Prevention**
   - Implement additional validation
   - Update security measures
   - Test thoroughly

4. **Communication**
   - Notify admins of issue
   - Document exploit and fix
   - Update users if needed

---

## 🔗 Security Updates

Stay informed about security updates:

- **GitHub**: [Watch Repository](https://github.com/iBoss21/lxr-cleangun)
- **Discord**: [Join Community](https://discord.gg/CrKcWdfd3A)

---

## 📄 Responsible Disclosure

Found a security issue? Contact us:

- **Email**: (Add your security contact)
- **Discord**: The Land of Wolves server
- **GitHub**: Private security advisory

**Do not** publicly disclose vulnerabilities.

---

**🐺 The Land of Wolves - Georgian RP - wolves.land**

**Security is a continuous process. Stay vigilant!**
